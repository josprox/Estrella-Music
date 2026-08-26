import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/generated/l10n.dart';

import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/backup/app_backup_service.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';

class CloudMigrationResult {
  const CloudMigrationResult({
    required this.success,
    required this.message,
    this.migrationId,
    this.receivedCounts = const <String, dynamic>{},
    this.usedExistingCloud = false,
    this.serverVersion = 0,
    this.recoveryBackupPath,
  });

  final bool success;
  final String message;
  final String? migrationId;
  final Map<String, dynamic> receivedCounts;
  final bool usedExistingCloud;
  final int serverVersion;
  final String? recoveryBackupPath;
}

class CloudMigrationService extends GetxService {
  static const _statusKey = 'cloudMigrationStatus';
  static const _deviceIdKey = 'linkedDeviceId';
  static const _backupHashKey = 'lastCloudMigrationBackupHash';
  static const _migrationIdKey = 'lastCloudMigrationId';

  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 90),
      validateStatus: (_) => true,
    ),
  );

  final isMigrating = false.obs;
  final progress = 0.0.obs;
  final statusMessage = 'Listo para migrar a Joss Red.'.obs;
  final lastError = ''.obs;

  AuthService get _authService => Get.find<AuthService>();
  AppBackupService get _appBackupService => Get.find<AppBackupService>();

  Future<CloudMigrationResult> migrateLocalLibraryToCloud() async {
    if (isMigrating.value) {
      return CloudMigrationResult(
        success: false,
        message: S.current.migrationAlreadyRunning,
      );
    }
    if (!_authService.isAuthenticated.value) {
      return CloudMigrationResult(
        success: false,
        message: S.current.migrationLoginRequired,
      );
    }

    isMigrating.value = true;
    progress.value = 0;
    lastError.value = '';

    String? migrationId;
    try {
      final prefs = SqliteStore.box('AppPrefs');
      statusMessage.value = S.current.migrationCheckingCloud;
      final remoteSummary = await fetchRemoteSummary();
      if (_hasRemoteLibraryData(remoteSummary)) {
        await prefs.put(_statusKey, 'using_existing_cloud');
        progress.value = 1;
        statusMessage.value = S.current.cloudLibraryFoundDeviceWillDownload;
        return CloudMigrationResult(
          success: true,
          message: S.current.cloudLibraryFound,
          receivedCounts: remoteSummary,
          usedExistingCloud: true,
        );
      }

      await prefs.put(_statusKey, 'creating_backup');
      statusMessage.value = S.current.migrationCreatingBackup;

      final backupBytes = await _appBackupService.createBackupBytes();
      final backupHash =
          'local-${backupBytes.length}-${DateTime.now().millisecondsSinceEpoch}';
      await prefs.put(_backupHashKey, backupHash);
      progress.value = 0.12;

      statusMessage.value = S.current.migrationAnalyzingLocal;
      final snapshot = await buildLocalSnapshot();
      final expectedCounts = _countSnapshot(snapshot);
      final deviceId = await _ensureDeviceId();
      migrationId = _newMigrationId(deviceId);
      await prefs.put(_migrationIdKey, migrationId);
      progress.value = 0.25;

      await prefs.put(_statusKey, 'starting');
      statusMessage.value = S.current.migrationPreparingCloud;
      final startResponse = await _dio.post(
        '${_normalizedBaseUrl()}api/music/migration/start',
        options: Options(headers: await _headers()),
        data: {
          'migration_id': migrationId,
          'device_id': deviceId,
          'local_backup_hash': backupHash,
          'expected_counts': expectedCounts,
        },
      );

      if (startResponse.statusCode != 200) {
        return _fail(
          S.current.migrationStartFailed,
          migrationId: migrationId,
          response: startResponse,
        );
      }

      await prefs.put(_statusKey, 'uploading');
      statusMessage.value = S.current.migrationUploadingData;
      final uploadOk = await _uploadSnapshot(
        migrationId: migrationId,
        deviceId: deviceId,
        snapshot: snapshot,
      );
      if (!uploadOk) {
        return _fail(
          S.current.migrationUploadIncomplete,
          migrationId: migrationId,
        );
      }

      await prefs.put(_statusKey, 'validating');
      statusMessage.value = S.current.migrationVerifyingIntegrity;
      final completeResponse = await _dio.post(
        '${_normalizedBaseUrl()}api/music/migration/complete',
        options: Options(headers: await _headers()),
        data: {'migration_id': migrationId},
      );

      if (completeResponse.statusCode != 200) {
        return _fail(
          S.current.migrationValidationFailed,
          migrationId: migrationId,
          response: completeResponse,
        );
      }

      final data = _asMap(completeResponse.data);
      await prefs.put(_statusKey, 'completed');
      await prefs.put('lastSuccessfulSyncAt', DateTime.now().toIso8601String());
      progress.value = 1;
      statusMessage.value = S.current.cloudModeReadyOfflineCache;

      return CloudMigrationResult(
        success: true,
        message: S.current.migrationCompleted,
        migrationId: migrationId,
        receivedCounts: _asMap(data['received_counts']),
      );
    } catch (e) {
      return _fail(
        S.current.migrationFailedLocalPreserved,
        migrationId: migrationId,
        error: e,
      );
    } finally {
      isMigrating.value = false;
    }
  }

  Future<CloudMigrationResult> forceReplaceRemoteWithLocal() async {
    if (isMigrating.value) {
      return CloudMigrationResult(
        success: false,
        message: S.current.migrationAlreadyRunning,
      );
    }
    if (!_authService.isAuthenticated.value) {
      return CloudMigrationResult(
        success: false,
        message: S.current.migrationLoginRequired,
      );
    }

    isMigrating.value = true;
    progress.value = 0;
    lastError.value = '';

    String? migrationId;
    String? recoveryBackupPath;
    try {
      final prefs = SqliteStore.box('AppPrefs');
      await prefs.put(_statusKey, 'force_replace_backup');
      statusMessage.value = S.current.syncForceReplaceCreatingBackup;
      final backupFile = await _appBackupService.createRecoveryBackupArchive();
      recoveryBackupPath = backupFile.path;
      final backupHash =
          'local-${await backupFile.length()}-${DateTime.now().millisecondsSinceEpoch}';
      await prefs.put(_backupHashKey, backupHash);
      progress.value = 0.12;

      statusMessage.value = S.current.migrationAnalyzingLocal;
      final snapshot = await buildLocalSnapshot();
      final expectedCounts = _countSnapshot(snapshot);
      final deviceId = await _ensureDeviceId();
      migrationId = _newMigrationId(deviceId);
      await prefs.put(_migrationIdKey, migrationId);
      progress.value = 0.25;

      statusMessage.value = S.current.migrationPreparingCloud;
      final startResponse = await _dio.post(
        '${_normalizedBaseUrl()}api/music/migration/start',
        options: Options(headers: await _headers()),
        data: {
          'migration_id': migrationId,
          'device_id': deviceId,
          'local_backup_hash': backupHash,
          'expected_counts': expectedCounts,
          'force_replace': true,
        },
      );
      if (startResponse.statusCode != 200) {
        return _fail(
          S.current.migrationStartFailed,
          migrationId: migrationId,
          response: startResponse,
          recoveryBackupPath: recoveryBackupPath,
        );
      }

      statusMessage.value = S.current.migrationUploadingData;
      final uploaded = await _uploadSnapshot(
        migrationId: migrationId,
        deviceId: deviceId,
        snapshot: snapshot,
      );
      if (!uploaded) {
        return _fail(
          S.current.migrationUploadIncomplete,
          migrationId: migrationId,
          recoveryBackupPath: recoveryBackupPath,
        );
      }

      statusMessage.value = S.current.syncForceReplaceValidating;
      final replaceResponse = await _dio.post(
        '${_normalizedBaseUrl()}api/sync/force-replace',
        options: Options(headers: await _headers()),
        data: {
          'migration_id': migrationId,
          'confirmation': 'REPLACE_REMOTE_MUSIC',
        },
      );
      if (replaceResponse.statusCode != 200) {
        return _fail(
          S.current.syncForceReplaceFailed,
          migrationId: migrationId,
          response: replaceResponse,
          recoveryBackupPath: recoveryBackupPath,
        );
      }

      final responseData = _asMap(replaceResponse.data);
      final receivedCounts = _asMap(responseData['received_counts']);
      if (!_countsMatch(expectedCounts, receivedCounts)) {
        return _fail(
          S.current.syncForceReplaceCountMismatch,
          migrationId: migrationId,
          recoveryBackupPath: recoveryBackupPath,
        );
      }

      final serverVersion = _asInt(responseData['server_version']);
      await prefs.put(_statusKey, 'force_replace_completed');
      await prefs.put('lastSuccessfulSyncAt', DateTime.now().toIso8601String());
      progress.value = 1;
      statusMessage.value = S.current.syncForceReplaceSuccess;
      return CloudMigrationResult(
        success: true,
        message: S.current.syncForceReplaceSuccess,
        migrationId: migrationId,
        receivedCounts: receivedCounts,
        serverVersion: serverVersion,
        recoveryBackupPath: recoveryBackupPath,
      );
    } catch (error) {
      return _fail(
        S.current.syncForceReplaceFailedLocalPreserved,
        migrationId: migrationId,
        error: error,
        recoveryBackupPath: recoveryBackupPath,
      );
    } finally {
      isMigrating.value = false;
    }
  }

  Future<Map<String, dynamic>> buildLocalSnapshot() async {
    final appPrefs = SqliteStore.box('AppPrefs');
    return {
      'playlists': await _collectPlaylists(),
      'favorites': SqliteStore.box('LIBFAV').values.toList(),
      'recent_plays': SqliteStore.box('LIBRP').values.toList(),
      'albums': SqliteStore.box('LibraryAlbums').values.toList(),
      'artists': SqliteStore.box('LibraryArtists').values.toList(),
      'settings': _syncableSettings(appPrefs),
    };
  }

  Future<Map<String, dynamic>> fetchRemoteSummary() async {
    try {
      final response = await _dio.get(
        '${_normalizedBaseUrl()}api/sync/status',
        options: Options(headers: await _headers()),
      );
      if (response.statusCode != 200 || response.data == null) {
        return <String, dynamic>{};
      }
      final data = _asMap(response.data);
      return _asMap(data['summary']);
    } catch (e) {
      printERROR('CloudMigrationService remote summary failed: $e');
      return <String, dynamic>{};
    }
  }

  Future<bool> cancelLastMigration() async {
    final migrationId =
        SqliteStore.box('AppPrefs').get(_migrationIdKey)?.toString();
    if (migrationId == null || migrationId.isEmpty) {
      return true;
    }

    try {
      final response = await _dio.post(
        '${_normalizedBaseUrl()}api/music/migration/cancel',
        options: Options(headers: await _headers()),
        data: {'migration_id': migrationId},
      );
      return response.statusCode == 200;
    } catch (e) {
      printERROR('CloudMigrationService cancel failed: $e');
      return false;
    }
  }

  Future<bool> _uploadSnapshot({
    required String migrationId,
    required String deviceId,
    required Map<String, dynamic> snapshot,
  }) async {
    const entityOrder = [
      'playlists',
      'favorites',
      'recent_plays',
      'albums',
      'artists',
      'settings',
    ];

    var uploaded = 0;
    for (final entityType in entityOrder) {
      final payload = snapshot[entityType];
      final chunks = _chunksFor(entityType, payload);

      for (var i = 0; i < chunks.length; i++) {
        final chunkPayload = chunks[i];
        final encoded = jsonEncode(chunkPayload);
        final response = await _dio.post(
          '${_normalizedBaseUrl()}api/music/migration/chunk',
          options: Options(headers: await _headers()),
          data: {
            'migration_id': migrationId,
            'device_id': deviceId,
            'batch_id': '$entityType-$i',
            'entity_type': entityType,
            'payload': chunkPayload,
            'payload_hash': '$entityType-${encoded.length}',
          },
        );

        if (response.statusCode != 200) {
          printERROR(
            'CloudMigrationService chunk failed: $entityType/$i ${response.statusCode} ${response.data}',
          );
          return false;
        }
      }

      uploaded++;
      progress.value = 0.25 + (uploaded / entityOrder.length) * 0.55;
    }

    return true;
  }

  List<dynamic> _chunksFor(String entityType, dynamic payload) {
    if (entityType == 'settings') {
      return [payload ?? <String, dynamic>{}];
    }
    final items = payload is List ? payload : const [];
    if (items.isEmpty) {
      return [const []];
    }

    const chunkSize = 200;
    final chunks = <List<dynamic>>[];
    for (var index = 0; index < items.length; index += chunkSize) {
      final end =
          (index + chunkSize) > items.length ? items.length : index + chunkSize;
      chunks.add(items.sublist(index, end));
    }
    return chunks;
  }

  Future<List<Map<String, dynamic>>> _collectPlaylists() async {
    final playlistsBox = SqliteStore.box('LibraryPlaylists');
    final result = <Map<String, dynamic>>[];

    for (final value in playlistsBox.values) {
      final playlist = _asMap(value);
      final playlistId = playlist['playlistId']?.toString();
      if (playlistId == null || playlistId.isEmpty) continue;
      if (playlist['isPipedPlaylist'] == true) continue;

      final boxName = _sanitizeBoxName(playlistId);
      final wasOpen = SqliteStore.isBoxOpen(boxName);
      final tracksBox = wasOpen
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      result.add({
        ...playlist,
        'tracks': tracksBox.values.toList(),
      });
      // Keep the tracks box open to prevent async read/write exceptions on closed boxes
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

  Map<String, int> _countSnapshot(Map<String, dynamic> snapshot) {
    int countList(String key) =>
        snapshot[key] is List ? (snapshot[key] as List).length : 0;

    final settings = snapshot['settings'];
    return {
      'playlists': countList('playlists'),
      'favorites': countList('favorites'),
      'recent_plays': countList('recent_plays'),
      'albums': countList('albums'),
      'artists': countList('artists'),
      'settings': settings is Map ? settings.length : 0,
    };
  }

  bool _hasRemoteLibraryData(Map<String, dynamic> summary) {
    const keys = [
      'playlists',
      'favorites',
      'recent_plays',
      'albums',
      'artists',
    ];
    for (final key in keys) {
      final value = summary[key];
      final count = value is num ? value.toInt() : int.tryParse('$value') ?? 0;
      if (count > 0) return true;
    }
    return false;
  }

  bool _countsMatch(
    Map<String, dynamic> expected,
    Map<String, dynamic> received,
  ) {
    const keys = [
      'playlists',
      'favorites',
      'recent_plays',
      'albums',
      'artists',
      'settings',
    ];
    for (final key in keys) {
      if (_asInt(expected[key]) != _asInt(received[key])) return false;
    }
    return true;
  }

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  Future<String> _ensureDeviceId() async {
    final prefs = SqliteStore.box('AppPrefs');
    final existing = prefs.get(_deviceIdKey)?.toString();
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final deviceId = 'device-${DateTime.now().millisecondsSinceEpoch}';
    await prefs.put(_deviceIdKey, deviceId);
    return deviceId;
  }

  String _newMigrationId(String deviceId) {
    return 'mig-$deviceId-${DateTime.now().millisecondsSinceEpoch}';
  }

  String _normalizedBaseUrl() {
    final isDebugEnv = dotenv.env['DEBUG']?.toLowerCase() == 'true';
    var base = '';
    if (kDebugMode && isDebugEnv) {
      if (GetPlatform.isWindows) {
        base = 'http://127.0.0.1:9000';
      } else if (GetPlatform.isAndroid) {
        base = 'http://10.0.2.2:9000';
      }
    }
    if (base.isEmpty) {
      base = dotenv.env['EMUSICWEB'] ?? _authService.baseUrl?.trim() ?? '';
    }
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
    if (token == null || token.isEmpty) {
      throw StateError(S.current.sessionExpiredLoginAgain);
    }
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  CloudMigrationResult _fail(
    String message, {
    String? migrationId,
    Response<dynamic>? response,
    Object? error,
    String? recoveryBackupPath,
  }) {
    final detail = response == null
        ? error?.toString()
        : '${response.statusCode}: ${response.data}';
    lastError.value = detail == null || detail.isEmpty ? message : detail;
    statusMessage.value = message;
    progress.value = 0;
    SqliteStore.box('AppPrefs').put(_statusKey, 'failed');
    printERROR('CloudMigrationService failed: $message ${detail ?? ''}');
    return CloudMigrationResult(
      success: false,
      message: message,
      migrationId: migrationId,
      recoveryBackupPath: recoveryBackupPath,
    );
  }

  String _sanitizeBoxName(String name) {
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_');
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }
}
