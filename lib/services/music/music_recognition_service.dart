import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:harmonymusic/services/music/shazam_signature_generator.dart';

enum RecognitionState {
  idle,
  listening,
  processing,
  success,
  noMatch,
  error,
}

class RecognitionResult {
  final String trackId;
  final String title;
  final String artist;
  final String? album;
  final String? coverArtUrl;
  final String? coverArtHqUrl;
  final String? genre;
  final String? releaseDate;
  final String? label;
  final List<String>? lyrics;
  final String? externalUrl;
  final String? isrc;

  RecognitionResult({
    required this.trackId,
    required this.title,
    required this.artist,
    this.album,
    this.coverArtUrl,
    this.coverArtHqUrl,
    this.genre,
    this.releaseDate,
    this.label,
    this.lyrics,
    this.externalUrl,
    this.isrc,
  });

  factory RecognitionResult.fromJson(Map<String, dynamic> json) {
    final track = json['track'] as Map<String, dynamic>?;
    if (track == null) {
      throw Exception("No track details in response");
    }

    final sections = track['sections'] as List<dynamic>?;

    Map<String, dynamic>? songSection;
    if (sections != null) {
      for (var sec in sections) {
        if (sec != null && sec['type'] == 'SONG') {
          songSection = sec as Map<String, dynamic>;
          break;
        }
      }
    }

    final metadata = songSection?['metadata'] as List<dynamic>?;
    String? album;
    String? label;
    String? releaseDate;

    if (metadata != null) {
      for (var item in metadata) {
        if (item != null) {
          final title = item['title'] as String?;
          final text = item['text'] as String?;
          if (title == 'Album') album = text;
          if (title == 'Label') label = text;
          if (title == 'Released') releaseDate = text;
        }
      }
    }

    Map<String, dynamic>? lyricsSection;
    if (sections != null) {
      for (var sec in sections) {
        if (sec != null && sec['type'] == 'LYRICS') {
          lyricsSection = sec as Map<String, dynamic>;
          break;
        }
      }
    }
    final lyricsList = lyricsSection?['text'] as List<dynamic>?;
    final List<String>? lyrics = lyricsList?.map((e) => e.toString()).toList();

    final images = track['images'] as Map<String, dynamic>?;
    final coverArtUrl = images?['coverart'] as String?;
    final coverArtHqUrl = images?['coverarthq'] as String?;

    final genres = track['genres'] as Map<String, dynamic>?;
    final genre = genres?['primary'] as String?;

    return RecognitionResult(
      trackId: track['key']?.toString() ?? json['tagid']?.toString() ?? '',
      title: track['title']?.toString() ?? '',
      artist: track['subtitle']?.toString() ?? '',
      album: album,
      coverArtUrl: coverArtUrl,
      coverArtHqUrl: coverArtHqUrl,
      genre: genre,
      releaseDate: releaseDate,
      label: label,
      lyrics: lyrics,
      externalUrl: track['url']?.toString(),
      isrc: track['isrc']?.toString(),
    );
  }
}

class MusicRecognitionService {
  final _audioRecorder = AudioRecorder();
  bool _isRecording = false;

  final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  static final List<String> _userAgents = [
    "Dalvik/2.1.0 (Linux; U; Android 5.0.2; VS980 4G Build/LRX22G)",
    "Dalvik/1.6.0 (Linux; U; Android 4.4.2; SM-T210 Build/KOT49H)",
    "Dalvik/2.1.0 (Linux; U; Android 5.1.1; SM-P905V Build/LMY47X)",
    "Dalvik/2.1.0 (Linux; U; Android 6.0.1; SM-G920F Build/MMB29K)",
    "Dalvik/2.1.0 (Linux; U; Android 5.0; SM-G900F Build/LRX21T)"
  ];

  static final List<String> _timezones = [
    "Europe/Paris",
    "Europe/London",
    "America/New_York",
    "America/Los_Angeles",
    "Asia/Tokyo",
    "Asia/Dubai"
  ];

