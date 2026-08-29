import 'package:flutter/foundation.dart';

enum PlaybackSourceType { localFile, authorizedStream, external, embedded }

enum AudioQuality { low, high }

@immutable
class PlaybackSource {
  const PlaybackSource({
    required this.type,
    required this.uri,
    this.headers = const {},
    this.mimeType,
    this.expiresAt,
    this.bitrate,
    this.loudnessDb = 0,
  });

  final PlaybackSourceType type;
  final Uri uri;
  final Map<String, String> headers;
  final String? mimeType;
  final DateTime? expiresAt;
  final int? bitrate;
  final double loudnessDb;

  bool get isLocal => type == PlaybackSourceType.localFile;
  bool get isExpired =>
      expiresAt != null && !DateTime.now().isBefore(expiresAt!);
}
