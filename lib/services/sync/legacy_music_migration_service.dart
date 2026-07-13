import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/music/music_service.dart';

class LegacyMigrationSummary {
  const LegacyMigrationSummary({
    required this.sourceName,
    required this.playlistCount,
    required this.songCount,
    required this.favoriteCount,
    required this.albumCount,
    required this.artistCount,
  });

  final String sourceName;
  final int playlistCount;
  final int songCount;
  final int favoriteCount;
  final int albumCount;
  final int artistCount;
}

class LegacyMusicMigrationService extends GetxService {
  Future<LegacyMigrationSummary> importFromBackupBytes(
    Uint8List bytes, {
    String sourceName = 'cloud_legacy.backup',
  }) async {
    final tempDir = await getTemporaryDirectory();
    final backupFile = File(
      '${tempDir.path}/legacy_cloud_${DateTime.now().millisecondsSinceEpoch}.backup',
    );
    await backupFile.writeAsBytes(bytes, flush: true);
    try {
      return await importFromPath(backupFile.path);
    } finally {
      if (await backupFile.exists()) {
        await backupFile.delete();
      }
    }
  }

  Future<LegacyMigrationSummary> importFromPath(String selectedPath) async {
    final resolved = await _resolveLegacySource(selectedPath);
    final database = sqlite3.open(
      resolved.databaseFile.path,
      mode: OpenMode.readOnly,
    );

    try {
      if (resolved.settingsFile != null) {
        final visitorId = _extractVisitorDataFromSettings(resolved.settingsFile!);
        if (visitorId != null && visitorId.isNotEmpty) {
          Get.find<MusicServices>().setVisitorId(visitorId);
        }
      }

      final songArtists = _loadSongArtists(database);
      final albumArtists = _loadAlbumArtists(database);
      final bookmarkedAlbumIds = _loadBookmarkedAlbumIds(database);
      final bookmarkedArtistIds = _loadBookmarkedArtistIds(database);
      final songs = _loadSongs(database, songArtists);
      final playlists = _loadPlaylists(database, songs);
      final importedSongIds = _computeImportedSongIds(
        songs: songs,
        playlists: playlists,
        bookmarkedAlbumIds: bookmarkedAlbumIds,
        bookmarkedArtistIds: bookmarkedArtistIds,
      );
      final albums = _loadAlbums(
        database,
        albumArtists: albumArtists,
        songs: songs,
        importedSongIds: importedSongIds,
        bookmarkedAlbumIds: bookmarkedAlbumIds,
      );
      final artists = _loadArtists(
        database,
        songs: songs,
        importedSongIds: importedSongIds,
        bookmarkedArtistIds: bookmarkedArtistIds,
      );
      final searchHistory = _loadSearchHistory(database);

      await _writeMigrationToLocalStore(
        songs: songs,
        playlists: playlists,
        albums: albums,
        artists: artists,
        searchHistory: searchHistory,
        importedSongIds: importedSongIds,
      );

      _refreshLibraryControllers();

      return LegacyMigrationSummary(
        sourceName: p.basename(selectedPath),
        playlistCount:
            playlists.where((playlist) => playlist.songs.isNotEmpty).length +
                (importedSongIds.isNotEmpty ? 1 : 0),
        songCount: importedSongIds.length,
        favoriteCount: songs.values.where((song) => song.liked).length,
        albumCount: albums.length,
        artistCount: artists.length,
      );
    } finally {
      database.dispose();
      if (resolved.cleanupDirectory != null &&
          await resolved.cleanupDirectory!.exists()) {
        await resolved.cleanupDirectory!.delete(recursive: true);
      }
    }
  }

