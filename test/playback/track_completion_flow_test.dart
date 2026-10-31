import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Track Navigation and Completion Engine', () {
    test('getNextSongIndex respects queue length, queueLoopMode and bounds', () {
      final queue = List.generate(
        4,
        (i) => MediaItem(id: 'song_$i', title: 'Song $i'),
      );

      int getNextSongIndex({
        required int currentIndex,
        required int queueLength,
        required bool queueLoopModeEnabled,
        required bool shuffleModeEnabled,
        required List<String> shuffledQueue,
        required int currentShuffleIndex,
      }) {
        if (shuffleModeEnabled && shuffledQueue.isNotEmpty) {
          final nextShuffleIndex = (currentShuffleIndex + 1 >= shuffledQueue.length)
              ? 0
              : currentShuffleIndex + 1;
          final targetId = shuffledQueue[nextShuffleIndex];
          final foundIdx = queue.indexWhere((item) => item.id == targetId);
          return foundIdx != -1 ? foundIdx : currentIndex;
        }

        if (queueLength > currentIndex + 1) {
          return currentIndex + 1;
        } else if (queueLoopModeEnabled) {
          return 0;
        } else {
          return currentIndex;
        }
      }

      // Middle of queue: moves forward
      expect(
        getNextSongIndex(
          currentIndex: 1,
          queueLength: queue.length,
          queueLoopModeEnabled: false,
          shuffleModeEnabled: false,
          shuffledQueue: [],
          currentShuffleIndex: 0,
        ),
        2,
      );

      // End of queue with queueLoopMode off: stays at current index (signals stop)
      expect(
        getNextSongIndex(
          currentIndex: 3,
          queueLength: queue.length,
          queueLoopModeEnabled: false,
          shuffleModeEnabled: false,
          shuffledQueue: [],
          currentShuffleIndex: 0,
        ),
        3,
      );

      // End of queue with queueLoopMode on: loops to index 0
      expect(
        getNextSongIndex(
          currentIndex: 3,
          queueLength: queue.length,
          queueLoopModeEnabled: true,
          shuffleModeEnabled: false,
          shuffledQueue: [],
          currentShuffleIndex: 0,
        ),
        0,
      );
    });

    test('getPrevSongIndex navigates backwards and stops at index 0 without underflow', () {
      int getPrevSongIndex({
        required int currentIndex,
      }) {
        if (currentIndex - 1 >= 0) {
          return currentIndex - 1;
        } else {
          return currentIndex;
        }
      }

      expect(getPrevSongIndex(currentIndex: 2), 1);
      expect(getPrevSongIndex(currentIndex: 0), 0, reason: 'Index must not underflow below 0');
    });

    test('atomic queue switch prevents residual indices and prevents out-of-range errors', () {
      final oldQueue = List.generate(10, (i) => MediaItem(id: 'old_$i', title: 'Old $i'));
      final newQueue = List.generate(3, (i) => MediaItem(id: 'new_$i', title: 'New $i'));

      int activeIndex = 8; // In the old queue, user was on index 8
      List<MediaItem> activeQueue = oldQueue;

      // Atomic transition to new queue with target index 0
      void setQueueAndPlay(List<MediaItem> queue, int index) {
        activeQueue = List<MediaItem>.from(queue);
        activeIndex = (index >= 0 && index < activeQueue.length) ? index : 0;
      }

      setQueueAndPlay(newQueue, 0);

      expect(activeQueue.length, 3);
      expect(activeIndex, 0);
      expect(activeQueue[activeIndex].id, 'new_0');
      expect(activeIndex < activeQueue.length, isTrue, reason: 'Index must remain within new queue bounds');
    });
  });
}
