import 'dart:async';

import 'package:dio/dio.dart';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_metadata_editor.dart';
import '../music_provider.dart';

/// Public, account-free metadata and artwork lookup backed by the Apple iTunes
/// Search API. Provides fast responses and high-resolution cover art (600x600)
/// without requiring API keys or user credentials.
class ItunesMetadataProvider implements MusicMetadataSearchProvider {
  ItunesMetadataProvider({
    Dio? client,
    Duration minimumRequestInterval = const Duration(milliseconds: 250),
    DateTime Function()? clock,
  })  : _client = client ?? Dio(),
        _ownsClient = client == null,
        _minimumRequestInterval = minimumRequestInterval,
        _clock = clock ?? DateTime.now;

  static const providerId = 'metadata.itunes';
  static const _endpoint = 'https://itunes.apple.com/search';
  static const _userAgent =
      'EstrellaMusic/2.4.0 (https://github.com/josprox/Estrella-Music)';
  static const _cacheLifetime = Duration(minutes: 30);

  final Dio _client;
  final bool _ownsClient;
  final Duration _minimumRequestInterval;
  final DateTime Function() _clock;
  final Map<String, _ItunesCacheEntry> _cache = {};
  Future<void> _requestTail = Future<void>.value();
  DateTime? _lastRequestAt;
  String _profileId = 'public-metadata';

  @override
  String get id => providerId;

  @override
  String get displayName => 'iTunes';

  @override
  ProviderCapabilities get capabilities => const ProviderCapabilities(
        search: true,
        artwork: true,
      );

  @override
  Future<void> initialize(MusicProviderContext context) async {
    _profileId = context.profileId;
  }

  @override
  Future<List<TrackMetadataCandidate>> searchMetadata(
    String query, {
    int limit = 20,
  }) async {
    final normalized = query.trim();
    if (normalized.isEmpty) return const [];
    final cacheKey = normalized.toLowerCase();
    final cached = _cache[cacheKey];
    if (cached != null && !cached.isExpired(_clock())) {
      return cached.values;
    }

    final turn = Completer<void>();
    final previous = _requestTail;
    _requestTail = turn.future;
    try {
      try {
        await previous;
      } catch (_) {}
      final cachedAfterWait = _cache[cacheKey];
      if (cachedAfterWait != null && !cachedAfterWait.isExpired(_clock())) {
        return cachedAfterWait.values;
      }

      await _respectRateLimit();
      try {
        final response = await _client.get<dynamic>(
          _endpoint,
          queryParameters: {
            'term': normalized,
            'entity': 'song',
            'media': 'music',
            'limit': limit.clamp(1, 25),
          },
          options: Options(
            headers: const {
              'Accept': 'application/json',
              'User-Agent': _userAgent,
            },
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );
        final root = _map(response.data);
        final seen = <String>{};
        final candidates = <TrackMetadataCandidate>[];
        for (final item in _list(root['results'])) {
          final candidate = _candidate(item);
          if (candidate == null || !seen.add(candidate.sourceId)) continue;
          candidates.add(candidate);
        }
        final immutable = List<TrackMetadataCandidate>.unmodifiable(candidates);
        if (_cache.length >= 100) _cache.remove(_cache.keys.first);
        _cache[cacheKey] = _ItunesCacheEntry(immutable, _clock());
        return immutable;
      } on DioException catch (error) {
        throw MusicProviderException(
          'Unable to reach the iTunes metadata catalog',
          cause: error,
        );
      }
    } finally {
      turn.complete();
    }
  }

  Future<void> _respectRateLimit() async {
    final previous = _lastRequestAt;
    if (previous != null) {
      final remaining = _minimumRequestInterval - _clock().difference(previous);
      if (remaining > Duration.zero) await Future<void>.delayed(remaining);
    }
    _lastRequestAt = _clock();
  }

  TrackMetadataCandidate? _candidate(Map<String, dynamic> item) {
    final trackId = item['trackId']?.toString();
    final trackName = _text(item['trackName']);
    if (trackId == null || trackName == null) return null;

    final artistName = _text(item['artistName']) ?? 'Unknown artist';
    final collectionName = _text(item['collectionName']) ?? 'Unknown album';
    final releaseDateStr = _text(item['releaseDate']);
    final durationMillis = item['trackTimeMillis'];
    final artworkUrl = _text(item['artworkUrl100']) ??
        _text(item['artworkUrl60']) ??
        _text(item['artworkUrl30']);

    Uri? highResArtworkUri;
    if (artworkUrl != null) {
      // iTunes provides 100x100 thumbnail; replace sizing for 600x600 high resolution cover
      final highResUrl = artworkUrl
          .replaceAll('100x100bb.jpg', '600x600bb.jpg')
          .replaceAll('100x100bb.png', '600x600bb.png')
          .replaceAll('100x100', '600x600');
      highResArtworkUri = Uri.tryParse(highResUrl) ?? Uri.tryParse(artworkUrl);
    }

    return TrackMetadataCandidate(
      sourceId: 'itunes:$trackId',
      title: trackName,
      artist: artistName,
      album: collectionName,
      albumArtist: artistName,
      duration: durationMillis is num
          ? Duration(milliseconds: durationMillis.toInt())
          : null,
      artworkUri: highResArtworkUri,
      year: _year(releaseDateStr),
      trackNumber: item['trackNumber'] is num
          ? (item['trackNumber'] as num).toInt()
          : null,
      genre: _text(item['primaryGenreName']),
    );
  }

  int? _year(String? value) {
    if (value == null || value.length < 4) return null;
    return int.tryParse(value.substring(0, 4));
  }

  String? _text(dynamic value) {
    final result = value?.toString().trim();
    return result == null || result.isEmpty || result == 'null' ? null : result;
  }

  Map<String, dynamic> _map(dynamic value) => value is Map
      ? value.map((key, item) => MapEntry(key.toString(), item))
      : const {};

  List<Map<String, dynamic>> _list(dynamic value) => value is List
      ? value.map(_map).where((item) => item.isNotEmpty).toList(growable: false)
      : const [];

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
  Future<void> refresh() async => _cache.clear();
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
    _cache.clear();
    if (_ownsClient) _client.close(force: true);
  }
}

class _ItunesCacheEntry {
  const _ItunesCacheEntry(this.values, this.createdAt);

  final List<TrackMetadataCandidate> values;
  final DateTime createdAt;

  bool isExpired(DateTime now) =>
      now.difference(createdAt) > ItunesMetadataProvider._cacheLifetime;
}
