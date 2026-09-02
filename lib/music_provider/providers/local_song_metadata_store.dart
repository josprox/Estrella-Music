import 'package:estrella_music/services/storage/sqlite_store.dart';

abstract interface class LocalSongMetadataStore {
  Future<void> initialize(String profileId);

  Future<Map<String, dynamic>?> read(String sourceId);

  Future<void> write(String sourceId, Map<String, dynamic> metadata);
}

/// Profile-scoped metadata overrides for local songs.
///
/// [SqliteStore] is the provider-aware storage facade. For a local profile its
/// backend is Hive, so these records never enter eMusic SQLite or sync.
class HiveLocalSongMetadataStore implements LocalSongMetadataStore {
  static const boxName = 'LocalSongMetadata';

  final Map<String, Map<String, dynamic>> _testFallback = {};
  SqliteBox<dynamic>? _box;

  @override
  Future<void> initialize(String profileId) async {
    if (!SqliteStore.isInitialized) return;
    final box = await SqliteStore.openBox<dynamic>(boxName);
    if (box.backend != MusicStoreBackend.hive) {
      throw StateError('Local song metadata must be stored in Hive');
    }
    _box = box;
  }

  @override
  Future<Map<String, dynamic>?> read(String sourceId) async {
    final value = _box?.get(sourceId) ?? _testFallback[sourceId];
    if (value is! Map) return null;
    return value.map((key, value) => MapEntry(key.toString(), value));
  }

  @override
  Future<void> write(
    String sourceId,
    Map<String, dynamic> metadata,
  ) async {
    final record = Map<String, dynamic>.from(metadata);
    final box = _box;
    if (box == null) {
      _testFallback[sourceId] = record;
      return;
    }
    await box.put(sourceId, record);
  }
}