  Future<_ResolvedLegacySource> _resolveLegacySource(
      String selectedPath) async {
    final file = File(selectedPath);
    if (!await file.exists()) {
      throw const FileSystemException(
          'No se encontró el archivo seleccionado.');
    }

    final lowerPath = selectedPath.toLowerCase();
    if (lowerPath.endsWith('.db')) {
      return _ResolvedLegacySource(databaseFile: file);
    }

    if (!lowerPath.endsWith('.backup')) {
      throw const FormatException(
        'Selecciona un song.db o un backup .backup de Joss Music.',
      );
    }

    final bytes = await file.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final legacyDbFile =
        archive.files.where((entry) => entry.name == 'song.db').firstOrNull;
    if (legacyDbFile == null) {
      throw const FormatException('El backup legado no contiene song.db.');
    }

    final tempDir = await getTemporaryDirectory();
    final extractDir = Directory(
      '${tempDir.path}/legacy_music_${DateTime.now().millisecondsSinceEpoch}',
    );
    await extractDir.create(recursive: true);

    final dbFile = File('${extractDir.path}/song.db');
    await dbFile.writeAsBytes(legacyDbFile.content as List<int>, flush: true);

    final legacySettingsFile = archive.files
        .where((entry) => entry.name.endsWith('settings.preferences_pb'))
        .firstOrNull;
    File? settingsFile;
    if (legacySettingsFile != null) {
      settingsFile = File('${extractDir.path}/settings.preferences_pb');
      await settingsFile.writeAsBytes(legacySettingsFile.content as List<int>,
          flush: true);
    }

    return _ResolvedLegacySource(
      databaseFile: dbFile,
      settingsFile: settingsFile,
      cleanupDirectory: extractDir,
    );
  }

  String? _extractVisitorDataFromSettings(File settingsFile) {
    try {
      final bytes = settingsFile.readAsBytesSync();
      final content = String.fromCharCodes(bytes);
      if (content.contains('visitorData')) {
        final reg = RegExp(r'Cg[a-zA-Z0-9_\-%]{10,}');
        final match = reg.firstMatch(content);
        return match?.group(0);
      }
    } catch (e) {
      printERROR('Fallo al extraer visitorData de settings: $e');
    }
    return null;
  }

  Map<String, List<Map<String, String>>> _loadSongArtists(Database database) {
    final result = <String, List<Map<String, String>>>{};
    final rows = database.select('''
      SELECT sam.songId AS songId, a.id AS artistId, a.name AS artistName
      FROM song_artist_map sam
      LEFT JOIN artist a ON a.id = sam.artistId
      ORDER BY sam.songId, sam.position
    ''');

    for (final row in rows) {
      final songId = row['songId']?.toString();
      final artistName = row['artistName']?.toString();
      if (songId == null || artistName == null || artistName.isEmpty) {
        continue;
      }
      result.putIfAbsent(songId, () => <Map<String, String>>[]).add({
        'id': row['artistId']?.toString() ?? '',
        'name': artistName,
      });
    }
    return result;
  }

  Map<String, List<Map<String, String>>> _loadAlbumArtists(Database database) {
    final result = <String, List<Map<String, String>>>{};
    final rows = database.select('''
      SELECT aam.albumId AS albumId, a.id AS artistId, a.name AS artistName
      FROM album_artist_map aam
      LEFT JOIN artist a ON a.id = aam.artistId
      ORDER BY aam.albumId, aam."order"
    ''');

    for (final row in rows) {
      final albumId = row['albumId']?.toString();
      final artistName = row['artistName']?.toString();
      if (albumId == null || artistName == null || artistName.isEmpty) {
        continue;
      }
      result.putIfAbsent(albumId, () => <Map<String, String>>[]).add({
        'id': row['artistId']?.toString() ?? '',
        'name': artistName,
      });
    }
    return result;
  }

  Set<String> _loadBookmarkedAlbumIds(Database database) {
    final ids = <String>{};
    final rows = database.select(
        'SELECT id, bookmarkedAt FROM album WHERE bookmarkedAt IS NOT NULL');
    for (final row in rows) {
      final id = row['id']?.toString();
      if (id != null && id.isNotEmpty) {
        ids.add(id);
      }
    }
    return ids;
  }

  Set<String> _loadBookmarkedArtistIds(Database database) {
    final ids = <String>{};
    final rows = database.select(
        'SELECT id, bookmarkedAt FROM artist WHERE bookmarkedAt IS NOT NULL');
    for (final row in rows) {
      final id = row['id']?.toString();
      if (id != null && id.isNotEmpty) {
        ids.add(id);
      }
    }
    return ids;
  }

