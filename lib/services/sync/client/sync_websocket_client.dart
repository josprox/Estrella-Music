import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:harmonymusic/utils/helpers/helper.dart';

class SyncWebSocketClient {
  WebSocket? _socket;
  StreamSubscription? _subscription;
  bool _isSocketAuthenticated = false;
  Timer? _reconnectTimer;
  final String deviceId;

  final _onSyncUpdateController = StreamController<void>.broadcast();
  Stream<void> get onSyncUpdate => _onSyncUpdateController.stream;

  bool get isConnected => _socket != null;
  bool get isAuthenticated => _isSocketAuthenticated;

  SyncWebSocketClient({required this.deviceId});

  Future<void> connect(String wsUrl, String token) async {
    if (_socket != null) return;
    printINFO("SyncWebSocketClient: Connecting to WS: $wsUrl");
    try {
      _reconnectTimer?.cancel();
      _socket = await WebSocket.connect(wsUrl).timeout(const Duration(seconds: 10));
      _isSocketAuthenticated = false;

      _socket!.add(jsonEncode({
        "type": "auth",
        "token": token,
        "device_id": deviceId
      }));

      _subscription = _socket!.listen(
        (message) {
          _handleSocketMessage(message.toString(), wsUrl, token);
        },
        onError: (err) {
          printERROR("SyncWebSocketClient: WS Error: $err");
          _scheduleSocketReconnect(wsUrl, token);
        },
        onDone: () {
          printINFO("SyncWebSocketClient: WS Connection closed.");
          _scheduleSocketReconnect(wsUrl, token);
        },
      );
    } catch (e) {
      printERROR("SyncWebSocketClient: Connection failed: $e");
      _scheduleSocketReconnect(wsUrl, token);
    }
  }

  void _scheduleSocketReconnect(String wsUrl, String token) {
    _socket = null;
    _subscription?.cancel();
    _subscription = null;
    _isSocketAuthenticated = false;

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      connect(wsUrl, token);
    });
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _subscription = null;
    _socket?.close();
    _socket = null;
    _isSocketAuthenticated = false;
    printINFO("SyncWebSocketClient: WS Disconnected.");
  }

  void sendPushPayload(Map<String, dynamic> payload) {
    if (_socket == null || !_isSocketAuthenticated) {
      throw Exception("WebSocket is not connected or authenticated.");
    }
    _socket!.add(jsonEncode({
      "type": "push",
      "payload": payload,
      "device_id": deviceId
    }));
  }

  void _handleSocketMessage(String raw, String wsUrl, String token) {
    try {
      final Map<String, dynamic> data = jsonDecode(raw);
      final String? type = data['type'];
      printINFO("SyncWebSocketClient: WS Received message type: $type");

      switch (type) {
        case 'welcome':
          break;
        case 'authenticated':
          _isSocketAuthenticated = true;
          printINFO("SyncWebSocketClient: WS Authenticated successfully.");
          break;
        case 'auth_failed':
          _isSocketAuthenticated = false;
          printERROR("SyncWebSocketClient: WS Auth failed: ${data['message']}");
          disconnect();
          break;
        case 'sync_update':
          printINFO("SyncWebSocketClient: WS received sync_update, notifying orchestrator...");
          _onSyncUpdateController.add(null);
          break;
        case 'push_success':
          printINFO("SyncWebSocketClient: WS push succeeded.");
          break;
        case 'error':
          printERROR("SyncWebSocketClient: WS Error: ${data['message']}");
          break;
      }
    } catch (e) {
      printERROR("SyncWebSocketClient: WS Error parsing message: $e");
    }
  }

  void dispose() {
    disconnect();
    _onSyncUpdateController.close();
  }
}
