import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/backup/app_backup_service.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/services/backup/cloud_backup_service.dart';
import 'package:estrella_music/services/sync/legacy_music_migration_service.dart';

class UserDataBootstrapService extends GetxService {
  final isPreparing = false.obs;
  final statusMessage = 'Preparando tu biblioteca...'.obs;
  final lastError = ''.obs;
  final willReplaceLocalData = false.obs;

  String? _preparedUserKey;
  String? _attemptedUserKey;
  String? _currentProcessingUserKey;
  Future<void>? _runningTask;

  final foundBackups = <CloudBackupFile>[].obs;
  final requiresUserConfirmation = false.obs;

  AuthService get _authService => Get.find<AuthService>();
  CloudBackupService get _cloudBackupService => Get.find<CloudBackupService>();
  LegacyMusicMigrationService get _legacyMigrationService =>
      Get.find<LegacyMusicMigrationService>();
  AppBackupService get _appBackupService => Get.find<AppBackupService>();

  String? get currentUserKey {
    final user = _authService.userProfile.value;
    if (user == null) return null;
    final rawKey = user['email']?.toString().trim().isNotEmpty == true
        ? user['email'].toString().trim().toLowerCase()
        : user['id']?.toString().trim().isNotEmpty == true
            ? user['id'].toString().trim()
            : user['username']?.toString().trim();
    if (rawKey == null || rawKey.isEmpty) {
      return null;
    }
    return rawKey.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_');
  }

  bool get needsBootstrapForCurrentUser {
    final userKey = currentUserKey;
    if (!_authService.isAuthenticated.value || userKey == null) {
      return false;
    }
    if (isPreparing.value) {
      return false;
    }
    if (_preparedUserKey == userKey || _attemptedUserKey == userKey) {
      return false;
    }

    return !_isBootstrapConfirmedLocally(userKey);
  }

  bool _isBootstrapConfirmedLocally(String userKey) {
    return SqliteStore.box('AppPrefs')
        .get('bootstrap_confirmed_$userKey', defaultValue: false);
  }

  Future<void> _confirmBootstrap(String userKey) async {
    _preparedUserKey = userKey;
    await SqliteStore.box('AppPrefs').put('bootstrap_confirmed_$userKey', true);
  }

  void resetRuntimeState() {
    if (isPreparing.value) {
      return;
    }
    _preparedUserKey = null;
    _attemptedUserKey = null;
    lastError.value = '';
    willReplaceLocalData.value = false;
    statusMessage.value = 'Preparando tu biblioteca...';
  }

  Future<void> prepareForAuthenticatedUser() async {
    final userKey = currentUserKey;
    if (!_authService.isAuthenticated.value || userKey == null) {
      return;
    }
    if (_preparedUserKey == userKey || _attemptedUserKey == userKey) {
      return;
    }
    if (_runningTask != null) {
      return _runningTask!;
    }

    _attemptedUserKey = userKey;
    _runningTask = _runBootstrap(userKey);
    try {
      await _runningTask;
    } finally {
      _runningTask = null;
    }
  }

  Future<void> _runBootstrap(String userKey) async {
    isPreparing.value = true;
    lastError.value = '';
    willReplaceLocalData.value = false;
    foundBackups.clear();
    requiresUserConfirmation.value = false;
    _currentProcessingUserKey = userKey;

    try {
      statusMessage.value = 'Revisando tu biblioteca local...';
      final hasLocalData = await hasMeaningfulLocalData();
      willReplaceLocalData.value = hasLocalData;

      statusMessage.value = 'Buscando backups de tu cuenta...';
      final estrellaBackups = await _cloudBackupService.listBackups(
        appName: CloudBackupService.defaultAppName,
      );
      final jossBackups = await _cloudBackupService.listBackups(
        appName: CloudBackupService.legacyMusicAppName,
      );

      final allRecentBackups = [...estrellaBackups, ...jossBackups];

      if (allRecentBackups.isNotEmpty) {
        // Find if the latest backup was already processed
        final latest = allRecentBackups.first;
        if (_wasBackupAlreadyProcessed(
              userKey: userKey,
              source: latest.appName,
              fileId: latest.fileId,
            ) &&
            hasLocalData) {
          statusMessage.value = 'Tu biblioteca ya está sincronizada.';
          await _confirmBootstrap(userKey);
          return;
        }

        foundBackups.assignAll(allRecentBackups);
        requiresUserConfirmation.value = true;
        statusMessage.value = '¡Encontramos respaldos de tu cuenta!';
        // Wait for user input via requiresUserConfirmation flow
        return;
      }

      statusMessage.value = hasLocalData
          ? 'No encontramos backups remotos. Conservamos tus datos locales.'
          : 'No encontramos backups remotos. Entrando...';
      await _confirmBootstrap(userKey);
    } catch (e) {
      lastError.value = e.toString().replaceFirst('Bad state: ', '');
      statusMessage.value = willReplaceLocalData.value
          ? 'No se pudo completar la búsqueda de respaldos. Entrando...'
          : 'No se pudo recuperar tu backup. Entrando...';
      printERROR('Bootstrap de usuario fallo: $e');
      await _confirmBootstrap(userKey);
    } finally {
      if (!requiresUserConfirmation.value) {
        isPreparing.value = false;
      }
    }
  }