  Map<String, _LegacySong> _loadSongs(
    Database database,
    Map<String, List<Map<String, String>>> songArtists,
  ) {
    final songs = <String, _LegacySong>{};
    final rows = database.select('''
      SELECT s.id, s.title, s.duration, s.thumbnailUrl, s.albumId, s.albumName, s.liked, s.inLibrary, s.totalPlayTime, MAX(e.timestamp) as lastPlayed
      FROM song s
      LEFT JOIN event e ON s.id = e.songId
      GROUP BY s.id
    ''');

    for (final row in rows) {
      final id = row['id']?.toString();
      if (id == null || id.isEmpty) {
        continue;
      }
      songs[id] = _LegacySong(
        id: id,
        title: row['title']?.toString() ?? 'Sin título',
        durationSeconds: _asInt(row['duration']) ?? 0,
        thumbnailUrl: row['thumbnailUrl']?.toString(),
        albumId: row['albumId']?.toString(),
        albumName: row['albumName']?.toString(),
        liked: _asBool(row['liked']),
        inLibrary: row['inLibrary'] != null,
        artists: songArtists[id] ?? const [],
        totalPlayTime: _asInt(row['totalPlayTime']) ?? 0,
        lastPlayed: _parseTimestamp(row['lastPlayed']?.toString()),
      );
    }

    return songs;
  }

  List<_LegacyPlaylist> _loadPlaylists(
    Database database,
    Map<String, _LegacySong> songs,
  ) {
    final result = <String, _LegacyPlaylist>{};
    final rows = database.select('''
      SELECT p.id AS playlistId, p.name AS playlistName, psm.songId AS songId
      FROM playlist p
      LEFT JOIN playlist_song_map psm ON p.id = psm.playlistId
      ORDER BY p.id, psm.position
    ''');

    for (final row in rows) {
      final playlistId = row['playlistId']?.toString();
      if (playlistId == null || playlistId.isEmpty) {
        continue;
      }

      final playlist = result.putIfAbsent(
        playlistId,
        () => _LegacyPlaylist(
          legacyId: playlistId,
          title: row['playlistName']?.toString().trim().isNotEmpty == true
              ? row['playlistName'].toString().trim()
              : 'Playlist migrada',
          songs: <_LegacySong>[],
        ),
      );

      final songId = row['songId']?.toString();
      if (songId != null && songs.containsKey(songId)) {
        playlist.songs.add(songs[songId]!);
      }
    }

    return result.values.toList();
  }

  Set<String> _computeImportedSongIds({
    required Map<String, _LegacySong> songs,
    required List<_LegacyPlaylist> playlists,
    required Set<String> bookmarkedAlbumIds,
    required Set<String> bookmarkedArtistIds,
  }) {
    final songIds = <String>{};

    for (final song in songs.values) {
      if (song.inLibrary || song.liked) {
        songIds.add(song.id);
      }
      if (song.albumId != null && bookmarkedAlbumIds.contains(song.albumId)) {
        songIds.add(song.id);
      }
      final songArtistIds = song.artists
          .map((artist) => artist['id']?.toString() ?? '')
          .where((id) => id.isNotEmpty);
      if (songArtistIds.any(bookmarkedArtistIds.contains)) {
        songIds.add(song.id);
      }
    }

    for (final playlist in playlists) {
      for (final song in playlist.songs) {
        songIds.add(song.id);
      }
    }

    return songIds;
  }

