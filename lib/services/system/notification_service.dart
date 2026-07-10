import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService {
  static Future<void> initOneSignal() async {
    if (!GetPlatform.isAndroid && !GetPlatform.isIOS) return;

    final String? onesignalKey = dotenv.env["ONESIGNAL"];
    if (onesignalKey == null) {
      if (kDebugMode) print("ERROR: OneSignal key not found in .env");
      return;
    }

    if (kDebugMode) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }
    
    OneSignal.initialize(onesignalKey);
    OneSignal.Notifications.requestPermission(true);
  }
}
