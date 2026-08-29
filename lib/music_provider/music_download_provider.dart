import 'models/playback_source.dart';
import 'models/provider_entities.dart';

/// Optional provider capability for an explicitly authorized offline copy.
/// Playback and downloads may use different URLs, formats and expiry rules.
abstract interface class MusicDownloadProvider {
  Future<PlaybackSource> getDownload(
    ProviderTrack track, {
    required String format,
  });
}
