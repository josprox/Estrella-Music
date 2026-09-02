import 'dart:async';

import 'package:dio/dio.dart';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_metadata_editor.dart';
import '../music_provider.dart';

/// Public, account-free metadata lookup backed by MusicBrainz and the Cover
/// Art Archive. This provider never handles playback or Joss Red credentials.
class MusicBrainzMetadataProvider implements MusicMetadataSearchProvider {
  MusicBrainzMetadataProvider({
    Dio? client,
    Duration minimumRequestInterval = const Duration(milliseconds: 1100),
    DateTime Function()? clock,
  })  : _client = client ?? Dio(),
        _ownsClient = client == null,
        _minimumRequestInterval = minimumRequestInterval,
        _clock = clock ?? DateTime.now;

  static const providerId = 'metadata.musicbrainz';
  static const _endpoint = 'https://musicbrainz.org/ws/2/recording';
  static const _userAgent =
      'EstrellaMusic/2.4.0 (https://github.com/josprox/Estrella-Music)';
  static const _cacheLifetime = Duration(minutes: 15);

  final Dio _client;
  final bool _ownsClient;
  final Duration _minimumRequestInterval;
  final DateTime Function() _clock;
  final Map<String, _MetadataCacheEntry> _cache = {};
  Future<void> _requestTail = Future<void>.value();
  DateTime? _lastRequestAt;
  String _profileId = 'public-metadata';

  @override
  String get id => providerId;

  @override
  String get displayName => 'MusicBrainz';

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
            'query': normalized,
            'fmt': 'json',
            'limit': limit.clamp(1, 20),
          },
          options: Options(
            headers: const {
              'Accept': 'application/json',
              'User-Agent': _userAgent,
            },
            sendTimeout: const Duration(seconds: 12),
            receiveTimeout: const Duration(seconds: 12),
          ),
        );
        final root = _map(response.data);
        final seen = <String>{};
        final candidates = <TrackMetadataCandidate>[];
        for (final recording in _list(root['recordings'])) {
          final candidate = _candidate(recording);
          if (candidate == null || !seen.add(candidate.sourceId)) continue;
          candidates.add(candidate);
        }
        final immutable = List<TrackMetadataCandidate>.unmodifiable(candidates);
        if (_cache.length >= 50) _cache.remove(_cache.keys.first);
        _cache[cacheKey] = _MetadataCacheEntry(immutable, _clock());
        return immutable;
      } on DioException catch (error) {
        throw MusicProviderException(
          'Unable to reach the public metadata catalog',
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

  TrackMetadataCandidate? _candidate(Map<String, dynamic> recording) {
    final recordingId = _text(recording['id']);
    final title = _text(recording['title']);
    if (recordingId == null || title == null) return null;

    final artist = _artistCredit(recording['artist-credit']);
    final releases = _list(recording['releases']);
    final release = _preferredRelease(releases);
    final releaseGroup = _map(release?['release-group']);
    final releaseGroupId = _text(releaseGroup['id']);
    final album = _text(releaseGroup['title']) ??
        _text(release?['title']) ??
        'Unknown album';
    final firstReleaseDate =
        _text(recording['first-release-date']) ?? _text(release?['date']);

    return TrackMetadataCandidate(
      sourceId: 'musicbrainz:$recordingId',
      title: title,
      artist: artist ?? 'Unknown artist',
      album: album,
      albumArtist: artist,
      duration: _milliseconds(recording['length']),
      artworkUri: releaseGroupId == null
          ? null
          : Uri.parse(
              'https://coverartarchive.org/release-group/'
              '$releaseGroupId/front-500',
            ),
      year: _year(firstReleaseDate),
      trackNumber: _trackNumber(release, recordingId),
    );
  }

  Map<String, dynamic>? _preferredRelease(
    List<Map<String, dynamic>> releases,
  ) {
    if (releases.isEmpty) return null;
    for (final release in releases) {
      if (_text(release['status']) == 'Official' &&
          _map(release['release-group']).isNotEmpty) {
        return release;
      }
    }
    return releases.first;
  }

  String? _artistCredit(dynamic raw) {
    final credits = _list(raw);
    if (credits.isEmpty) return null;
    final buffer = StringBuffer();
    for (final credit in credits) {
      final name =
          _text(credit['name']) ?? _text(_map(credit['artist'])['name']);
      if (name == null) continue;
      buffer.write(name);
      buffer.write(credit['joinphrase']?.toString() ?? '');
    }
    return _text(buffer.toString());
  }

  int? _trackNumber(Map<String, dynamic>? release, String recordingId) {
    if (release == null) return null;
    for (final medium in _list(release['media'])) {
      for (final track in _list(medium['track'])) {
        final linkedRecording = _text(_map(track['recording'])['id']);
        if (linkedRecording != null && linkedRecording != recordingId) continue;
        final value = _text(track['number']) ?? _text(track['position']);
        final numeric = value == null
            ? null
            : int.tryParse(RegExp(r'\d+').firstMatch(value)?.group(0) ?? '');
        if (numeric != null) return numeric;
      }
    }
    return null;
  }

  Duration? _milliseconds(dynamic value) {
    final milliseconds =
        value is num ? value.toInt() : int.tryParse(value?.toString() ?? '');
    return milliseconds == null ? null : Duration(milliseconds: milliseconds);
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

class _MetadataCacheEntry {
  const _MetadataCacheEntry(this.values, this.createdAt);

  final List<TrackMetadataCandidate> values;
  final DateTime createdAt;

  bool isExpired(DateTime now) =>
      now.difference(createdAt) > MusicBrainzMetadataProvider._cacheLifetime;
}
