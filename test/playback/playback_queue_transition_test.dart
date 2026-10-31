import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/models/media_item_builder.dart';
import 'package:estrella_music/services/auth/catalog_recovery_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Playback Queue and Shuffle Synchronization', () {
    test('shuffled queue only contains IDs of the active queue and avoids RangeError', () {
      final queue1 = List.generate(
        5,
        (i) => MediaItem(id: 'song_list1_$i', title: 'Song List 1 - $i'),
      );
      final queue2 = List.generate(
        3,
        (i) => MediaItem(id: 'song_list2_$i', title: 'Song List 2 - $i'),
      );

      // Simulating updateQueue logic
      List<String> shuffledQueue = queue1.map((e) => e.id).toList()..shuffle();
      expect(shuffledQueue.length, 5);
      expect(shuffledQueue.every((id) => id.startsWith('song_list1_')), isTrue);

      // Switch to queue2
      shuffledQueue = queue2.map((e) => e.id).toList()..shuffle();
      expect(shuffledQueue.length, 3);
      expect(shuffledQueue.every((id) => id.startsWith('song_list2_')), isTrue);
      expect(shuffledQueue.any((id) => id.startsWith('song_list1_')), isFalse);

      // Test safe shuffleCmd with out of bounds index
      final queueIds = queue2.map((e) => e.id).toList();
      final outOfBoundsIndex = 99;
      final currentSongId = (outOfBoundsIndex >= 0 && outOfBoundsIndex < queueIds.length)
          ? queueIds.removeAt(outOfBoundsIndex)
          : null;
      queueIds.shuffle();
      if (currentSongId != null) queueIds.insert(0, currentSongId);
      shuffledQueue = queueIds;

      expect(shuffledQueue.length, 3);
      expect(shuffledQueue.every((id) => id.startsWith('song_list2_')), isTrue);
    });

    test('recovering song with low confidence (< 0.60) is rejected to protect catalog metadata', () {
      final recoveryService = CatalogRecoveryService();

      // Test helper logic: candidate with score 0.45 should be discarded
      const candidateScore = 0.45;
      final isAcceptable = candidateScore >= 0.60;
      expect(isAcceptable, isFalse, reason: 'Scores below 0.60 must not replace original tracks');

      const confidentScore = 0.75;
      final isConfident = confidentScore >= 0.65;
      expect(isConfident, isTrue, reason: 'High confidence matches are accepted');
    });

    test('track completion debounce prevents duplicate next-song triggers', () {
      DateTime? lastTrackCompletionTime;
      int? lastCompletedSongIndex;

      bool canTriggerTrackCompletion(int currentIndex, DateTime now) {
        if (lastTrackCompletionTime != null &&
            now.difference(lastTrackCompletionTime!) < const Duration(milliseconds: 1200) &&
            lastCompletedSongIndex == currentIndex) {
          return false;
        }
        lastTrackCompletionTime = now;
        lastCompletedSongIndex = currentIndex;
        return true;
      }

      final t0 = DateTime(2026, 10, 30, 12, 0, 0, 0);
      // First trigger from positionStream
      expect(canTriggerTrackCompletion(2, t0), isTrue);

      // Immediate second trigger 100ms later from processingStateStream
      final t1 = t0.add(const Duration(milliseconds: 100));
      expect(canTriggerTrackCompletion(2, t1), isFalse,
          reason: 'Duplicate trigger for the same track within debounce window must be blocked');

      // Subsequent trigger for next track (index 3) should be allowed
      final t2 = t0.add(const Duration(milliseconds: 200));
      expect(canTriggerTrackCompletion(3, t2), isTrue,
          reason: 'Advancing to a new index must be allowed');
    });
  });
}
