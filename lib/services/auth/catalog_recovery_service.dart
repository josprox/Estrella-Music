import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:path_provider/path_provider.dart';

import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/models/media_item_builder.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/music/music_service.dart';

class CatalogRecoveryService extends GetxService {
  MusicServices get _musicServices => Get.find<MusicServices>();

  Future<Artist?> findSimilarArtist({
    required String artistName,
  }) async {
    final query = artistName.trim();
    if (query.isEmpty) {
      return null;
    }

    final candidates = await _searchCandidates<Artist>(
      query: query,
      filter: 'artists',
    );

    return _pickBestCandidate(
      candidates,
      (artist) => _textScore(artist.name, query),
    );
  }

  Future<Album?> findSimilarAlbum({
    required String title,
    String? artistName,
  }) async {
    final query = [title, artistName]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ')
        .trim();
    if (query.isEmpty) {
      return null;
    }

    final candidates = await _searchCandidates<Album>(
      query: query,
      filter: 'albums',
    );

    return _pickBestCandidate(
      candidates,
      (album) {
        final titleScore = _textScore(album.title, title);
        final expectedArtist = artistName?.trim() ?? '';
        final currentArtist =
            album.artists?.firstOrNull?['name']?.toString().trim() ?? '';
        final artistScore = expectedArtist.isEmpty
            ? 0.0
            : _textScore(currentArtist, expectedArtist);
        return titleScore * 0.75 + artistScore * 0.25;
      },
    );
  }

  Future<Playlist?> findSimilarPlaylist({
    required String title,
    String? description,
  }) async {
    final query = [title, description]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ')
        .trim();
    if (query.isEmpty) {
      return null;
    }

    final candidates = await _searchCandidates<Playlist>(
      query: query,
      filter: 'playlists',
    );

    return _pickBestCandidate(
      candidates,
      (playlist) {
        final titleScore = _textScore(playlist.title, title);
        final descScore = (description == null || description.trim().isEmpty)
            ? 0.0
            : _textScore(playlist.description ?? '', description);
        return titleScore * 0.8 + descScore * 0.2;
      },
    );
  }

  Future<MediaItem?> findSimilarSong({
    required String title,
    String? artistName,
    String? albumName,
    Duration? duration,
    Set<String> excludeIds = const {},
  }) async {
    final query = [title, artistName, albumName]
        .where((value) => value != null && value.trim().isNotEmpty)
        .join(' ')
        .trim();
    if (query.isEmpty) {
      return null;
    }

    final candidates = await _searchCandidates<MediaItem>(
      query: query,
      filter: 'songs',
    );

    return _pickBestCandidate(
      candidates.where((song) => !excludeIds.contains(song.id)).toList(),
      (song) {
        final titleScore = _textScore(song.title, title);
        final artistScore = (artistName == null || artistName.trim().isEmpty)
            ? 1.0
            : _textScore(song.artist ?? '', artistName);
        final albumScore = (albumName == null || albumName.trim().isEmpty)
            ? 1.0
            : _textScore(song.album ?? '', albumName);
        final durationScore = _durationScore(song.duration, duration);
        return titleScore * 0.6 +
            artistScore * 0.3 +
            albumScore * 0.05 +
            durationScore * 0.05;
      },
      minimumScore: 0.72,
    );
  }

  Future<void> persistRecoveredArtist({
    required String oldBrowseId,
    required Artist artist,
  }) async {
    final wasOpen = SqliteStore.isBoxOpen('LibraryArtists');
    final box = wasOpen
        ? SqliteStore.box('LibraryArtists')
        : await SqliteStore.openBox('LibraryArtists');

    if (oldBrowseId != artist.browseId) {
      await box.delete(oldBrowseId);
    }
    await box.put(artist.browseId, artist.toJson());

    if (!wasOpen && box.isOpen) {
      await box.close();
    }
    _refreshArtistsLibrary();
  }

  Future<void> persistRecoveredAlbum({
    required String oldBrowseId,
    required Album album,
    required List<MediaItem> tracks,
  }) async {
    final wasOpen = SqliteStore.isBoxOpen('LibraryAlbums');
    final box = wasOpen
        ? SqliteStore.box('LibraryAlbums')
        : await SqliteStore.openBox('LibraryAlbums');

    if (oldBrowseId != album.browseId) {
      await box.delete(oldBrowseId);
    }
    await box.put(album.browseId, album.toJson());

    if (!wasOpen && box.isOpen) {
      await box.close();
    }

    await _rewriteSongBox(
      oldBoxName: oldBrowseId,
      newBoxName: album.browseId,
      tracks: tracks,
    );
    _refreshAlbumsLibrary();
  }

