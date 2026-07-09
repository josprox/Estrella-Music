import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/playlist.dart';
import '../ui/screens/Library/library_controller.dart';
import '../utils/helper.dart';
import 'auth_service.dart';
import 'cloud_migration_service.dart';
import 'pending_sync_queue_service.dart';
import 'app_backup_service.dart';


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

  AuthService get _authService => Get.find<AuthService>();
  PendingSyncQueueService get _queue => Get.find<PendingSyncQueueService>();

  @override
  void onInit() {
    super.onInit();
    _retryTimer = Timer.periodic(const Duration(minutes: 2), (_) async {
      if (isCloudMode && Hive.box('AppPrefs').get(_pendingKey) == true) {
        final online = await checkConnection();
        if (online) {
          final success = await push();
          if (success) await pull();
        }
      }
    });
  }

  @override
  void onClose() {
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
    _debounce = Timer(const Duration(seconds: 3), () {
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
    lastStatusMessage.value = 'Descargando cambios de Joss Red...';

    try {
      final response = await _dio.get(
        '${_normalizedBaseUrl()}api/sync/pull',
        options: Options(headers: await _headers()),
      );

      if (response.statusCode != 200 || response.data == null) {
        lastStatusMessage.value = 'No se pudo descargar la sincronizacion.';
        return false;
      }

      final data = _asMap(response.data);
      await _mergePlaylists(data['playlists']);
      await _replaceBoxValues('LIBFAV', data['favorites']);
      await _replaceBoxValues('LIBRP', data['recent_plays']);
      await _replaceBoxValues('LibraryAlbums', data['albums'],
          idKeys: ['browseId', 'albumId', 'id']);
      await _replaceBoxValues('LibraryArtists', data['artists'],
          idKeys: ['browseId', 'channelId', 'artistId', 'id']);
      await _mergeSettings(data['settings']);

      await Hive.box('AppPrefs')
          .put(_lastSyncKey, DateTime.now().toIso8601String());
      await Hive.box('AppPrefs').put(_pendingKey, false);
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

  Future<bool> push() async {
    if (!isCloudMode || !_authService.isAuthenticated.value) {
      return true;
    }
    if (isSyncing.value) return false;
    isSyncing.value = true;
    lastStatusMessage.value = 'Subiendo cambios a Joss Red...';

    try {
      final payload = await _buildPushPayload();
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

      final boxName = _sanitizeBoxName(playlistId);
      final wasOpen = Hive.isBoxOpen(boxName);
      final tracksBox =
          wasOpen ? Hive.box(boxName) : await Hive.openBox(boxName);
      result.add({
        ...playlist,
        'tracks': tracksBox.values.toList(),
      });
      if (!wasOpen && playlistId != 'SongDownloads') {
        await tracksBox.close();
      }
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

  String _sanitizeBoxName(String name) {
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '_');
  }

  Future<void> _mergePlaylists(dynamic value) async {
    if (value is! List) return;
    final playlistsBox = Hive.box('LibraryPlaylists');

    for (final raw in value) {
      final playlist = _asMap(raw);
      final playlistId = playlist['playlistId']?.toString();
      if (playlistId == null || playlistId.isEmpty) continue;
      if (playlistId == 'LIBFAV' || playlistId == 'LIBRP') continue;

      await playlistsBox.put(playlistId, playlist);
      final tracks = playlist['tracks'];
      if (tracks is List) {
        final boxName = _sanitizeBoxName(playlistId);
        try {
          final wasOpen = Hive.isBoxOpen(boxName);
          final tracksBox =
              wasOpen ? Hive.box(boxName) : await Hive.openBox(boxName);
          await tracksBox.clear();
          for (var i = 0; i < tracks.length; i++) {
            await tracksBox.put(i, tracks[i]);
          }
          if (!wasOpen) {
            await tracksBox.close();
          }
        } catch (e) {
          printERROR('SyncService: no se pudo abrir box para playlist $playlistId: $e');
        }
      }
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

  Future<bool> pushCollaborative(Playlist playlist) async {
    if (!_authService.isAuthenticated.value) return false;
    printINFO('SyncService: Pushing collaborative playlist...');

    try {
      final tracksBox = await Hive.openBox(_sanitizeBoxName(playlist.playlistId));
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
}
