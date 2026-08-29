import 'dart:async';

import 'package:get/get.dart';

import 'package:harmonymusic/music_provider/music_provider_manager.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';

import 'music_profile.dart';
import 'profile_persistence.dart';
import 'profile_storage_namespace.dart';

abstract interface class ProfileLifecycleCoordinator {
  Future<Map<String, dynamic>> deactivate(MusicProfile profile);
  Future<void> activate(MusicProfile profile, Map<String, dynamic> savedState);
}

class NoopProfileLifecycleCoordinator implements ProfileLifecycleCoordinator {
  const NoopProfileLifecycleCoordinator();

  @override
  Future<Map<String, dynamic>> deactivate(MusicProfile profile) async =>
      const {};

  @override
  Future<void> activate(
      MusicProfile profile, Map<String, dynamic> savedState) async {}
}

typedef ProfileIdGenerator = String Function();

class ProfileManager extends GetxService {
  ProfileManager({
    required MusicProviderManager providerManager,
    required ProfilePersistence persistence,
    ProfileLifecycleCoordinator lifecycle =
        const NoopProfileLifecycleCoordinator(),
    ProfileIdGenerator? idGenerator,
  })  : _providerManager = providerManager,
        _persistence = persistence,
        _lifecycle = lifecycle,
        _idGenerator = idGenerator ??
            (() => 'profile-${DateTime.now().microsecondsSinceEpoch}');

  static const defaultLocalProfileId = 'local-default';

  final MusicProviderManager _providerManager;
  final ProfilePersistence _persistence;
  final ProfileLifecycleCoordinator _lifecycle;
  final ProfileIdGenerator _idGenerator;

  final profiles = <MusicProfile>[].obs;
  final activeProfile = Rxn<MusicProfile>();
  final isSwitching = false.obs;
  final lastError = ''.obs;

  Future<void> initialize() async {
    final loaded = await _persistence.loadProfiles();
    profiles.assignAll(loaded);
    var local = _fallbackProfile;
    if (local == null) {
      local = MusicProfile(
        id: defaultLocalProfileId,
        name: 'Local',
        providerId: _providerManager.localProviderId,
        isFallback: true,
      );
      profiles.add(local);
      await _persistence.saveProfile(local);
    }

    final savedId = await _persistence.loadActiveProfileId();
    final requested = _find(savedId) ?? local;
    if (!await _activateAtStartup(requested)) {
      await _activateAtStartup(local);
    }
  }

  MusicProfile? get _fallbackProfile {
    for (final profile in profiles) {
      if (profile.isFallback ||
          profile.providerId == _providerManager.localProviderId) {
        return profile;
      }
    }
    return null;
  }

  MusicProfile? _find(String? profileId) {
    if (profileId == null) return null;
    for (final profile in profiles) {
      if (profile.id == profileId) return profile;
    }
    return null;
  }

  Future<bool> _activateAtStartup(MusicProfile profile) async {
    if (!_providerManager.isRegistered(profile.providerId)) {
      await _markUnavailable(
        profile,
        MusicProfileAvailability.providerUnavailable,
        'Provider ${profile.providerId} is not installed',
      );
      return false;
    }
    try {
      await _providerManager.activate(
        profileId: profile.id,
        providerId: profile.providerId,
        settings: profile.settings,
      );
      await ProfileStorageNamespace.activateAndOpen(
        profileId: profile.id,
        providerId: profile.providerId,
      );
      final available = profile.copyWith(
        availability: MusicProfileAvailability.available,
        clearError: true,
      );
      _replace(available);
      activeProfile.value = available;
      await _persistence.saveProfile(available);
      await _persistence.saveActiveProfileId(profile.id);
      await _lifecycle.activate(
          available, await _persistence.loadState(profile.id));
      return true;
    } catch (error) {
      await _markUnavailable(
        profile,
        MusicProfileAvailability.initializationFailed,
        error.toString(),
      );
      return false;
    }
  }

  Future<MusicProfile> createProfile({
    required String name,
    required String providerId,
    Map<String, dynamic> settings = const {},
    Map<String, dynamic> metadata = const {},
  }) async {
    if (!_providerManager.isRegistered(providerId)) {
      throw StateError('Provider is not registered: $providerId');
    }
    final profile = MusicProfile(
      id: _idGenerator(),
      name: name.trim().isEmpty ? 'Profile' : name.trim(),
      providerId: providerId,
      settings: Map.unmodifiable(settings),
      metadata: Map.unmodifiable(metadata),
    );
    profiles.add(profile);
    await _persistence.saveProfile(profile);
    return profile;
  }

