import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:estrella_music/services/sync/repository/sync_local_repository.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

class PendingMusicChange {
  const PendingMusicChange({
    required this.changeId,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.baseVersion,
  });

  final String changeId;
  final String entityType;
  final String entityId;
  final String operation;
  final Map<String, dynamic> payload;
  final int baseVersion;

  Map<String, dynamic> toApiJson() => {
        'client_change_id': changeId,
        'entity_type': entityType,
        'entity_id': entityId,
        'operation': operation,
        'base_version': baseVersion,
        'payload': payload,
      };
}

/// Durable music cache and transactional outbox.
///
/// Normalized music entities, server versions and transactional sync outbox.
class MusicSqliteService extends GetxService {
  static const schemaVersion = 2;
  static const databaseFileName = 'estrella_music.sqlite3';

  Database? _database;
  Database get db {
    final value = _database;
    if (value == null) {
      throw StateError('MusicSqliteService is not initialized');
    }
    return value;
  }

  Future<void> initialize({String? databasePath}) async {
    if (_database != null) return;
    final path = databasePath ?? await _defaultDatabasePath();
    _database =
        path == ':memory:' ? sqlite3.openInMemory() : sqlite3.open(path);
    _configureDatabase();
    _createSchema();
  }

  Future<String> _defaultDatabasePath() async {
    final support = await getApplicationSupportDirectory();
    final directory = Directory(p.join(support.path, 'db'));
    if (!await directory.exists()) await directory.create(recursive: true);
    return p.join(directory.path, databaseFileName);
  }

  void _configureDatabase() {
    db.execute('PRAGMA foreign_keys = ON');
    db.execute('PRAGMA journal_mode = WAL');
    db.execute('PRAGMA synchronous = NORMAL');
    db.execute('PRAGMA busy_timeout = 5000');
  }

  void _createSchema() {
    db.execute('''
      CREATE TABLE IF NOT EXISTS music_entities (
        account_key TEXT NOT NULL,
        entity_type TEXT NOT NULL,
        entity_id TEXT NOT NULL,
        parent_id TEXT,
        payload_json TEXT NOT NULL,
        server_version INTEGER NOT NULL DEFAULT 0,
        sync_state TEXT NOT NULL DEFAULT 'synced',
        updated_at TEXT NOT NULL,
        deleted_at TEXT,
        PRIMARY KEY (account_key, entity_type, entity_id)
      )
    ''');
    db.execute('''
      CREATE INDEX IF NOT EXISTS idx_music_entities_parent
      ON music_entities(account_key, entity_type, parent_id, deleted_at)
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS sync_outbox (
        change_id TEXT PRIMARY KEY,
        account_key TEXT NOT NULL,
        entity_type TEXT NOT NULL,
        entity_id TEXT NOT NULL,
        operation TEXT NOT NULL,
        payload_json TEXT NOT NULL,
        base_version INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'pending',
        attempts INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        last_attempt_at TEXT
      )
    ''');
    db.execute('''
      CREATE INDEX IF NOT EXISTS idx_sync_outbox_pending
      ON sync_outbox(account_key, status, created_at)
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS sync_state (
        account_key TEXT NOT NULL,
        state_key TEXT NOT NULL,
        state_value TEXT NOT NULL,
        PRIMARY KEY (account_key, state_key)
      )
    ''');
    db.execute('''
      CREATE TABLE IF NOT EXISTS local_migrations (
        migration_key TEXT PRIMARY KEY,
        status TEXT NOT NULL,
        summary_json TEXT NOT NULL,
        completed_at TEXT NOT NULL
      )
    ''');
    final currentVersion =
        db.select('PRAGMA user_version').first['user_version'] as int;
    if (currentVersion < 2) {
      // Download files and their metadata belong exclusively to this device.
      // Remove only sync mirrors/outbox entries; SongDownloads remains intact.
      db.execute("DELETE FROM sync_outbox WHERE entity_type = 'download'");
      db.execute("DELETE FROM music_entities WHERE entity_type = 'download'");
    }
    db.execute('PRAGMA user_version = $schemaVersion');
  }

