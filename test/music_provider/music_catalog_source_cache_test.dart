import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estrella_music/music_provider/models/music_identity.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/models/provider_capabilities.dart';
import 'package:estrella_music/music_provider/models/provider_entities.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/music_provider/music_download_provider.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/profiles/music_profile.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/profiles/profile_persistence.dart';
import 'package:estrella_music/profiles/profile_storage_namespace.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

void main() {
  late Directory directory;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('source-cache-test-');
    await SqliteStore.initialize(directory.path);
    SqliteStore.boxNameResolver = ProfileStorageNamespace.resolve;
    SqliteStore.boxBackendResolver = ProfileStorageNamespace.backendFor;
  });

  tearDown(() async {
    await SqliteStore.close();
    SqliteStore.boxNameResolver = null;
    SqliteStore.boxBackendResolver = null;
    if (await directory.exists()) await directory.delete(recursive: true);
  });

  test('reuses an unexpired signed source after provider recreation', () async {
    final first = await _catalogFixture();
    final item = _item();

    final original = await first.catalog.resolvePlayback(item);
    expect(first.provider.playbackRequests, 1);
    expect(original.expiresAt, isNotNull);

    await first.manager.deactivate('cloud-profile');
    final restarted = await _catalogFixture();
    final restored = await restarted.catalog.resolvePlayback(item);

    expect(restored.uri, original.uri);
    expect(restarted.provider.playbackRequests, 0,
        reason: 'the profile-local signed URL is still valid');

    await restarted.catalog.invalidatePlayback(item);
    await restarted.catalog.resolvePlayback(item);
    expect(restarted.provider.playbackRequests, 1,
        reason: 'explicit invalidation must force a fresh source');
  });

  test('keeps download and streaming source caches independent', () async {
    final fixture = await _catalogFixture();
    final item = _item();

    await fixture.catalog.resolvePlayback(item);
    await fixture.catalog.resolveDownload(item, format: 'opus');
    await fixture.catalog.resolvePlayback(item);
    await fixture.catalog.resolveDownload(item, format: 'opus');

    expect(fixture.provider.playbackRequests, 1);
    expect(fixture.provider.downloadRequests, 1);
  });
}

Future<_CatalogFixture> _catalogFixture() async {
  late _CountingProvider cloud;
  final manager = MusicProviderManager(localProviderId: 'estrella.local')
    ..register(ProviderRegistration(
      id: 'estrella.local',
      displayName: 'Local',
      factory: () => _CountingProvider('estrella.local'),
      trust: ProviderTrust.local,
    ))
    ..register(ProviderRegistration(
      id: 'joss.emusic',
      displayName: 'eMusic',
      factory: () => cloud = _CountingProvider('joss.emusic'),
      trust: ProviderTrust.jossRedAuthorized,
    ));
  final persistence = _MemoryProfilePersistence()
    ..profiles['cloud-profile'] = const MusicProfile(
      id: 'cloud-profile',
      name: 'eMusic',
      providerId: 'joss.emusic',
    )
    ..activeProfileId = 'cloud-profile';
  final profiles = ProfileManager(
    providerManager: manager,
    persistence: persistence,
  );
  await profiles.initialize();
  return _CatalogFixture(
    manager: manager,
    provider: cloud,
    catalog: MusicCatalogService(
      providerManager: manager,
      profileManager: profiles,
    ),
  );
}

MediaItem _item() => const MediaItem(
      id: 'track-1',
      title: 'Track',
      extras: {
        'providerId': 'joss.emusic',
        'profileId': 'cloud-profile',
        'sourceId': 'track-1',
      },
    );

class _CatalogFixture {
  const _CatalogFixture({
    required this.manager,
    required this.provider,
    required this.catalog,
  });

  final MusicProviderManager manager;
  final _CountingProvider provider;
  final MusicCatalogService catalog;
}

class _CountingProvider implements MusicProvider, MusicDownloadProvider {
  _CountingProvider(this.id);

  @override
  final String id;
  int playbackRequests = 0;
  int downloadRequests = 0;

  @override
  String get displayName => id;

  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(
        playback: true,
        tracks: true,
      );

  @override
  Future<void> initialize(MusicProviderContext context) async {}

  @override
  Future<void> dispose() async {}

  @override
  Future<void> refresh() async {}

  @override
  Future<PlaybackSource> getPlayback(ProviderTrack track) async {
    playbackRequests++;
    return _source('stream');
  }

  @override
  Future<PlaybackSource> getDownload(
    ProviderTrack track, {
    required String format,
  }) async {
    downloadRequests++;
    return _source('download-$format');
  }

  PlaybackSource _source(String purpose) {
    final expiresAt = DateTime.now().add(const Duration(hours: 1));
    return PlaybackSource(
      type: PlaybackSourceType.authorizedStream,
      uri: Uri.parse(
        'https://media.test/$purpose?expire='
        '${expiresAt.millisecondsSinceEpoch ~/ 1000}',
      ),
      headers: const {'User-Agent': 'Estrella'},
      mimeType: 'audio/ogg; codecs="opus"',
      expiresAt: expiresAt,
      contentLength: 100,
    );
  }

  @override
  Future<List<ProviderTrack>> getTracks() async => const [];
  @override
  Future<ProviderTrack?> getTrack(String sourceId) async => null;
  @override
  Future<List<ProviderAlbum>> getAlbums() async => const [];
  @override
  Future<ProviderAlbum?> getAlbum(String sourceId) async => null;
  @override
  Future<List<ProviderArtist>> getArtists() async => const [];
  @override
  Future<ProviderArtist?> getArtist(String sourceId) async => null;
  @override
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity) async => null;
  @override
  Future<ProviderLyrics?> getLyrics(ProviderTrack track) async => null;
  @override
  Future<ProviderSearchResults> search(String query) async =>
      const ProviderSearchResults();
}

class _MemoryProfilePersistence implements ProfilePersistence {
  final profiles = <String, MusicProfile>{};
  final states = <String, Map<String, dynamic>>{};
  String? activeProfileId;

  @override
  Future<List<MusicProfile>> loadProfiles() async => profiles.values.toList();
  @override
  Future<void> saveProfile(MusicProfile profile) async =>
      profiles[profile.id] = profile;
  @override
  Future<void> deleteProfile(String profileId) async =>
      profiles.remove(profileId);
  @override
  Future<String?> loadActiveProfileId() async => activeProfileId;
  @override
  Future<void> saveActiveProfileId(String profileId) async =>
      activeProfileId = profileId;
  @override
  Future<Map<String, dynamic>> loadState(String profileId) async =>
      states[profileId] ?? const {};
  @override
  Future<void> saveState(
    String profileId,
    Map<String, dynamic> state,
  ) async =>
      states[profileId] = state;
}
