import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PendingSyncQueueService extends GetxService {
  static const boxName = 'PendingSyncChanges';

  final pendingCount = 0.obs;

  Box get _box => Hive.box(boxName);

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

  Future<void> markAllSynced() async {
    await _box.clear();
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
