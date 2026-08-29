import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:estrella_music/services/storage/safe_secure_storage.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static const appId = 'estrella_music';
  static Timer? _desktopSyncTimer;
  static bool _syncing = false;

  static void Function(String title, String message, String type)?
      _onNotificationReceived;
  static final List<Map<String, dynamic>> _uiBacklog = [];
  static final Set<String> _seenMessageIds = {};

  static set onNotificationReceived(
    void Function(String title, String message, String type)? callback,
  ) {
    _onNotificationReceived = callback;
    if (callback == null || _uiBacklog.isEmpty) return;

    final queued = List<Map<String, dynamic>>.from(_uiBacklog);
    _uiBacklog.clear();
    for (final data in queued) {
      _deliverToUi(data, callback);
    }
  }

  static Future<void> initInboxSync({required bool mobile}) async {
    await syncMessages();
    if (mobile) return;
    _desktopSyncTimer?.cancel();
    _desktopSyncTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => syncMessages(),
    );
  }

  static Future<void> syncMessages() async {
    if (_syncing) return;
    _syncing = true;
    try {
      final token = await SafeSecureStorage.read('jwt_token');
      final base = _normalizedBaseUrl();
      if (token == null || token.isEmpty || base == null) return;

      final response = await http.get(
        Uri.parse('$base/api/notification-messages')
            .replace(queryParameters: {'app_id': appId}),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode != 200) return;

      final payload = jsonDecode(response.body);
      final items = payload is Map ? payload['data'] : null;
      if (items is List) {
        for (final item in items.whereType<Map>()) {
          handleNativeNotification(Map<String, dynamic>.from(item));
        }
      }
    } catch (error) {
      debugPrint('[NotificationService] Sincronizacion: $error');
    } finally {
      _syncing = false;
    }
  }

  static void handleNativeNotification(Map<String, dynamic> data) {
    if (data['app_id']?.toString() != appId) return;
    if (_isExpiredTemporary(data)) return;
    final id = data['id']?.toString();
    if (id != null && id.isNotEmpty && !_seenMessageIds.add(id)) return;

    final callback = _onNotificationReceived;
    if (callback == null) {
      _uiBacklog.add(Map<String, dynamic>.from(data));
      return;
    }
    _deliverToUi(data, callback);
  }

  static bool _isExpiredTemporary(Map<String, dynamic> data) {
    if (data['delivery_mode']?.toString() != 'temporary') return false;
    final expiresAt = DateTime.tryParse(data['expires_at']?.toString() ?? '');
    return expiresAt == null || !expiresAt.isAfter(DateTime.now());
  }

  static void _deliverToUi(
    Map<String, dynamic> data,
    void Function(String title, String message, String type) callback,
  ) {
    callback(
      data['title']?.toString() ?? 'Nueva notificacion',
      data['message']?.toString() ?? '',
      data['type']?.toString() ?? 'push',
    );

    final id = data['id'];
    if (id != null) unawaited(acknowledgeMessage(id));
  }

  static Future<bool> acknowledgeMessage(dynamic id) async {
    final idText = id.toString();
    try {
      final token = await SafeSecureStorage.read('jwt_token');
      final base = _normalizedBaseUrl();
      if (token == null || token.isEmpty || base == null) {
        _seenMessageIds.remove(idText);
        return false;
      }

      final response = await http.post(
        Uri.parse('$base/api/notification-messages/ack'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': id, 'app_id': appId}),
      );
      if (response.statusCode == 200) return true;
    } catch (error) {
      debugPrint('[NotificationService] Confirmacion: $error');
    }
    _seenMessageIds.remove(idText);
    return false;
  }

  static String? _normalizedBaseUrl() {
    var base = dotenv.env['JOSSRED']?.trim();
    if (base == null || base.isEmpty) return null;
    if (base.endsWith('/')) base = base.substring(0, base.length - 1);
    if (base.endsWith('/api')) base = base.substring(0, base.length - 4);
    return base;
  }

  static Future<void> disconnect() async {
    _desktopSyncTimer?.cancel();
    _desktopSyncTimer = null;
  }
}
