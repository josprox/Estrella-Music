import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

class SyncLocalRepository {
  Future<Map<String, dynamic>> buildPushPayload() async {
    final appPrefs = SqliteStore.isBoxOpen('AppPrefs') ? SqliteStore.box('AppPrefs') : await SqliteStore.openBox('AppPrefs');
    final libFav = SqliteStore.isBoxOpen('LIBFAV') ? SqliteStore.box('LIBFAV') : await SqliteStore.openBox('LIBFAV');
    final libRp = SqliteStore.isBoxOpen('LIBRP') ? SqliteStore.box('LIBRP') : await SqliteStore.openBox('LIBRP');
    final libAlbums = SqliteStore.isBoxOpen('LibraryAlbums') ? SqliteStore.box('LibraryAlbums') : await SqliteStore.openBox('LibraryAlbums');
    final libArtists = SqliteStore.isBoxOpen('LibraryArtists') ? SqliteStore.box('LibraryArtists') : await SqliteStore.openBox('LibraryArtists');
    final songDownloads = SqliteStore.isBoxOpen('SongDownloads') ? SqliteStore.box('SongDownloads') : await SqliteStore.openBox('SongDownloads');
    return {
      'playlists': await _collectPlaylists(),
      'favorites': libFav.values.toList(),
      'recent_plays': libRp.values.toList(),
      'albums': libAlbums.values.toList(),
      'artists': libArtists.values.toList(),
      'downloads': songDownloads.values.toList(),
      'settings': _syncableSettings(appPrefs),
    };
  }

  Future<List<Map<String, dynamic>>> _collectPlaylists() async {
    final playlistsBox = SqliteStore.isBoxOpen('LibraryPlaylists')
        ? SqliteStore.box('LibraryPlaylists')
        : await SqliteStore.openBox('LibraryPlaylists');
    final result = <Map<String, dynamic>>[];

    for (final value in playlistsBox.values) {
      final playlist = _asMap(value);
      final playlistId = playlist['playlistId']?.toString();
      if (playlistId == null || playlistId.isEmpty) continue;
      if (playlist['isPipedPlaylist'] == true) continue;

      final boxName = sanitizeBoxName(playlistId);
      final wasOpen = SqliteStore.isBoxOpen(boxName);
      final tracksBox =
          wasOpen ? SqliteStore.box(boxName) : await SqliteStore.openBox(boxName);
      result.add({
        ...playlist,
        'tracks': tracksBox.values.toList(),
      });
    }

    return result;
  }

