import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:harmonymusic/services/backup/app_backup_service.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/backup/cloud_backup_service.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: '.env');
      
      // 1. Initialize Hive
      String applicationDataDirectoryPath;
      if (GetPlatform.isDesktop) {
        applicationDataDirectoryPath =
            "${(await getApplicationSupportDirectory()).path}/db";
      } else {
        applicationDataDirectoryPath =
            (await getApplicationDocumentsDirectory()).path;
      }
      await Hive.initFlutter(applicationDataDirectoryPath);
      final appPrefs = await Hive.openBox('AppPrefs');
      
      // 2. Check if we should backup
      final lastBackupStr = appPrefs.get('last_cloud_backup_timestamp');
      final firstRunStr = appPrefs.get('app_first_run_timestamp');
      
      if (lastBackupStr != null) {
        // Lógica normal: Cada 4 horas
        final lastBackup = DateTime.tryParse(lastBackupStr.toString());
        if (lastBackup != null && 
            DateTime.now().difference(lastBackup).inHours < 4) {
          if (kDebugMode) print("Background Backup: Skipping, last backup was less than 4h ago.");
          return true; 
        }
      } else if (firstRunStr != null) {
        // Lógica de "Primera Vez": Esperar 12 horas desde la instalación
        final firstRun = DateTime.tryParse(firstRunStr.toString());
        if (firstRun != null && 
            DateTime.now().difference(firstRun).inHours < 12) {
          if (kDebugMode) print("Background Backup: Skipping, first-time delay of 12h not met yet.");
          return true;
        }
      }

      // 3. Initialize minimum required services
      final authService = Get.put(AuthService(), permanent: true);
      final appBackupService = Get.put(AppBackupService(), permanent: true);
      final cloudBackupService = Get.put(CloudBackupService(), permanent: true);

      // 4. Restore session (needed for token)
      await authService.restoreSession();
      if (!authService.isAuthenticated.value) {
        return true; // Cannot backup without session
      }

      // 5. Perform backup
      final bytes = await appBackupService.createBackupBytes();
      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '')
          .replaceAll('.', '_');
      
      await cloudBackupService.uploadBackupBytes(
        bytes: bytes,
        fileName: 'estrellamusic_auto_$timestamp.hmb',
      );

      // 6. Update timestamp
      await appPrefs.put('last_cloud_backup_timestamp', DateTime.now().toIso8601String());

      // 7. Notify user
      await _showNotification();

      return true;
    } catch (e) {
      printERROR('Background Backup Failed: $e');
      return false;
    }
  });
}

Future<void> _showNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
      
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'backup_channel',
    'Backups',
    channelDescription: 'Notificaciones de respaldo automático',
    importance: Importance.low,
    priority: Priority.low,
  );
  
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
      
  await flutterLocalNotificationsPlugin.show(
    99,
    'Backup completado',
    'Se utilizaron datos de red para actualizar tu respaldo de Estrella Music.',
    notificationDetails,
  );
}