  Future<void> persistRecoveredPlaylist({
    required String oldPlaylistId,
    required Playlist playlist,
    required List<MediaItem> tracks,
  }) async {
    final wasOpen = SqliteStore.isBoxOpen('LibraryPlaylists');
    final box = wasOpen
        ? SqliteStore.box('LibraryPlaylists')
        : await SqliteStore.openBox('LibraryPlaylists');

    if (oldPlaylistId != playlist.playlistId) {
      await box.delete(oldPlaylistId);
    }
    await box.put(playlist.playlistId, playlist.toJson());

    if (!wasOpen && box.isOpen) {
      await box.close();
    }

    await _rewriteSongBox(
      oldBoxName: oldPlaylistId,
      newBoxName: playlist.playlistId,
      tracks: tracks,
    );
    _refreshPlaylistsLibrary();
  }

  Future<void> persistRecoveredSong({
    required MediaItem oldSong,
    required MediaItem recoveredSong,
  }) async {
    if (oldSong.id == recoveredSong.id) {
      return;
    }

    final contentBoxNames = <String>{
      'LIBFAV',
      'LIBRP',
      ...await _collectContentBoxNames('LibraryPlaylists'),
      ...await _collectContentBoxNames('LibraryAlbums'),
    };

    for (final boxName in contentBoxNames) {
      await _replaceSongInIndexedBox(
        boxName: boxName,
        oldSong: oldSong,
        recoveredSong: recoveredSong,
      );
    }

    await _migrateDownloadedSong(
      oldSong: oldSong,
      recoveredSong: recoveredSong,
    );
    await _deleteCachedSong(oldSong.id);
    await _deleteSongUrlCache(oldSong.id);
    await _refreshSongsLibrary();
  }

  Future<List<T>> _searchCandidates<T>({
    required String query,
    required String filter,
  }) async {
    try {
      final results = await _musicServices.search(
        query,
        filter: filter,
        limit: 8,
        ignoreSpelling: true,
      );

      return results.values
          .whereType<List>()
          .expand((items) => items)
          .whereType<T>()
          .toList();
    } catch (e) {
      printERROR('No fue posible buscar coincidencias para "$query": $e');
      return <T>[];
    }
  }

  T? _pickBestCandidate<T>(
      List<T> candidates, double Function(T candidate) scorer,
      {double minimumScore = 0.42}) {
    T? bestCandidate;
    var bestScore = 0.0;

    for (final candidate in candidates) {
      final score = scorer(candidate);
      if (score > bestScore) {
        bestScore = score;
        bestCandidate = candidate;
      }
    }

    return bestScore >= minimumScore ? bestCandidate : null;
  }

  double _durationScore(Duration? candidate, Duration? expected) {
    if (candidate == null || expected == null) return 1.0;
    final difference = (candidate.inSeconds - expected.inSeconds).abs();
    if (difference <= 2) return 1.0;
    if (difference <= 5) return 0.75;
    if (difference <= 10) return 0.35;
    return 0.0;
  }

  double _textScore(String left, String right) {
    final normalizedLeft = _normalize(left);
    final normalizedRight = _normalize(right);
    if (normalizedLeft.isEmpty || normalizedRight.isEmpty) {
      return 0.0;
    }
    if (normalizedLeft == normalizedRight) {
      return 1.0;
    }
    if (normalizedLeft.contains(normalizedRight) ||
        normalizedRight.contains(normalizedLeft)) {
      return 0.92;
    }

    final leftTokens =
        normalizedLeft.split(' ').where((token) => token.isNotEmpty).toSet();
    final rightTokens =
        normalizedRight.split(' ').where((token) => token.isNotEmpty).toSet();
    if (leftTokens.isEmpty || rightTokens.isEmpty) {
      return 0.0;
    }

    final intersection = leftTokens.intersection(rightTokens).length;
    final union = leftTokens.union(rightTokens).length;
    return union == 0 ? 0.0 : intersection / union;
  }

