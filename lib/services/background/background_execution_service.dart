import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

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
        channelName: S.current.downloads,
        channelDescription: S.current.downloads,
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
          notificationTitle: 'Estrella Music',
          notificationText: S.current.downloads,
        );
        return;
      }
      final result = await FlutterForegroundTask.startService(
        serviceId: _serviceId,
        serviceTypes:
            GetPlatform.isAndroid ? [ForegroundServiceTypes.dataSync] : null,
        notificationTitle: 'Estrella Music',
        notificationText: S.current.downloads,
        callback: backgroundExecutionStartCallback,
      );
      if (result is ServiceRequestFailure) {
        printERROR('No fue posible iniciar la tarea en segundo plano: $result');
      }
    } catch (error) {
      printERROR('No fue posible iniciar la tarea en segundo plano: $error');
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
