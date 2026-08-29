import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:estrella_music/music_provider/models/music_identity.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/models/provider_capabilities.dart';
import 'package:estrella_music/music_provider/models/provider_entities.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/music_provider/providers/local_music_provider.dart';
import 'package:estrella_music/profiles/music_profile.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/profiles/profile_persistence.dart';

void main() {
  tearDown(Get.reset);

  test(
      'registers, activates, switches and allows multiple profiles per provider',
      () async {
    final providers = _providerManager();
    final persistence = _MemoryProfilePersistence();
    final lifecycle = _RecordingLifecycle();
    var sequence = 0;
    final profiles = ProfileManager(
      providerManager: providers,
      persistence: persistence,
      lifecycle: lifecycle,
      idGenerator: () => 'p-${++sequence}',
    );

    await profiles.initialize();
    expect(profiles.activeProfile.value?.providerId,
        LocalMusicProvider.providerId);
    expect(providers.availableProviderIds,
        containsAll(['estrella.local', 'joss.emusic']));

    final personal = await profiles.createProfile(
        name: 'Personal', providerId: 'joss.emusic');
    final work =
        await profiles.createProfile(name: 'Work', providerId: 'joss.emusic');
    expect(personal.id, isNot(work.id));

    await profiles.switchProfile(personal.id);
    expect(profiles.activeProfile.value?.id, personal.id);
    expect(
        providers.instanceForProfile(personal.id)?.capabilities.search, isTrue);
    expect(profiles.activeProfileMaySync, isTrue);
    expect(
        lifecycle.deactivated, contains(ProfileManager.defaultLocalProfileId));

    await profiles.switchProfile(work.id);
    expect(profiles.activeProfile.value?.id, work.id);
    expect(persistence.activeId, work.id);

    await profiles.renameProfile(work.id, 'Office');
    expect(profiles.profiles.firstWhere((p) => p.id == work.id).name, 'Office');
    await profiles.switchProfile(personal.id);
    expect(lifecycle.activatedState[personal.id]?['queue'], personal.id);
    await profiles.deleteProfile(work.id);
    expect(profiles.profiles.any((p) => p.id == work.id), isFalse);
  });

  test('preserves unavailable profile and falls back to local at startup',
      () async {
    final providers = _providerManager();
    final persistence = _MemoryProfilePersistence()
      ..values['missing'] = const MusicProfile(
        id: 'missing',
        name: 'CloudSound',
        providerId: 'community.cloudsound',
      )
      ..activeId = 'missing';
    final profiles = ProfileManager(
      providerManager: providers,
      persistence: persistence,
    );

    await profiles.initialize();
    expect(profiles.activeProfile.value?.providerId,
        LocalMusicProvider.providerId);
    expect(profiles.profiles.firstWhere((p) => p.id == 'missing').availability,
        MusicProfileAvailability.providerUnavailable);
    expect(persistence.values, contains('missing'));
  });

  test(
      'falls back after provider initialization failure and protects local profile',
      () async {
    final providers = _providerManager(includeFailing: true);
    final persistence = _MemoryProfilePersistence()
      ..values['broken'] = const MusicProfile(
        id: 'broken',
        name: 'Broken',
        providerId: 'broken.provider',
      )
      ..activeId = 'broken';
    final profiles =
        ProfileManager(providerManager: providers, persistence: persistence);

    await profiles.initialize();
    expect(
        profiles.activeProfile.value?.id, ProfileManager.defaultLocalProfileId);
    expect(profiles.profiles.firstWhere((p) => p.id == 'broken').availability,
        MusicProfileAvailability.initializationFailed);
    expect(
      () => profiles.deleteProfile(ProfileManager.defaultLocalProfileId),
      throwsStateError,
    );
  });

  test('community provider cannot obtain Joss Red sync authorization',
      () async {
    final manager = _providerManager(includeCommunity: true);
    final authorized = await manager.activate(
      profileId: 'emusic-profile',
      providerId: 'joss.emusic',
    );
    final community = await manager.activate(
      profileId: 'community-profile',
      providerId: 'community.provider',
    );
    final local = await manager.activate(
      profileId: 'local-profile',
      providerId: LocalMusicProvider.providerId,
    );

    expect(authorized.mayUseJossRedSync, isTrue);
    expect(community.capabilities.sync, isTrue);
    expect(community.mayUseJossRedSync, isFalse);
    expect(local.mayUseJossRedSync, isFalse);
  });
}

