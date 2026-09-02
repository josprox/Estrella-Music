import 'music_provider.dart';
import 'models/provider_entities.dart';

/// Metadata returned by an online music provider and safe to associate with a
/// local song after the user confirms the match.
class TrackMetadataCandidate {
  const TrackMetadataCandidate({
    required this.sourceId,
    required this.title,
    required this.artist,
    required this.album,
    this.albumArtist,
    this.duration,
    this.artworkUri,
    this.year,
    this.genre,
    this.trackNumber,
  });

  final String sourceId;
  final String title;
  final String artist;
  final String album;
  final String? albumArtist;
  final Duration? duration;
  final Uri? artworkUri;
  final int? year;
  final String? genre;
  final int? trackNumber;
}

/// Optional capability for providers whose songs can receive metadata
/// overrides.
/// Controllers consume this contract instead of checking a concrete provider.
abstract interface class MusicMetadataEditor {
  String suggestedMetadataQuery(ProviderTrack track);

  Future<ProviderTrack> applyMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  );
}

enum AutomaticMetadataLookupOutcome { noMatch, error }

/// Optional capability used by the catalog to enrich incomplete local songs
/// in the background without replacing a user's manual choice.
abstract interface class AutomaticMusicMetadataEditor {
  bool shouldLookupMetadataAutomatically(ProviderTrack track);

  Future<ProviderTrack> applyAutomaticMetadata(
    ProviderTrack track,
    TrackMetadataCandidate candidate,
  );

  Future<void> recordAutomaticMetadataLookup(
    ProviderTrack track,
    AutomaticMetadataLookupOutcome outcome,
  );
}

/// A metadata-only online source. It remains a [MusicProvider] so all remote
/// music data still enters through the provider boundary, but it is not a
/// playable profile and never receives Joss Red credentials.
abstract interface class MusicMetadataSearchProvider implements MusicProvider {
  Future<List<TrackMetadataCandidate>> searchMetadata(
    String query, {
    int limit = 20,
  });
}
