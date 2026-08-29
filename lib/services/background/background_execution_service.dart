import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:estrella_music/generated/l10n.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

@pragma('vm:entry-point')
void backgroundExecutionStartCallback() {
  FlutterForegroundTask.setTaskHandler(_BackgroundExecutionHandler());
}

class _BackgroundExecutionHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {
    FlutterForegroundTask.sendDataToMain({
      'type': 'heartbeat',
      'timestamp': timestamp.millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}
}

class BackgroundExecutionService {
  static const _serviceId = 7302;
  static bool _initialized = false;

  static bool get _isSupported => GetPlatform.isAndroid || GetPlatform.isIOS;

  static void initialize() {
    if (!_isSupported || _initialized) return;
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'estrella_music_background',
        channelName: S.current.downloadNotificationChannelName,
        channelDescription: S.current.downloadNotificationChannelDescription,
        onlyAlertOnce: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(60000),
        autoRunOnBoot: false,
        autoRunOnMyPackageReplaced: false,
        allowWakeLock: true,
        allowWifiLock: true,
        allowAutoRestart: true,
        stopWithTask: false,
      ),
    );
    _initialized = true;
  }

  static Future<void> startDownloads() async {
    if (!_isSupported) return;
    initialize();
    try {
      final permission =
          await FlutterForegroundTask.checkNotificationPermission();
      if (permission != NotificationPermission.granted) {
        await FlutterForegroundTask.requestNotificationPermission();
      }
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.updateService(
          notificationTitle: S.current.downloadNotificationTitle,
          notificationText: S.current.downloadNotificationPreparing,
        );
        return;
      }
      final result = await FlutterForegroundTask.startService(
        serviceId: _serviceId,
        serviceTypes:
            GetPlatform.isAndroid ? [ForegroundServiceTypes.dataSync] : null,
        notificationTitle: S.current.downloadNotificationTitle,
        notificationText: S.current.downloadNotificationPreparing,
        callback: backgroundExecutionStartCallback,
      );
      if (result is ServiceRequestFailure) {
        printERROR('No fue posible iniciar la tarea en segundo plano: $result');
      }
    } catch (error) {
      printERROR('No fue posible iniciar la tarea en segundo plano: $error');
    }
  }

  static Future<void> updateCurrentSong(String songTitle) async {
    if (!_isSupported || !_initialized) return;
    try {
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.updateService(
          notificationTitle: S.current.downloadNotificationTitle,
          notificationText: S.current.downloadNotificationSong(songTitle),
        );
      }
    } catch (error) {
      printERROR('No fue posible actualizar la notificación: $error');
    }
  }

  static Future<void> stopDownloads() async {
    if (!_isSupported || !_initialized) return;
    try {
      if (await FlutterForegroundTask.isRunningService) {
        await FlutterForegroundTask.stopService();
      }
    } catch (error) {
      printERROR('No fue posible detener la tarea en segundo plano: $error');
    }
  }
}
