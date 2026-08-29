import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:estrella_music/generated/l10n.dart';

import 'package:estrella_music/models/playlist.dart';
import 'package:estrella_music/ui/screens/Library/library_controller.dart';
import 'package:estrella_music/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/services/sync/pending_sync_queue_service.dart';
import 'package:estrella_music/services/sync/music_sqlite_service.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/profiles/music_profile.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';

import 'package:estrella_music/services/sync/client/sync_http_client.dart';
import 'package:estrella_music/services/sync/client/sync_websocket_client.dart';
import 'package:estrella_music/services/sync/repository/sync_local_repository.dart';

class SyncService extends GetxService {
  String get _profileKey =>
      Get.find<ProfileManager>().activeProfile.value?.id ?? 'no-profile';
  String get _pendingKey => 'hasPendingSync::$_profileKey';
  String get _lastSyncKey => 'lastSuccessfulSyncAt::$_profileKey';
  String get pendingPreferenceKey => _pendingKey;
  String get lastSyncPreferenceKey => _lastSyncKey;
  bool get hasPendingChanges => _hasPendingLocalChanges;

  final SyncHttpClient _httpClient = SyncHttpClient();
  final SyncLocalRepository _repository = SyncLocalRepository();
  SyncWebSocketClient? _wsClient;

  final isSyncing = false.obs;
  final isOnline = true.obs;
  final lastStatusMessage = S.current.syncLocalModeActive.obs;
  Timer? _debounce;
  Timer? _retryTimer;
  bool _isApplyingRemoteChanges = false;
  int _localMutationRevision = 0;
  int _pushRetryAttempt = 0;
  bool _pushRequestedWhileSyncing = false;
  int _activeLocalMutations = 0;
  Completer<void>? _pullCompletion;
  bool _authoritativeUploadInProgress = false;
  bool _fullPullRequested = false;
  List<String> _authoritativeOutboxIds = const [];
  List<String> _authoritativeQueueIds = const [];
  final List<StreamSubscription<dynamic>> _profileBoxSubscriptions = [];
  Worker? _profileWorker;

  AuthService get _authService => Get.find<AuthService>();
  PendingSyncQueueService get _queue => Get.find<PendingSyncQueueService>();
  MusicSqliteService get _musicDatabase => Get.find<MusicSqliteService>();

  String get _accountKey {
    final user = _authService.userProfile.value;
    final account =
        (user?['id'] ?? user?['user_id'] ?? user?['email'] ?? 'cloud-user')
            .toString();
    final profileId =
        Get.find<ProfileManager>().activeProfile.value?.id ?? 'no-profile';
    return '$account::$profileId';
  }

