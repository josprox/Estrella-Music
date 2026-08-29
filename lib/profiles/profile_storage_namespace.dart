import 'package:harmonymusic/services/storage/sqlite_store.dart';

class ProfileStorageNamespace {
  static String? _activeProfileId;
  static String _activeProviderId = localProviderId;

  static const localProviderId = 'estrella.local';

  static const _globalBoxes = {
    'appprefs',
    'musicprofiles',
    'musicprofilestate',
  };

  static String? get activeProfileId => _activeProfileId;
  static String get activeProviderId => _activeProviderId;

  static void activate(
    String profileId, {
    String providerId = localProviderId,
  }) {
    _activeProfileId = profileId;
    _activeProviderId = providerId;
  }

  static MusicStoreBackend backendFor(String logicalName) {
    final normalized = logicalName.trim().toLowerCase();
    if (_globalBoxes.contains(normalized)) return MusicStoreBackend.hive;
    return _activeProviderId == localProviderId
        ? MusicStoreBackend.hive
        : MusicStoreBackend.sqlite;
  }

  static Future<void> activateAndOpen({
    required String profileId,
    required String providerId,
  }) async {
    activate(profileId, providerId: providerId);
    if (!SqliteStore.isInitialized) return;
    if (providerId == localProviderId) {
      await SqliteStore.preserveLocalProfileInHive(profileId);
    }
    for (final boxName in const [
      'SongsCache',
      'SongDownloads',
      'SongsUrlCache',
      'LIBFAV',
      'LIBRP',
      'LibraryArtists',
      'LibraryAlbums',
      'LibraryPlaylists',
      'homeScreenData',
      'prevSessionData',
      'PendingSyncChanges',
    ]) {
      await SqliteStore.openBox(boxName);
    }
  }

  static String resolve(String logicalName) {
    final normalized = logicalName.trim().toLowerCase();
    final profileId = _activeProfileId;
    if (profileId == null || _globalBoxes.contains(normalized)) {
      return logicalName;
    }
    return 'profiles__${_safe(profileId)}__$logicalName';
  }

  static String _safe(String value) =>
      value.toLowerCase().replaceAll(RegExp(r'[^a-z0-9_.-]'), '_');
}