  Map<String, _LegacyAlbum> _loadAlbums(
    Database database, {
    required Map<String, List<Map<String, String>>> albumArtists,
    required Map<String, _LegacySong> songs,
    required Set<String> importedSongIds,
    required Set<String> bookmarkedAlbumIds,
  }) {
    final groupedSongs = <String, List<_LegacySong>>{};
    for (final songId in importedSongIds) {
      final song = songs[songId];
      if (song == null || song.albumId == null || song.albumId!.isEmpty) {
        continue;
      }
      groupedSongs.putIfAbsent(song.albumId!, () => <_LegacySong>[]).add(song);
    }

    final rows = database.select('''
      SELECT id, title, year, thumbnailUrl, bookmarkedAt
      FROM album
    ''');

    final albums = <String, _LegacyAlbum>{};
    for (final row in rows) {
      final id = row['id']?.toString();
      if (id == null || id.isEmpty) {
        continue;
      }

      final relatedSongs = groupedSongs[id] ?? const <_LegacySong>[];
      if (relatedSongs.isEmpty && !bookmarkedAlbumIds.contains(id)) {
        continue;
      }

      albums[id] = _LegacyAlbum(
        id: id,
        title: row['title']?.toString() ??
            relatedSongs.firstOrNull?.albumName ??
            'Álbum migrado',
        year: row['year']?.toString(),
        thumbnailUrl: row['thumbnailUrl']?.toString(),
        artists: albumArtists[id] ?? _fallbackAlbumArtists(relatedSongs),
        songs: relatedSongs,
      );
    }

    for (final entry in groupedSongs.entries) {
      if (albums.containsKey(entry.key)) {
        continue;
      }
      albums[entry.key] = _LegacyAlbum(
        id: entry.key,
        title: entry.value.first.albumName ?? 'Álbum migrado',
        year: null,
        thumbnailUrl: entry.value.first.thumbnailUrl,
        artists: _fallbackAlbumArtists(entry.value),
        songs: entry.value,
      );
    }

    return albums;
  }

  Map<String, _LegacyArtist> _loadArtists(
    Database database, {
    required Map<String, _LegacySong> songs,
    required Set<String> importedSongIds,
    required Set<String> bookmarkedArtistIds,
  }) {
    final artists = <String, _LegacyArtist>{};
    final songArtists = <String, Set<_LegacySong>>{};

    for (final songId in importedSongIds) {
      final song = songs[songId];
      if (song == null) {
        continue;
      }
      for (final artist in song.artists) {
        final artistId = artist['id']?.toString() ?? '';
        final artistName = artist['name']?.toString() ?? '';
        if (artistId.isEmpty || artistName.isEmpty) {
          continue;
        }
        songArtists.putIfAbsent(artistId, () => <_LegacySong>{}).add(song);
      }
    }

    final rows = database.select('''
      SELECT id, name, thumbnailUrl, bookmarkedAt
      FROM artist
    ''');

    for (final row in rows) {
      final id = row['id']?.toString();
      if (id == null || id.isEmpty) {
        continue;
      }

      final relatedSongs = songArtists[id]?.toList() ?? const <_LegacySong>[];
      if (relatedSongs.isEmpty && !bookmarkedArtistIds.contains(id)) {
        continue;
      }

      artists[id] = _LegacyArtist(
        id: id,
        name: row['name']?.toString() ?? 'Artista migrado',
        thumbnailUrl: row['thumbnailUrl']?.toString(),
        songs: relatedSongs,
      );
    }

    for (final entry in songArtists.entries) {
      if (artists.containsKey(entry.key)) {
        continue;
      }
      artists[entry.key] = _LegacyArtist(
        id: entry.key,
        name: entry.value.first.artists
                .firstWhereOrNull(
                    (artist) => artist['id'] == entry.key)?['name']
                ?.toString() ??
            'Artista migrado',
        thumbnailUrl: entry.value.first.thumbnailUrl,
        songs: entry.value.toList(),
      );
    }

    return artists;
  }

  List<Map<String, String>> _fallbackAlbumArtists(List<_LegacySong> songs) {
    final artists = <String, Map<String, String>>{};
    for (final song in songs) {
      for (final artist in song.artists) {
        final artistId = artist['id']?.toString() ?? '';
        final artistName = artist['name']?.toString() ?? '';
        final key = artistId.isNotEmpty ? artistId : artistName;
        if (key.isEmpty || artistName.isEmpty) {
          continue;
        }
        artists[key] = {
          'id': artistId,
          'name': artistName,
        };
      }
    }
    return artists.values.toList();
  }

