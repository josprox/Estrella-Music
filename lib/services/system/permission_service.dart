import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '/native_bindings/andrid_utils.dart' show SDKInt;

enum RequiredAppPermission { storage, notifications }

class RequiredPermissionStatus {
  const RequiredPermissionStatus({
    required this.storage,
    required this.notifications,
  });

  final PermissionStatus storage;
  final PermissionStatus notifications;

  bool get allGranted => storage.isGranted;

  PermissionStatus statusOf(RequiredAppPermission permission) {
    return switch (permission) {
      RequiredAppPermission.storage => storage,
      RequiredAppPermission.notifications => notifications,
    };
  }
}

class PermissionService {
  static int get _androidSdk => SDKInt.Companion.getSDKInt();

  static Permission get _storagePermission {
    if (!GetPlatform.isAndroid) return Permission.mediaLibrary;
    if (_androidSdk >= 33) return Permission.audio;
    return Permission.storage;
  }

  static Future<RequiredPermissionStatus> requiredPermissionStatus() async {
    if (!GetPlatform.isAndroid && !GetPlatform.isIOS) {
      return const RequiredPermissionStatus(
        storage: PermissionStatus.granted,
        notifications: PermissionStatus.granted,
      );
    }

    return RequiredPermissionStatus(
      storage: await _storagePermission.status,
      notifications: await Permission.notification.status,
    );
  }

  static Future<PermissionStatus> request(
    RequiredAppPermission permission,
  ) async {
    return switch (permission) {
      RequiredAppPermission.storage => _storagePermission.request(),
      RequiredAppPermission.notifications => Permission.notification.request(),
    };
  }

  static Future<bool> getExtStoragePermission() async {
    if (GetPlatform.isDesktop || GetPlatform.isIOS) return true;

    final status = await _storagePermission.status;
    if (status.isGranted) return true;

    final requested = await _storagePermission.request();
    if (requested.isPermanentlyDenied) {
      await openAppSettings();
    }
    return requested.isGranted;
  }
}
