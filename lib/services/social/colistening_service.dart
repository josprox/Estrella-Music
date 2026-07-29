import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

class ColisteningService extends GetxService {
  static const _pingInterval = Duration(seconds: 30);

  WebSocket? _socket;
  StreamSubscription? _subscription;
  bool _connecting = false;
  bool _disposed = false;
  int _connectionGeneration = 0;

  final isConnected = false.obs;
  final currentRoomCode = ''.obs;
  final isHost = false.obs;
  final connId = ''.obs;
  final guests = <String>[].obs;

  SyncService get _syncService => Get.find<SyncService>();
  AuthService get _authService => Get.find<AuthService>();

  String get _wsUrl {
    var base = _syncService.syncBaseUrl ?? 'http://127.0.0.1:9000';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    base = base.replaceAll('https://', 'wss://').replaceAll('http://', 'ws://');
    return '$base/api/co-listening-ws';
  }

  Future<void> connect() async {
    if (_disposed || _connecting || _socket?.readyState == WebSocket.open) {
      return;
    }

    _connecting = true;
    final generation = ++_connectionGeneration;
    printINFO('ColisteningService: Connecting to WS: $_wsUrl');
    try {
      final token = await _authService.getAccessToken();
      final socket = await WebSocket.connect(
        _wsUrl,
      ).timeout(const Duration(seconds: 10));

      if (_disposed || generation != _connectionGeneration) {
        await socket.close();
        return;
      }

      socket.pingInterval = _pingInterval;
      _socket = socket;
      _subscription = socket.listen(
        (message) => _handleMessage(
          message.toString(),
          generation,
          socket,
        ),
        onError: (Object error) {
          printERROR('ColisteningService: WS Error: $error');
          _handleConnectionEnded(generation, socket);
        },
        onDone: () {
          printINFO('ColisteningService: WS Connection closed.');
          _handleConnectionEnded(generation, socket);
        },
        cancelOnError: true,
      );

      if (token != null && token.isNotEmpty) {
        socket.add(jsonEncode({'type': 'auth', 'token': token}));
      }
    } catch (error) {
      printERROR('ColisteningService: Connection failed: $error');
      if (generation == _connectionGeneration) {
        _resetConnectionState();
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
    _resetConnectionState(closeSocket: true);
  }

  void disconnect() {
    _connectionGeneration++;
    final socket = _socket;
    if (socket?.readyState == WebSocket.open && currentRoomCode.isNotEmpty) {
      try {
        socket!.add(jsonEncode({'type': 'leave_room'}));
      } catch (_) {}
    }
    _resetConnectionState(closeSocket: true);
    printINFO('ColisteningService: Disconnected.');
  }

  void _resetConnectionState({bool closeSocket = false}) {
    _subscription?.cancel();
    _subscription = null;
    final socket = _socket;
    _socket = null;
    _connecting = false;
    isConnected.value = false;
    currentRoomCode.value = '';
    isHost.value = false;
    connId.value = '';
    guests.clear();
    if (closeSocket && socket != null) {
      unawaited(socket.close());
    }
  }

  void createRoom() {
    if (!isConnected.value || _socket == null) return;
    _socket!.add(jsonEncode({'type': 'create_room'}));
  }

  void joinRoom(String roomCode) {
    final normalizedCode = roomCode.trim();
    if (!isConnected.value || _socket == null || normalizedCode.isEmpty) {
      return;
    }
    _socket!.add(
      jsonEncode({'type': 'join_room', 'roomCode': normalizedCode}),
    );
  }

  void leaveRoom() {
    if (!isConnected.value || _socket == null || currentRoomCode.isEmpty) {
      return;
    }
    _socket!.add(jsonEncode({'type': 'leave_room'}));
  }

  void sendPlaybackSync(Map<String, dynamic> state) {
    if (!isConnected.value || _socket == null || currentRoomCode.isEmpty) {
      return;
    }
    _socket!.add(jsonEncode({'type': 'sync_playback', 'state': state}));
  }

  void _handleMessage(
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
      printINFO('ColisteningService: Received message type: $type');

      switch (type) {
        case 'welcome':
          connId.value = data['connId']?.toString() ?? '';
          if (data['auth_required'] != true) {
            isConnected.value = true;
          }
          break;
        case 'authenticated':
          isConnected.value = true;
          break;
        case 'auth_failed':
          printERROR(
            'ColisteningService: Authentication failed: ${data['message']}',
          );
          disconnect();
          break;
        case 'room_created':
          currentRoomCode.value = data['roomCode']?.toString() ?? '';
          isHost.value = true;
          guests.clear();
          printINFO(
            'ColisteningService: Room created: ${currentRoomCode.value}',
          );
          break;
        case 'joined':
          currentRoomCode.value = data['roomCode']?.toString() ?? '';
          isHost.value = false;
          printINFO(
            'ColisteningService: Joined room: ${currentRoomCode.value}',
          );
          break;
        case 'left_room':
          currentRoomCode.value = '';
          isHost.value = false;
          guests.clear();
          break;
        case 'room_closed':
          printINFO('ColisteningService: Host closed the room.');
          currentRoomCode.value = '';
          isHost.value = false;
          guests.clear();
          break;
        case 'guest_joined':
          final guestId = data['guestId']?.toString() ?? '';
          if (guestId.isNotEmpty && !guests.contains(guestId)) {
            guests.add(guestId);
          }
          printINFO('ColisteningService: Guest joined: $guestId');
          _sendCurrentPlaybackStateToNewGuest();
          break;
        case 'guest_left':
          final guestId = data['guestId']?.toString() ?? '';
          guests.remove(guestId);
          printINFO('ColisteningService: Guest left: $guestId');
          break;
        case 'sync_state':
          final rawState = data['state'];
          if (rawState is Map && Get.isRegistered<PlayerController>()) {
            unawaited(
              _syncLocalPlayer(Map<String, dynamic>.from(rawState)),
            );
          }
          break;
        case 'sync_ack':
          break;
        case 'pong':
          break;
        case 'error':
          printERROR(
            'ColisteningService: Server error: ${data['message']}',
          );
          break;
        default:
          printERROR('ColisteningService: Unknown message type: $type');
      }
    } catch (error) {
      printERROR('ColisteningService: Error parsing message: $error');
    }
  }

  void _sendCurrentPlaybackStateToNewGuest() {
    if (!isHost.value || !Get.isRegistered<PlayerController>()) return;
    final player = Get.find<PlayerController>();
    final song = player.currentSong.value;
    if (song == null) return;

    sendPlaybackSync({
      'videoId': song.id,
      'position': player.progressBarStatus.value.current.inMilliseconds,
      'isPlaying': player.buttonState.value == PlayButtonState.playing,
      'title': song.title,
      'artist': song.artist,
      'artUri': song.artUri?.toString(),
    });
  }

  Future<void> _syncLocalPlayer(Map<String, dynamic> state) async {
    final videoId = state['videoId']?.toString();
    final positionMs = state['position'] is num
        ? (state['position'] as num).toInt()
        : int.tryParse(state['position']?.toString() ?? '');
    final isPlaying = state['isPlaying'] as bool?;
    final title = state['title']?.toString();
    final artist = state['artist']?.toString();
    final artUri = state['artUri']?.toString();

    if (videoId == null || videoId.isEmpty) return;
    final player = Get.find<PlayerController>();

    if (player.currentSong.value?.id != videoId) {
      printINFO('ColisteningService: Syncing song to $title ($videoId)');
      final mediaItem = MediaItem(
        id: videoId,
        album: 'EMusic Sync',
        title: title ?? 'Sync Song',
        artist: artist ?? 'Unknown',
        artUri: artUri != null ? Uri.tryParse(artUri) : null,
      );
      await player.playPlayListSong([mediaItem], 0);
    }

    if (isPlaying != null) {
      if (isPlaying && player.buttonState.value != PlayButtonState.playing) {
        player.play();
      } else if (!isPlaying &&
          player.buttonState.value == PlayButtonState.playing) {
        player.pause();
      }
    }

    if (positionMs != null && positionMs >= 0) {
      final targetPosition = Duration(milliseconds: positionMs);
      final currentPosition = player.progressBarStatus.value.current;
      final drift = (currentPosition - targetPosition).inMilliseconds.abs();
      if (drift > 1500) {
        printINFO(
          'ColisteningService: Drift detected ($drift ms). Seeking to $positionMs ms',
        );
        player.seek(targetPosition);
      }
    }
  }

  @override
  void onClose() {
    _disposed = true;
    disconnect();
    super.onClose();
  }
}
