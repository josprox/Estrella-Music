import 'models/music_identity.dart';

/// Optional lifecycle hook for providers that cache expiring media sources.
/// The catalog facade uses it after a source is rejected by the media origin.
abstract interface class MusicSourceCacheControl {
  void invalidatePlaybackSource(MusicIdentity identity);

  void invalidateDownloadSource(
    MusicIdentity identity, {
    required String format,
  });
}
