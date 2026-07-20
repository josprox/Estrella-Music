import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:audio_service/audio_service.dart';

class ColisteningService extends GetxService {
  WebSocket? _socket;
  StreamSubscription? _subscription;
  
  final isConnected = false.obs;
  final currentRoomCode = ''.obs;
  final isHost = false.obs;
  final connId = ''.obs;
  final guests = <String>[].obs;

  SyncService get _syncService => Get.find<SyncService>();

  String get _wsUrl {
    var base = _syncService.syncBaseUrl ?? 'http://127.0.0.1:9000';
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    base = base.replaceAll('https://', 'wss://').replaceAll('http://', 'ws://');
    return '$base/api/co-listening-ws';
  }

  Future<void> connect() async {
    if (isConnected.value) return;
    printINFO("ColisteningService: Connecting to WS: $_wsUrl");
    try {
      _socket = await WebSocket.connect(_wsUrl).timeout(const Duration(seconds: 10));
      isConnected.value = true;
      
      _subscription = _socket!.listen(
        (message) {
          _handleMessage(message.toString());
        },
        onError: (err) {
          printERROR("ColisteningService: WS Error: $err");
          disconnect();
        },
        onDone: () {
          printINFO("ColisteningService: WS Connection closed.");
          disconnect();
        },
      );
    } catch (e) {
      printERROR("ColisteningService: Connection failed: $e");
      isConnected.value = false;
    }
  }

  void disconnect() {
    _subscription?.cancel();
    _socket?.close();
    _socket = null;
    isConnected.value = false;
    currentRoomCode.value = '';
    isHost.value = false;
    connId.value = '';
    guests.clear();
    printINFO("ColisteningService: Disconnected.");
  }

  void createRoom() {
    if (_socket == null) return;
    final payload = {"type": "create_room"};
    _socket!.add(jsonEncode(payload));
  }

  void joinRoom(String roomCode) {
    if (_socket == null) return;
    final payload = {"type": "join_room", "roomCode": roomCode};
    _socket!.add(jsonEncode(payload));
  }

  void sendPlaybackSync(Map<String, dynamic> state) {
    if (_socket == null || currentRoomCode.isEmpty) return;
    final payload = {
      "type": "sync_playback",
      "state": state
    };
    _socket!.add(jsonEncode(payload));
  }

  void _handleMessage(String raw) {
    try {
      final Map<String, dynamic> data = jsonDecode(raw);
      final String? type = data['type'];
      printINFO("ColisteningService: Received message type: $type");

      switch (type) {
        case 'welcome':
          connId.value = data['connId']?.toString() ?? '';
          break;

        case 'room_created':
          currentRoomCode.value = data['roomCode']?.toString() ?? '';
          isHost.value = true;
          guests.clear();
          printINFO("ColisteningService: Room created: ${currentRoomCode.value}");
          break;

        case 'joined':
          currentRoomCode.value = data['roomCode']?.toString() ?? '';
          isHost.value = false;
          printINFO("ColisteningService: Joined room: ${currentRoomCode.value}");
          break;

        case 'guest_joined':
          final guestId = data['guestId']?.toString() ?? '';
          if (!guests.contains(guestId)) {
            guests.add(guestId);
          }
          printINFO("ColisteningService: Guest joined: $guestId");
          // If host, push current playback state immediately
          if (isHost.value && Get.isRegistered<PlayerController>()) {
            final player = Get.find<PlayerController>();
            if (player.currentSong.value != null) {
              sendPlaybackSync({
                "videoId": player.currentSong.value!.id,
                "position": player.progressBarStatus.value.current.inMilliseconds,
                "isPlaying": player.buttonState.value == PlayButtonState.playing,
                "title": player.currentSong.value!.title,
                "artist": player.currentSong.value!.artist,
                "artUri": player.currentSong.value!.artUri?.toString(),
              });
            }
          }
          break;

        case 'sync_state':
          final state = data['state'] as Map<String, dynamic>?;
          if (state != null && Get.isRegistered<PlayerController>()) {
            _syncLocalPlayer(state);
          }
          break;

        case 'error':
          printERROR("ColisteningService: Server error: ${data['message']}");
          break;
      }
    } catch (e) {
      printERROR("ColisteningService: Error parsing message: $e");
    }
  }

  void _syncLocalPlayer(Map<String, dynamic> state) async {
    final String? videoId = state['videoId'];
    final int? positionMs = state['position'];
    final bool? isPlaying = state['isPlaying'];
    final String? title = state['title'];
    final String? artist = state['artist'];
    final String? artUri = state['artUri'];

    if (videoId == null) return;
    
    final player = Get.find<PlayerController>();
    
    // 1. Check if song matches, if not play it
    if (player.currentSong.value?.id != videoId) {
      printINFO("ColisteningService: Syncing song to $title ($videoId)");
      final mediaItem = MediaItem(
        id: videoId,
        album: 'EMusic Sync',
        title: title ?? 'Sync Song',
        artist: artist ?? 'Unknown',
        artUri: artUri != null ? Uri.parse(artUri) : null,
      );
      
      // Load and play song
      await player.playPlayListSong([mediaItem], 0);
    }

    // 2. Sync playback status (Play/Pause)
    if (isPlaying != null) {
      if (isPlaying && player.buttonState.value != PlayButtonState.playing) {
        player.play();
      } else if (!isPlaying && player.buttonState.value == PlayButtonState.playing) {
        player.pause();
      }
    }

    // 3. Sync seek position if drift is larger than 1.5 seconds
    if (positionMs != null) {
      final targetPos = Duration(milliseconds: positionMs);
      final currentPos = player.progressBarStatus.value.current;
      final diff = (currentPos - targetPos).inMilliseconds.abs();
      if (diff > 1500) {
        printINFO("ColisteningService: Drift detected ($diff ms). Seeking to $positionMs ms");
        player.seek(targetPos);
      }
    }
  }

  @override
  void onClose() {
    disconnect();
    super.onClose();
  }
}