  Map<String, dynamic> _syncableSettings(SqliteBox appPrefs) {
    const allowedKeys = [
      'themeModeType',
      'streamingQuality',
      'discoverContentType',
      'cacheHomeScreenData',
      'autoLanguage',
      'currentAppLanguageCode',
      'lyricsMode',
      'isLoopModeEnabled',
      'isShuffleModeEnabled',
      'queueLoopModeEnabled',
    ];

    return {
      for (final key in allowedKeys)
        if (appPrefs.containsKey(key)) key: appPrefs.get(key),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  Future<void> mergePlaylists(dynamic value) async {
    if (value == null) return;
    if (value is! List) {
      printWarning('SyncLocalRepository: playlists ignoradas (${value.runtimeType}).');
      return;
    }

    final playlistsBox = SqliteStore.isBoxOpen('LibraryPlaylists')
        ? SqliteStore.box('LibraryPlaylists')
        : await SqliteStore.openBox('LibraryPlaylists');
    var merged = 0;

    for (final raw in value) {
      final playlist = _normalizePlaylist(_asMap(raw));
      final playlistId = playlist['playlistId']?.toString();
      if (playlistId == null || playlistId.isEmpty) continue;
      if (playlistId == 'LIBFAV' || playlistId == 'LIBRP') continue;

      await playlistsBox.put(playlistId, playlist);
      final tracks = _extractTracks(raw, playlist);
      if (tracks is List) {
        final boxName = sanitizeBoxName(playlistId);
        try {
          final wasOpen = SqliteStore.isBoxOpen(boxName);
          final tracksBox =
              wasOpen ? SqliteStore.box(boxName) : await SqliteStore.openBox(boxName);
          await tracksBox.clear();
          for (var i = 0; i < tracks.length; i++) {
            await tracksBox.put(i, tracks[i]);
          }
        } catch (e) {
          printERROR('SyncLocalRepository: no se pudo abrir box para playlist $playlistId: $e');
        }
      }
      merged++;
    }

    if (merged == 0 && value.isNotEmpty) {
      printWarning('SyncLocalRepository: ninguna playlist mapeada de ${value.length} recibidas.');
    } else if (merged > 0) {
      printINFO('SyncLocalRepository: playlists mapeadas=$merged de ${value.length}.');
    }
  }

  Future<void> replaceBoxValues(
    String boxName,
    dynamic value, {
    List<String> idKeys = const ['videoId', 'id'],
  }) async {
    if (value is! List) return;
    final box = SqliteStore.isBoxOpen(boxName)
        ? SqliteStore.box(boxName)
        : await SqliteStore.openBox(boxName);
    await box.clear();
    for (var i = 0; i < value.length; i++) {
      final item = _asMap(value[i]);
      final key = _firstPresentKey(item, idKeys) ?? i;
      await box.put(key, item);
    }
  }

  Future<void> mergeSettings(dynamic value) async {
    if (value is! Map) return;
    final settings = _asMap(value);
    final appPrefs = SqliteStore.isBoxOpen('AppPrefs')
        ? SqliteStore.box('AppPrefs')
        : await SqliteStore.openBox('AppPrefs');
    for (final entry in settings.entries) {
      if (entry.key == 'updatedAt') continue;
      await appPrefs.put(entry.key, entry.value);
    }
  }

  Map<String, dynamic> resolveSyncPayload(dynamic raw) {
    final data = _asMap(raw);
    if (data.isEmpty) return data;

    const nestedCandidates = [
      'data',
      'snapshot',
      'payload',
      'result',
      'sync',
    ];
    for (final key in nestedCandidates) {
      final nested = _asMap(data[key]);
      if (nested.isNotEmpty && _containsSyncCollections(nested)) {
        return nested;
      }
    }
    return data;
  }

  bool _containsSyncCollections(Map<String, dynamic> map) {
    const collectionKeys = [
      'playlists',
      'user_playlists',
      'library_playlists',
      'favorites',
      'user_favorites',
      'recent_plays',
      'recentPlays',
      'user_recent_plays',
      'albums',
      'user_albums',
      'artists',
      'user_artists',
      'settings',
      'user_settings',
      'downloads',
    ];
    return collectionKeys.any((key) => map.containsKey(key));
  }

  dynamic firstNonNull(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      if (map.containsKey(key) && map[key] != null) {
        return map[key];
      }
    }
    return null;
  }

  Map<String, dynamic> _normalizePlaylist(Map<String, dynamic> playlist) {
    final playlistId = _firstPresentKey(
      playlist,
      const ['playlistId', 'playlist_id', 'id', 'browseId'],
    )?.toString();
    if (playlistId == null || playlistId.isEmpty) {
      return <String, dynamic>{};
    }

    final title = _firstPresentKey(
          playlist,
          const ['title', 'name', 'playlist_name'],
        )?.toString() ??
        'Playlist';

    final normalized = <String, dynamic>{
      ...playlist,
      'playlistId': playlistId,
      'title': title,
      'isCloudPlaylist': playlist['isCloudPlaylist'] ?? true,
    };

    if (normalized['description'] == null && playlist['summary'] != null) {
      normalized['description'] = playlist['summary'];
    }

    if (normalized['itemCount'] == null) {
      normalized['itemCount'] = _firstPresentKey(
        playlist,
        const ['count', 'song_count', 'songs_count', 'tracks_count'],
      );
    }

    final thumbnails = normalized['thumbnails'];
    if (thumbnails is! List || thumbnails.isEmpty) {
      final thumbnailUrl = _firstPresentKey(
        playlist,
        const ['thumbnailUrl', 'thumbnail_url', 'thumbnail', 'image', 'cover'],
      )?.toString();
      if (thumbnailUrl != null && thumbnailUrl.isNotEmpty) {
        normalized['thumbnails'] = [
          {'url': thumbnailUrl}
        ];
      }
    }

    return normalized;
  }

  dynamic _extractTracks(dynamic rawPlaylist, Map<String, dynamic> normalized) {
    final original = _asMap(rawPlaylist);
    if (normalized['tracks'] is List) return normalized['tracks'];
    if (original['tracks'] is List) return original['tracks'];
    if (original['songs'] is List) return original['songs'];
    if (original['items'] is List) return original['items'];
    if (original['playlist_tracks'] is List) return original['playlist_tracks'];
    return null;
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  dynamic _firstPresentKey(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value != null && value.toString().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }
}
