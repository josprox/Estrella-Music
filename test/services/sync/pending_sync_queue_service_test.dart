import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:harmonymusic/services/sync/pending_sync_queue_service.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory hiveDirectory;
  late PendingSyncQueueService queue;

  setUp(() async {
    hiveDirectory = await Directory.systemTemp.createTemp('emusic-sync-queue-');
    Hive.init(hiveDirectory.path);
    await Hive.openBox(PendingSyncQueueService.boxName);
    queue = PendingSyncQueueService();
    queue.onInit();
  });

  tearDown(() async {
    await Hive.close();
    await hiveDirectory.delete(recursive: true);
  });

  test(
      'acknowledging one push preserves mutations created while it was in flight',
      () async {
    await queue.enqueueSnapshotChange(reason: 'first-like');
    final capturedByFirstPush = queue.capturePendingIds();

    await queue.enqueueSnapshotChange(reason: 'playlist-track-added-later');
    await queue.markSynced(capturedByFirstPush);

    expect(queue.hasPendingChanges, isTrue);
    expect(queue.pendingCount.value, 1);
    expect(queue.capturePendingIds(), isNot(equals(capturedByFirstPush)));
  });

  test('a push only empties the queue when no newer mutation exists', () async {
    await queue.enqueueSnapshotChange(reason: 'favorite-added');

    await queue.markSynced(queue.capturePendingIds());

    expect(queue.hasPendingChanges, isFalse);
    expect(queue.pendingCount.value, 0);
  });
}
