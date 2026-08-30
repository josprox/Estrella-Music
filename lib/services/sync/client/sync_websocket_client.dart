import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:estrella_music/utils/helpers/helper.dart';

class SyncWebSocketClient {
  static const _authenticationTimeout = Duration(seconds: 15);
  static const _pushTimeout = Duration(seconds: 30);
  static const _pingInterval = Duration(seconds: 45);

  Completer<bool>? _pushCompleter;
  Map<String, int>? _expectedPushCounts;
  WebSocket? _socket;
  StreamSubscription? _subscription;
  Timer? _authenticationTimer;
  Timer? _pushTimer;
  Timer? _reconnectTimer;

  bool _isSocketAuthenticated = false;
  bool _shouldReconnect = false;
  bool _disposed = false;
  bool _connecting = false;
  int _connectionGeneration = 0;
  int _reconnectDelaySeconds = 5;
  final Random _reconnectRandom = Random();
  String? _activeUrl;
  String? _activeToken;
  String? _desiredUrl;
  String? _desiredToken;

  final String deviceId;
  final _onSyncUpdateController = StreamController<void>.broadcast();
  final _onAuthenticatedController = StreamController<void>.broadcast();

  Stream<void> get onSyncUpdate => _onSyncUpdateController.stream;
  Stream<void> get onAuthenticated => _onAuthenticatedController.stream;
  bool get isConnected => _socket?.readyState == WebSocket.open;
  bool get isAuthenticated => isConnected && _isSocketAuthenticated;

  SyncWebSocketClient({required this.deviceId});

  Future<void> connect(String wsUrl, String token) async {
    if (_disposed || token.isEmpty) return;

    _desiredUrl = wsUrl;
    _desiredToken = token;
    _shouldReconnect = true;

    final connectionIsCurrent = (_socket != null || _connecting) &&
        _activeUrl == wsUrl &&
        _activeToken == token;
    if (connectionIsCurrent) return;

    _closeCurrentConnection();
    _connecting = true;
    _activeUrl = wsUrl;
    _activeToken = token;
    final generation = ++_connectionGeneration;

    printINFO('SyncWebSocketClient: Connecting to WS: $wsUrl');
    try {
      _reconnectTimer?.cancel();
      final socket = await WebSocket.connect(
        wsUrl,
      ).timeout(const Duration(seconds: 10));

      if (_disposed ||
          !_shouldReconnect ||
          generation != _connectionGeneration) {
        await socket.close();
        return;
      }

      socket.pingInterval = _pingInterval;
      _socket = socket;
      _isSocketAuthenticated = false;

      _subscription = socket.listen(
        (message) => _handleSocketMessage(
          message.toString(),
          generation,
          socket,
        ),
        onError: (Object error) {
          printERROR('SyncWebSocketClient: WS Error: $error');
          _handleConnectionEnded(generation, socket);
        },
        onDone: () {
          printINFO('SyncWebSocketClient: WS Connection closed.');
          _handleConnectionEnded(generation, socket);
        },
        cancelOnError: true,
      );

      socket.add(
        jsonEncode({'type': 'auth', 'token': token, 'device_id': deviceId}),
      );
      _authenticationTimer?.cancel();
      _authenticationTimer = Timer(_authenticationTimeout, () {
        if (generation == _connectionGeneration && !_isSocketAuthenticated) {
          printERROR('SyncWebSocketClient: Authentication timed out.');
          _handleConnectionEnded(generation, socket);
          unawaited(socket.close());
        }
      });
    } catch (error) {
      printERROR('SyncWebSocketClient: Connection failed: $error');
      if (generation == _connectionGeneration) {
        _scheduleReconnect();
      }
    } finally {
      if (generation == _connectionGeneration) {
        _connecting = false;
      }
    }
  }

  void _handleConnectionEnded(int generation, WebSocket socket) {
    if (generation != _connectionGeneration || !identical(_socket, socket)) {
      return;
    }

    _authenticationTimer?.cancel();
    _authenticationTimer = null;
    _subscription?.cancel();
    _subscription = null;
    _socket = null;
    _isSocketAuthenticated = false;
    _completePendingPush(false);
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_disposed || !_shouldReconnect) return;
    final wsUrl = _desiredUrl;
    final token = _desiredToken;
    if (wsUrl == null || token == null || token.isEmpty) return;

