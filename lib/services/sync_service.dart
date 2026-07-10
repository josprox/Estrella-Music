import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/playlist.dart';
import '../ui/screens/Library/library_controller.dart';
import '../ui/screens/Playlist/playlist_screen_controller.dart';
import '../ui/player/player_controller.dart';
import '../utils/helper.dart';
import 'app_backup_service.dart';
import 'auth_service.dart';
import 'cloud_migration_service.dart';
import 'pending_sync_queue_service.dart';

class SyncService extends GetxService {
  static const _modeKey = 'emusicDataMode';
  static const _pendingKey = 'hasPendingSync';
  static const _lastSyncKey = 'lastSuccessfulSyncAt';

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 45),
      validateStatus: (_) => true,
    ),
  );

  final isSyncing = false.obs;
  final isOnline = true.obs;
  final lastStatusMessage = 'Modo local activo'.obs;
  Timer? _debounce;
  Timer? _retryTimer;
  bool _isApplyingRemoteChanges = false;

  WebSocket? _socket;
  StreamSubscription? _subscription;
  bool _isSocketAuthenticated = false;
  Timer? _reconnectTimer;

  AuthService get _authService => Get.find<AuthService>();
  PendingSyncQueueService get _queue => Get.find<PendingSyncQueueService>();

  @override
  void onInit() {
    super.onInit();
    _retryTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
      if (!isCloudMode || !_authService.isAuthenticated.value) return;
      final online = await checkConnection();
      if (!online) return;

      final hasPending = Hive.box('AppPrefs').get(_pendingKey) == true;
      if (hasPending) {
        final success = await push();
        if (success) await pull();
      } else {
        await pull();
      }
    });
    _setupLocalMutationWatchers();

    ever(_authService.isAuthenticated, (bool authenticated) {
      if (authenticated && isCloudMode) {
        connectSocket();
      } else {
        disconnectSocket();
      }
    });

    if (_authService.isAuthenticated.value && isCloudMode) {
      connectSocket();
    }
  }

  void _setupLocalMutationWatchers() {
    final watchBoxes = [
      'LIBFAV',
      'LIBRP',
      'LibraryAlbums',
      'LibraryArtists',
      'LibraryPlaylists',
    ];

    for (final boxName in watchBoxes) {
      Hive.box(boxName).watch().listen((_) {
        if (_isApplyingRemoteChanges) return;
        triggerPush();
      });
    }

    Hive.box('AppPrefs').watch().listen((event) {
      if (_isApplyingRemoteChanges) return;
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
      if (allowedKeys.contains(event.key)) {
        triggerPush();
      }
    });
  }

  /// Descarga cambios remotos al volver a la app o cambiar de dispositivo.
  Future<void> pullRemoteChanges() async {
    if (!isCloudMode || !_authService.isAuthenticated.value) return;
    if (isSyncing.value) return;
    final online = await checkConnection();
    if (!online) return;
    await pull();
  }

  @override
  void onClose() {
    disconnectSocket();
    _retryTimer?.cancel();
    _debounce?.cancel();
    super.onClose();
  }

  bool get isCloudMode =>
      Hive.box('AppPrefs').get(_modeKey, defaultValue: 'local') == 'cloud';

  String? get syncBaseUrl {
    final isDebugEnv = dotenv.env['DEBUG']?.toLowerCase() == 'true';
    if (kDebugMode && isDebugEnv) {
      if (GetPlatform.isWindows) {
        return 'http://127.0.0.1:9000';
      } else if (GetPlatform.isAndroid) {
        return 'http://10.0.2.2:9000';
      }
    }
    return dotenv.env['EMUSICWEB'] ?? _authService.baseUrl;
  }

  Future<void> enableCloudMode() async {
    if (isCloudMode) {
      await Hive.box('AppPrefs').put(_pendingKey, true);
      lastStatusMessage.value = 'Modo cloud activo. Sincronizacion pendiente.';
      triggerPush();
      return;
    }

    final migrationResult =
        await Get.find<CloudMigrationService>().migrateLocalLibraryToCloud();
    if (!migrationResult.success) {
      await Hive.box('AppPrefs').put(_modeKey, 'local');
      await Hive.box('AppPrefs').put(_pendingKey, false);
      lastStatusMessage.value = migrationResult.message;
      return;
    }

    await Hive.box('AppPrefs').put(_modeKey, 'cloud');
    await Hive.box('AppPrefs').put(_pendingKey, false);
    await Hive.box('AppPrefs').put('emusicCloudRequested', false);
    await Hive.box('AppPrefs').put('emusicModeChoiceCompleted', true);
    lastStatusMessage.value = migrationResult.usedExistingCloud
        ? 'Modo cloud activado. Descargando biblioteca existente.'
        : 'Modo cloud activado. Biblioteca migrada.';

    if (migrationResult.usedExistingCloud) {
      await Get.find<AppBackupService>().clearLocalMusicData();
    }

    await pull();
  }

  Future<void> keepLocalMode() async {
    await Hive.box('AppPrefs').put(_modeKey, 'local');
    await Hive.box('AppPrefs').put(_pendingKey, false);
    await Hive.box('AppPrefs').put('emusicCloudRequested', false);
    await Hive.box('AppPrefs').put('emusicModeChoiceCompleted', true);
    lastStatusMessage.value =
        'Tus datos se mantienen solo en este dispositivo.';
  }

  String _normalizedBaseUrl() {
    var base = syncBaseUrl?.trim() ?? '';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    if (base.endsWith('/api')) {
      base = base.substring(0, base.length - 4);
    }
    return '$base/';
  }

  String _normalizedJossRedBaseUrl() {
    var base = _authService.baseUrl?.trim() ?? '';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    if (base.endsWith('/api')) {
      base = base.substring(0, base.length - 4);
    }
    return '$base/';
  }

  Future<Map<String, String>> _headers() async {
    final token = await _authService.getAccessToken();
    return {
      'Authorization': 'Bearer ${token ?? ''}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  void triggerPush() {
    if (!isCloudMode) {
      printINFO('SyncService: cambio local registrado; cloud no esta activo.');
      return;
    }
    Hive.box('AppPrefs').put(_pendingKey, true);
    _queue.enqueueSnapshotChange(reason: 'local_mutation');
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      push().then((success) {
        if (success) {
          pull();
        }
      });
    });
  }

  Future<bool> checkConnection() async {
    try {
      final response = await _dio.get(
        '${_normalizedBaseUrl()}api/sync/status',
        options: Options(headers: await _headers()),
      );
      isOnline.value = response.statusCode == 200;
      return isOnline.value;
    } catch (_) {
      isOnline.value = false;
      return false;
    }
  }

  Future<bool> pull() async {
    if (!isCloudMode || !_authService.isAuthenticated.value) {
      return true;
    }
    if (isSyncing.value) return false;
    isSyncing.value = true;
    lastStatusMessage.value = 'Descargando cambios de EMusic...';

    try {
      final response = await _dio.get(
        '${_normalizedBaseUrl()}api/sync/pull',
        options: Options(headers: await _headers()),
      );

      if (response.statusCode != 200 || response.data == null) {
        lastStatusMessage.value = 'No se pudo descargar la sincronizacion.';
        printERROR(
            'SyncService pull: status ${response.statusCode}, body: ${_previewJson(response.data)}');
        return false;
      }

      final data = _resolveSyncPayload(response.data);
      final rawPlaylists = _firstNonNull(data, const [
        'playlists',
        'user_playlists',
        'library_playlists',
      ]);
      _logPullDiagnostics(response.data, data, rawPlaylists);
      _isApplyingRemoteChanges = true;
      try {
        await _mergePlaylists(rawPlaylists);
        await _replaceBoxValues(
          'LIBFAV',
          _firstNonNull(data, const ['favorites', 'user_favorites']),
        );
        await _replaceBoxValues(
          'LIBRP',
          _firstNonNull(data, const [
            'recent_plays',
            'recentPlays',
            'user_recent_plays',
          ]),
        );
        await _replaceBoxValues(
          'LibraryAlbums',
          _firstNonNull(data, const ['albums', 'user_albums']),
          idKeys: ['browseId', 'albumId', 'id'],
        );
        await _replaceBoxValues(
          'LibraryArtists',
          _firstNonNull(data, const ['artists', 'user_artists']),
          idKeys: ['browseId', 'channelId', 'artistId', 'id'],
        );
        await _mergeSettings(
          _firstNonNull(data, const ['settings', 'user_settings']),
        );

        await Hive.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        await Hive.box('AppPrefs').put(_pendingKey, false);
      } finally {
        _isApplyingRemoteChanges = false;
      }
      _refreshLibraryControllers();
      lastStatusMessage.value = 'Biblioteca sincronizada.';
      return true;
    } catch (e) {
      isOnline.value = false;
      lastStatusMessage.value = 'Sin conexion. Los cambios quedan pendientes.';
      printERROR('SyncService pull failed: $e');
      return false;
    } finally {
      isSyncing.value = false;
    }
  }

  void _logPullDiagnostics(
    dynamic rawResponse,
    Map<String, dynamic> resolved,
    dynamic playlistsValue,
  ) {
    if (!kDebugMode) return;

    final rawKeys = rawResponse is Map
        ? rawResponse.keys.map((k) => k.toString()).toList()
        : <String>[];

    printINFO(
      'SyncService pull: url=${_normalizedBaseUrl()}api/sync/pull | '
      'rawType=${rawResponse.runtimeType} | rawKeys=$rawKeys | '
      'resolvedKeys=${resolved.keys.toList()}',
    );

    if (playlistsValue == null) {
      printWarning(
        'SyncService pull: no se encontro clave de playlists. '
        'Respuesta: ${_previewJson(rawResponse)}',
      );
      return;
    }

    if (playlistsValue is! List) {
      printWarning(
        'SyncService pull: playlists no es List (${playlistsValue.runtimeType}).',
      );
      return;
    }

    printINFO(
      'SyncService pull: playlists=${playlistsValue.length} elemento(s).',
    );

    if (playlistsValue.isEmpty) {
      printWarning(
        'SyncService pull: playlists vacio. '
        'favorites=${_listLength(resolved, 'favorites')}, '
        'albums=${_listLength(resolved, 'albums')}, '
        'artists=${_listLength(resolved, 'artists')}',
      );
    }
  }

  int? _listLength(Map<String, dynamic> map, String key) {
    final value = map[key];
    return value is List ? value.length : null;
  }

  String _previewJson(dynamic value, {int maxChars = 1200}) {
    try {
      final encoded = const JsonEncoder.withIndent('  ').convert(value);
      if (encoded.length <= maxChars) return encoded;
      return '${encoded.substring(0, maxChars)}... [truncado]';
    } catch (_) {
      return value.toString();
    }
  }

  Future<bool> push() async {
    if (!isCloudMode || !_authService.isAuthenticated.value) {
      return true;
    }
    if (isSyncing.value) return false;
    isSyncing.value = true;
    lastStatusMessage.value = 'Subiendo cambios a EMusic...';

    try {
      final payload = await _buildPushPayload();
      final deviceId = await _ensureDeviceId();
      payload['device_id'] = deviceId;

      if (_socket != null && _isSocketAuthenticated) {
        _socket!.add(jsonEncode({
          "type": "push",
          "payload": payload,
          "device_id": deviceId
        }));
        await Hive.box('AppPrefs').put(_pendingKey, false);
        await _queue.markAllSynced();
        await Hive.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        lastStatusMessage.value = 'Cambios subidos correctamente (WS).';
        return true;
      }

      final response = await _dio.post(
        '${_normalizedBaseUrl()}api/sync/push',
        options: Options(headers: await _headers()),
        data: payload,
      );

      if (response.statusCode == 200) {
        await Hive.box('AppPrefs').put(_pendingKey, false);
        await _queue.markAllSynced();
        await Hive.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        lastStatusMessage.value = 'Cambios subidos correctamente.';
        return true;
      }

      await Hive.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value = 'No se pudo subir. Se reintentara despues.';
      printERROR(
          'SyncService push failed with status ${response.statusCode}: ${response.data}');
      return false;
    } catch (e) {
      isOnline.value = false;
      await Hive.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value =
          'Sin conexion. Cambios guardados para reintento.';
      printERROR('SyncService push failed: $e');
      return false;
    } finally {
      isSyncing.value = false;
    }
  }

  Future<Map<String, dynamic>> _buildPushPayload() async {
    final appPrefs = Hive.box('AppPrefs');
    return {
      'playlists': await _collectPlaylists(),
      'favorites': Hive.box('LIBFAV').values.toList(),
      'recent_plays': Hive.box('LIBRP').values.toList(),
      'albums': Hive.box('LibraryAlbums').values.toList(),
      'artists': Hive.box('LibraryArtists').values.toList(),
      'downloads': Hive.box('SongDownloads').values.toList(),
      'settings': _syncableSettings(appPrefs),
    };
  }

  Future<List<Map<String, dynamic>>> _collectPlaylists() async {
    final playlistsBox = Hive.box('LibraryPlaylists');
    final result = <Map<String, dynamic>>[];

    for (final value in playlistsBox.values) {
      final playlist = _asMap(value);
      final playlistId = playlist['playlistId']?.toString();
      if (playlistId == null || playlistId.isEmpty) continue;
      if (playlist['isPipedPlaylist'] == true) continue;

      final boxName = sanitizeBoxName(playlistId);
      final wasOpen = Hive.isBoxOpen(boxName);
      final tracksBox =
          wasOpen ? Hive.box(boxName) : await Hive.openBox(boxName);
      result.add({
        ...playlist,
        'tracks': tracksBox.values.toList(),
      });
      // Keep the tracks box open to prevent async read/write exceptions on closed boxes
    }

    return result;
  }

  Map<String, dynamic> _syncableSettings(Box appPrefs) {
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

  Future<void> _mergePlaylists(dynamic value) async {
    if (value == null) return;
    if (value is! List) {
      printWarning(
        'SyncService: playlists ignoradas (${value.runtimeType}).',
      );
      return;
    }

    final playlistsBox = Hive.box('LibraryPlaylists');
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
          final wasOpen = Hive.isBoxOpen(boxName);
          final tracksBox =
              wasOpen ? Hive.box(boxName) : await Hive.openBox(boxName);
          await tracksBox.clear();
          for (var i = 0; i < tracks.length; i++) {
            await tracksBox.put(i, tracks[i]);
          }
          // Keep the tracks box open to prevent async read/write exceptions on closed boxes
        } catch (e) {
          printERROR(
            'SyncService: no se pudo abrir box para playlist $playlistId: $e',
          );
        }
      }
      merged++;
    }

    if (merged == 0 && value.isNotEmpty) {
      printWarning(
        'SyncService: ninguna playlist mapeada de ${value.length} recibidas.',
      );
    } else if (merged > 0) {
      printINFO('SyncService: playlists mapeadas=$merged de ${value.length}.');
    }
  }

  Future<void> _replaceBoxValues(
    String boxName,
    dynamic value, {
    List<String> idKeys = const ['videoId', 'id'],
  }) async {
    if (value is! List) return;
    final box = Hive.isBoxOpen(boxName)
        ? Hive.box(boxName)
        : await Hive.openBox(boxName);
    await box.clear();
    for (var i = 0; i < value.length; i++) {
      final item = _asMap(value[i]);
      final key = _firstPresentKey(item, idKeys) ?? i;
      await box.put(key, item);
    }
  }

  Future<void> _mergeSettings(dynamic value) async {
    if (value is! Map) return;
    final settings = _asMap(value);
    final appPrefs = Hive.box('AppPrefs');
    for (final entry in settings.entries) {
      if (entry.key == 'updatedAt') continue;
      await appPrefs.put(entry.key, entry.value);
    }
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

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  Map<String, dynamic> _resolveSyncPayload(dynamic raw) {
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

  dynamic _firstNonNull(Map<String, dynamic> map, List<String> keys) {
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
    _refreshDefaultPlaylistScreen('LIBFAV');
    _refreshDefaultPlaylistScreen('LIBRP');
    if (Get.isRegistered<PlayerController>()) {
      Get.find<PlayerController>().refreshFavoriteState();
    }
  }

  void _refreshDefaultPlaylistScreen(String playlistId) {
    final tag = Key(playlistId).hashCode.toString();
    if (Get.isRegistered<PlaylistScreenController>(tag: tag)) {
      Get.find<PlaylistScreenController>(tag: tag)
          .fetchSongsfromDatabase(playlistId);
    }
  }

  Future<bool> pushCollaborative(Playlist playlist) async {
    if (!_authService.isAuthenticated.value) return false;
    printINFO('SyncService: Pushing collaborative playlist...');

    try {
      final tracksBox =
          await Hive.openBox(sanitizeBoxName(playlist.playlistId));
      final tracks = tracksBox.values.toList();

      final plMap = playlist.toJson();
      plMap['tracks'] = tracks;

      final response = await _dio.post(
        '${_normalizedBaseUrl()}api/sync/push-collaborative',
        options: Options(headers: await _headers()),
        data: {'playlist': plMap},
      );

      if (response.statusCode == 200) {
        printINFO('SyncService: Collaborative push completed successfully.');
        return true;
      } else {
        printERROR(
            'SyncService: Collaborative push failed with status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      printERROR('SyncService: Collaborative push failed with exception: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    if (!_authService.isAuthenticated.value) return [];
    try {
      final response = await _dio.get(
        '${_normalizedJossRedBaseUrl()}api/friends/search',
        queryParameters: {'query': query},
        options: Options(headers: await _headers()),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List users = response.data['users'] as List? ?? [];
        return users.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (e) {
      printERROR('SyncService: Search users failed: $e');
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchFriends() async {
    if (!_authService.isAuthenticated.value) return [];
    try {
      final response = await _dio.get(
        '${_normalizedJossRedBaseUrl()}api/friends',
        options: Options(headers: await _headers()),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List friends = response.data['friends'] as List? ?? [];
        return friends.map((u) => Map<String, dynamic>.from(u)).toList();
      }
    } catch (e) {
      printERROR('SyncService: Fetch friends failed: $e');
    }
    return [];
  }

  Future<List<Playlist>> fetchPublicPlaylists() async {
    if (!_authService.isAuthenticated.value) return [];
    try {
      final response = await _dio.get(
        '${_normalizedBaseUrl()}api/playlists/public',
        options: Options(headers: await _headers()),
      );
      if (response.statusCode == 200 && response.data != null) {
        final List playlists = response.data['playlists'] as List? ?? [];
        return playlists.map((p) => Playlist.fromJson(p)).toList();
      }
    } catch (e) {
      printERROR('SyncService: Fetch public playlists failed: $e');
    }
    return [];
  }

  String get _wsUrl {
    var base = syncBaseUrl ?? 'http://127.0.0.1:9000';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    base = base.replaceAll('https://', 'wss://').replaceAll('http://', 'ws://');
    return '$base/api/sync-ws';
  }

  Future<void> connectSocket() async {
    if (_socket != null || !isCloudMode || !_authService.isAuthenticated.value) return;
    printINFO("SyncService: Connecting to WS: $_wsUrl");
    try {
      _reconnectTimer?.cancel();
      _socket = await WebSocket.connect(_wsUrl).timeout(const Duration(seconds: 10));
      _isSocketAuthenticated = false;
      
      final token = await _authService.getAccessToken();
      final deviceId = await _ensureDeviceId();
      
      _socket!.add(jsonEncode({
        "type": "auth",
        "token": token ?? "",
        "device_id": deviceId
      }));

      _subscription = _socket!.listen(
        (message) {
          _handleSocketMessage(message.toString());
        },
        onError: (err) {
          printERROR("SyncService: WS Error: $err");
          _scheduleSocketReconnect();
        },
        onDone: () {
          printINFO("SyncService: WS Connection closed.");
          _scheduleSocketReconnect();
        },
      );
    } catch (e) {
      printERROR("SyncService: Connection failed: $e");
      _scheduleSocketReconnect();
    }
  }

  void _scheduleSocketReconnect() {
    _socket = null;
    _subscription?.cancel();
    _subscription = null;
    _isSocketAuthenticated = false;

    if (!isCloudMode || !_authService.isAuthenticated.value) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connectSocket();
    });
  }

  void disconnectSocket() {
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _subscription = null;
    _socket?.close();
    _socket = null;
    _isSocketAuthenticated = false;
    printINFO("SyncService: WS Disconnected.");
  }

  void _handleSocketMessage(String raw) {
    try {
      final Map<String, dynamic> data = jsonDecode(raw);
      final String? type = data['type'];
      printINFO("SyncService: WS Received message type: $type");

      switch (type) {
        case 'welcome':
          break;
        case 'authenticated':
          _isSocketAuthenticated = true;
          printINFO("SyncService: WS Authenticated successfully.");
          break;
        case 'auth_failed':
          _isSocketAuthenticated = false;
          printERROR("SyncService: WS Auth failed: ${data['message']}");
          disconnectSocket();
          break;
        case 'sync_update':
          printINFO("SyncService: WS received sync_update, pulling remote changes...");
          pull();
          break;
        case 'push_success':
          printINFO("SyncService: WS push succeeded.");
          break;
        case 'error':
          printERROR("SyncService: WS Error: ${data['message']}");
          break;
      }
    } catch (e) {
      printERROR("SyncService: WS Error parsing message: $e");
    }
  }

  Future<String> _ensureDeviceId() async {
    final prefs = Hive.box('AppPrefs');
    final existing = prefs.get('linkedDeviceId')?.toString();
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final deviceId = 'device-${DateTime.now().millisecondsSinceEpoch}';
    await prefs.put('linkedDeviceId', deviceId);
    return deviceId;
  }
}
