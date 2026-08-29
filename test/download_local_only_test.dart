import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/services/sync/music_sqlite_service.dart';
import 'package:harmonymusic/services/sync/repository/sync_local_repository.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory tempDirectory;

  setUp(() async {
    tempDirectory =
        await Directory.systemTemp.createTemp('estrella-download-local-');
    await SqliteStore.initialize(
      tempDirectory.path,
      migrateLegacyHive: false,
    );
  });

  tearDown(() async {
    await SqliteStore.close();
    if (await tempDirectory.exists()) {
      await tempDirectory.delete(recursive: true);
    }
  });

  test('cloud snapshots exclude downloads without changing SongDownloads',
      () async {
    final downloads = SqliteStore.box('SongDownloads');
    await downloads.put('track-1', {
      'videoId': 'track-1',
      'url': r'C:\device-only\track-1.m4a',
    });

    final payload = await SyncLocalRepository().buildPushPayload();

    expect(payload, isNot(contains('downloads')));
    expect(downloads.get('track-1'), isNotNull);
    expect(downloads.length, 1);
  });

  test('schema v2 removes download sync mirrors but keeps local downloads',
      () async {
    final downloads = SqliteStore.box('SongDownloads');
    await downloads.put('track-1', {
      'videoId': 'track-1',
      'url': r'C:\device-only\track-1.m4a',
    });

    final musicDatabasePath =
        p.join(tempDirectory.path, 'music-sync-v1.sqlite3');
    final legacyDatabase = sqlite3.open(musicDatabasePath);
    legacyDatabase.execute('''
      CREATE TABLE music_entities (
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
    legacyDatabase.execute('''
      CREATE TABLE sync_outbox (
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
    legacyDatabase.execute(
      '''INSERT INTO music_entities
         (account_key, entity_type, entity_id, payload_json, updated_at)
         VALUES ('user-1', 'download', 'track-1', '{}', '2026-07-28')''',
    );
    legacyDatabase.execute(
      '''INSERT INTO music_entities
         (account_key, entity_type, entity_id, payload_json, updated_at)
         VALUES ('user-1', 'favorite', 'track-2', '{}', '2026-07-28')''',
    );
    legacyDatabase.execute(
      '''INSERT INTO sync_outbox
         (change_id, account_key, entity_type, entity_id, operation,
          payload_json, created_at)
         VALUES ('download-change', 'user-1', 'download', 'track-1',
                 'upsert', '{}', '2026-07-28')''',
    );
    legacyDatabase.execute(
      '''INSERT INTO sync_outbox
         (change_id, account_key, entity_type, entity_id, operation,
          payload_json, created_at)
         VALUES ('favorite-change', 'user-1', 'favorite', 'track-2',
                 'upsert', '{}', '2026-07-28')''',
    );
    legacyDatabase.execute('PRAGMA user_version = 1');
    legacyDatabase.dispose();

    final service = MusicSqliteService();
    addTearDown(service.closeDatabase);
    await service.initialize(databasePath: musicDatabasePath);

    expect(
      service.db.select(
        "SELECT 1 FROM music_entities WHERE entity_type = 'download'",
      ),
      isEmpty,
    );
    expect(
      service.db.select(
        "SELECT 1 FROM sync_outbox WHERE entity_type = 'download'",
      ),
      isEmpty,
    );
    expect(
      service.db.select(
        "SELECT 1 FROM music_entities WHERE entity_type = 'favorite'",
      ),
      isNotEmpty,
    );
    expect(
      service.db.select(
        "SELECT 1 FROM sync_outbox WHERE entity_type = 'favorite'",
      ),
      isNotEmpty,
    );
    expect(downloads.get('track-1'), isNotNull);
  });

  test('starting the sync database never imports a local library', () async {
    await SqliteStore.box('LIBFAV').put('local-track', {
      'videoId': 'local-track',
      'title': 'Only on this device',
    });
    final service = MusicSqliteService();
    addTearDown(service.closeDatabase);
    await service.initialize(databasePath: ':memory:');

    expect(service.db.select('SELECT * FROM music_entities'), isEmpty);
    expect(service.db.select('SELECT * FROM sync_outbox'), isEmpty);
  });
}