    _reconnectTimer?.cancel();
    final baseDelay = _reconnectDelaySeconds;
    final jitterWindow = min(baseDelay * 5, 300);
    final delay = baseDelay + _reconnectRandom.nextInt(jitterWindow + 1);
    printINFO(
      'SyncWebSocketClient: Scheduling reconnect in $delay seconds...',
    );
    _reconnectTimer = Timer(Duration(seconds: delay), () {
      if (_shouldReconnect && !_disposed) {
        unawaited(connect(wsUrl, token));
      }
    });
    _reconnectDelaySeconds = (_reconnectDelaySeconds * 2).clamp(5, 300);
  }

  void disconnect() {
    _shouldReconnect = false;
    _desiredUrl = null;
    _desiredToken = null;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _connectionGeneration++;
    _closeCurrentConnection();
    printINFO('SyncWebSocketClient: WS Disconnected.');
  }

  void _closeCurrentConnection() {
    _authenticationTimer?.cancel();
    _authenticationTimer = null;
    _pushTimer?.cancel();
    _pushTimer = null;
    _subscription?.cancel();
    _subscription = null;
    final socket = _socket;
    _socket = null;
    _isSocketAuthenticated = false;
    _connecting = false;
    _activeUrl = null;
    _activeToken = null;
    _completePendingPush(false);
    if (socket != null) {
      unawaited(socket.close());
    }
  }

  Future<bool> sendPushPayload(Map<String, dynamic> payload) {
    final socket = _socket;
    if (socket == null || !isAuthenticated) {
      return Future.value(false);
    }

    _completePendingPush(false);
    _pushCompleter = Completer<bool>();
    _expectedPushCounts = _collectionCounts(payload);
    _pushTimer = Timer(_pushTimeout, () {
      printERROR('SyncWebSocketClient: Push acknowledgement timed out.');
      _completePendingPush(false);
    });

    try {
      socket.add(
        jsonEncode({
          'type': 'push',
          'payload': payload,
          'device_id': deviceId,
        }),
      );
      return _pushCompleter!.future;
    } catch (error) {
      printERROR('SyncWebSocketClient: Failed to send push: $error');
      _completePendingPush(false);
      return Future.value(false);
    }
  }

  void _handleSocketMessage(
    String raw,
    int generation,
    WebSocket socket,
  ) {
    if (generation != _connectionGeneration || !identical(_socket, socket)) {
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw const FormatException('WebSocket payload is not an object');
      }
      final data = Map<String, dynamic>.from(decoded);
      final type = data['type']?.toString();
      printINFO('SyncWebSocketClient: WS Received message type: $type');

      switch (type) {
        case 'welcome':
        case 'pong':
          break;
        case 'authenticated':
          _authenticationTimer?.cancel();
          _authenticationTimer = null;
          _isSocketAuthenticated = true;
          _reconnectDelaySeconds = 5;
          printINFO('SyncWebSocketClient: WS Authenticated successfully.');
          _onAuthenticatedController.add(null);
          break;
        case 'auth_failed':
          _isSocketAuthenticated = false;
          printERROR(
            'SyncWebSocketClient: WS Auth failed: ${data['message']}',
          );
          disconnect();
          break;
        case 'sync_update':
          if (data['origin_device_id']?.toString() == deviceId) {
            break;
          }
          printINFO(
            'SyncWebSocketClient: WS received sync_update, notifying orchestrator...',
          );
          _onSyncUpdateController.add(null);
          break;
        case 'push_success':
          final valid = _summaryMatchesExpected(data['summary']);
          valid
              ? printINFO(
                  'SyncWebSocketClient: WS push succeeded and was verified.',
                )
              : printERROR(
                  'SyncWebSocketClient: WS push acknowledgement did not match the sent snapshot.',
                );
          _completePendingPush(valid);
          break;
        case 'error':
          printERROR(
            'SyncWebSocketClient: WS Error: ${data['message']}',
          );
          _completePendingPush(false);
          break;
        default:
          printERROR(
            'SyncWebSocketClient: Unknown message type: $type',
          );
      }
    } catch (error) {
      printERROR('SyncWebSocketClient: WS Error parsing message: $error');
    }
  }

  void _completePendingPush(bool result) {
    _pushTimer?.cancel();
    _pushTimer = null;
    final completer = _pushCompleter;
    _pushCompleter = null;
    _expectedPushCounts = null;
    if (completer != null && !completer.isCompleted) {
      completer.complete(result);
    }
  }

  Map<String, int> _collectionCounts(Map<String, dynamic> payload) {
    const keys = [
      'playlists',
      'favorites',
      'recent_plays',
      'albums',
      'artists',
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
    if (_disposed) return;
    _disposed = true;
    disconnect();
    _onSyncUpdateController.close();
    _onAuthenticatedController.close();
  }
}