  /// Explicit legacy import used only by a user-confirmed eMusic migration.
  /// It must never run during local-profile startup.
  Future<void> importLocalStoreForAuthorizedMigration() async {
    const migrationKey = 'local_store_to_music_sqlite_v1';
    final existing = db.select(
      'SELECT status FROM local_migrations WHERE migration_key = ?',
      [migrationKey],
    );
    if (existing.isNotEmpty && existing.first['status'] == 'complete') return;

    final snapshot = await SyncLocalRepository().buildPushPayload();
    final summary = <String, int>{};
    _transaction(() {
      summary['favorites'] = _importCollection(
        'local',
        'favorite',
        snapshot['favorites'],
        const ['videoId', 'id'],
      );
      summary['recent_plays'] = _importCollection(
        'local',
        'recent_play',
        snapshot['recent_plays'],
        const ['videoId', 'id'],
      );
      summary['albums'] = _importCollection(
        'local',
        'album',
        snapshot['albums'],
        const ['browseId', 'albumId', 'id'],
      );
      summary['artists'] = _importCollection(
        'local',
        'artist',
        snapshot['artists'],
        const ['channelId', 'artistId', 'id'],
      );
      summary['playlists'] = _importPlaylists('local', snapshot['playlists']);
      db.execute(
        '''INSERT OR REPLACE INTO local_migrations
           (migration_key, status, summary_json, completed_at)
           VALUES (?, 'complete', ?, ?)''',
        [
          migrationKey,
          jsonEncode(summary),
          DateTime.now().toUtc().toIso8601String()
        ],
      );
    });
    printINFO('MusicSqliteService: local-store migration complete: $summary');
  }

  void checkpoint() {
    db.execute('PRAGMA wal_checkpoint(TRUNCATE)');
  }

  Future<void> closeDatabase() async {
    _database?.dispose();
    _database = null;
  }

  int _importCollection(
    String accountKey,
    String entityType,
    dynamic raw,
    List<String> idKeys,
  ) {
    if (raw is! List) return 0;
    var imported = 0;
    for (final value in raw) {
      final payload = _stringMap(value);
      final entityId = _firstId(payload, idKeys);
      if (entityId == null) continue;
      _upsertEntity(accountKey, entityType, entityId, payload,
          syncState: 'synced');
      imported++;
    }
    return imported;
  }

  int _importPlaylists(String accountKey, dynamic raw) {
    if (raw is! List) return 0;
    var imported = 0;
    for (final value in raw) {
      final playlist = _stringMap(value);
      final playlistId =
          _firstId(playlist, const ['playlistId', 'playlist_id', 'id']);
      if (playlistId == null) continue;
      final tracks = playlist.remove('tracks');
      _upsertEntity(accountKey, 'playlist', playlistId, playlist,
          syncState: 'synced');
      if (tracks is List) {
        for (var position = 0; position < tracks.length; position++) {
          final track = _stringMap(tracks[position]);
          final trackId = _firstId(track, const ['videoId', 'id']);
          if (trackId == null) continue;
          _upsertEntity(
            accountKey,
            'playlist_track',
            '$playlistId:$trackId',
            {...track, 'playlist_id': playlistId, 'position': position},
            parentId: playlistId,
            syncState: 'synced',
          );
        }
      }
      imported++;
    }
    return imported;
  }

