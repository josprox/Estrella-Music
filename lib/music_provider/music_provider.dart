import 'models/music_identity.dart';
import 'models/playback_source.dart';
import 'models/provider_capabilities.dart';
import 'models/provider_entities.dart';

class MusicProviderException implements Exception {
  const MusicProviderException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => cause == null ? message : '$message: $cause';
}

class MusicProviderContext {
  const MusicProviderContext({
    required this.profileId,
    this.settings = const {},
  });

  final String profileId;
  final Map<String, dynamic> settings;
}

abstract interface class MusicProvider {
  String get id;
  String get displayName;
  ProviderCapabilities get capabilities;

  Future<void> initialize(MusicProviderContext context);
  Future<void> refresh() async {}
  Future<void> dispose();

  Future<ProviderSearchResults> search(String query);
  Future<List<ProviderTrack>> getTracks();
  Future<ProviderTrack?> getTrack(String sourceId);
  Future<List<ProviderAlbum>> getAlbums();
  Future<ProviderAlbum?> getAlbum(String sourceId);
  Future<List<ProviderArtist>> getArtists();
  Future<ProviderArtist?> getArtist(String sourceId);
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity);
  Future<ProviderLyrics?> getLyrics(ProviderTrack track);
  Future<PlaybackSource> getPlayback(ProviderTrack track);
}
