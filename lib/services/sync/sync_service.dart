import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/backup/app_backup_service.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/sync/cloud_migration_service.dart';
import 'package:harmonymusic/services/sync/pending_sync_queue_service.dart';

import 'package:harmonymusic/services/sync/client/sync_http_client.dart';
import 'package:harmonymusic/services/sync/client/sync_websocket_client.dart';
import 'package:harmonymusic/services/sync/repository/sync_local_repository.dart';

class SyncService extends GetxService {
  static const _modeKey = 'emusicDataMode';
  static const _pendingKey = 'hasPendingSync';
  static const _lastSyncKey = 'lastSuccessfulSyncAt';

  final SyncHttpClient _httpClient = SyncHttpClient();
  final SyncLocalRepository _repository = SyncLocalRepository();
  SyncWebSocketClient? _wsClient;

  final isSyncing = false.obs;
  final isOnline = true.obs;
  final lastStatusMessage = 'Modo local activo'.obs;
  Timer? _debounce;
  Timer? _retryTimer;
  bool _isApplyingRemoteChanges = false;
  int _localMutationRevision = 0;
  bool _pushRequestedWhileSyncing = false;
  int _activeLocalMutations = 0;
  Completer<void>? _pullCompletion;

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
    _wsClient?.dispose();
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

  void triggerPush() {
    if (!isCloudMode) {
      printINFO('SyncService: cambio local registrado; cloud no esta activo.');
      return;
    }

    // Increment synchronously. This closes the race where a mutation happens
    // while an older request is in flight but its durable queue write has not
    // completed yet.
    _localMutationRevision++;
    unawaited(_recordPendingMutation());
  }

  /// Serializes user writes against the destructive compatibility pull.
  /// The mutation must include both its Hive write and [triggerPush] call.
  Future<T> performLocalMutation<T>(Future<T> Function() mutation) async {
    while (true) {
      final activePull = _pullCompletion;
      if (activePull != null && !activePull.isCompleted) {
        await activePull.future;
        continue;
      }

      _activeLocalMutations++;
      // No await occurs between observing the pull and reserving the local
      // mutation slot, so pull() cannot enter concurrently on this isolate.
      if (_pullCompletion == null) break;
      _activeLocalMutations--;
    }

    try {
      return await mutation();
    } finally {
      _activeLocalMutations--;
    }
  }

  Future<void> _recordPendingMutation() async {
    await Hive.box('AppPrefs').put(_pendingKey, true);
    await _queue.enqueueSnapshotChange(reason: 'local_mutation');
    _schedulePush();
  }

  void _schedulePush({Duration delay = const Duration(seconds: 1)}) {
    _debounce?.cancel();
    _debounce = Timer(delay, () {
      unawaited(push());
    });
  }

  Future<bool> checkConnection() async {
    try {
      final token = await _authService.getAccessToken();
      final online =
          await _httpClient.checkConnection(_normalizedBaseUrl(), token ?? "");
      isOnline.value = online;
      return online;
    } catch (_) {
      isOnline.value = false;
      return false;
    }
  }

