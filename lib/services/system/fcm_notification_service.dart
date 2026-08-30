import 'dart:convert';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:estrella_music/services/storage/safe_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'notification_service.dart';

const _channelId = 'estrella_music_notifications';
const _channelName = 'Notificaciones de Estrella Music';
const _channelDescription = 'Mensajes enviados desde la plataforma Joss';

bool _isExpiredTemporary(Map<String, dynamic> data) {
  if (data['delivery_mode']?.toString() != 'temporary') return false;
  final expiresAt = DateTime.tryParse(data['expires_at']?.toString() ?? '');
  return expiresAt == null || !expiresAt.isAfter(DateTime.now());
}

@pragma('vm:entry-point')
Future<void> estrellaFcmBackgroundHandler(RemoteMessage remoteMessage) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {}

  final data = Map<String, dynamic>.from(remoteMessage.data);
  if (data['app_id'] != NotificationService.appId ||
      data['type'] != 'push' ||
      _isExpiredTemporary(data)) {
    return;
  }

  final notifications = await _initializeLocalNotifications();
  await _showLocalNotification(notifications, data);
  await _acknowledgeFromBackground(data['id']);
}

Future<FlutterLocalNotificationsPlugin> _initializeLocalNotifications() async {
  final notifications = FlutterLocalNotificationsPlugin();
  await notifications.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    ),
  );
  await notifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ));
  return notifications;
}

Future<void> _showLocalNotification(
  FlutterLocalNotificationsPlugin notifications,
  Map<String, dynamic> data,
) async {
  final id = int.tryParse(data['id']?.toString() ?? '') ??
      DateTime.now().millisecondsSinceEpoch.remainder(2147483647);
  await notifications.show(
    id,
    data['title']?.toString() ?? 'Nueva notificacion',
    data['message']?.toString() ?? '',
    const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: true,
      ),
    ),
  );
}

Future<void> _acknowledgeFromBackground(dynamic id) async {
  if (id == null) return;
  final token = await SafeSecureStorage.read('jwt_token');
  var base = dotenv.env['JOSSRED']?.trim();
  if (token == null || token.isEmpty || base == null || base.isEmpty) return;
  if (base.endsWith('/')) base = base.substring(0, base.length - 1);
  if (base.endsWith('/api')) base = base.substring(0, base.length - 4);
  try {
    await http.post(
      Uri.parse('$base/api/notification-messages/ack'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'id': id,
        'app_id': NotificationService.appId,
      }),
    );
  } catch (_) {
    // El buzon durable reintentara cuando la app vuelva a abrirse.
  }
}

class FcmNotificationService {
  static const _registrationSignatureKey = 'fcm_registration_signature';
  static const _registrationTimeKey = 'fcm_registration_time';
  static const _registrationRefreshInterval = Duration(days: 7);
  static FlutterLocalNotificationsPlugin? _localNotifications;
  static bool _initialized = false;
  static Future<bool>? _registrationInFlight;

  static Future<void> initialize() async {
    if (_initialized ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }
    _initialized = true;

    try {
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(estrellaFcmBackgroundHandler);
      _localNotifications = await _initializeLocalNotifications();

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((remoteMessage) async {
        final data = Map<String, dynamic>.from(remoteMessage.data);
        if (data['app_id'] != NotificationService.appId ||
            _isExpiredTemporary(data)) {
          return;
        }
        if (data['type'] == 'push') {
          await _showLocalNotification(_localNotifications!, data);
        }
        NotificationService.handleNativeNotification(data);
      });

      FirebaseMessaging.instance.onTokenRefresh.listen((_) {
        registerCurrentToken(force: true);
      });
      await registerCurrentToken();
    } catch (error) {
      _initialized = false;
      debugPrint('[FCM] No se pudo iniciar: $error');
    }
  }

  static Future<bool> registerCurrentToken({bool force = false}) {
    final current = _registrationInFlight;
    if (current != null) return current;
    final operation = _registerCurrentToken(force: force);
    _registrationInFlight = operation;
    return operation.whenComplete(() {
      if (identical(_registrationInFlight, operation)) {
        _registrationInFlight = null;
      }
    });
  }

  static Future<bool> _registerCurrentToken({required bool force}) async {
    try {
      final jwt = await SafeSecureStorage.read('jwt_token');
      var base = dotenv.env['JOSSRED']?.trim();
      final deviceToken = await FirebaseMessaging.instance.getToken();
      final permission =
          await FirebaseMessaging.instance.getNotificationSettings();
      final notificationsEnabled =
          permission.authorizationStatus == AuthorizationStatus.authorized ||
              permission.authorizationStatus == AuthorizationStatus.provisional;
      if (jwt == null ||
          jwt.isEmpty ||
          base == null ||
          base.isEmpty ||
          deviceToken == null ||
          deviceToken.isEmpty) {
        return false;
      }
      if (base.endsWith('/')) base = base.substring(0, base.length - 1);
      if (base.endsWith('/api')) base = base.substring(0, base.length - 4);

      final signature = '$deviceToken|$notificationsEnabled|$jwt';
      final previousSignature =
          await SafeSecureStorage.read(_registrationSignatureKey);
      final previousRegistration = DateTime.tryParse(
        await SafeSecureStorage.read(_registrationTimeKey) ?? '',
      );
      final registrationIsFresh = previousRegistration != null &&
          DateTime.now().difference(previousRegistration) <
              _registrationRefreshInterval;
      if (!force && previousSignature == signature && registrationIsFresh) {
        return true;
      }

      final response = await http.post(
        Uri.parse('$base/api/notification-devices'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode({
          'device_token': deviceToken,
          'app_id': NotificationService.appId,
          'notifications_enabled': notificationsEnabled,
          'platform':
              defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android',
        }),
      );
      if (response.statusCode != 200) return false;
      await SafeSecureStorage.write(_registrationSignatureKey, signature);
      await SafeSecureStorage.write(
        _registrationTimeKey,
        DateTime.now().toUtc().toIso8601String(),
      );
      return true;
    } catch (error) {
      debugPrint('[FCM] No se pudo registrar el dispositivo: $error');
      return false;
    }
  }

  static Future<void> unregisterCurrentToken() async {
    try {
      final jwt = await SafeSecureStorage.read('jwt_token');
      var base = dotenv.env['JOSSRED']?.trim();
      final deviceToken = await FirebaseMessaging.instance.getToken();
      if (jwt == null ||
          jwt.isEmpty ||
          base == null ||
          base.isEmpty ||
          deviceToken == null ||
          deviceToken.isEmpty) {
        return;
      }
      if (base.endsWith('/')) base = base.substring(0, base.length - 1);
      if (base.endsWith('/api')) base = base.substring(0, base.length - 4);
      await http.post(
        Uri.parse('$base/api/notification-devices/deactivate'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
        body: jsonEncode({
          'device_token': deviceToken,
          'app_id': NotificationService.appId,
        }),
      );
    } catch (error) {
      debugPrint('[FCM] No se pudo desactivar el dispositivo: $error');
    } finally {
      await SafeSecureStorage.delete(_registrationSignatureKey);
      await SafeSecureStorage.delete(_registrationTimeKey);
    }
  }
}
