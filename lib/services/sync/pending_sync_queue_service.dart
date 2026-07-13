import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

class PendingSyncQueueService extends GetxService {
  static const boxName = 'PendingSyncChanges';

  final pendingCount = 0.obs;

  SqliteBox get _box => SqliteStore.box(boxName);

  @override
  void onInit() {
    super.onInit();
    refreshCount();
  }

  Future<void> enqueueSnapshotChange({
    required String reason,
    String entityType = 'library_snapshot',
  }) async {
    final key = 'change-${DateTime.now().microsecondsSinceEpoch}';
    await _box.put(key, {
      'id': key,
      'entityType': entityType,
      'operation': 'snapshot_required',
      'reason': reason,
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
    });
    refreshCount();
  }

  /// Returns the durable queue entries that may be acknowledged by one push.
  /// Entries created after this snapshot must survive that push.
  List<String> capturePendingIds() =>
      _box.keys.map((key) => key.toString()).toList(growable: false);

  bool get hasPendingChanges => _box.isNotEmpty;

  Future<void> markSynced(Iterable<String> ids) async {
    await _box.deleteAll(ids);
    refreshCount();
  }

  Future<void> markRetryScheduled() async {
    for (final key in _box.keys) {
      final raw = _box.get(key);
      if (raw is Map) {
        await _box.put(key, {
          ...raw.map((k, v) => MapEntry(k.toString(), v)),
          'status': 'pending_retry',
          'lastAttemptAt': DateTime.now().toIso8601String(),
        });
      }
    }
    refreshCount();
  }

  void refreshCount() {
    pendingCount.value = _box.length;
  }
}