  Future<void> saveProfile(MusicProfile profile) async {
    _replace(profile);
    if (activeProfile.value?.id == profile.id) activeProfile.value = profile;
    await _persistence.saveProfile(profile);
  }

  Future<void> renameProfile(String profileId, String name) async {
    final profile = _find(profileId);
    if (profile == null) throw StateError('Unknown profile: $profileId');
    final renamed = profile.copyWith(name: name.trim());
    _replace(renamed);
    if (activeProfile.value?.id == profileId) activeProfile.value = renamed;
    await _persistence.saveProfile(renamed);
  }

  Future<void> deleteProfile(String profileId) async {
    final profile = _find(profileId);
    if (profile == null) return;
    if (profile.isFallback || profile.id == _fallbackProfile?.id) {
      throw StateError('The fallback local profile cannot be deleted');
    }
    if (activeProfile.value?.id == profileId) {
      await switchProfile(_fallbackProfile!.id);
    }
    await _providerManager.deactivate(profileId);
    profiles.removeWhere((item) => item.id == profileId);
    await _persistence.deleteProfile(profileId);
  }

  Future<void> switchProfile(String profileId) async {
    if (isSwitching.value || activeProfile.value?.id == profileId) return;
    final next = _find(profileId);
    if (next == null) throw StateError('Unknown profile: $profileId');
    if (!_providerManager.isRegistered(next.providerId)) {
      await _markUnavailable(
        next,
        MusicProfileAvailability.providerUnavailable,
        'Provider ${next.providerId} is not installed',
      );
      throw StateError('Provider ${next.providerId} is not installed');
    }

    isSwitching.value = true;
    lastError.value = '';
    final previous = activeProfile.value;
    try {
      if (Get.isRegistered<PlayerController>()) {
        try {
          Get.find<PlayerController>().closePlayer();
        } catch (_) {}
      }
      if (previous != null) {
        final state = await _lifecycle.deactivate(previous);
        await _persistence.saveState(previous.id, state);
      }
      await _providerManager.activate(
        profileId: next.id,
        providerId: next.providerId,
        settings: next.settings,
      );
      await ProfileStorageNamespace.activateAndOpen(
        profileId: next.id,
        providerId: next.providerId,
      );
      final available = next.copyWith(
        availability: MusicProfileAvailability.available,
        clearError: true,
      );
      _replace(available);
      activeProfile.value = available;
      await _persistence.saveProfile(available);
      await _persistence.saveActiveProfileId(available.id);
      await _lifecycle.activate(
          available, await _persistence.loadState(available.id));
      if (previous != null) await _providerManager.deactivate(previous.id);
      if (activeProfileMaySync && Get.isRegistered<SyncService>()) {
        unawaited(Get.find<SyncService>().pull());
      }
    } catch (error) {
      lastError.value = error.toString();
      await _markUnavailable(
        next,
        MusicProfileAvailability.initializationFailed,
        error.toString(),
      );
      if (previous != null) {
        await _providerManager.activate(
          profileId: previous.id,
          providerId: previous.providerId,
          settings: previous.settings,
        );
        await ProfileStorageNamespace.activateAndOpen(
          profileId: previous.id,
          providerId: previous.providerId,
        );
        activeProfile.value = previous;
        await _lifecycle.activate(
            previous, await _persistence.loadState(previous.id));
      }
      rethrow;
    } finally {
      isSwitching.value = false;
    }
  }

  Future<void> _markUnavailable(
    MusicProfile profile,
    MusicProfileAvailability availability,
    String message,
  ) async {
    final unavailable = profile.copyWith(
      availability: availability,
      errorMessage: message,
    );
    _replace(unavailable);
    await _persistence.saveProfile(unavailable);
  }

  void _replace(MusicProfile profile) {
    final index = profiles.indexWhere((item) => item.id == profile.id);
    if (index == -1) {
      profiles.add(profile);
    } else {
      profiles[index] = profile;
    }
  }

  bool get activeProfileMaySync {
    final profile = activeProfile.value;
    if (profile == null) return false;
    return _providerManager.instanceForProfile(profile.id)?.mayUseJossRedSync ==
        true;
  }

  @override
  void onClose() {
    final profile = activeProfile.value;
    if (profile != null) unawaited(_providerManager.deactivate(profile.id));
    super.onClose();
  }
}
