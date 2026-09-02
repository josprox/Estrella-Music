import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:estrella_music/music_provider/models/music_identity.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/models/provider_capabilities.dart';
import 'package:estrella_music/music_provider/models/provider_entities.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/music_provider/music_metadata_editor.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/profiles/music_profile.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/profiles/profile_persistence.dart';

void main() {
  tearDown(Get.reset);

  test('searches public metadata without an eMusic profile and applies locally',
      () async {
    late _EditableLocalProvider local;
    final metadata = _MetadataProvider();
    final manager = MusicProviderManager(localProviderId: 'estrella.local')
      ..register(ProviderRegistration(
        id: 'estrella.local',
        displayName: 'Local',
        factory: () => local = _EditableLocalProvider(),
        trust: ProviderTrust.local,
      ));
    final persistence = _MemoryProfilePersistence()
      ..profiles['local'] = const MusicProfile(
        id: 'local',
        name: 'Local',
        providerId: 'estrella.local',
        isFallback: true,
      )
      ..activeProfileId = 'local';
    final profiles = ProfileManager(
      providerManager: manager,
      persistence: persistence,
    );
    await profiles.initialize();
    final catalog = MusicCatalogService(
      providerManager: manager,
      profileManager: profiles,
      metadataProvider: metadata,
    );
    final item = catalog.mediaItemFromTrack((await local.getTracks()).single);

    final candidates = await catalog.searchTrackMetadata(item, 'rough song');

    expect(candidates.single.title, 'Finished Song');
    expect(candidates.single.artist, 'Correct Artist');
    expect(metadata.initializedProfileId, 'public-metadata');
    expect(metadata.disposed, isFalse);
    expect(profiles.activeProfile.value?.id, 'local');

    final updated = await catalog.applyTrackMetadata(item, candidates.single);
    expect(updated.title, 'Finished Song');
    expect(local.applied?.sourceId, 'online-track');
    catalog.onClose();
    await Future<void>.delayed(Duration.zero);
    expect(metadata.disposed, isTrue);
  });

  test('automatically enriches incomplete local metadata at startup', () async {
    late _AutomaticLocalProvider local;
    final metadata = _AutomaticMetadataProvider();
    final manager = MusicProviderManager(localProviderId: 'estrella.local')
      ..register(ProviderRegistration(
        id: 'estrella.local',
        displayName: 'Local',
        factory: () => local = _AutomaticLocalProvider(),
        trust: ProviderTrust.local,
      ));
    final persistence = _MemoryProfilePersistence()
      ..profiles['local'] = const MusicProfile(
        id: 'local',
        name: 'Local',
        providerId: 'estrella.local',
        isFallback: true,
      )
      ..activeProfileId = 'local';
    final profiles = ProfileManager(
      providerManager: manager,
      persistence: persistence,
    );
    await profiles.initialize();
    final catalog = MusicCatalogService(
      providerManager: manager,
      profileManager: profiles,
      metadataProvider: metadata,
    );

    Get.put(catalog);
    await Future<void>.delayed(Duration.zero);
    expect(metadata.queries, isEmpty,
        reason: 'the first scan can run before Android grants audio access');
    await catalog.refresh();
    for (var attempt = 0;
        attempt < 20 && local.automaticCandidate == null;
        attempt++) {
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }

    expect(metadata.queries, ['Nicki Nicole, Young Miko 8 AM']);
    expect(local.automaticCandidate?.sourceId, 'musicbrainz:8-am');
    expect(local.lookupOutcome, isNull);
    expect(catalog.automaticMetadataRevision.value, 1);
  });
}

abstract class _StubProvider implements MusicProvider {
  String profileId = '';

  @override
  String get displayName => id;

  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(
        search: true,
        tracks: true,
        playback: true,
      );

  @override
  Future<void> initialize(MusicProviderContext context) async {
    profileId = context.profileId;
  }

  @override
  Future<void> dispose() async {}
  @override
  Future<void> refresh() async {}
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
  Future<PlaybackSource> getPlayback(ProviderTrack track) async =>
      PlaybackSource(type: PlaybackSourceType.localFile, uri: Uri.file('test'));
  @override
  Future<ProviderSearchResults> search(String query) async =>
      const ProviderSearchResults();
}

