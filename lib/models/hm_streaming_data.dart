class Audio {
  const Audio({
    required this.itag,
    required this.audioCodec,
    required this.bitrate,
    this.duration = 0,
    this.size = 0,
    this.loudnessDb = 0,
    required this.url,
    this.headers = const {},
    this.mimeType,
  });

  final int itag;
  final Codec audioCodec;
  final int bitrate;
  final int duration;
  final int size;
  final double loudnessDb;
  final String url;
  final Map<String, String> headers;
  final String? mimeType;

  Map<String, dynamic> toJson() => {
        'itag': itag,
        'audioCodec': audioCodec.name,
        'bitrate': bitrate,
        'approxDurationMs': duration,
        'size': size,
        'loudnessDb': loudnessDb,
        'url': url,
        'headers': headers,
        'mimeType': mimeType,
      };

  factory Audio.fromJson(dynamic json) => Audio(
        itag: (json['itag'] as num?)?.toInt() ?? 0,
        audioCodec: json['audioCodec']?.toString().contains('opus') == true
            ? Codec.opus
            : Codec.mp4a,
        bitrate: (json['bitrate'] as num?)?.toInt() ?? 0,
        duration: (json['approxDurationMs'] as num?)?.toInt() ?? 0,
        size: (json['size'] as num?)?.toInt() ?? 0,
        loudnessDb: (json['loudnessDb'] as num?)?.toDouble() ?? 0,
        url: json['url']?.toString() ?? '',
        headers: json['headers'] is Map
            ? (json['headers'] as Map).map(
                (key, value) => MapEntry(key.toString(), value.toString()),
              )
            : const {},
        mimeType: json['mimeType']?.toString(),
      );
}

enum Codec { mp4a, opus }

class HMStreamingData {
  final bool playable;
  final String statusMSG;
  final Audio? lowQualityAudio;
  final Audio? highQualityAudio;
  int qualityIndex = 1;
  HMStreamingData({
    required this.playable,
    required this.statusMSG,
    this.lowQualityAudio,
    this.highQualityAudio,
  });

  setQualityIndex(int index) {
    qualityIndex = index;
  }

  Audio? get audio => qualityIndex == 0 ? lowQualityAudio : highQualityAudio;

  factory HMStreamingData.fromJson(json) {
    if (!json['playable']) {
      return HMStreamingData(
        playable: false,
        statusMSG: json['statusMSG'],
      );
    }
    final lowQualityAudio = Audio.fromJson(json['lowQualityAudio']);
    final highQualityAudio = Audio.fromJson(json['highQualityAudio']);
    return HMStreamingData(
        playable: json['playable'],
        statusMSG: json['statusMSG'],
        lowQualityAudio: lowQualityAudio,
        highQualityAudio: highQualityAudio);
  }

  Map<String, dynamic> toJson() => {
        "playable": playable,
        "statusMSG": statusMSG,
        "lowQualityAudio": lowQualityAudio?.toJson(),
        "highQualityAudio": highQualityAudio?.toJson(),
      };
}
