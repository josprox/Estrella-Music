import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '/native_bindings/andrid_utils.dart' show SDKInt;

enum RequiredAppPermission { storage, notifications, microphone }

class RequiredPermissionStatus {
  const RequiredPermissionStatus({
    required this.storage,
    required this.notifications,
    required this.microphone,
  });

  final PermissionStatus storage;
  final PermissionStatus notifications;
  final PermissionStatus microphone;

  bool get allGranted =>
      storage.isGranted && notifications.isGranted && microphone.isGranted;

  PermissionStatus statusOf(RequiredAppPermission permission) {
    return switch (permission) {
      RequiredAppPermission.storage => storage,
      RequiredAppPermission.notifications => notifications,
      RequiredAppPermission.microphone => microphone,
    };
  }
}

class PermissionService {
  static int get _androidSdk => SDKInt.Companion.getSDKInt();

  static Permission get _storagePermission {
    if (!GetPlatform.isAndroid) return Permission.mediaLibrary;
    if (_androidSdk >= 33) return Permission.audio;
    if (_androidSdk >= 30) return Permission.manageExternalStorage;
    return Permission.storage;
  }

  static Future<RequiredPermissionStatus> requiredPermissionStatus() async {
    if (!GetPlatform.isAndroid && !GetPlatform.isIOS) {
      return const RequiredPermissionStatus(
        storage: PermissionStatus.granted,
        notifications: PermissionStatus.granted,
        microphone: PermissionStatus.granted,
      );
    }

    return RequiredPermissionStatus(
      storage: await _storagePermission.status,
      notifications: await Permission.notification.status,
      microphone: await Permission.microphone.status,
    );
  }

  static Future<PermissionStatus> request(
    RequiredAppPermission permission,
  ) async {
    return switch (permission) {
      RequiredAppPermission.storage => _storagePermission.request(),
      RequiredAppPermission.notifications => Permission.notification.request(),
      RequiredAppPermission.microphone => Permission.microphone.request(),
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
