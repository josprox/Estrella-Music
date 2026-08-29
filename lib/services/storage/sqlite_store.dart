import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart' as hive;
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

enum MusicStoreBackend { hive, sqlite }

/// Provider-aware key/value facade.
///
/// Local profiles and global application state are persisted in Hive. SQLite
/// is reserved for eMusic profile state and its synchronization pipeline. The
/// legacy class name is intentionally kept while consumers migrate so widgets
/// remain storage-agnostic.
class SqliteStore {
  static const databaseFileName = 'estrella_local.sqlite3';
  static const _legacyMigrationKey = 'legacy_hive_to_sqlite_v1';

  static Database? _database;
  static String? _directoryPath;
  static final Map<String, SqliteBox<dynamic>> _boxes = {};
  static String Function(String logicalName)? boxNameResolver;
  static MusicStoreBackend Function(String logicalName)? boxBackendResolver;

  static Database get database {
    final value = _database;
    if (value == null) {
      throw const SqliteStoreException('Store is not initialized');
    }
    return value;
  }

  static bool get isInitialized => _database != null;

  static String get databasePath {
    final directory = _directoryPath;
    if (directory == null) {
      throw const SqliteStoreException('Store is not initialized');
    }
    return p.join(directory, databaseFileName);
  }

  static Future<void> initFlutter(String directoryPath) async {
    await initialize(directoryPath);
  }

  static Future<void> initialize(
    String directoryPath, {
    bool migrateLegacyHive = false,
    bool deleteLegacyAfterVerification = false,
  }) async {
    if (_database != null) return;
    final directory = Directory(directoryPath);
    await directory.create(recursive: true);
    _directoryPath = directory.path;
    hive.Hive.init(directory.path);
    _database = sqlite3.open(p.join(directory.path, databaseFileName));
    _configure();
    _createSchema();
    if (migrateLegacyHive) {
      await _migrateLegacyHive(
        deleteAfterVerification: deleteLegacyAfterVerification,
      );
    }
  }

  static void _configure() {
    database.execute('PRAGMA journal_mode = WAL');
    database.execute('PRAGMA synchronous = NORMAL');
    database.execute('PRAGMA busy_timeout = 5000');
  }