  Future<void> _writeMigrationToLocalStore({
    required Map<String, _LegacySong> songs,
    required List<_LegacyPlaylist> playlists,
    required Map<String, _LegacyAlbum> albums,
    required Map<String, _LegacyArtist> artists,
    required List<String> searchHistory,
    required Set<String> importedSongIds,
  }) async {
    final libraryPlaylistsBox = await SqliteStore.openBox('LibraryPlaylists');
    final favoritesBox = await SqliteStore.openBox('LIBFAV');
    final albumsBox = await SqliteStore.openBox('LibraryAlbums');
    final artistsBox = await SqliteStore.openBox('LibraryArtists');
    final queryBox = await SqliteStore.openBox("searchQuery");

    if (searchHistory.isNotEmpty) {
      for (var query in searchHistory) {
        if (!queryBox.values.contains(query)) {
          await queryBox.add(query);
        }
      }
    }

    if (importedSongIds.isNotEmpty) {
      const legacyLibraryPlaylistId = 'LEGACY_LIBRARY';
      final legacySongs = importedSongIds
          .map((songId) => songs[songId])
          .whereType<_LegacySong>()
          .toList();
      final legacyPlaylistBox = await SqliteStore.openBox(legacyLibraryPlaylistId);
      await legacyPlaylistBox.clear();
      for (var index = 0; index < legacySongs.length; index++) {
        await legacyPlaylistBox.put(index, legacySongs[index].toHarmonyJson());
      }
      await legacyPlaylistBox.close();

      final thumbnail = legacySongs.isNotEmpty
          ? legacySongs.first.thumbnailOrFallback
          : Playlist.thumbPlaceholderUrl;
      await libraryPlaylistsBox.put(
        legacyLibraryPlaylistId,
        Playlist(
          title: 'Biblioteca migrada',
          playlistId: legacyLibraryPlaylistId,
          thumbnailUrl: thumbnail,
          description: 'Canciones importadas desde Joss Music Kotlin',
          isCloudPlaylist: false,
        ).toJson(),
      );
    }

    for (final song in songs.values.where((song) => song.liked)) {
      await favoritesBox.put(song.id, song.toHarmonyJson());
    }

    for (final playlist in playlists) {
      if (playlist.songs.isEmpty || playlist.legacyId == 'LP_LIKED') {
        continue;
      }

      final playlistId = _playlistIdForLegacy(playlist.legacyId);
      final playlistBox = await SqliteStore.openBox(playlistId);
      await playlistBox.clear();
      for (var index = 0; index < playlist.songs.length; index++) {
        await playlistBox.put(index, playlist.songs[index].toHarmonyJson());
      }
      await playlistBox.close();

      await libraryPlaylistsBox.put(
        playlistId,
        Playlist(
          title: playlist.title,
          playlistId: playlistId,
          thumbnailUrl: playlist.songs.first.thumbnailOrFallback,
          description: 'Migrada desde Joss Music Kotlin',
          isCloudPlaylist: false,
        ).toJson(),
      );
    }

    for (final album in albums.values) {
      if (album.songs.isEmpty) {
        continue;
      }

      final albumBox = await SqliteStore.openBox(album.id);
      await albumBox.clear();
      for (var index = 0; index < album.songs.length; index++) {
        await albumBox.put(index, album.songs[index].toHarmonyJson());
      }
      await albumBox.close();

      await albumsBox.put(
        album.id,
        Album(
          title: album.title,
          browseId: album.id,
          artists: album.artists,
          year: album.year,
          description: 'Migrado desde Joss Music Kotlin',
          thumbnailUrl: album.thumbnailOrFallback,
        ).toJson(),
      );
    }

    for (final artist in artists.values) {
      await artistsBox.put(
        artist.id,
        Artist(
          name: artist.name,
          browseId: artist.id,
          thumbnailUrl: artist.thumbnailOrFallback,
        ).toJson(),
      );
    }
  }

  String _playlistIdForLegacy(String legacyId) {
    final safeId = legacyId.replaceAll(RegExp(r'[^A-Za-z0-9_]'), '_');
    return 'LEGACY_$safeId';
  }

  void _refreshLibraryControllers() {
    if (Get.isRegistered<LibraryPlaylistsController>()) {
      Get.find<LibraryPlaylistsController>().refreshLib();
    }
    if (Get.isRegistered<LibraryAlbumsController>()) {
      Get.find<LibraryAlbumsController>().refreshLib();
    }
    if (Get.isRegistered<LibraryArtistsController>()) {
      Get.find<LibraryArtistsController>().refreshLib();
    }
  }

