import 'dart:async';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_metadata_editor.dart';
import '../music_provider.dart';
import 'itunes_metadata_provider.dart';
import 'musicbrainz_metadata_provider.dart';

/// Composite public metadata provider that queries the fast and high-resolution
/// iTunes Search API as the primary source, with MusicBrainz as fallback.
class CompositeMetadataProvider implements MusicMetadataSearchProvider {
  CompositeMetadataProvider({
    MusicMetadataSearchProvider? primary,
    MusicMetadataSearchProvider? fallback,
  })  : _primary = primary ?? ItunesMetadataProvider(),
        _fallback = fallback ?? MusicBrainzMetadataProvider();

  static const providerId = 'metadata.composite';

  final MusicMetadataSearchProvider _primary;
  final MusicMetadataSearchProvider _fallback;
  String _profileId = 'public-metadata';

  @override
  String get id => providerId;

  @override
  String get displayName => 'Public Metadata';

  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(
        search: true,
        artwork: true,
      );

  @override
  Future<void> initialize(MusicProviderContext context) async {
    _profileId = context.profileId;
    await Future.wait([
      _primary.initialize(context),
      _fallback.initialize(context),
    ]);
  }

  @override
  Future<List<TrackMetadataCandidate>> searchMetadata(
    String query, {
    int limit = 20,
  }) async {
    final normalized = query.trim();
    if (normalized.isEmpty) return const [];

    try {
      final primaryResults = await _primary.searchMetadata(
        normalized,
        limit: limit,
      );
      if (primaryResults.isNotEmpty) {
        return primaryResults;
      }
    } catch (_) {
      // Primary search failed, fallback to secondary
    }

    try {
      return await _fallback.searchMetadata(
        normalized,
        limit: limit,
      );
    } catch (error) {
      // If both failed, rethrow or return empty
      return const [];
    }
  }

  @override
  Future<ProviderSearchResults> search(String query) async {
    final candidates = await searchMetadata(query);
    return ProviderSearchResults(
      tracks: candidates
          .map(
            (candidate) => ProviderTrack(
              identity: MusicIdentity(
                providerId: id,
                profileId: _profileId,
                sourceId: candidate.sourceId,
              ),
              title: candidate.title,
              artist: candidate.artist,
              album: candidate.album,
              duration: candidate.duration,
              artworkUri: candidate.artworkUri,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> refresh() async {
    await Future.wait([
      _primary.refresh(),
      _fallback.refresh(),
    ]);
  }

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
  Future<PlaybackSource> getPlayback(ProviderTrack track) =>
      throw const MusicProviderException(
        'The public metadata provider does not expose playback',
      );

  @override
  Future<void> dispose() async {
    await Future.wait([
      _primary.dispose(),
      _fallback.dispose(),
    ]);
  }
}
