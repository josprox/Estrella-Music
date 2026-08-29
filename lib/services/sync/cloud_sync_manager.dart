import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/profiles/profile_manager.dart';

enum DataMode { local, cloud }

enum SyncStatus {
  success,
  offline,
  skippedLocalMode,
  skippedNotAuthenticated,
  alreadySyncing,
  conflictResolved,
  failed,
}

class SyncResult {
  final SyncStatus status;
  final String message;
  final Object? error;
  final DateTime timestamp;

  SyncResult({
    required this.status,
    required this.message,
    this.error,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  bool get isSuccess =>
      status == SyncStatus.success || status == SyncStatus.conflictResolved;
  bool get isOffline => status == SyncStatus.offline;
  bool get isSkipped =>
      status == SyncStatus.skippedLocalMode ||
      status == SyncStatus.skippedNotAuthenticated;
}

/// Gestor unificado para controlar el modo de datos (Local vs Cloud)
/// y orquestar el pipeline de sincronización multidispositivo con seguridad.
class CloudSyncManager extends GetxService {
  final Rx<DataMode> currentMode = DataMode.local.obs;
  Worker? _profileWorker;

  AuthService get _authService => Get.find<AuthService>();
  SyncService get _syncService => Get.find<SyncService>();

  @override
  void onInit() {
    super.onInit();
    _loadStoredMode();
    _profileWorker = ever(
      Get.find<ProfileManager>().activeProfile,
      (_) => _loadStoredMode(),
    );
  }

  void _loadStoredMode() {
    currentMode.value = Get.find<ProfileManager>().activeProfileMaySync
        ? DataMode.cloud
        : DataMode.local;
  }

  bool get isCloudMode => currentMode.value == DataMode.cloud;
  bool get isLocalMode => currentMode.value == DataMode.local;

  /// Cambia de modo de datos entre Local y Cloud con migración segura.
  Future<SyncResult> switchMode(DataMode newMode) async {
    if (newMode == currentMode.value) {
      return SyncResult(
        status: SyncStatus.success,
        message: isCloudMode
            ? S.current.syncCloudModeActive
            : S.current.syncLocalModeActive,
      );
    }

    if (newMode == DataMode.local) {
      await _syncService.keepLocalMode();
      currentMode.value = DataMode.local;
      _syncService.disconnectSocket();
      return SyncResult(
        status: SyncStatus.success,
        message: S.current.syncLocalModeActive,
      );
    }

    // Cambiar a Cloud Mode
    if (!_authService.isAuthenticated.value) {
      return SyncResult(
        status: SyncStatus.skippedNotAuthenticated,
        message:
            'Se requiere iniciar sesión en Joss Red para usar el modo nube.',
      );
    }

    await _syncService.enableCloudMode();
    currentMode.value = DataMode.cloud;
    _syncService.connectSocket();

    // Ejecutar pipeline seguro post-migración
    return await syncNow(force: true);
  }

  /// Ejecuta la sincronización inteligente multidispositivo en 3 fases:
  /// 1. Obtener cambios remotos (pull) para no sobreescribir datos de otros dispositivos.
  /// 2. Resolver conflictos de estado / versiones localmente.
  /// 3. Subir los cambios resueltos al servidor (push).
  Future<SyncResult> syncNow({bool force = false}) async {
    if (isLocalMode && !force) {
      return SyncResult(
        status: SyncStatus.skippedLocalMode,
        message: S.current.syncLocalModeActive,
      );
    }

    if (!_authService.isAuthenticated.value) {
      return SyncResult(
        status: SyncStatus.skippedNotAuthenticated,
        message: 'Usuario no autenticado.',
      );
    }

    final isConnected = await _syncService.checkConnection();
    if (!isConnected) {
      _syncService.isOnline.value = false;
      return SyncResult(
        status: SyncStatus.offline,
        message: S.current.syncOfflineRetry,
      );
    }

    if (_syncService.isSyncing.value) {
      return SyncResult(
        status: SyncStatus.alreadySyncing,
        message: 'Sincronización en curso...',
      );
    }

    try {
      // FASE 1: Traer cambios remotos primero para asegurar el estado del servidor
      final pullSuccess = await _syncService.pull();
      if (!pullSuccess) {
        debugPrint(
            '[CloudSyncManager] Advertencia en Fase 1 (Pull). Continuando con verificación local.');
      }

      // FASE 2 y 3: Si existen cambios locales pendientes resueltos, enviarlos
      final hasPending = _syncService.hasPendingChanges;
      if (hasPending) {
        final pushSuccess = await _syncService.push();
        if (!pushSuccess) {
          return SyncResult(
            status: SyncStatus.failed,
            message: 'Error al enviar cambios resueltos al servidor.',
          );
        }
      }

      return SyncResult(
        status: SyncStatus.success,
        message: S.current.syncUploadSuccess,
      );
    } catch (e, stack) {
      debugPrint(
          '[CloudSyncManager] Error durante el pipeline de sync: $e\n$stack');
      return SyncResult(
        status: SyncStatus.failed,
        message: 'Fallo durante la sincronización: $e',
        error: e,
      );
    }
  }

  @override
  void onClose() {
    _profileWorker?.dispose();
    super.onClose();
  }
}