  Future<void> restoreSelectedBackup(CloudBackupFile backup) async {
    final userKey = _currentProcessingUserKey;
    if (userKey == null) return;

    requiresUserConfirmation.value = false;
    isPreparing.value = true;
    lastError.value = '';

    try {
      final isLegacy = backup.appName == CloudBackupService.legacyMusicAppName;
      final label = isLegacy ? 'Joss Music' : 'Estrella Music';

      statusMessage.value = 'Descargando tu respaldo de $label...';
      final bytes = await _cloudBackupService.downloadBackupBytes(backup);

      if (willReplaceLocalData.value) {
        statusMessage.value = 'Creando respaldo local de seguridad...';
        final safetyBackup =
            await _appBackupService.createTemporaryBackupArchive();
        await SqliteStore.box('AppPrefs').put(
          'last_restore_safety_backup',
          safetyBackup.path,
        );
      }

      statusMessage.value = 'Restaurando tu respaldo de $label...';
      if (isLegacy) {
        await _legacyMigrationService.importFromBackupBytes(
          bytes,
          sourceName: backup.fileName,
        );
      } else {
        await _appBackupService.restoreBackupBytes(
          bytes,
          clearExistingMediaAssets: true,
          reopenCoreBoxes: true,
        );
      }

      await _persistProcessedBackup(
        userKey: userKey,
        source: backup.appName,
        fileId: backup.fileId,
        fileName: backup.fileName,
      );

      _applyLocaleFromAppPrefs();
      statusMessage.value = '¡Tu biblioteca ha sido restaurada!';
      await _confirmBootstrap(userKey);
    } catch (e) {
      lastError.value = e.toString().replaceFirst('Bad state: ', '');
      statusMessage.value = 'La restauración falló. Entrando a la app...';
      printERROR('Restauración manual falló: $e');
      await _confirmBootstrap(userKey);
    } finally {
      isPreparing.value = false;
    }
  }

  Future<void> continueWithLocalData() async {
    final userKey = _currentProcessingUserKey;
    if (userKey == null) return;

    requiresUserConfirmation.value = false;
    isPreparing.value = true;
    statusMessage.value = 'Entrando con tus datos locales...';

    await _confirmBootstrap(userKey);
    isPreparing.value = false;
  }

  Future<bool> hasMeaningfulLocalData() async {
    final boxesToCheck = <String>[
      'LibraryPlaylists',
      'LibraryAlbums',
      'LibraryArtists',
      'LIBFAV',
      'LIBRP',
      'SongDownloads',
    ];

    for (final boxName in boxesToCheck) {
      final wasOpen = SqliteStore.isBoxOpen(boxName);
      final box = wasOpen
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      final hasData = box.isNotEmpty;
      if (!wasOpen) {
        await box.close();
      }
      if (hasData) {
        return true;
      }
    }
    return false;
  }

  bool _wasBackupAlreadyProcessed({
    required String userKey,
    required String source,
    required String fileId,
  }) {
    final raw = SqliteStore.box('AppPrefs').get(_bootstrapStateKey(userKey));
    if (raw is! Map) {
      return false;
    }
    final state = raw.map((key, value) => MapEntry(key.toString(), value));
    return state['source']?.toString() == source &&
        state['fileId']?.toString() == fileId;
  }

  Future<void> _persistProcessedBackup({
    required String userKey,
    required String source,
    required String fileId,
    required String fileName,
  }) async {
    await SqliteStore.box('AppPrefs').put(
      _bootstrapStateKey(userKey),
      {
        'source': source,
        'fileId': fileId,
        'fileName': fileName,
        'processedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  String _bootstrapStateKey(String userKey) => 'bootstrap_state_$userKey';

  void _applyLocaleFromAppPrefs() {
    if (!SqliteStore.isBoxOpen('AppPrefs')) {
      return;
    }
    final appPrefs = SqliteStore.box('AppPrefs');
    final autoLanguage = appPrefs.get('autoLanguage', defaultValue: true);
    final languageCode = appPrefs.get('currentAppLanguageCode');
    if (!autoLanguage &&
        languageCode is String &&
        languageCode.trim().isNotEmpty) {
      Get.updateLocale(Locale(languageCode));
    }
  }
}
