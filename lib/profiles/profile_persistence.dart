import 'package:estrella_music/services/storage/sqlite_store.dart';

import 'music_profile.dart';

abstract interface class ProfilePersistence {
  Future<List<MusicProfile>> loadProfiles();
  Future<void> saveProfile(MusicProfile profile);
  Future<void> deleteProfile(String profileId);
  Future<String?> loadActiveProfileId();
  Future<void> saveActiveProfileId(String profileId);
  Future<Map<String, dynamic>> loadState(String profileId);
  Future<void> saveState(String profileId, Map<String, dynamic> state);
}

class SqliteProfilePersistence implements ProfilePersistence {
  static const profilesBox = 'MusicProfiles';
  static const profileStateBox = 'MusicProfileState';
  static const activeProfileKey = 'activeMusicProfileId';

  @override
  Future<List<MusicProfile>> loadProfiles() async {
    final box = await SqliteStore.openBox(profilesBox);
    return box.values
        .whereType<Map>()
        .map((value) => MusicProfile.fromJson(
              value.map((key, item) => MapEntry(key.toString(), item)),
            ))
        .where((profile) => profile.id.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<void> saveProfile(MusicProfile profile) async {
    await (await SqliteStore.openBox(profilesBox))
        .put(profile.id, profile.toJson());
  }

  @override
  Future<void> deleteProfile(String profileId) async {
    await (await SqliteStore.openBox(profilesBox)).delete(profileId);
    await (await SqliteStore.openBox(profileStateBox)).delete(profileId);
  }

  @override
  Future<String?> loadActiveProfileId() async =>
      (await SqliteStore.openBox('AppPrefs')).get(activeProfileKey)?.toString();

  @override
  Future<void> saveActiveProfileId(String profileId) async {
    await (await SqliteStore.openBox('AppPrefs'))
        .put(activeProfileKey, profileId);
  }

  @override
  Future<Map<String, dynamic>> loadState(String profileId) async {
    final value = (await SqliteStore.openBox(profileStateBox)).get(profileId);
    return value is Map
        ? value.map((key, item) => MapEntry(key.toString(), item))
        : <String, dynamic>{};
  }

  @override
  Future<void> saveState(String profileId, Map<String, dynamic> state) async {
    await (await SqliteStore.openBox(profileStateBox)).put(profileId, state);
  }
}
