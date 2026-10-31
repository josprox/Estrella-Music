import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/models/hm_streaming_data.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/services/music/playback_source_resolver.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlaybackSourceResolver', () {
    test('audioFromPlaybackSource converts PlaybackSource to Audio model with headers and opus codec', () {
      final source = PlaybackSource(
        type: PlaybackSourceType.authorizedStream,
        uri: Uri.parse('https://stream.example.com/audio.opus'),
        mimeType: 'audio/opus',
        bitrate: 160000,
        loudnessDb: -7.5,
        headers: {'Authorization': 'Bearer token123'},
      );

      final audio = PlaybackSourceResolver.audioFromPlaybackSource(source);

      expect(audio.url, 'https://stream.example.com/audio.opus');
      expect(audio.audioCodec, Codec.opus);
      expect(audio.bitrate, 160000);
      expect(audio.loudnessDb, -7.5);
      expect(audio.headers?['Authorization'], 'Bearer token123');
      expect(audio.mimeType, 'audio/opus');
    });

    test('audioFromPlaybackSource converts mp4/m4a PlaybackSource to mp4a Codec', () {
      final source = PlaybackSource(
        type: PlaybackSourceType.authorizedStream,
        uri: Uri.parse('https://stream.example.com/audio.m4a'),
        mimeType: 'audio/mp4',
        bitrate: 256000,
        loudnessDb: -14.0,
      );

      final audio = PlaybackSourceResolver.audioFromPlaybackSource(source);

      expect(audio.url, 'https://stream.example.com/audio.m4a');
      expect(audio.audioCodec, Codec.mp4a);
      expect(audio.bitrate, 256000);
      expect(audio.loudnessDb, -14.0);
    });
  });
}
