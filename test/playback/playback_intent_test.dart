import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/playback_intent.dart';
import 'package:estrella_music/models/playling_from.dart';
import 'package:estrella_music/models/playlist.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlaybackIntent', () {
    test('PlayAlbumIntent constructs with album context and correct PlaylingFrom', () {
      final album = Album(
        title: 'Random Access Memories',
        browseId: 'ALBUM_123',
        artists: const [
          {'name': 'Daft Punk', 'id': 'AR_DAFTPUNK'}
        ],
        thumbnailUrl: 'https://example.com/album.jpg',
      );
      final tracks = [
        const MediaItem(id: 'song_1', title: 'Give Life Back to Music'),
        const MediaItem(id: 'song_2', title: 'Instant Crush'),
      ];

      final intent = PlayAlbumIntent(
        album: album,
        tracks: tracks,
        startIndex: 1,
      );

      expect(intent.album.title, 'Random Access Memories');
      expect(intent.startIndex, 1);
      expect(intent.tracks.length, 2);
      expect(intent.playFrom.type, PlaylingFromType.ALBUM);
      expect(intent.playFrom.name, 'Random Access Memories');
    });

    test('PlayPlaylistIntent constructs with playlist context and correct PlaylingFrom', () {
      final playlist = Playlist(
        title: 'Workout Beats',
        playlistId: 'PL_WORKOUT',
        thumbnailUrl: 'https://example.com/playlist.jpg',
      );
      final tracks = [
        const MediaItem(id: 'song_w1', title: 'High Energy 1'),
      ];

      final intent = PlayPlaylistIntent(
        playlist: playlist,
        tracks: tracks,
        startIndex: 0,
      );

      expect(intent.playlist.title, 'Workout Beats');
      expect(intent.playFrom.type, PlaylingFromType.PLAYLIST);
      expect(intent.playFrom.name, 'Workout Beats');
    });

    test('StartRadioIntent constructs with seed track', () {
      const seed = MediaItem(id: 'seed_1', title: 'Seed Track', artist: 'Artist');
      final intent = StartRadioIntent(seedTrack: seed, playlistId: 'RD_SEED');

      expect(intent.seedTrack.id, 'seed_1');
      expect(intent.playlistId, 'RD_SEED');
      expect(intent.playFrom.type, PlaylingFromType.SELECTION);
      expect(intent.playFrom.name, 'Seed Track');
    });
  });
}
