import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart'
    show PermissionStatus, openAppSettings;

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
  static final _deviceInfo = DeviceInfoPlugin();

  /// Devuelve el SDK de Android, o 0 en otras plataformas.
  static Future<int> _androidSdk() async {
    if (!GetPlatform.isAndroid) return 0;
    final info = await _deviceInfo.androidInfo;
    return info.version.sdkInt;
  }

  static Future<Permission> get _storagePermission async {
    if (!GetPlatform.isAndroid) return Permission.mediaLibrary;
    final sdk = await _androidSdk();
    return sdk >= 33 ? Permission.audio : Permission.storage;
  }

  static Future<RequiredPermissionStatus> requiredPermissionStatus() async {
    if (!GetPlatform.isAndroid && !GetPlatform.isIOS) {
      return const RequiredPermissionStatus(
        storage: PermissionStatus.granted,
        notifications: PermissionStatus.granted,
      );
    }

    final perm = await _storagePermission;
    return RequiredPermissionStatus(
      storage: await perm.status,
      notifications: await Permission.notification.status,
    );
  }

  static Future<PermissionStatus> request(
    RequiredAppPermission permission,
  ) async {
    return switch (permission) {
      RequiredAppPermission.storage =>
        (await _storagePermission).request(),
      RequiredAppPermission.notifications =>
        Permission.notification.request(),
    };
  }

  static Future<bool> getExtStoragePermission() async {
    if (GetPlatform.isDesktop || GetPlatform.isIOS) return true;

    final perm = await _storagePermission;
    final status = await perm.status;
    if (status.isGranted) return true;

    final requested = await perm.request();
    if (requested.isPermanentlyDenied) {
      await openAppSettings();
    }
    return requested.isGranted;
  }
}