  Future<RecognitionResult?> recognizeMusic({
    required Function(RecognitionState state) onStateChanged,
    required Function(String errorMessage) onError,
  }) async {
    try {
      onStateChanged(RecognitionState.listening);
      final permission = await Permission.microphone.request();
      if (!permission.isGranted) {
        onError("Se requiere permiso de micrófono para reconocer música.");
        onStateChanged(RecognitionState.error);
        return null;
      }

      final tempDir = await getTemporaryDirectory();
      final tempPath =
          '${tempDir.path}/shazam_rec_${DateTime.now().millisecondsSinceEpoch}.wav';

      _isRecording = true;
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: tempPath,
      );

      // Record for 12 seconds or until stopped early
      for (int i = 0; i < 24; i++) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (!_isRecording) break;
      }

      if (_isRecording) {
        _isRecording = false;
        await _audioRecorder.stop();
      }

      final file = File(tempPath);
      if (!await file.exists()) {
        onError("No se pudieron registrar datos de audio.");
        onStateChanged(RecognitionState.error);
        return null;
      }

      final fileBytes = await file.readAsBytes();
      if (fileBytes.length <= 44) {
        onError("El audio registrado está vacío o es inválido.");
        onStateChanged(RecognitionState.error);
        try {
          await file.delete();
        } catch (_) {}
        return null;
      }

      // Skip WAV header (44 bytes) to get the raw 16-bit PCM little-endian data
      final pcmBytes = fileBytes.sublist(44);
      final int16samples = pcmBytes.buffer
          .asInt16List(pcmBytes.offsetInBytes, pcmBytes.length ~/ 2);

      // Generate Shazam signature in pure Dart!
      final signature = ShazamSignatureGenerator.fromI16(int16samples);

      // Delete temporary recording file
      try {
        await file.delete();
      } catch (_) {}

      onStateChanged(RecognitionState.processing);

      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final uuid1 = _generateUuid().toUpperCase();
      final uuid2 = _generateUuid();

      final requestBody = {
        "geolocation": {
          "altitude": Random().nextDouble() * 400 + 100,
          "latitude": Random().nextDouble() * 180 - 90,
          "longitude": Random().nextDouble() * 360 - 180
        },
        "signature": {
          "samplems": 12000,
          "timestamp": timestamp,
          "uri": signature
        },
        "timestamp": timestamp,
        "timezone": _timezones[Random().nextInt(_timezones.length)]
      };

      final response = await _dio.post(
        "https://amp.shazam.com/discovery/v5/en/US/android/-/tag/$uuid1/$uuid2",
        queryParameters: {
          "sync": "true",
          "webv3": "true",
          "sampling": "true",
          "connected": "",
          "shazamapiversion": "v3",
          "sharehub": "true",
          "video": "v3"
        },
        data: requestBody,
        options: Options(
          headers: {
            "User-Agent": _userAgents[Random().nextInt(_userAgents.length)],
            "Content-Language": "en_US",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode != 200) {
        if (response.statusCode == 204) {
          onStateChanged(RecognitionState.noMatch);
          return null;
        }
        onError("Error del servidor de reconocimiento: ${response.statusCode}");
        onStateChanged(RecognitionState.error);
        return null;
      }

      final data = response.data;
      if (data == null || data['track'] == null) {
        onStateChanged(RecognitionState.noMatch);
        return null;
      }

      final result = RecognitionResult.fromJson(data);
      onStateChanged(RecognitionState.success);
      return result;
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        onError("Permiso de micrófono denegado.");
      } else {
        onError("Error al grabar audio: ${e.message}");
      }
      onStateChanged(RecognitionState.error);
      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 204) {
        onStateChanged(RecognitionState.noMatch);
      } else {
        onError("Error de conexión: ${e.message}");
        onStateChanged(RecognitionState.error);
      }
      return null;
    } catch (e) {
      onError("Error desconocido: $e");
      onStateChanged(RecognitionState.error);
      return null;
    }
  }

  Future<void> stopRecording() async {
    if (_isRecording) {
      _isRecording = false;
      try {
        await _audioRecorder.stop();
      } catch (_) {}
    }
  }

  String _generateUuid() {
    final random = Random();
    const hexDigits = '0123456789abcdef';
    final uuid = StringBuffer();
    for (var i = 0; i < 36; i++) {
      if (i == 8 || i == 13 || i == 18 || i == 23) {
        uuid.write('-');
      } else if (i == 14) {
        uuid.write('4');
      } else if (i == 19) {
        uuid.write(hexDigits[random.nextInt(4) + 8]);
      } else {
        uuid.write(hexDigits[random.nextInt(16)]);
      }
    }
    return uuid.toString();
  }
}