  @override
  void onInit() {
    super.onInit();
    _retryTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
      if (_authoritativeUploadInProgress) return;
      if (!isCloudMode || !_authService.isAuthenticated.value) return;
      final online = await checkConnection();
      if (!online) return;

      final hasPending = SqliteStore.box('AppPrefs').get(_pendingKey) == true;
      if (hasPending) {
        final success = await push();
        if (success) await pull();
      } else {
        await pull();
      }
    });
    _setupLocalMutationWatchers();
    _profileWorker = ever<MusicProfile?>(
      Get.find<ProfileManager>().activeProfile,
      (_) => _setupLocalMutationWatchers(),
    );

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
    unawaited(_syncOnStartup());
  }

  Future<void> _syncOnStartup() async {
    // Wait a brief moment to let other services initialize (e.g. HttpClient, AuthService)
    await Future.delayed(const Duration(milliseconds: 500));
    if (_authoritativeUploadInProgress ||
        !isCloudMode ||
        !_authService.isAuthenticated.value) {
      return;
    }

    final online = await checkConnection();
    if (!online) return;

    final hasPending = SqliteStore.box('AppPrefs').get(_pendingKey) == true;
    if (hasPending) {
      final success = await push();
      if (success) await pull();
    } else {
      await pull();
    }
  }

  void _setupLocalMutationWatchers() {
    for (final subscription in _profileBoxSubscriptions) {
      unawaited(subscription.cancel());
    }
    _profileBoxSubscriptions.clear();
    const entityBoxes = {
      'LIBFAV': 'favorite',
      'LIBRP': 'recent_play',
      'LibraryAlbums': 'album',
      'LibraryArtists': 'artist',
      'LibraryPlaylists': 'playlist',
    };

    for (final entry in entityBoxes.entries) {
      _profileBoxSubscriptions
          .add(SqliteStore.box(entry.key).watch().listen((event) {
        if (_isApplyingRemoteChanges) return;
        if (entry.key == 'LibraryPlaylists') {
          final playlistId = event.key.toString();
          unawaited(recordPlaylistChange(
            playlistId,
            deleted: event.deleted,
          ));
          return;
        }
        unawaited(_recordBoxMutation(entry.key, entry.value, event));
      }));
    }

    _profileBoxSubscriptions
        .add(SqliteStore.box('AppPrefs').watch().listen((event) {
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
        unawaited(_recordEntityChange(
          entityType: 'setting',
          entityId: event.key.toString(),
          operation: event.deleted ? 'delete' : 'upsert',
          payload: event.deleted
              ? const {}
              : {'key': event.key.toString(), 'value': event.value},
        ));
      }
    }));
  }

  Future<void> _recordBoxMutation(
    String boxName,
    String entityType,
    SqliteBoxEvent event,
  ) async {
    final payload = event.value is Map
        ? Map<String, dynamic>.from(
            (event.value as Map)
                .map((key, value) => MapEntry(key.toString(), value)),
          )
        : <String, dynamic>{};
    final entityId = _entityIdForBox(boxName, event.key, payload);
    if (entityId == null || entityId.isEmpty) return;
    await _recordEntityChange(
      entityType: entityType,
      entityId: entityId,
      operation: event.deleted ? 'delete' : 'upsert',
      payload: payload,
    );
  }

  String? _entityIdForBox(
    String boxName,
    dynamic key,
    Map<String, dynamic> payload,
  ) {
    const idKeys = {
      'LIBFAV': ['videoId', 'id'],
      'LIBRP': ['videoId', 'id'],
      'LibraryAlbums': ['browseId', 'albumId', 'id'],
      'LibraryArtists': ['channelId', 'artistId', 'id'],
      'LibraryPlaylists': ['playlistId', 'playlist_id', 'id'],
    };
    for (final idKey in idKeys[boxName] ?? const <String>[]) {
      final value = payload[idKey]?.toString();
      if (value != null && value.isNotEmpty && value != 'null') return value;
    }
    return key?.toString();
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
    _profileWorker?.dispose();
    for (final subscription in _profileBoxSubscriptions) {
      unawaited(subscription.cancel());
    }
    super.onClose();
  }

  bool get isCloudMode => Get.find<ProfileManager>().activeProfileMaySync;

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
      await SqliteStore.box('AppPrefs').put(_pendingKey, true);
      lastStatusMessage.value = S.current.syncCloudPending;
      triggerPush();
      return;
    }

    final profiles = Get.find<ProfileManager>();
    final providers = Get.find<MusicProviderManager>();
    final authorizedProviderId =
        providers.availableProviderIds.firstWhereOrNull(
      (id) =>
          providers.registrationFor(id)?.trust ==
          ProviderTrust.jossRedAuthorized,
    );
    if (authorizedProviderId == null) {
      throw StateError('No authorized Joss Red music provider is installed');
    }
    var cloudProfile = profiles.profiles.firstWhereOrNull(
      (profile) => profile.providerId == authorizedProviderId,
    );
    cloudProfile ??= await profiles.createProfile(
      name: 'eMusic',
      providerId: authorizedProviderId,
    );
    await profiles.switchProfile(cloudProfile.id);
    await SqliteStore.box('AppPrefs').put(_pendingKey, false);
    lastStatusMessage.value = S.current.syncCloudDownloadingExisting;
    await pull();
  }

  Future<void> keepLocalMode() async {
    final profiles = Get.find<ProfileManager>();
    final localProviderId = Get.find<MusicProviderManager>().localProviderId;
    final local = profiles.profiles.firstWhere(
      (profile) => profile.providerId == localProviderId,
    );
    await profiles.switchProfile(local.id);
    await SqliteStore.box('AppPrefs').put(_pendingKey, false);
    lastStatusMessage.value = S.current.syncLocalDeviceOnly;
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
    unawaited(_markPendingAndSchedule());
  }

  /// Serializes user writes against the destructive compatibility pull.
  /// The mutation must include both its SqliteStore write and [triggerPush] call.
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

  Future<void> _markPendingAndSchedule() async {
    await SqliteStore.box('AppPrefs').put(_pendingKey, true);
    _schedulePush();
  }

  Future<void> _recordEntityChange({
    required String entityType,
    required String entityId,
    required String operation,
    Map<String, dynamic> payload = const {},
    String? parentId,
  }) async {
    if (!isCloudMode) return;
    await _musicDatabase.recordLocalChange(
      accountKey: _accountKey,
      entityType: entityType,
      entityId: entityId,
      operation: operation,
      payload: payload,
      parentId: parentId,
    );
    triggerPush();
  }

  Future<void> recordPlaylistChange(
    String playlistId, {
    bool deleted = false,
  }) async {
    if (deleted) {
      await _recordEntityChange(
        entityType: 'playlist',
        entityId: playlistId,
        operation: 'delete',
      );
      return;
    }
    final metadata = SqliteStore.box('LibraryPlaylists').get(playlistId);
    if (metadata is! Map) return;
    final payload = Map<String, dynamic>.from(
      metadata.map((key, value) => MapEntry(key.toString(), value)),
    );
    final boxName = sanitizeBoxName(playlistId);
    final tracksBox = SqliteStore.isBoxOpen(boxName)
        ? SqliteStore.box(boxName)
        : await SqliteStore.openBox(boxName);
    payload['tracks'] = tracksBox.values.toList();
    await _recordEntityChange(
      entityType: 'playlist',
      entityId: playlistId,
      operation: 'upsert',
      payload: payload,
    );
  }

  Future<void> recordPlaylistTrackChange(
    String playlistId,
    String trackId, {
    required bool deleted,
    Map<String, dynamic> track = const {},
    int? position,
  }) async {
    await _recordEntityChange(
      entityType: 'playlist_track',
      entityId: '$playlistId:$trackId',
      operation: deleted ? 'delete' : 'upsert',
      parentId: playlistId,
      payload: {
        ...track,
        'playlist_id': playlistId,
        'videoId': trackId,
        if (position != null) 'position': position,
      },
    );
  }

  Future<void> recordFavoriteChange(
    String trackId, {
    required bool deleted,
    Map<String, dynamic> track = const {},
  }) async {
    await _recordEntityChange(
      entityType: 'favorite',
      entityId: trackId,
      operation: deleted ? 'delete' : 'upsert',
      payload: deleted ? const {} : track,
    );
  }

  void _schedulePush({Duration delay = const Duration(seconds: 1)}) {
    if (_authoritativeUploadInProgress) return;
    _debounce?.cancel();
    _debounce = Timer(delay, () {
      unawaited(push());
    });
  }

  Duration _nextPushRetryDelay() {
    const retrySeconds = [5, 10, 20, 40, 80, 160, 300];
    final index = _pushRetryAttempt < retrySeconds.length
        ? _pushRetryAttempt
        : retrySeconds.length - 1;
    _pushRetryAttempt++;
    return Duration(seconds: retrySeconds[index]);
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
    if (_authoritativeUploadInProgress) return false;
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
    lastStatusMessage.value = S.current.syncDownloading;

    try {
      final token = await _authService.getAccessToken();
      if (_musicDatabase.isBootstrapComplete(_accountKey)) {
        return await _pullIncremental(token ?? '');
      }
      final responseData =
          await _httpClient.pull(_normalizedBaseUrl(), token ?? "");

      if (responseData == null) {
        lastStatusMessage.value = S.current.syncDownloadFailed;
        return false;
      }

      // Never apply a remote snapshot over a mutation made while the request
      // was in flight. The pending push will run after this pull releases the
      // coordinator.
      if (_localMutationRevision != revisionAtStart ||
          _hasPendingLocalChanges) {
        lastStatusMessage.value = S.current.syncLocalChangesFirst;
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

        await _musicDatabase.importServerSnapshot(_accountKey, data);
        final serverVersion = _asInt(responseData['server_version']);
        await _musicDatabase.markBootstrapComplete(
          _accountKey,
          serverVersion,
        );

        await SqliteStore.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        await _updatePendingFlag();
      } finally {
        _isApplyingRemoteChanges = false;
      }
      _refreshLibraryControllers();
      lastStatusMessage.value = S.current.syncLibrarySynced;
      return true;
    } catch (e, stack) {
      isOnline.value = false;
      lastStatusMessage.value = S.current.syncOfflinePending;
      printERROR('SyncService pull failed: $e\n$stack');
      return false;
    } finally {
      if (_pullCompletion == pullCompletion) {
        _pullCompletion = null;
        if (!pullCompletion.isCompleted) pullCompletion.complete();
      }
      isSyncing.value = false;
      if (_fullPullRequested &&
          !_hasPendingLocalChanges &&
          !_authoritativeUploadInProgress) {
        _fullPullRequested = false;
        unawaited(pull());
      } else if (_hasPendingLocalChanges) {
        _schedulePush(delay: Duration.zero);
      }
    }
  }

  Future<bool> _pullIncremental(String token) async {
    final accountKey = _accountKey;
    final sinceVersion = _musicDatabase.lastServerVersion(accountKey);
    final response = await _httpClient.pullChanges(
      _normalizedBaseUrl(),
      token,
      sinceVersion,
    );
    final rawChanges = response['changes'];
    final changes = rawChanges is List
        ? rawChanges
            .whereType<Map>()
            .map((change) => Map<String, dynamic>.from(change))
            .toList()
        : <Map<String, dynamic>>[];
    final serverVersion = _asInt(response['server_version']);

    if (changes.any(
        (change) => change['entity_type']?.toString() == 'library_reset')) {
      await _discardPendingChangesSupersededByReset(serverVersion);
      await _musicDatabase.markBootstrapIncomplete(accountKey);
      _fullPullRequested = true;
      lastStatusMessage.value = S.current.syncDownloading;
      return false;
    }

    _isApplyingRemoteChanges = true;
    try {
      await _musicDatabase.applyRemoteChanges(accountKey, changes);
      await _applyIncrementalChangesToLocalStore(changes);
      await _musicDatabase.markBootstrapComplete(accountKey, serverVersion);
      await SqliteStore.box('AppPrefs')
          .put(_lastSyncKey, DateTime.now().toIso8601String());
    } finally {
      _isApplyingRemoteChanges = false;
    }
    _refreshLibraryControllers();
    lastStatusMessage.value = changes.isEmpty
        ? S.current.syncLibraryUpToDate
        : S.current.syncChangesSynced(changes.length);
    return true;
  }

  Future<void> _discardPendingChangesSupersededByReset(
      int serverVersion) async {
    final outboxIds = _musicDatabase.pendingChangeIds(_accountKey);
    await _musicDatabase.markChangesSynced(
      _accountKey,
      outboxIds,
      serverVersion,
    );
    await _queue.markSynced(_queue.capturePendingIds());
    await SqliteStore.box('AppPrefs').put(_pendingKey, false);
  }

  Future<void> _handleRemoteSyncUpdate() async {
    if (_authoritativeUploadInProgress) return;
    if (isSyncing.value) {
      Future<void>.delayed(const Duration(seconds: 1), _handleRemoteSyncUpdate);
      return;
    }
    if (!_hasPendingLocalChanges) {
      await pull();
      return;
    }

    try {
      final token = await _authService.getAccessToken();
      final response = await _httpClient.pullChanges(
        _normalizedBaseUrl(),
        token ?? '',
        _musicDatabase.lastServerVersion(_accountKey),
      );
      final rawChanges = response['changes'];
      final hasReset = rawChanges is List &&
          rawChanges.whereType<Map>().any(
              (change) => change['entity_type']?.toString() == 'library_reset');
      if (!hasReset) return;

      final serverVersion = _asInt(response['server_version']);
      await _discardPendingChangesSupersededByReset(serverVersion);
      await _musicDatabase.markBootstrapIncomplete(_accountKey);
      await pull();
    } catch (error) {
      printERROR('SyncService reset check failed: $error');
    }
  }

  Future<void> _applyIncrementalChangesToLocalStore(
    List<Map<String, dynamic>> changes,
  ) async {
    for (final change in changes) {
      final entityType = change['entity_type']?.toString() ?? '';
      final entityId = change['entity_id']?.toString() ?? '';
      final operation = change['operation']?.toString() ?? 'upsert';
      final payload = _changePayload(change);
      switch (entityType) {
        case 'favorite':
          await _applyBoxChange('LIBFAV', entityId, operation, payload);
          break;
        case 'recent_play':
          await _applyBoxChange('LIBRP', entityId, operation, payload);
          break;
        case 'album':
          await _applyBoxChange('LibraryAlbums', entityId, operation, payload);
          break;
        case 'artist':
          await _applyBoxChange('LibraryArtists', entityId, operation, payload);
          break;
        case 'playlist':
          await _applyPlaylistChange(entityId, operation, payload);
          break;
        case 'playlist_track':
          await _applyPlaylistTrackChange(entityId, operation, payload);
          break;
        case 'setting':
          final key = payload['key']?.toString() ?? entityId;
          if (operation == 'delete') {
            await SqliteStore.box('AppPrefs').delete(key);
          } else {
            await SqliteStore.box('AppPrefs').put(key, payload['value']);
          }
          break;
      }
    }
  }

  Future<void> _applyBoxChange(
    String boxName,
    String entityId,
    String operation,
    Map<String, dynamic> payload,
  ) async {
    final box = SqliteStore.box(boxName);
    if (operation == 'delete') {
      await box.delete(entityId);
    } else {
      await box.put(entityId, payload);
    }
  }

  Future<void> _applyPlaylistChange(
    String entityId,
    String operation,
    Map<String, dynamic> payload,
  ) async {
    final playlists = SqliteStore.box('LibraryPlaylists');
    if (operation == 'delete') {
      await playlists.delete(entityId);
      final boxName = sanitizeBoxName(entityId);
      if (SqliteStore.isBoxOpen(boxName)) {
        await SqliteStore.box(boxName).clear();
      }
      return;
    }
    final tracks = payload.remove('tracks');
    await playlists.put(entityId, payload);
    if (tracks is List) {
      final boxName = sanitizeBoxName(entityId);
      final box = SqliteStore.isBoxOpen(boxName)
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      await box.clear();
      for (var i = 0; i < tracks.length; i++) {
        await box.put(i, tracks[i]);
      }
    }
  }

  Future<void> _applyPlaylistTrackChange(
    String entityId,
    String operation,
    Map<String, dynamic> payload,
  ) async {
    final playlistId =
        payload['playlist_id']?.toString() ?? entityId.split(':').first;
    final trackId = payload['videoId']?.toString() ??
        (entityId.contains(':')
            ? entityId.substring(entityId.indexOf(':') + 1)
            : entityId);
    final boxName = sanitizeBoxName(playlistId);
    final box = SqliteStore.isBoxOpen(boxName)
        ? SqliteStore.box(boxName)
        : await SqliteStore.openBox(boxName);
    final existingKey = box.keys.cast<dynamic>().firstWhere(
          (key) => (box.get(key) as Map?)?['videoId']?.toString() == trackId,
          orElse: () => null,
        );
    if (existingKey != null) await box.delete(existingKey);
    if (operation != 'delete') {
      final requestedPosition = _asInt(payload['position']);
      final key = requestedPosition >= 0 && !box.containsKey(requestedPosition)
          ? requestedPosition
          : null;
      if (key == null) {
        await box.add(payload);
      } else {
        await box.put(key, payload);
      }
    }
  }

  Map<String, dynamic> _changePayload(Map<String, dynamic> change) {
    final raw = change['payload'] ?? change['payload_json'];
    if (raw is Map) {
      return Map<String, dynamic>.from(
        raw.map((key, value) => MapEntry(key.toString(), value)),
      );
    }
    if (raw is String && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return Map<String, dynamic>.from(
          decoded.map((key, value) => MapEntry(key.toString(), value)),
        );
      }
    }
    return <String, dynamic>{};
  }

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  Future<bool> push() async {
    if (_authoritativeUploadInProgress) return false;
    if (!isCloudMode || !_authService.isAuthenticated.value) {
      return true;
    }
    if (isSyncing.value) {
      _pushRequestedWhileSyncing = true;
      return false;
    }
    _debounce?.cancel();
    _debounce = null;
    isSyncing.value = true;
    _pushRequestedWhileSyncing = false;
    var pushSucceeded = false;
    lastStatusMessage.value = S.current.syncUploading;

    try {
      final incrementalChanges = _musicDatabase.pendingChanges(_accountKey);
      if (incrementalChanges.isNotEmpty) {
        pushSucceeded = await _pushIncrementalChanges(incrementalChanges);
        if (pushSucceeded) _pushRetryAttempt = 0;
        return pushSucceeded;
      }
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
          pushSucceeded = true;
          _pushRetryAttempt = 0;
          await _acknowledgePush(capturedPendingIds, capturedRevision);
          await SqliteStore.box('AppPrefs')
              .put(_lastSyncKey, DateTime.now().toIso8601String());
          lastStatusMessage.value = S.current.syncUploadSuccessWs;
          return true;
        } else {
          await SqliteStore.box('AppPrefs').put(_pendingKey, true);
          await _queue.markRetryScheduled();
          lastStatusMessage.value = S.current.syncUploadWsRetry;
          return false;
        }
      }

      final token = await _authService.getAccessToken();
      final success =
          await _httpClient.push(_normalizedBaseUrl(), token ?? "", payload);

      if (success) {
        pushSucceeded = true;
        _pushRetryAttempt = 0;
        await _acknowledgePush(capturedPendingIds, capturedRevision);
        await SqliteStore.box('AppPrefs')
            .put(_lastSyncKey, DateTime.now().toIso8601String());
        lastStatusMessage.value = S.current.syncUploadSuccess;
        return true;
      }

      await SqliteStore.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value = S.current.syncUploadRetry;
      return false;
    } on DioException catch (e) {
      isOnline.value = false;
      await SqliteStore.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value = S.current.syncOfflineRetry;
      debugPrint('[SyncService] Sync push postponed (${e.type}): ${e.message}');
      return false;
    } catch (e, stack) {
      isOnline.value = false;
      await SqliteStore.box('AppPrefs').put(_pendingKey, true);
      await _queue.markRetryScheduled();
      lastStatusMessage.value = S.current.syncOfflineRetry;
      printERROR('SyncService push failed: $e\n$stack');
      return false;
    } finally {
      isSyncing.value = false;
      if (_authoritativeUploadInProgress) {
        _pushRequestedWhileSyncing = false;
      } else if (_pushRequestedWhileSyncing) {
        _pushRequestedWhileSyncing = false;
        _schedulePush();
      } else if (_hasPendingLocalChanges) {
        _schedulePush(
          delay: pushSucceeded ? Duration.zero : _nextPushRetryDelay(),
        );
      }
    }
  }

  Future<bool> _pushIncrementalChanges(
    List<PendingMusicChange> changes,
  ) async {
    final accountKey = _accountKey;
    final changeIds = changes.map((change) => change.changeId).toList();
    try {
      final token = await _authService.getAccessToken();
      final deviceId = await _ensureDeviceId();
      final response = await _httpClient.pushChanges(
        _normalizedBaseUrl(),
        token ?? '',
        changes.map((change) => change.toApiJson()).toList(),
        deviceId,
      );
      final acceptedRaw = response['accepted_change_ids'];
      final accepted = acceptedRaw is List
          ? acceptedRaw.map((value) => value.toString()).toSet()
          : <String>{};
      if (!changeIds.every(accepted.contains)) {
        await _musicDatabase.markChangesForRetry(accountKey, changeIds);
        lastStatusMessage.value = S.current.syncUnconfirmedRetry;
        return false;
      }
      final serverVersion = _asInt(response['server_version']);
      await _musicDatabase.markChangesSynced(
        accountKey,
        changeIds,
        serverVersion,
      );
      await _updatePendingFlag();
      await SqliteStore.box('AppPrefs')
          .put(_lastSyncKey, DateTime.now().toIso8601String());
      lastStatusMessage.value =
          S.current.syncChangesConfirmed(changeIds.length);
      return true;
    } catch (_) {
      await _musicDatabase.markChangesForRetry(accountKey, changeIds);
      rethrow;
    }
  }

  bool get _hasPendingLocalChanges =>
      SqliteStore.box('AppPrefs').get(_pendingKey, defaultValue: false) ==
          true ||
      _queue.hasPendingChanges ||
      (isCloudMode && _musicDatabase.hasPendingChanges(_accountKey));

  Future<void> _acknowledgePush(
    List<String> capturedPendingIds,
    int capturedRevision,
  ) async {
    await _queue.markSynced(capturedPendingIds);
    final hasNewerMutation =
        _localMutationRevision != capturedRevision || _queue.hasPendingChanges;
    await SqliteStore.box('AppPrefs').put(_pendingKey, hasNewerMutation);
  }

  Future<void> _updatePendingFlag() async {
    final hasPending = _queue.hasPendingChanges ||
        (isCloudMode && _musicDatabase.hasPendingChanges(_accountKey));
    await SqliteStore.box('AppPrefs').put(_pendingKey, hasPending);
  }

  /// Stops network synchronization and captures only the pending entries
  /// represented by the authoritative local snapshot about to be uploaded.
  Future<bool> pauseForAuthoritativeUpload() async {
    if (_authoritativeUploadInProgress) return false;
    _authoritativeUploadInProgress = true;
    _debounce?.cancel();
    _debounce = null;
    disconnectSocket();

    final deadline = DateTime.now().add(const Duration(seconds: 60));
    while (isSyncing.value && DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    if (isSyncing.value) {
      _authoritativeUploadInProgress = false;
      unawaited(connectSocket());
      return false;
    }

    _authoritativeOutboxIds = _musicDatabase.pendingChangeIds(_accountKey);
    _authoritativeQueueIds = _queue.capturePendingIds();
    return true;
  }

  Future<void> completeAuthoritativeUpload(int serverVersion) async {
    await _musicDatabase.markChangesSynced(
      _accountKey,
      _authoritativeOutboxIds,
      serverVersion,
    );
    await _musicDatabase.markBootstrapComplete(_accountKey, serverVersion);
    await _queue.markSynced(_authoritativeQueueIds);
    await SqliteStore.box('AppPrefs')
        .put(_lastSyncKey, DateTime.now().toIso8601String());
    _authoritativeOutboxIds = const [];
    _authoritativeQueueIds = const [];
    _pushRetryAttempt = 0;
    _authoritativeUploadInProgress = false;
    await _updatePendingFlag();
    unawaited(connectSocket());
    if (_hasPendingLocalChanges) _schedulePush(delay: Duration.zero);
  }

  void resumeAfterAuthoritativeUploadFailure() {
    _authoritativeOutboxIds = const [];
    _authoritativeQueueIds = const [];
    _authoritativeUploadInProgress = false;
    unawaited(connectSocket());
    if (_hasPendingLocalChanges) _schedulePush();
  }

  Future<bool> pushCollaborative(Playlist playlist) async {
    if (!_authService.isAuthenticated.value) return false;
    printINFO('SyncService: Pushing collaborative playlist...');

    try {
      final tracksBox =
          await SqliteStore.openBox(sanitizeBoxName(playlist.playlistId));
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
      throw StateError(S.current.friendsLoginRequired);
    }
    final token = await _authService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw StateError(S.current.invalidSessionToken);
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
      return {'success': false, 'message': S.current.notAuthenticated};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.sendFriendRequest(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> acceptFriendRequest(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': S.current.notAuthenticated};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.acceptFriendRequest(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> removeFriendship(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': S.current.notAuthenticated};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.removeFriendship(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> blockUser(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': S.current.notAuthenticated};
    }
    final token = await _authService.getAccessToken();
    return _httpClient.blockUser(
        _normalizedJossRedBaseUrl(), token ?? "", friendId);
  }

  Future<Map<String, dynamic>> unblockUser(int friendId) async {
    if (!_authService.isAuthenticated.value) {
      return {'success': false, 'message': S.current.notAuthenticated};
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
    if (_authoritativeUploadInProgress ||
        !isCloudMode ||
        !_authService.isAuthenticated.value) {
      return;
    }

    if (_wsClient == null) {
      final deviceId = await _ensureDeviceId();
      _wsClient = SyncWebSocketClient(deviceId: deviceId);
      _wsClient!.onSyncUpdate.listen((_) {
        printINFO(
            "SyncService: WS received sync_update, pulling remote changes...");
        unawaited(_handleRemoteSyncUpdate());
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
    final prefs = SqliteStore.box('AppPrefs');
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