MusicProviderManager _providerManager({
  bool includeFailing = false,
  bool includeCommunity = false,
}) {
  final manager =
      MusicProviderManager(localProviderId: LocalMusicProvider.providerId);
  manager.register(ProviderRegistration(
    id: LocalMusicProvider.providerId,
    displayName: 'Local',
    factory: () => _FakeProvider(LocalMusicProvider.providerId, sync: false),
    trust: ProviderTrust.local,
  ));
  manager.register(ProviderRegistration(
    id: 'joss.emusic',
    displayName: 'eMusic',
    factory: () => _FakeProvider('joss.emusic', sync: true),
    trust: ProviderTrust.jossRedAuthorized,
  ));
  if (includeFailing) {
    manager.register(ProviderRegistration(
      id: 'broken.provider',
      displayName: 'Broken',
      factory: () => _FakeProvider('broken.provider', fail: true),
      trust: ProviderTrust.community,
    ));
  }
  if (includeCommunity) {
    manager.register(ProviderRegistration(
      id: 'community.provider',
      displayName: 'Community',
      factory: () => _FakeProvider('community.provider', sync: true),
      trust: ProviderTrust.community,
    ));
  }
  return manager;
}

class _FakeProvider implements MusicProvider {
  _FakeProvider(this.id, {this.sync = false, this.fail = false});
  @override
  final String id;
  final bool sync;
  final bool fail;
  String profileId = '';

  @override
  String get displayName => id;
  @override
  ProviderCapabilities get capabilities => ProviderCapabilities(
        search: true,
        playback: true,
        tracks: true,
        sync: sync,
      );
  @override
  Future<void> initialize(MusicProviderContext context) async {
    if (fail) throw StateError('failed');
    profileId = context.profileId;
  }

  @override
  Future<void> refresh() async {}
  @override
  Future<void> dispose() async {}
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
  Future<PlaybackSource> getPlayback(ProviderTrack track) async =>
      PlaybackSource(type: PlaybackSourceType.localFile, uri: Uri.file('fake'));
  @override
  Future<ProviderSearchResults> search(String query) async =>
      const ProviderSearchResults();
}

class _MemoryProfilePersistence implements ProfilePersistence {
  final values = <String, MusicProfile>{};
  final states = <String, Map<String, dynamic>>{};
  String? activeId;

  @override
  Future<void> deleteProfile(String profileId) async {
    values.remove(profileId);
    states.remove(profileId);
  }

  @override
  Future<String?> loadActiveProfileId() async => activeId;
  @override
  Future<List<MusicProfile>> loadProfiles() async => values.values.toList();
  @override
  Future<Map<String, dynamic>> loadState(String profileId) async =>
      states[profileId] ?? {};
  @override
  Future<void> saveActiveProfileId(String profileId) async =>
      activeId = profileId;
  @override
  Future<void> saveProfile(MusicProfile profile) async =>
      values[profile.id] = profile;
  @override
  Future<void> saveState(String profileId, Map<String, dynamic> state) async =>
      states[profileId] = state;
}

class _RecordingLifecycle implements ProfileLifecycleCoordinator {
  final deactivated = <String>[];
  final activatedState = <String, Map<String, dynamic>>{};
  @override
  Future<void> activate(
      MusicProfile profile, Map<String, dynamic> savedState) async {
    activatedState[profile.id] = savedState;
  }

  @override
  Future<Map<String, dynamic>> deactivate(MusicProfile profile) async {
    deactivated.add(profile.id);
    return {'queue': profile.id};
  }
}