  Future<bool> pull() async {
    if (!isCloudMode || !_authService.isAuthenticated.value) {
      return true;
    }
    if (_hasPendingLocalChanges) {
      printINFO(
          'SyncService: Pull skipped because there are pending local changes to push.');
      return false;
    }
    if (_activeLocalMutations > 0) {
      printINFO(
          'SyncService: Pull skipped because a local mutation is in progress.');
      return false;
    }
    if (isSyncing.value) return false;
    isSyncing.value = true;
    final pullCompletion = Completer<void>();
    _pullCompletion = pullCompletion;
    final revisionAtStart = _localMutationRevision;
    lastStatusMessage.value = 'Descargando cambios de EMusic...';

    try {
      final token = await _authService.getAccessToken();
      final responseData =
          await _httpClient.pull(_normalizedBaseUrl(), token ?? "");

      if (responseData == null) {
        lastStatusMessage.value = 'No se pudo descargar la sincronizacion.';
        return false;
      }

      // Never apply a remote snapshot over a mutation made while the request
      // was in flight. The pending push will run after this pull releases the
      // coordinator.
      if (_localMutationRevision != revisionAtStart ||
          _hasPendingLocalChanges) {
        lastStatusMessage.value =
            'Hay cambios locales nuevos. Se subiran antes de descargar.';
        return false;
      }

      final data = _repository.resolveSyncPayload(responseData);
      final rawPlaylists = _repository.firstNonNull(data, const [
        'playlists',
        'user_playlists',
        'library_playlists',
      ]);

      if (kDebugMode) {
        final rawKeys = responseData.keys.toList();
        printINFO(
          'SyncService pull: url=${_normalizedBaseUrl()}api/sync/pull | '
          'rawKeys=$rawKeys | resolvedKeys=${data.keys.toList()}',
        );
      }

      _isApplyingRemoteChanges = true;
      try {
        await _repository.mergePlaylists(rawPlaylists);
        await _repository.replaceBoxValues(
          'LIBFAV',
          _repository.firstNonNull(data, const ['favorites', 'user_favorites']),
        );
        await _repository.replaceBoxValues(
          'LIBRP',
          _repository.firstNonNull(data, const [
            'recent_plays',
            'recentPlays',
            'user_recent_plays',
          ]),
        );
        await _repository.replaceBoxValues(
          'LibraryAlbums',
          _repository.firstNonNull(data, const ['albums', 'user_albums']),
          idKeys: ['browseId', 'albumId', 'id'],
        );
        await _repository.replaceBoxValues(
          'LibraryArtists',
          _repository.firstNonNull(data, const ['artists', 'user_artists']),
          idKeys: ['browseId', 'channelId', 'artistId', 'id'],
        );
        await _repository.mergeSettings(
          _repository.firstNonNull(data, const ['settings', 'user_settings']),
        );

        await Hive.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        await _updatePendingFlag();
      } finally {
        _isApplyingRemoteChanges = false;
      }
      _refreshLibraryControllers();
      lastStatusMessage.value = 'Biblioteca sincronizada.';
      return true;
    } catch (e, stack) {
      isOnline.value = false;
      lastStatusMessage.value = 'Sin conexion. Los cambios quedan pendientes.';
      printERROR('SyncService pull failed: $e\n$stack');
      return false;
    } finally {
      if (_pullCompletion == pullCompletion) {
        _pullCompletion = null;
        if (!pullCompletion.isCompleted) pullCompletion.complete();
      }
      isSyncing.value = false;
      if (_hasPendingLocalChanges) {
        _schedulePush(delay: Duration.zero);
      }
    }
  }

  Future<bool> push() async {
    if (!isCloudMode || !_authService.isAuthenticated.value) {
      return true;
    }
    if (isSyncing.value) {
      _pushRequestedWhileSyncing = true;
      return false;
    }
    isSyncing.value = true;
    _pushRequestedWhileSyncing = false;
    lastStatusMessage.value = 'Subiendo cambios a EMusic...';

    try {
      // Only these queue entries and this mutation revision are represented by
      // this request. Newer entries must never be acknowledged by it.
      final capturedPendingIds = _queue.capturePendingIds();
      final capturedRevision = _localMutationRevision;
      final payload = await _repository.buildPushPayload();
      final deviceId = await _ensureDeviceId();
      payload['device_id'] = deviceId;

      if (_wsClient != null && _wsClient!.isAuthenticated) {
        final success = await _wsClient!.sendPushPayload(payload);
        if (success) {
          await _acknowledgePush(capturedPendingIds, capturedRevision);
          await Hive.box('AppPrefs')
              .put(_lastSyncKey, DateTime.now().toIso8601String());
          lastStatusMessage.value = 'Cambios subidos correctamente (WS).';
          return true;
        } else {
          await Hive.box('AppPrefs').put(_pendingKey, true);
          await _queue.markRetryScheduled();
          lastStatusMessage.value =
              'No se pudo subir via WS. Se reintentara despues.';
          return false;
        }
      }

      final token = await _authService.getAccessToken();
      final success =
          await _httpClient.push(_normalizedBaseUrl(), token ?? "", payload);

      if (success) {
        await _acknowledgePush(capturedPendingIds, capturedRevision);
        await Hive.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        lastStatusMessage.value = 'Cambios subidos correctamente.';
        return true;
      }

      await Hive.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value = 'No se pudo subir. Se reintentara despues.';
      return false;
    } catch (e, stack) {
      isOnline.value = false;
      await Hive.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value =
          'Sin conexion. Cambios guardados para reintento.';
      printERROR('SyncService push failed: $e\n$stack');
      return false;
    } finally {
      isSyncing.value = false;
      if (_pushRequestedWhileSyncing || _hasPendingLocalChanges) {
        _pushRequestedWhileSyncing = false;
        _schedulePush(delay: Duration.zero);
      }
    }
  }