  Future<String> recordLocalChange({
    required String accountKey,
    required String entityType,
    required String entityId,
    required String operation,
    Map<String, dynamic> payload = const {},
    String? parentId,
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final changeId =
        '${DateTime.now().microsecondsSinceEpoch}-$entityType-$entityId';
    _transaction(() {
      final current = db.select(
        '''SELECT server_version FROM music_entities
           WHERE account_key = ? AND entity_type = ? AND entity_id = ?''',
        [accountKey, entityType, entityId],
      );
      final baseVersion =
          current.isEmpty ? 0 : current.first['server_version'] as int;
      if (operation == 'delete') {
        _upsertEntity(
          accountKey,
          entityType,
          entityId,
          payload,
          parentId: parentId,
          serverVersion: baseVersion,
          syncState: 'pending',
          deletedAt: now,
        );
      } else {
        _upsertEntity(
          accountKey,
          entityType,
          entityId,
          payload,
          parentId: parentId,
          serverVersion: baseVersion,
          syncState: 'pending',
        );
      }
      // Coalesce rapid toggles/reorders for the same entity. Only the latest
      // desired state needs to cross the network.
      db.execute(
        '''DELETE FROM sync_outbox WHERE account_key = ? AND entity_type = ?
           AND entity_id = ? AND status IN ('pending', 'retry')''',
        [accountKey, entityType, entityId],
      );
      db.execute(
        '''INSERT INTO sync_outbox
           (change_id, account_key, entity_type, entity_id, operation,
            payload_json, base_version, status, created_at)
           VALUES (?, ?, ?, ?, ?, ?, ?, 'pending', ?)''',
        [
          changeId,
          accountKey,
          entityType,
          entityId,
          operation,
          jsonEncode(payload),
          baseVersion,
          now
        ],
      );
    });
    return changeId;
  }

  Future<void> mirrorLocalEntity({
    required String accountKey,
    required String entityType,
    required String entityId,
    required String operation,
    Map<String, dynamic> payload = const {},
    String? parentId,
  }) async {
    if (operation == 'delete') {
      _upsertEntity(
        accountKey,
        entityType,
        entityId,
        payload,
        parentId: parentId,
        syncState: 'local',
        deletedAt: DateTime.now().toUtc().toIso8601String(),
      );
    } else {
      _upsertEntity(
        accountKey,
        entityType,
        entityId,
        payload,
        parentId: parentId,
        syncState: 'local',
      );
    }
  }

  List<PendingMusicChange> pendingChanges(String accountKey,
      {int limit = 100}) {
    final rows = db.select(
      '''SELECT change_id, entity_type, entity_id, operation, payload_json, base_version
         FROM sync_outbox
         WHERE account_key = ? AND status IN ('pending', 'retry')
         ORDER BY created_at ASC LIMIT ?''',
      [accountKey, limit],
    );
    return rows
        .map((row) => PendingMusicChange(
              changeId: row['change_id'] as String,
              entityType: row['entity_type'] as String,
              entityId: row['entity_id'] as String,
              operation: row['operation'] as String,
              payload: _decodeMap(row['payload_json']),
              baseVersion: row['base_version'] as int,
            ))
        .toList(growable: false);
  }

  bool hasPendingChanges(String accountKey) => db.select(
        '''SELECT 1 FROM sync_outbox
           WHERE account_key = ? AND status IN ('pending', 'retry') LIMIT 1''',
        [accountKey],
      ).isNotEmpty;

  List<String> pendingChangeIds(String accountKey) => db
      .select(
        '''SELECT change_id FROM sync_outbox
           WHERE account_key = ? AND status IN ('pending', 'retry')
           ORDER BY created_at ASC''',
        [accountKey],
      )
      .map((row) => row['change_id'] as String)
      .toList(growable: false);

  Future<void> markChangesSynced(
    String accountKey,
    Iterable<String> changeIds,
    int serverVersion,
  ) async {
    _transaction(() {
      for (final changeId in changeIds) {
        final rows = db.select(
          '''SELECT entity_type, entity_id FROM sync_outbox
             WHERE account_key = ? AND change_id = ?''',
          [accountKey, changeId],
        );
        if (rows.isNotEmpty) {
          db.execute(
            '''UPDATE music_entities SET sync_state = 'synced', server_version = ?
               WHERE account_key = ? AND entity_type = ? AND entity_id = ?''',
            [
              serverVersion,
              accountKey,
              rows.first['entity_type'],
              rows.first['entity_id']
            ],
          );
        }
        db.execute(
          'DELETE FROM sync_outbox WHERE account_key = ? AND change_id = ?',
          [accountKey, changeId],
        );
      }
      _setState(accountKey, 'last_server_version', serverVersion.toString());
    });
  }

  Future<void> markChangesForRetry(
      String accountKey, Iterable<String> changeIds) async {
    final now = DateTime.now().toUtc().toIso8601String();
    for (final id in changeIds) {
      db.execute(
        '''UPDATE sync_outbox SET status = 'retry', attempts = attempts + 1,
           last_attempt_at = ? WHERE account_key = ? AND change_id = ?''',
        [now, accountKey, id],
      );
    }
  }

  int lastServerVersion(String accountKey) =>
      int.tryParse(
        _state(accountKey, 'last_server_version') ?? '0',
      ) ??
      0;

  bool isBootstrapComplete(String accountKey) =>
      _state(accountKey, 'bootstrap_complete') == 'true';

  Future<void> markBootstrapComplete(
      String accountKey, int serverVersion) async {
    _transaction(() {
      _setState(accountKey, 'bootstrap_complete', 'true');
      _setState(accountKey, 'last_server_version', serverVersion.toString());
    });
  }

  Future<void> markBootstrapIncomplete(String accountKey) async {
    _transaction(() {
      _setState(accountKey, 'bootstrap_complete', 'false');
    });
  }

  Future<void> importServerSnapshot(
    String accountKey,
    Map<String, dynamic> snapshot,
  ) async {
    _transaction(() {
      db.execute(
          'DELETE FROM music_entities WHERE account_key = ?', [accountKey]);
      _importCollection(accountKey, 'favorite', snapshot['favorites'],
          const ['videoId', 'id']);
      _importCollection(accountKey, 'recent_play', snapshot['recent_plays'],
          const ['videoId', 'id']);
      _importCollection(accountKey, 'album', snapshot['albums'],
          const ['browseId', 'albumId', 'id']);
      _importCollection(accountKey, 'artist', snapshot['artists'],
          const ['channelId', 'artistId', 'id']);
      _importPlaylists(accountKey, snapshot['playlists']);
    });
  }

  Future<void> applyRemoteChanges(
    String accountKey,
    List<Map<String, dynamic>> changes,
  ) async {
    _transaction(() {
      for (final change in changes) {
        final entityType =
            (change['entity_type'] ?? change['entityType']).toString();
        if (entityType == 'download') continue;
        final entityId = (change['entity_id'] ?? change['entityId']).toString();
        final operation = change['operation']?.toString() ?? 'upsert';
        final version =
            _asInt(change['sync_version'] ?? change['server_version']);
        final payload = change['payload'] is Map
            ? _stringMap(change['payload'])
            : _decodeMap(change['payload_json']);
        final parentId = payload['playlist_id']?.toString();
        if (operation == 'delete') {
          _upsertEntity(
            accountKey,
            entityType,
            entityId,
            payload,
            parentId: parentId,
            serverVersion: version,
            syncState: 'synced',
            deletedAt: DateTime.now().toUtc().toIso8601String(),
          );
        } else {
          _upsertEntity(
            accountKey,
            entityType,
            entityId,
            payload,
            parentId: parentId,
            serverVersion: version,
            syncState: 'synced',
          );
        }
      }
    });
  }

  void _upsertEntity(
    String accountKey,
    String entityType,
    String entityId,
    Map<String, dynamic> payload, {
    String? parentId,
    int serverVersion = 0,
    String syncState = 'synced',
    String? deletedAt,
  }) {
    db.execute(
      '''INSERT INTO music_entities
         (account_key, entity_type, entity_id, parent_id, payload_json,
          server_version, sync_state, updated_at, deleted_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
         ON CONFLICT(account_key, entity_type, entity_id) DO UPDATE SET
           parent_id = excluded.parent_id,
           payload_json = excluded.payload_json,
           server_version = excluded.server_version,
           sync_state = excluded.sync_state,
           updated_at = excluded.updated_at,
           deleted_at = excluded.deleted_at''',
      [
        accountKey,
        entityType,
        entityId,
        parentId,
        jsonEncode(payload),
        serverVersion,
        syncState,
        DateTime.now().toUtc().toIso8601String(),
        deletedAt,
      ],
    );
  }

  void _transaction(void Function() action) {
    db.execute('BEGIN IMMEDIATE');
    try {
      action();
      db.execute('COMMIT');
    } catch (_) {
      db.execute('ROLLBACK');
      rethrow;
    }
  }

  String? _state(String accountKey, String key) {
    final rows = db.select(
      'SELECT state_value FROM sync_state WHERE account_key = ? AND state_key = ?',
      [accountKey, key],
    );
    return rows.isEmpty ? null : rows.first['state_value'] as String;
  }

  void _setState(String accountKey, String key, String value) {
    db.execute(
      '''INSERT INTO sync_state(account_key, state_key, state_value)
         VALUES (?, ?, ?)
         ON CONFLICT(account_key, state_key) DO UPDATE SET state_value = excluded.state_value''',
      [accountKey, key, value],
    );
  }

  Map<String, dynamic> _decodeMap(dynamic raw) {
    if (raw is Map) return _stringMap(raw);
    if (raw is String && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is Map) return _stringMap(decoded);
    }
    return <String, dynamic>{};
  }

  Map<String, dynamic> _stringMap(dynamic value) => value is Map
      ? value.map((key, item) => MapEntry(key.toString(), item))
      : <String, dynamic>{};

  String? _firstId(Map<String, dynamic> value, List<String> keys) {
    for (final key in keys) {
      final candidate = value[key]?.toString();
      if (candidate != null && candidate.isNotEmpty && candidate != 'null') {
        return candidate;
      }
    }
    return null;
  }

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  @override
  void onClose() {
    _database?.dispose();
    _database = null;
    super.onClose();
  }
}
