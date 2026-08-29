import 'dart:math';
import 'package:get/get.dart';
import 'package:dart_discord_presence/dart_discord_presence.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

class DiscordRpcService {
  static final DiscordRpcService _instance = DiscordRpcService._internal();
  factory DiscordRpcService() => _instance;
  DiscordRpcService._internal();

  static const String defaultAppId = "1447278780795064401";

  DiscordRPC? _rpc;
  bool _initialized = false;
  bool _isConnected = false;

  void init() async {
    if (_initialized) return;
    _initialized = true;

    if (!GetPlatform.isDesktop) {
      printINFO(
          "Discord RPC: Supported only on Desktop platforms (Windows, macOS, Linux). Skipping initialization.");
      return;
    }

    try {
      printINFO("Initializing Discord RPC with App ID: $defaultAppId");
      _rpc = DiscordRPC();
      await _rpc?.initialize(defaultAppId);
      _isConnected = true;
      printINFO("Discord RPC: Initialized and connected successfully.");
    } catch (e) {
      printERROR("Discord RPC: Initialization failed: $e");
    }
  }

  void updatePresence({
    required String title,
    required String artist,
    String? album,
    bool isPlaying = true,
    Duration? currentPosition,
    Duration? totalDuration,
  }) async {
    if (!GetPlatform.isDesktop || _rpc == null || !_isConnected) return;

    try {
      final state = isPlaying ? "Reproduciendo" : "Pausado";
      final details = "$title - $artist";

      // Calculate timestamps for remaining time if playing
      DateTime? startTime;
      DateTime? endTime;

      if (isPlaying && currentPosition != null && totalDuration != null) {
        final now = DateTime.now();
        startTime = now.subtract(currentPosition);
        endTime = startTime.add(totalDuration);
      }

      printINFO("Updating Discord RPC Presence: $details ($state)");

      await _rpc?.setPresence(
        DiscordPresence(
          state: state,
          details: details.substring(0, min(127, details.length)),
          largeAsset: DiscordAsset(
            key: "music_player",
            text: (album != null && album.isNotEmpty)
                ? album.substring(0, min(127, album.length))
                : "Estrella Music",
          ),
          smallAsset: DiscordAsset(
            key: isPlaying ? "play" : "pause",
            text: isPlaying ? "Reproduciendo" : "Pausado",
          ),
          timestamps: (startTime != null && endTime != null)
              ? DiscordTimestamps(
                  start: startTime.millisecondsSinceEpoch,
                  end: endTime.millisecondsSinceEpoch,
                )
              : null,
        ),
      );
    } catch (e) {
      printERROR("Discord RPC: Failed to update presence: $e");
    }
  }

  void clearPresence() async {
    if (!GetPlatform.isDesktop || _rpc == null) return;
    try {
      await _rpc?.clearPresence();
      printINFO("Discord RPC: Presence cleared.");
    } catch (e) {
      printERROR("Discord RPC: Failed to clear presence: $e");
    }
  }

  void close() async {
    if (!GetPlatform.isDesktop || _rpc == null) return;
    try {
      await _rpc?.dispose();
      _rpc = null;
      _isConnected = false;
      _initialized = false;
      printINFO("Discord RPC: Connection closed.");
    } catch (e) {
      printERROR("Discord RPC: Failed to close connection: $e");
    }
  }
}
