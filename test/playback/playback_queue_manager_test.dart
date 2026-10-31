import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/models/playling_from.dart';
import 'package:estrella_music/services/music/playback_queue_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlaybackQueueManager', () {
    test('loadQueue initializes queue items, clamps startIndex and tracks context', () {
      final manager = PlaybackQueueManager();
      final tracks = List.generate(
        5,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );

      manager.loadQueue(
        tracks,
        startIndex: 2,
        playFrom: PlaylingFrom(name: 'My Playlist', type: PlaylingFromType.PLAYLIST),
        isRadio: false,
      );

      expect(manager.length, 5);
      expect(manager.currentIndex, 2);
      expect(manager.currentTrack?.id, 'song_2');
      expect(manager.playingFrom?.name, 'My Playlist');
      expect(manager.isRadioMode, isFalse);
    });

    test('getNextIndex advances sequentially and stops at end of queue when loop is disabled', () {
      final tracks = List.generate(
        3,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );
      final manager = PlaybackQueueManager(initialQueue: tracks, initialIndex: 0);

      expect(manager.getNextIndex(), 1);
      manager.seekToIndex(1);
      expect(manager.getNextIndex(), 2);
      manager.seekToIndex(2);
      expect(manager.getNextIndex(), isNull, reason: 'End of queue with queueLoop off must return null');

      // With queueLoop enabled, wraps back to 0
      manager.setQueueLoopMode(true);
      expect(manager.getNextIndex(), 0);
    });

    test('getPreviousIndex navigates backward and stops at 0 without underflow', () {
      final tracks = List.generate(
        3,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );
      final manager = PlaybackQueueManager(initialQueue: tracks, initialIndex: 2);

      expect(manager.getPreviousIndex(), 1);
      manager.seekToIndex(1);
      expect(manager.getPreviousIndex(), 0);
      manager.seekToIndex(0);
      expect(manager.getPreviousIndex(), 0, reason: 'At index 0, previous index stays at 0');
    });

    test('insertPlayNext places song immediately after current playing song', () {
      final tracks = List.generate(
        3,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );
      final manager = PlaybackQueueManager(initialQueue: tracks, initialIndex: 1);

      const nextSong = MediaItem(id: 'song_next', title: 'Play Next Song');
      manager.insertPlayNext(nextSong);

      expect(manager.length, 4);
      expect(manager.items[2].id, 'song_next');
      expect(manager.currentIndex, 1);
      expect(manager.currentTrack?.id, 'song_1');
    });

    test('shuffle mode creates safe shuffled sequence keeping current track first', () {
      final tracks = List.generate(
        10,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );
      final manager = PlaybackQueueManager(
        initialQueue: tracks,
        initialIndex: 4,
        shuffleModeEnabled: true,
      );

      expect(manager.shuffledQueue.length, 10);
      expect(manager.shuffledQueue.first, 'song_4',
          reason: 'Active track must remain at the front of the shuffled queue');
      expect(manager.currentShuffleIndex, 0);

      // Advance in shuffle mode
      final nextIdx = manager.getNextIndex();
      expect(nextIdx, isNotNull);
      expect(nextIdx != 4, isTrue);
    });

    test('seekToIndex synchronizes shuffle pointer with selected track', () {
      final tracks = List.generate(
        5,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );
      final manager = PlaybackQueueManager(
        initialQueue: tracks,
        initialIndex: 0,
        shuffleModeEnabled: true,
      );

      // Seek to song 3
      manager.seekToIndex(3);
      expect(manager.currentIndex, 3);
      expect(manager.currentTrack?.id, 'song_3');
      expect(manager.shuffledQueue[manager.currentShuffleIndex], 'song_3',
          reason: 'Shuffle index must align with the seeked track');
    });

    test('removeAt safely cleans up queue and preserves index bounds', () {
      final tracks = List.generate(
        3,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );
      final manager = PlaybackQueueManager(initialQueue: tracks, initialIndex: 2);

      // Remove last track
      final removed = manager.removeAt(2);
      expect(removed?.id, 'song_2');
      expect(manager.length, 2);
      expect(manager.currentIndex, 1, reason: 'Active index shifts down when removing active last item');
    });
  });
}