  bool get _hasPendingLocalChanges =>
      Hive.box('AppPrefs').get(_pendingKey, defaultValue: false) == true ||
      _queue.hasPendingChanges;

  Future<void> _acknowledgePush(
    List<String> capturedPendingIds,
    int capturedRevision,
  ) async {
    await _queue.markSynced(capturedPendingIds);
    final hasNewerMutation =
        _localMutationRevision != capturedRevision || _queue.hasPendingChanges;
    await Hive.box('AppPrefs').put(_pendingKey, hasNewerMutation);
  }

  Future<void> _updatePendingFlag() async {
    await Hive.box('AppPrefs').put(_pendingKey, _queue.hasPendingChanges);
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

      final token = await _authService.getAccessToken();
      final success = await _httpClient.pushCollaborative(
          _normalizedBaseUrl(), token ?? "", plMap);

      if (success) {
        printINFO('SyncService: Collaborative push completed successfully.');
        return true;
      }
      return false;
    } catch (e) {
      printERROR('SyncService: Collaborative push failed with exception: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    if (!_authService.isAuthenticated.value) {
      throw StateError('Debes iniciar sesión para buscar amigos');
    }
    final token = await _authService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw StateError('La sesión no contiene un token válido');
    }
    return _httpClient.searchUsers(
        _normalizedJossRedBaseUrl(), token, query.trim());
  }

  Future<List<Map<String, dynamic>>> fetchFriends() async {
    if (!_authService.isAuthenticated.value) return [];
    final token = await _authService.getAccessToken();
    return _httpClient.fetchFriends(_normalizedJossRedBaseUrl(), token ?? "");
  }

  Future<List<Map<String, dynamic>>> fetchRequests() async {
    if (!_authService.isAuthenticated.value) return [];
    final token = await _authService.getAccessToken();
    return _httpClient.fetchRequests(_normalizedJossRedBaseUrl(), token ?? "");
  }

  Future<List<Map<String, dynamic>>> fetchBlocked() async {
    if (!_authService.isAuthenticated.value) return [];
    final token = await _authService.getAccessToken();
    return _httpClient.fetchBlocked(_normalizedJossRedBaseUrl(), token ?? "");
  }

  Future<Map<String, dynamic>> sendFriendRequest(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': 'No autenticado'};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.sendFriendRequest(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> acceptFriendRequest(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': 'No autenticado'};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.acceptFriendRequest(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> removeFriendship(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': 'No autenticado'};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.removeFriendship(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> blockUser(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': 'No autenticado'};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.blockUser(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> unblockUser(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': 'No autenticado'};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.unblockUser(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<List<Playlist>> fetchPublicPlaylists() async {
    if (!_authService.isAuthenticated.value) return [];
    final token = await _authService.getAccessToken();
    final rawPlaylists = await _httpClient.fetchPublicPlaylists(
        _normalizedBaseUrl(), token ?? "");
    return rawPlaylists.map((p) => Playlist.fromJson(p)).toList();
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
    if (!isCloudMode || !_authService.isAuthenticated.value) return;

    if (_wsClient == null) {
      final deviceId = await _ensureDeviceId();
      _wsClient = SyncWebSocketClient(deviceId: deviceId);
      _wsClient!.onSyncUpdate.listen((_) {
        printINFO(
            "SyncService: WS received sync_update, pulling remote changes...");
        pull();
      });
    }

    final token = await _authService.getAccessToken();
    if (token != null) {
      await _wsClient!.connect(_wsUrl, token);
    }
  }

  void disconnectSocket() {
    _wsClient?.disconnect();
    printINFO("SyncService: WS Disconnected.");
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
}