  static void _createSchema() {
    database.execute('''
      CREATE TABLE IF NOT EXISTS local_store_entries (
        box_name TEXT NOT NULL,
        key_type TEXT NOT NULL,
        key_value TEXT NOT NULL,
        value_json TEXT NOT NULL,
        sequence INTEGER NOT NULL,
        updated_at TEXT NOT NULL,
        PRIMARY KEY (box_name, key_type, key_value)
      )
    ''');
    database.execute('''
      CREATE INDEX IF NOT EXISTS idx_local_store_sequence
      ON local_store_entries(box_name, sequence)
    ''');
    database.execute('''
      CREATE TABLE IF NOT EXISTS local_store_metadata (
        metadata_key TEXT PRIMARY KEY,
        metadata_value TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  static Future<SqliteBox<T>> openBox<T>(String name) async {
    final resolved = _resolved(name);
    if (resolved.backend == MusicStoreBackend.hive &&
        !hive.Hive.isBoxOpen(resolved.name)) {
      await hive.Hive.openBox<dynamic>(resolved.name);
    }
    return _box<T>(resolved);
  }

  static SqliteBox<T> box<T>(String name) {
    final resolved = _resolved(name);
    if (resolved.backend == MusicStoreBackend.hive &&
        !hive.Hive.isBoxOpen(resolved.name)) {
      throw SqliteStoreException(
        'Hive box ${resolved.name} must be opened before synchronous access',
      );
    }
    return _box<T>(resolved);
  }

  static SqliteBox<T> _box<T>(_ResolvedBox resolved) {
    final cacheKey = '${resolved.backend.name}::${resolved.name}';
    final existing = _boxes[cacheKey];
    if (existing != null) return existing as SqliteBox<T>;
    final created = SqliteBox<T>._(
      resolved.name,
      resolved.backend,
      resolved.backend == MusicStoreBackend.hive
          ? hive.Hive.box<dynamic>(resolved.name)
          : null,
    );
    _boxes[cacheKey] = created;
    return created;
  }

  static bool isBoxOpen(String name) {
    final resolved = _resolved(name);
    return _boxes.containsKey('${resolved.backend.name}::${resolved.name}') ||
        (resolved.backend == MusicStoreBackend.hive &&
            hive.Hive.isBoxOpen(resolved.name));
  }

  static void checkpoint() {
    database.execute('PRAGMA wal_checkpoint(TRUNCATE)');
  }

  static Future<void> deleteBoxFromDisk(String name) async {
    await box(name).deleteFromDisk();
  }

  /// Copies a SQLite box into Hive only when the Hive destination is empty.
  /// The SQLite source is intentionally retained as a recovery copy.
  static Future<int> copySqliteBoxToHive({
    required String sourcePhysicalName,
    required String targetPhysicalName,
  }) async {
    final source = sourcePhysicalName.trim().toLowerCase();
    final target = targetPhysicalName.trim().toLowerCase();
    final hiveBox = hive.Hive.isBoxOpen(target)
        ? hive.Hive.box<dynamic>(target)
        : await hive.Hive.openBox<dynamic>(target);
    if (hiveBox.isNotEmpty) return 0;
    final rows = database.select(
      '''SELECT key_type, key_value, value_json
         FROM local_store_entries WHERE box_name = ? ORDER BY sequence ASC''',
      [source],
    );
    if (rows.isEmpty) return 0;
    final values = <dynamic, dynamic>{};
    for (final row in rows) {
      values[_EncodedKey.decode(
        row['key_type'] as String,
        row['key_value'] as String,
      )] = _ValueCodec.decode(row['value_json']);
    }
    await hiveBox.putAll(values);
    return values.length;
  }

  /// Preserves an existing SQLite local profile by copying every namespaced
  /// box to Hive. No source rows or files are removed.
  static Future<int> preserveLocalProfileInHive(String profileId) async {
    final safeProfile =
        profileId.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_.-]'), '_');
    final prefix = 'profiles__${safeProfile}__';
    final names = database
        .select(
          '''SELECT DISTINCT box_name FROM local_store_entries
             WHERE box_name LIKE ? ORDER BY box_name''',
          ['$prefix%'],
        )
        .map((row) => row['box_name'] as String)
        .toSet();

    const legacyLocalBoxes = {
      'songscache',
      'songdownloads',
      'songsurlcache',
      'libfav',
      'librp',
      'libraryartists',
      'libraryalbums',
      'libraryplaylists',
      'homescreendata',
      'prevsessiondata',
      'pendingsyncchanges',
    };
    var copied = 0;
    if (profileId == 'local-default') {
      for (final legacyName in legacyLocalBoxes) {
        copied += await copySqliteBoxToHive(
          sourcePhysicalName: legacyName,
          targetPhysicalName: '$prefix$legacyName',
        );
      }
    }
    for (final name in names) {
      copied += await copySqliteBoxToHive(
        sourcePhysicalName: name,
        targetPhysicalName: name,
      );
    }
    return copied;
  }

  static Future<void> close() async {
    for (final value in _boxes.values) {
      await value._dispose();
    }
    _boxes.clear();
    await hive.Hive.close();
    _database?.dispose();
    _database = null;
  }

  static _ResolvedBox _resolved(String logicalName) => _ResolvedBox(
        (boxNameResolver?.call(logicalName) ?? logicalName)
            .trim()
            .toLowerCase(),
        boxBackendResolver?.call(logicalName) ?? MusicStoreBackend.sqlite,
      );

  static String _normalizeBoxName(String name) => _resolved(name).name;

  static Future<void> _migrateLegacyHive({
    required bool deleteAfterVerification,
  }) async {
    final completed = database.select(
      'SELECT metadata_value FROM local_store_metadata WHERE metadata_key = ?',
      [_legacyMigrationKey],
    );
    if (completed.isNotEmpty) return;

    final directory = Directory(_directoryPath!);
    final hiveFiles = await directory
        .list(recursive: false)
        .where((entity) => entity is File && entity.path.endsWith('.hive'))
        .cast<File>()
        .toList();
    if (hiveFiles.isEmpty) {
      _writeMetadata(
          _legacyMigrationKey,
          jsonEncode({
            'status': 'complete',
            'boxes': 0,
            'entries': 0,
            'checksum': 0,
          }));
      return;
    }

    final backup = await _archiveLegacyFiles(hiveFiles);
    final snapshots = <String, List<MapEntry<dynamic, dynamic>>>{};
    hive.Hive.init(directory.path);
    try {
      for (final file in hiveFiles) {
        final name = p.basenameWithoutExtension(file.path);
        final legacyBox = await hive.Hive.openBox<dynamic>(name);
        snapshots[_normalizeBoxName(name)] = [
          for (final key in legacyBox.keys)
            MapEntry<dynamic, dynamic>(key, legacyBox.get(key)),
        ];
      }
    } catch (error) {
      throw SqliteStoreException(
        'Legacy Hive migration could not read every box. Backup: ${backup.path}',
        error,
      );
    } finally {
      await hive.Hive.close();
    }

    var expectedEntries = 0;
    var expectedChecksum = 0;
    database.execute('BEGIN IMMEDIATE');
    try {
      for (final snapshot in snapshots.entries) {
        var sequence = 0;
        for (final entry in snapshot.value) {
          final encodedKey = _EncodedKey.from(entry.key);
          final encodedValue = _ValueCodec.encode(entry.value);
          database.execute(
            '''INSERT OR REPLACE INTO local_store_entries
               (box_name, key_type, key_value, value_json, sequence, updated_at)
               VALUES (?, ?, ?, ?, ?, ?)''',
            [
              snapshot.key,
              encodedKey.type,
              encodedKey.value,
              encodedValue,
              sequence++,
              DateTime.now().toUtc().toIso8601String(),
            ],
          );
          expectedEntries++;
          expectedChecksum = _checksumPart(
            expectedChecksum,
            '${snapshot.key}|${encodedKey.type}|${encodedKey.value}|$encodedValue',
          );
        }
      }

      final verification = _legacyVerification(snapshots.keys);
      if (verification.$1 != expectedEntries ||
          verification.$2 != expectedChecksum) {
        throw SqliteStoreException(
          'Legacy migration verification failed: '
          '${verification.$1}/$expectedEntries entries, '
          '${verification.$2}/$expectedChecksum checksum',
        );
      }
      _writeMetadata(
          _legacyMigrationKey,
          jsonEncode({
            'status': 'complete',
            'boxes': snapshots.length,
            'entries': expectedEntries,
            'checksum': expectedChecksum,
            'backup_path': backup.path,
          }));
      database.execute('COMMIT');
    } catch (_) {
      database.execute('ROLLBACK');
      rethrow;
    }

    if (deleteAfterVerification) {
      for (final file in hiveFiles) {
        await file.delete();
        final lock = File(p.setExtension(file.path, '.lock'));
        if (await lock.exists()) await lock.delete();
      }
    }
  }

  static (int, int) _legacyVerification(Iterable<String> boxNames) {
    var count = 0;
    var checksum = 0;
    for (final boxName in boxNames) {
      final rows = database.select(
        '''SELECT key_type, key_value, value_json FROM local_store_entries
           WHERE box_name = ? ORDER BY sequence ASC''',
        [boxName],
      );
      for (final row in rows) {
        count++;
        checksum = _checksumPart(
          checksum,
          '$boxName|${row['key_type']}|${row['key_value']}|${row['value_json']}',
        );
      }
    }
    return (count, checksum);
  }

  static int _checksumPart(int current, String value) {
    var hash = current == 0 ? 0x811c9dc5 : current;
    for (final byte in utf8.encode(value)) {
      hash ^= byte;
      hash = (hash * 0x01000193) & 0x7fffffff;
    }
    return hash;
  }

  static Future<File> _archiveLegacyFiles(List<File> files) async {
    final backupDirectory = Directory(
      p.join(_directoryPath!, 'legacy_hive_backups'),
    );
    await backupDirectory.create(recursive: true);
    final backup = File(p.join(
      backupDirectory.path,
      'hive_${DateTime.now().millisecondsSinceEpoch}.zip',
    ));
    final encoder = ZipFileEncoder();
    encoder.create(backup.path);
    for (final file in files) {
      encoder.addFile(file, p.basename(file.path));
    }
    encoder.close();
    final decoded = ZipDecoder().decodeBytes(await backup.readAsBytes());
    if (decoded.length != files.length) {
      throw const SqliteStoreException(
        'Legacy backup verification failed: file count mismatch',
      );
    }
    for (final source in files) {
      final expectedName = p.basename(source.path);
      final expectedLength = await source.length();
      final archived = decoded.files
          .where((entry) => entry.name == expectedName)
          .firstOrNull;
      if (archived == null || archived.size != expectedLength) {
        throw SqliteStoreException(
          'Legacy backup verification failed for $expectedName',
        );
      }
    }
    return backup;
  }

  static void _writeMetadata(String key, String value) {
    database.execute(
      '''INSERT INTO local_store_metadata(metadata_key, metadata_value, updated_at)
         VALUES (?, ?, ?)
         ON CONFLICT(metadata_key) DO UPDATE SET
           metadata_value = excluded.metadata_value,
           updated_at = excluded.updated_at''',
      [key, value, DateTime.now().toUtc().toIso8601String()],
    );
  }
}

class _ResolvedBox {
  const _ResolvedBox(this.name, this.backend);

  final String name;
  final MusicStoreBackend backend;
}

class SqliteBox<T> extends ChangeNotifier
    implements ValueListenable<SqliteBox<T>> {
  SqliteBox._(this.name, this.backend, this._hiveBox) {
    if (_hiveBox != null) {
      _hiveSubscription = _hiveBox!.watch().listen((event) {
        final value = event.deleted ? null : event.value;
        _changed(SqliteBoxEvent(event.key, value, event.deleted), emit: false);
      });
    }
  }

  final String name;
  final MusicStoreBackend backend;
  final hive.Box<dynamic>? _hiveBox;
  StreamSubscription<hive.BoxEvent>? _hiveSubscription;
  final StreamController<SqliteBoxEvent> _events =
      StreamController<SqliteBoxEvent>.broadcast();

  Database get _db => SqliteStore.database;

  @override
  SqliteBox<T> get value => this;

  bool get isOpen => true;
  bool get isEmpty => length == 0;
  bool get isNotEmpty => length != 0;

  int get length =>
      _hiveBox?.length ??
      (_db.select(
        'SELECT COUNT(*) AS total FROM local_store_entries WHERE box_name = ?',
        [name],
      ).first['total'] as int);

  Iterable<dynamic> get keys =>
      _hiveBox?.keys ?? _rows().map(_decodeRowKey).toList();
  Iterable<T> get values => _hiveBox != null
      ? _hiveBox!.values.cast<T>()
      : _rows()
          .map((row) => _ValueCodec.decode(row['value_json']) as T)
          .toList();

  T? get(dynamic key, {T? defaultValue}) {
    if (_hiveBox != null) {
      return _hiveBox!.get(key, defaultValue: defaultValue) as T?;
    }
    final encoded = _EncodedKey.from(key);
    final rows = _db.select(
      '''SELECT value_json FROM local_store_entries
         WHERE box_name = ? AND key_type = ? AND key_value = ?''',
      [name, encoded.type, encoded.value],
    );
    if (rows.isEmpty) return defaultValue;
    return _ValueCodec.decode(rows.first['value_json']) as T?;
  }

  T? getAt(int index) {
    if (_hiveBox != null) return _hiveBox!.getAt(index) as T?;
    final rows = _rows();
    if (index < 0 || index >= rows.length) return null;
    return _ValueCodec.decode(rows[index]['value_json']) as T?;
  }

  bool containsKey(dynamic key) {
    if (_hiveBox != null) return _hiveBox!.containsKey(key);
    final encoded = _EncodedKey.from(key);
    return _db.select(
      '''SELECT 1 FROM local_store_entries
         WHERE box_name = ? AND key_type = ? AND key_value = ? LIMIT 1''',
      [name, encoded.type, encoded.value],
    ).isNotEmpty;
  }

  Future<void> put(dynamic key, T value) async {
    if (_hiveBox != null) {
      await _hiveBox!.put(key, value);
      return;
    }
    final encoded = _EncodedKey.from(key);
    final current = _db.select(
      '''SELECT sequence FROM local_store_entries
         WHERE box_name = ? AND key_type = ? AND key_value = ?''',
      [name, encoded.type, encoded.value],
    );
    final sequence = current.isEmpty
        ? (_db.select('''SELECT COALESCE(MAX(sequence), -1) + 1 AS next_sequence
                   FROM local_store_entries WHERE box_name = ?''',
            [name]).first['next_sequence'] as int)
        : current.first['sequence'] as int;
    _db.execute(
      '''INSERT INTO local_store_entries
         (box_name, key_type, key_value, value_json, sequence, updated_at)
         VALUES (?, ?, ?, ?, ?, ?)
         ON CONFLICT(box_name, key_type, key_value) DO UPDATE SET
           value_json = excluded.value_json,
           updated_at = excluded.updated_at''',
      [
        name,
        encoded.type,
        encoded.value,
        _ValueCodec.encode(value),
        sequence,
        DateTime.now().toUtc().toIso8601String(),
      ],
    );
    _changed(SqliteBoxEvent(key, value, false));
  }

  Future<void> putAll(Map<dynamic, T> entries) async {
    if (_hiveBox != null) {
      await _hiveBox!.putAll(entries);
      return;
    }
    _db.execute('BEGIN IMMEDIATE');
    try {
      for (final entry in entries.entries) {
        await put(entry.key, entry.value);
      }
      _db.execute('COMMIT');
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  Future<int> add(T value) async {
    if (_hiveBox != null) return _hiveBox!.add(value);
    final rows = _db.select(
      '''SELECT key_value FROM local_store_entries
         WHERE box_name = ? AND key_type = 'int'
         ORDER BY CAST(key_value AS INTEGER) DESC LIMIT 1''',
      [name],
    );
    final key = rows.isEmpty ? 0 : int.parse(rows.first['key_value']) + 1;
    await put(key, value);
    return key;
  }

  Future<void> delete(dynamic key) async {
    if (_hiveBox != null) {
      await _hiveBox!.delete(key);
      return;
    }
    final previous = get(key);
    final encoded = _EncodedKey.from(key);
    _db.execute(
      '''DELETE FROM local_store_entries
         WHERE box_name = ? AND key_type = ? AND key_value = ?''',
      [name, encoded.type, encoded.value],
    );
    if (previous != null) _changed(SqliteBoxEvent(key, null, true));
  }

  Future<void> deleteAt(int index) async {
    if (_hiveBox != null) {
      await _hiveBox!.deleteAt(index);
      return;
    }
    final rows = _rows();
    if (index < 0 || index >= rows.length) return;
    await delete(_decodeRowKey(rows[index]));
  }

  Future<void> deleteAll(Iterable<dynamic> keys) async {
    if (_hiveBox != null) {
      await _hiveBox!.deleteAll(keys);
      return;
    }
    for (final key in keys.toList()) {
      await delete(key);
    }
  }

  Future<int> clear() async {
    if (_hiveBox != null) return _hiveBox!.clear();
    final oldLength = length;
    if (oldLength == 0) return 0;
    _db.execute('DELETE FROM local_store_entries WHERE box_name = ?', [name]);
    _changed(const SqliteBoxEvent(null, null, true));
    return oldLength;
  }

  Future<void> deleteFromDisk() async {
    await clear();
  }

  Future<void> close() async {}

  Stream<SqliteBoxEvent> watch({dynamic key}) => key == null
      ? _events.stream
      : _events.stream.where((event) => event.key == key);

  ValueListenable<SqliteBox<T>> listenable({List<dynamic>? keys}) => this;

  List<Row> _rows() => _db.select(
        '''SELECT key_type, key_value, value_json FROM local_store_entries
           WHERE box_name = ? ORDER BY sequence ASC''',
        [name],
      );

  dynamic _decodeRowKey(Row row) =>
      _EncodedKey.decode(row['key_type'] as String, row['key_value'] as String);

  void _changed(SqliteBoxEvent event, {bool emit = true}) {
    if (emit && !_events.isClosed) _events.add(event);
    if (!emit && !_events.isClosed) _events.add(event);
    notifyListeners();
  }

  Future<void> _dispose() async {
    await _hiveSubscription?.cancel();
    await _events.close();
    dispose();
  }
}

class SqliteBoxEvent {
  const SqliteBoxEvent(this.key, this.value, this.deleted);

  final dynamic key;
  final dynamic value;
  final bool deleted;
}

class SqliteStoreException implements Exception {
  const SqliteStoreException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => cause == null ? message : '$message: $cause';
}

class _EncodedKey {
  const _EncodedKey(this.type, this.value);

  factory _EncodedKey.from(dynamic key) {
    if (key is int) return _EncodedKey('int', key.toString());
    if (key is String) return _EncodedKey('string', key);
    if (key is double) return _EncodedKey('double', key.toString());
    if (key is bool) return _EncodedKey('bool', key ? '1' : '0');
    throw SqliteStoreException(
        'Unsupported local-store key: ${key.runtimeType}');
  }

  final String type;
  final String value;

  static dynamic decode(String type, String value) => switch (type) {
        'int' => int.parse(value),
        'double' => double.parse(value),
        'bool' => value == '1',
        _ => value,
      };
}

class _ValueCodec {
  static String encode(dynamic value) => jsonEncode(_encodeNode(value));

  static dynamic decode(dynamic raw) =>
      _decodeNode(jsonDecode(raw?.toString() ?? 'null'));

  static dynamic _encodeNode(dynamic value) {
    if (value == null || value is String || value is num || value is bool) {
      return value;
    }
    if (value is Uint8List) {
      return {'__em_type': 'bytes', 'value': base64Encode(value)};
    }
    if (value is DateTime) {
      return {'__em_type': 'datetime', 'value': value.toIso8601String()};
    }
    if (value is Map) {
      return {
        '__em_type': 'map',
        'entries': [
          for (final entry in value.entries)
            [_encodeNode(entry.key), _encodeNode(entry.value)],
        ],
      };
    }
    if (value is Iterable) {
      return {
        '__em_type': 'list',
        'items': value.map(_encodeNode).toList(),
      };
    }
    try {
      return _encodeNode((value as dynamic).toJson());
    } catch (_) {
      throw SqliteStoreException(
        'Unsupported local-store value: ${value.runtimeType}',
      );
    }
  }

  static dynamic _decodeNode(dynamic value) {
    if (value is! Map) return value;
    switch (value['__em_type']) {
      case 'bytes':
        return Uint8List.fromList(base64Decode(value['value'] as String));
      case 'datetime':
        return DateTime.parse(value['value'] as String);
      case 'list':
        return (value['items'] as List).map(_decodeNode).toList();
      case 'map':
        return Map<dynamic, dynamic>.fromEntries(
          (value['entries'] as List).map((entry) {
            final pair = entry as List;
            return MapEntry(_decodeNode(pair[0]), _decodeNode(pair[1]));
          }),
        );
      default:
        return value.map((key, node) => MapEntry(key, _decodeNode(node)));
    }
  }
}