class _EditableLocalProvider extends _StubProvider
    implements MusicMetadataEditor {
  TrackMetadataCandidate? applied;

  @override
  String get id => 'estrella.local';

  ProviderTrack get track => ProviderTrack(
        identity: MusicIdentity(
          providerId: id,
          profileId: profileId,
          sourceId: 'local-track',
        ),
        title: applied?.title ?? 'Rough Song',
        artist: applied?.artist ?? 'Unknown artist',
        album: applied?.album ?? 'Unknown album',
        filePath: 'C:/Music/rough-song.mp3',
      );

  @override
  Future<List<ProviderTrack>> getTracks() async => [track];

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async =>
      sourceId == track.identity.sourceId ? track : null;

  @override
  String suggestedMetadataQuery(ProviderTrack track) => 'rough song';

  @override
  Future<ProviderTrack> applyMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  ) async {
    applied = candidate;
    return this.track;
  }
}

class _MetadataProvider extends _StubProvider
    implements MusicMetadataSearchProvider {
  bool disposed = false;
  String? initializedProfileId;

  @override
  String get id => 'metadata.public';

  @override
  Future<void> initialize(MusicProviderContext context) async {
    initializedProfileId = context.profileId;
    await super.initialize(context);
  }

  @override
  Future<void> dispose() async => disposed = true;

  @override
  Future<List<ProviderTrack>> getTracks() async => const [];
  @override
  Future<ProviderTrack?> getTrack(String sourceId) async => null;

  @override
  Future<List<TrackMetadataCandidate>> searchMetadata(
    String query, {
    int limit = 20,
  }) async =>
      const [
        TrackMetadataCandidate(
          sourceId: 'online-track',
          title: 'Finished Song',
          artist: 'Correct Artist',
          album: 'Correct Album',
          duration: Duration(minutes: 3),
        ),
      ];
}

class _AutomaticLocalProvider extends _StubProvider
    implements MusicMetadataEditor, AutomaticMusicMetadataEditor {
  TrackMetadataCandidate? automaticCandidate;
  AutomaticMetadataLookupOutcome? lookupOutcome;
  bool tracksVisible = false;

  @override
  String get id => 'estrella.local';

  ProviderTrack get track => ProviderTrack(
        identity: MusicIdentity(
          providerId: id,
          profileId: profileId,
          sourceId: 'local-8-am',
        ),
        title: automaticCandidate?.title ?? '8 AM',
        artist: automaticCandidate?.artist ?? 'Nicki Nicole, Young Miko',
        album: automaticCandidate?.album ?? 'Unknown album',
        duration: const Duration(milliseconds: 147603),
        filePath: 'C:/Music/8 AM (Nicki Nicole, Young Miko).opus',
        metadata: {
          'metadataSource':
              automaticCandidate == null ? 'filename' : 'automatic',
          'needsMetadataReview': automaticCandidate == null,
        },
      );

  @override
  Future<List<ProviderTrack>> getTracks() async =>
      tracksVisible ? [track] : const [];

  @override
  Future<void> refresh() async {
    tracksVisible = true;
  }

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async =>
      sourceId == track.identity.sourceId ? track : null;

  @override
  String suggestedMetadataQuery(ProviderTrack track) =>
      'Nicki Nicole, Young Miko 8 AM';

  @override
  bool shouldLookupMetadataAutomatically(ProviderTrack track) =>
      automaticCandidate == null;

  @override
  Future<ProviderTrack> applyAutomaticMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  ) async {
    automaticCandidate = candidate;
    return this.track;
  }

  @override
  Future<ProviderTrack> applyMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  ) =>
      applyAutomaticMetadata(track, candidate);

  @override
  Future<void> recordAutomaticMetadataLookup(
    ProviderTrack track,
    AutomaticMetadataLookupOutcome outcome,
  ) async {
    lookupOutcome = outcome;
  }
}

class _AutomaticMetadataProvider extends _StubProvider
    implements MusicMetadataSearchProvider {
  final List<String> queries = [];

  @override
  String get id => 'metadata.public';

  @override
  Future<List<ProviderTrack>> getTracks() async => const [];

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async => null;

  @override
  Future<List<TrackMetadataCandidate>> searchMetadata(
    String query, {
    int limit = 20,
  }) async {
    queries.add(query);
    return const [
      TrackMetadataCandidate(
        sourceId: 'musicbrainz:8-am',
        title: '8 AM',
        artist: 'Nicki Nicole & Young Miko',
        album: '8 AM',
        duration: Duration(milliseconds: 147603),
        year: 2023,
      ),
    ];
  }
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
