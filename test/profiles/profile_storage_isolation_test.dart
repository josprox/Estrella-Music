import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/profiles/profile_storage_namespace.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

void main() {
  late Directory directory;

  setUp(() async {
    directory =
        await Directory.systemTemp.createTemp('estrella-profile-store-');
    await SqliteStore.initialize(directory.path, migrateLegacyHive: false);
    SqliteStore.boxNameResolver = ProfileStorageNamespace.resolve;
    SqliteStore.boxBackendResolver = ProfileStorageNamespace.backendFor;
  });

  tearDown(() async {
    await SqliteStore.close();
    SqliteStore.boxNameResolver = null;
    SqliteStore.boxBackendResolver = null;
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test('favorites, playlists, history, cache and playback state are isolated',
      () async {
    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'personal',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    expect(SqliteStore.box('LIBFAV').backend, MusicStoreBackend.hive);
    await SqliteStore.box('LIBFAV')
        .put('track', {'title': 'Personal favorite'});
    await SqliteStore.box('LibraryPlaylists')
        .put('mix', {'title': 'Personal mix'});
    await SqliteStore.box('LIBRP').put('track', {'title': 'Personal history'});
    await SqliteStore.box('SongsCache')
        .put('track', {'title': 'Personal cache'});
    await SqliteStore.box('prevSessionData').put('position', 100);

    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'work',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    expect(SqliteStore.box('LIBFAV').isEmpty, isTrue);
    expect(SqliteStore.box('LibraryPlaylists').isEmpty, isTrue);
    expect(SqliteStore.box('LIBRP').isEmpty, isTrue);
    expect(SqliteStore.box('SongsCache').isEmpty, isTrue);
    expect(SqliteStore.box('prevSessionData').isEmpty, isTrue);
    await SqliteStore.box('LIBFAV').put('track', {'title': 'Work favorite'});

    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'personal',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    expect(
        SqliteStore.box('LIBFAV').get('track')['title'], 'Personal favorite');
    expect(SqliteStore.box('prevSessionData').get('position'), 100);
  });

  test('downloads stay local and are namespaced without entering sync storage',
      () async {
    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'one',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    await SqliteStore.box('SongDownloads')
        .put('track', {'url': r'C:\Music\one.mp3'});
    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'two',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    expect(SqliteStore.box('SongDownloads').containsKey('track'), isFalse);
  });

  test('eMusic profile uses SQLite while local data remains in Hive', () async {
    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'local',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    await SqliteStore.box('LIBFAV').put('same-id', {'title': 'Local'});

    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'cloud',
      providerId: 'joss.emusic',
    );
    expect(SqliteStore.box('LIBFAV').backend, MusicStoreBackend.sqlite);
    expect(SqliteStore.box('LIBFAV').containsKey('same-id'), isFalse);
    await SqliteStore.box('LIBFAV').put('same-id', {'title': 'Cloud'});

    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'local',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    expect(SqliteStore.box('LIBFAV').get('same-id')['title'], 'Local');
  });

  test('SQLite recovery data is copied to local Hive without deletion',
      () async {
    ProfileStorageNamespace.activate(
      'local-default',
      providerId: 'joss.emusic',
    );
    await SqliteStore.openBox('LIBFAV');
    await SqliteStore.box('LIBFAV').put('recovered', {'title': 'Preserved'});

    await ProfileStorageNamespace.activateAndOpen(
      profileId: 'local-default',
      providerId: ProfileStorageNamespace.localProviderId,
    );
    expect(SqliteStore.box('LIBFAV').backend, MusicStoreBackend.hive);
    expect(SqliteStore.box('LIBFAV').get('recovered')['title'], 'Preserved');
    expect(
      SqliteStore.database.select(
        "SELECT 1 FROM local_store_entries WHERE box_name = 'profiles__local-default__libfav'",
      ),
      isNotEmpty,
    );
  });
}