  String _normalize(String value) {
    const replacements = {
      'á': 'a',
      'é': 'e',
      'í': 'i',
      'ó': 'o',
      'ú': 'u',
      'ü': 'u',
      'ñ': 'n',
    };

    final lowered = value.toLowerCase();
    final buffer = StringBuffer();
    for (final rune in lowered.runes) {
      final char = String.fromCharCode(rune);
      buffer.write(replacements[char] ?? char);
    }
    return buffer
        .toString()
        .replaceAll(RegExp(r'[^a-z0-9 ]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  Future<Set<String>> _collectContentBoxNames(String libraryBoxName) async {
    final wasOpen = SqliteStore.isBoxOpen(libraryBoxName);
    final box = wasOpen
        ? SqliteStore.box(libraryBoxName)
        : await SqliteStore.openBox(libraryBoxName);

    final boxNames = box.keys
        .map((key) => key?.toString() ?? '')
        .where((name) => name.isNotEmpty)
        .toSet();

    if (!wasOpen && box.isOpen) {
      await box.close();
    }

    return boxNames;
  }

  Future<void> _replaceSongInIndexedBox({
    required String boxName,
    required MediaItem oldSong,
    required MediaItem recoveredSong,
  }) async {
    final wasOpen = SqliteStore.isBoxOpen(boxName);
    final box =
        wasOpen ? SqliteStore.box(boxName) : await SqliteStore.openBox(boxName);

    for (final key in box.keys.toList()) {
      final value = box.get(key);
      if (value is Map && value['videoId'] == oldSong.id) {
        final recoveredJson = _mergeRecoveredSongJson(
          existingJson: value,
          recoveredSong: recoveredSong,
        );
        if (boxName == 'LIBFAV' && key.toString() == oldSong.id) {
          await box.delete(key);
          await box.put(recoveredSong.id, recoveredJson);
        } else {
          await box.put(key, recoveredJson);
        }
      }
    }

    if (!wasOpen && box.isOpen && boxName != 'SongDownloads') {
      await box.close();
    }
  }

  Future<void> _migrateDownloadedSong({
    required MediaItem oldSong,
    required MediaItem recoveredSong,
  }) async {
    final wasOpen = SqliteStore.isBoxOpen('SongDownloads');
    final box = wasOpen
        ? SqliteStore.box('SongDownloads')
        : await SqliteStore.openBox('SongDownloads');

    if (box.containsKey(oldSong.id)) {
      final value = box.get(oldSong.id);
      if (value is Map) {
        await box.delete(oldSong.id);
        await box.put(
          recoveredSong.id,
          _mergeRecoveredSongJson(
            existingJson: value,
            recoveredSong: recoveredSong,
            preserveStreamInfo: true,
          ),
        );
      }
    }

    if (!wasOpen && box.isOpen) {
      await box.close();
    }
  }

  Map<String, dynamic> _mergeRecoveredSongJson({
    required Map existingJson,
    required MediaItem recoveredSong,
    bool preserveStreamInfo = false,
  }) {
    final merged = MediaItemBuilder.toJson(recoveredSong);

    if (existingJson['date'] != null) {
      merged['date'] = existingJson['date'];
    }
    if (existingJson['url'] != null) {
      merged['url'] = existingJson['url'];
    }
    if (merged['trackDetails'] == null &&
        existingJson['trackDetails'] != null) {
      merged['trackDetails'] = existingJson['trackDetails'];
    }
    if (merged['year'] == null && existingJson['year'] != null) {
      merged['year'] = existingJson['year'];
    }
    if (preserveStreamInfo && existingJson['streamInfo'] != null) {
      merged['streamInfo'] = existingJson['streamInfo'];
    }

    return merged;
  }

  Future<void> _deleteCachedSong(String songId) async {
    final wasOpen = SqliteStore.isBoxOpen('SongsCache');
    final box = wasOpen
        ? SqliteStore.box('SongsCache')
        : await SqliteStore.openBox('SongsCache');
    await box.delete(songId);
    if (!wasOpen && box.isOpen) {
      await box.close();
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final cachedFile = File('${tempDir.path}/cachedSongs/$songId.mp3');
      if (await cachedFile.exists()) {
        await cachedFile.delete();
      }
    } catch (e) {
      printERROR('No fue posible limpiar cache de $songId: $e');
    }
  }

  Future<void> _deleteSongUrlCache(String songId) async {
    final wasOpen = SqliteStore.isBoxOpen('SongsUrlCache');
    final box = wasOpen
        ? SqliteStore.box('SongsUrlCache')
        : await SqliteStore.openBox('SongsUrlCache');
    await box.delete(songId);
    if (!wasOpen && box.isOpen) {
      await box.close();
    }
  }

  Future<void> _rewriteSongBox({
    required String oldBoxName,
    required String newBoxName,
    required List<MediaItem> tracks,
  }) async {
    final newBox = await SqliteStore.openBox(newBoxName);
    await newBox.clear();
    for (var index = 0; index < tracks.length; index++) {
      await newBox.put(index, MediaItemBuilder.toJson(tracks[index]));
    }
    if (newBoxName != 'SongDownloads' && newBox.isOpen) {
      await newBox.close();
    }

    if (oldBoxName != newBoxName) {
      await _deleteBox(oldBoxName);
    }
  }

  Future<void> _deleteBox(String boxName) async {
    try {
      final box = SqliteStore.isBoxOpen(boxName)
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      await box.deleteFromDisk();
    } catch (e) {
      printERROR('No fue posible borrar la caja antigua $boxName: $e');
    }
  }

  void _refreshPlaylistsLibrary() {
    if (Get.isRegistered<LibraryPlaylistsController>()) {
      Get.find<LibraryPlaylistsController>().refreshLib();
    }
  }

  void _refreshAlbumsLibrary() {
    if (Get.isRegistered<LibraryAlbumsController>()) {
      Get.find<LibraryAlbumsController>().refreshLib();
    }
  }

  void _refreshArtistsLibrary() {
    if (Get.isRegistered<LibraryArtistsController>()) {
      Get.find<LibraryArtistsController>().refreshLib();
    }
  }

  Future<void> _refreshSongsLibrary() async {
    if (Get.isRegistered<LibrarySongsController>()) {
      final controller = Get.find<LibrarySongsController>();
      if (!controller.isClosed) {
        await controller.init();
      }
    }
  }
}
