import 'dart:async';

import 'package:get/get.dart';

import 'music_provider.dart';
import 'models/provider_capabilities.dart';

typedef MusicProviderFactory = MusicProvider Function();

enum ProviderTrust { local, jossRedAuthorized, community }

class ProviderRegistration {
  const ProviderRegistration({
    required this.id,
    required this.displayName,
    required this.factory,
    required this.trust,
  });

  final String id;
  final String displayName;
  final MusicProviderFactory factory;
  final ProviderTrust trust;
}

class ProviderInstance {
  const ProviderInstance({
    required this.profileId,
    required this.registration,
    required this.provider,
  });

  final String profileId;
  final ProviderRegistration registration;
  final MusicProvider provider;

  ProviderCapabilities get capabilities => provider.capabilities;
  bool get mayUseJossRedSync =>
      registration.trust == ProviderTrust.jossRedAuthorized &&
      capabilities.sync;
}

class MusicProviderManager extends GetxService {
  MusicProviderManager({required this.localProviderId});

  final String localProviderId;
  final Map<String, ProviderRegistration> _registrations = {};
  final Map<String, ProviderInstance> _instancesByProfile = {};
  final availableProviderIds = <String>[].obs;

  void register(ProviderRegistration registration) {
    if (_registrations.containsKey(registration.id)) {
      throw StateError('Provider already registered: ${registration.id}');
    }
    _registrations[registration.id] = registration;
    availableProviderIds.assignAll(_registrations.keys);
  }

  bool isRegistered(String providerId) =>
      _registrations.containsKey(providerId);

  ProviderRegistration? registrationFor(String providerId) =>
      _registrations[providerId];

  Future<ProviderInstance> activate({
    required String profileId,
    required String providerId,
    Map<String, dynamic> settings = const {},
  }) async {
    final registration = _registrations[providerId];
    if (registration == null) {
      throw MusicProviderException('Provider is not registered: $providerId');
    }

    final previous = _instancesByProfile.remove(profileId);
    if (previous != null) await previous.provider.dispose();

    final provider = registration.factory();
    try {
      await provider.initialize(
        MusicProviderContext(profileId: profileId, settings: settings),
      );
    } catch (error) {
      await provider.dispose();
      throw MusicProviderException(
        'Provider $providerId failed to initialize',
        cause: error,
      );
    }

    final instance = ProviderInstance(
      profileId: profileId,
      registration: registration,
      provider: provider,
    );
    _instancesByProfile[profileId] = instance;
    return instance;
  }

  ProviderInstance? instanceForProfile(String profileId) =>
      _instancesByProfile[profileId];

  Future<void> deactivate(String profileId) async {
    final current = _instancesByProfile.remove(profileId);
    if (current != null) await current.provider.dispose();
  }

  @override
  void onClose() {
    for (final instance in _instancesByProfile.values) {
      unawaited(instance.provider.dispose());
    }
    _instancesByProfile.clear();
    super.onClose();
  }
}