  bool _asBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is int) return value == 1;
    return value.toString() == '1' || value.toString().toLowerCase() == 'true';
  }

  int? _asInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  int? _parseTimestamp(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value).millisecondsSinceEpoch;
    } catch (e) {
      return null;
    }
  }

  List<String> _loadSearchHistory(Database database) {
    final history = <String>[];
    try {
      final rows = database.select('SELECT query FROM search_history ORDER BY id DESC');
      for (final row in rows) {
        final query = row['query']?.toString();
        if (query != null && query.isNotEmpty) {
          history.add(query);
        }
      }
    } catch (e) {
      printERROR("Fallo al cargar search_history: $e");
    }
    return history;
  }
}

class _ResolvedLegacySource {
  const _ResolvedLegacySource({
    required this.databaseFile,
    this.settingsFile,
    this.cleanupDirectory,
  });

  final File databaseFile;
  final File? settingsFile;
  final Directory? cleanupDirectory;
}

class _LegacyPlaylist {
  _LegacyPlaylist({
    required this.legacyId,
    required this.title,
    required this.songs,
  });

  final String legacyId;
  final String title;
  final List<_LegacySong> songs;
}

class _LegacyAlbum {
  const _LegacyAlbum({
    required this.id,
    required this.title,
    required this.year,
    required this.thumbnailUrl,
    required this.artists,
    required this.songs,
  });

  final String id;
  final String title;
  final String? year;
  final String? thumbnailUrl;
  final List<Map<String, String>> artists;
  final List<_LegacySong> songs;

  String get thumbnailOrFallback => (thumbnailUrl != null &&
          thumbnailUrl!.trim().isNotEmpty)
      ? thumbnailUrl!.trim()
      : songs.firstOrNull?.thumbnailOrFallback ?? Playlist.thumbPlaceholderUrl;
}

class _LegacyArtist {
  const _LegacyArtist({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.songs,
  });

  final String id;
  final String name;
  final String? thumbnailUrl;
  final List<_LegacySong> songs;

  String get thumbnailOrFallback => (thumbnailUrl != null &&
          thumbnailUrl!.trim().isNotEmpty)
      ? thumbnailUrl!.trim()
      : songs.firstOrNull?.thumbnailOrFallback ?? Playlist.thumbPlaceholderUrl;
}

class _LegacySong {
  const _LegacySong({
    required this.id,
    required this.title,
    required this.durationSeconds,
    required this.thumbnailUrl,
    required this.albumId,
    required this.albumName,
    required this.liked,
    required this.inLibrary,
    required this.artists,
    required this.totalPlayTime,
    required this.lastPlayed,
  });

  final String id;
  final String title;
  final int durationSeconds;
  final String? thumbnailUrl;
  final String? albumId;
  final String? albumName;
  final bool liked;
  final bool inLibrary;
  final List<Map<String, String>> artists;
  final int totalPlayTime;
  final int? lastPlayed;

  String get thumbnailOrFallback {
    if (thumbnailUrl != null && thumbnailUrl!.trim().isNotEmpty) {
      return thumbnailUrl!.trim();
    }
    return 'https://i.ytimg.com/vi/$id/hqdefault.jpg';
  }

  Map<String, dynamic> toHarmonyJson() {
    return {
      'videoId': id,
      'title': title,
      'album': albumId != null && albumId!.isNotEmpty
          ? {
              'id': albumId,
              'name': albumName ?? 'Álbum',
            }
          : null,
      'artists': artists
          .map(
            (artist) => {
              'id': artist['id'],
              'name': artist['name'],
            },
          )
          .toList(),
      'length': getTimeString(Duration(seconds: durationSeconds)),
      'duration': durationSeconds,
      'date': null,
      'thumbnails': [
        {'url': thumbnailOrFallback}
      ],
      'url': null,
      'trackDetails': null,
      'year': null,
      'totalPlayTime': totalPlayTime,
      'lastPlayed': lastPlayed,
    };
  }
}
