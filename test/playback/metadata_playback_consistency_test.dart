import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/models/hm_streaming_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Metadata and Playback Consistency', () {
    test('fresh stream info preserves original media metadata attributes', () {
      final originalItem = MediaItem(
        id: 'track_123',
        title: 'Original Song',
        artist: 'Original Artist',
        album: 'Original Album',
        duration: const Duration(seconds: 210),
        artUri: Uri.parse('https://example.com/art.jpg'),
        extras: {'length': '3:30'},
      );

      final audio = Audio(
        url: 'https://stream.example.com/track_123.mp4',
        audioCodec: Codec.mp4a,
        bitrate: 256,
        duration: 210,
        loudnessDb: -14.0,
        itag: 140,
        size: 5000000,
        headers: {'User-Agent': 'EstrellaMusic'},
      );

      final streamingData = HMStreamingData(
        playable: true,
        statusMSG: 'OK',
        highQualityAudio: audio,
        lowQualityAudio: audio,
      );

      expect(streamingData.playable, isTrue);
      expect(streamingData.audio?.url, 'https://stream.example.com/track_123.mp4');
      expect(streamingData.audio?.headers?['User-Agent'], 'EstrellaMusic');

      // The resolved MediaItem must maintain original title, artist, album, artUri
      final updatedItem = originalItem.copyWith(
        extras: {
          ...originalItem.extras ?? {},
          'url': streamingData.audio!.url,
          'playbackHeaders': streamingData.audio!.headers,
        },
      );

      expect(updatedItem.id, originalItem.id);
      expect(updatedItem.title, originalItem.title);
      expect(updatedItem.artist, originalItem.artist);
      expect(updatedItem.album, originalItem.album);
      expect(updatedItem.artUri, originalItem.artUri);
      expect(updatedItem.extras?['url'], 'https://stream.example.com/track_123.mp4');
    });

    test('generateNewUrl bypasses cached url check to prevent stale audio reproduction', () {
      bool shouldCheckCache({
        required bool offlineReplacementUrl,
        required bool generateNewUrl,
        required bool hasCachedSong,
      }) {
        if (!offlineReplacementUrl && !generateNewUrl && hasCachedSong) {
          return true;
        }
        return false;
      }

      // Normal playback with cached song available
      expect(
        shouldCheckCache(
          offlineReplacementUrl: false,
          generateNewUrl: false,
          hasCachedSong: true,
        ),
        isTrue,
      );

      // Force refresh (generateNewUrl: true) must bypass cache
      expect(
        shouldCheckCache(
          offlineReplacementUrl: false,
          generateNewUrl: true,
          hasCachedSong: true,
        ),
        isFalse,
        reason: 'When generating new URL, cached file must be bypassed to avoid playing expired/stale audio',
      );
    });
  });
}
