import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/utils/helpers/queue_reorder.dart';

void main() {
  group('reorderQueue', () {
    test('moves song 124 to position 125 and shifts the previous item', () {
      final songs = List<int>.generate(235, (index) => index + 1);

      final result = reorderQueue<int>(
        items: songs,
        oldIndex: 123,
        newIndex: 125,
        currentIndex: 0,
      );

      expect(result.items[123], 125);
      expect(result.items[124], 124);
      expect(result.items, hasLength(235));
      expect(result.items.toSet(), hasLength(235));
    });

    test('keeps the playing item selected when an earlier song moves past it',
        () {
      final result = reorderQueue<String>(
        items: const ['a', 'b', 'playing', 'c', 'd'],
        oldIndex: 0,
        newIndex: 5,
        currentIndex: 2,
      );

      expect(result.items, ['b', 'playing', 'c', 'd', 'a']);
      expect(result.currentIndex, 1);
      expect(result.items[result.currentIndex], 'playing');
    });

    test('tracks the playing item when that item itself is moved', () {
      final result = reorderQueue<String>(
        items: const ['a', 'playing', 'b', 'c'],
        oldIndex: 1,
        newIndex: 4,
        currentIndex: 1,
      );

      expect(result.items, ['a', 'b', 'c', 'playing']);
      expect(result.currentIndex, 3);
    });
  });
}
