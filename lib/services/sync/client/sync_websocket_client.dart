import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:harmonymusic/utils/helpers/helper.dart';

class SyncWebSocketClient {
  Completer<bool>? _pushCompleter;
  Map<String, int>? _expectedPushCounts;
  WebSocket? _socket;
  StreamSubscription? _subscription;
  bool _isSocketAuthenticated = false;
  Timer? _reconnectTimer;
  int _reconnectDelaySeconds = 5;
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
      _socket =
          await WebSocket.connect(wsUrl).timeout(const Duration(seconds: 10));
      _isSocketAuthenticated = false;

      _socket!.add(
          jsonEncode({"type": "auth", "token": token, "device_id": deviceId}));

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
    _pushCompleter?.complete(false);
    _pushCompleter = null;
    _expectedPushCounts = null;
    _socket = null;
    _subscription?.cancel();
    _subscription = null;
    _isSocketAuthenticated = false;

    _reconnectTimer?.cancel();
    final delay = _reconnectDelaySeconds;
    printINFO("SyncWebSocketClient: Scheduling reconnect in $delay seconds...");
    _reconnectTimer = Timer(Duration(seconds: delay), () {
      connect(wsUrl, token);
    });

    _reconnectDelaySeconds = (_reconnectDelaySeconds * 2).clamp(5, 300);
  }

  void disconnect() {
    _pushCompleter?.complete(false);
    _pushCompleter = null;
    _expectedPushCounts = null;
    _reconnectTimer?.cancel();
    _subscription?.cancel();
    _subscription = null;
    _socket?.close();
    _socket = null;
    _isSocketAuthenticated = false;
    printINFO("SyncWebSocketClient: WS Disconnected.");
  }

  Future<bool> sendPushPayload(Map<String, dynamic> payload) {
    if (_socket == null || !_isSocketAuthenticated) {
      return Future.value(false);
    }
    _pushCompleter?.complete(false); // cancel any previous pending push
    _pushCompleter = Completer<bool>();
    _expectedPushCounts = _collectionCounts(payload);
    try {
      _socket!.add(jsonEncode(
          {"type": "push", "payload": payload, "device_id": deviceId}));
      return _pushCompleter!.future;
    } catch (e) {
      printERROR("SyncWebSocketClient: Failed to send push: $e");
      _pushCompleter = null;
      return Future.value(false);
    }
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
          _reconnectDelaySeconds = 5;
          printINFO("SyncWebSocketClient: WS Authenticated successfully.");
          break;
        case 'auth_failed':
          _isSocketAuthenticated = false;
          printERROR("SyncWebSocketClient: WS Auth failed: ${data['message']}");
          disconnect();
          break;
        case 'sync_update':
          printINFO(
              "SyncWebSocketClient: WS received sync_update, notifying orchestrator...");
          _onSyncUpdateController.add(null);
          break;
        case 'push_success':
          final valid = _summaryMatchesExpected(data['summary']);
          valid
              ? printINFO(
                  "SyncWebSocketClient: WS push succeeded and was verified.")
              : printERROR(
                  "SyncWebSocketClient: WS push acknowledgement did not match the sent snapshot.");
          _pushCompleter?.complete(valid);
          _pushCompleter = null;
          _expectedPushCounts = null;
          break;
        case 'error':
          printERROR("SyncWebSocketClient: WS Error: ${data['message']}");
          _pushCompleter?.complete(false);
          _pushCompleter = null;
          _expectedPushCounts = null;
          break;
      }
    } catch (e) {
      printERROR("SyncWebSocketClient: WS Error parsing message: $e");
    }
  }

  Map<String, int> _collectionCounts(Map<String, dynamic> payload) {
    const keys = [
      'playlists',
      'favorites',
      'recent_plays',
      'albums',
      'artists',
      'downloads',
    ];
    return {
      for (final key in keys)
        if (payload[key] is List) key: (payload[key] as List).length,
    };
  }

  bool _summaryMatchesExpected(dynamic rawSummary) {
    if (rawSummary is! Map || _expectedPushCounts == null) return false;
    for (final entry in _expectedPushCounts!.entries) {
      if (rawSummary[entry.key] != entry.value) return false;
    }
    return true;
  }

  void dispose() {
    disconnect();
    _onSyncUpdateController.close();
  }
}
