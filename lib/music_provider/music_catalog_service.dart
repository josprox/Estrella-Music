import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:estrella_music/models/album.dart';
import 'package:estrella_music/models/artist.dart';
import 'package:estrella_music/music_provider/models/music_identity.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/music_provider/models/provider_capabilities.dart';
import 'package:estrella_music/music_provider/models/provider_entities.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

import 'music_provider.dart';
import 'music_download_provider.dart';
import 'music_discovery_provider.dart';
import 'music_metadata_editor.dart';
import 'music_provider_manager.dart';
import 'music_source_cache_control.dart';

/// Provider-neutral application facade used by controllers and playback.
class MusicCatalogService extends GetxService {
  MusicCatalogService({
    required MusicProviderManager providerManager,
    required ProfileManager profileManager,
    required MusicMetadataSearchProvider metadataProvider,
  })  : _providerManager = providerManager,
        _profileManager = profileManager,
        _metadataProvider = metadataProvider;

  final MusicProviderManager _providerManager;
  final ProfileManager _profileManager;
  final MusicMetadataSearchProvider _metadataProvider;
  Future<void>? _metadataProviderReady;
  Worker? _activeProfileWorker;
  int _automaticLookupGeneration = 0;

  final automaticMetadataRevision = 0.obs;
  final isAutomaticallyIdentifyingMetadata = false.obs;
  final automaticMetadataProgress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _activeProfileWorker = ever(
      _profileManager.activeProfile,
      (_) => _scheduleAutomaticMetadataLookup(),
    );
    _scheduleAutomaticMetadataLookup();
  }

  MusicProvider get provider {
    final profile = _profileManager.activeProfile.value;
    if (profile == null) {
      throw const MusicProviderException('No active music profile');
    }
    final instance = _providerManager.instanceForProfile(profile.id);
    if (instance == null) {
      throw const MusicProviderException('Active provider is unavailable');
    }
    return instance.provider;
  }

  ProviderCapabilities get capabilities => provider.capabilities;
  MusicDiscoveryProvider? get _discoveryProvider {
    final active = provider;
    return active is MusicDiscoveryProvider
        ? active as MusicDiscoveryProvider
        : null;
  }

  String get activeProviderId => provider.id;
  String get activeProfileId => _profileManager.activeProfile.value!.id;

  Future<void> init() async {}

  Future<void> refresh() async {
    await provider.refresh();
    _scheduleAutomaticMetadataLookup();
  }

  void _scheduleAutomaticMetadataLookup() {
    final generation = ++_automaticLookupGeneration;
    Future<void>.microtask(
      () => _runAutomaticMetadataLookup(generation),
    );
  }

  Future<void> runAutomaticMetadataLookup() async {
    final generation = ++_automaticLookupGeneration;
    await _runAutomaticMetadataLookup(generation);
  }

  Future<void> _runAutomaticMetadataLookup(int generation) async {
    MusicProvider active;
    String profileId;
    try {
      active = provider;
      profileId = activeProfileId;
    } catch (_) {
      return;
    }
    if (active is! AutomaticMusicMetadataEditor ||
        active is! MusicMetadataEditor) {
      return;
    }
    final automaticEditor = active as AutomaticMusicMetadataEditor;
    final metadataEditor = active as MusicMetadataEditor;
    final tracks = await active.getTracks();
    final pending = tracks
        .where(automaticEditor.shouldLookupMetadataAutomatically)
        .toList(growable: false);
    if (pending.isEmpty || generation != _automaticLookupGeneration) return;

    isAutomaticallyIdentifyingMetadata.value = true;
    automaticMetadataProgress.value = 0;
    var completed = 0;
    var consecutiveErrors = 0;
    var matched = 0;
    var noMatches = 0;
    var errors = 0;
    debugPrint(
      '[LocalMetadata] Starting automatic lookup for ${pending.length} songs',
    );
    try {
      await (_metadataProviderReady ??= _metadataProvider.initialize(
        const MusicProviderContext(profileId: 'public-metadata'),
      ));
      for (final track in pending) {
        if (generation != _automaticLookupGeneration ||
            activeProfileId != profileId ||
            !identical(provider, active)) {
          return;
        }
        try {
          final query = metadataEditor.suggestedMetadataQuery(track).trim();
          if (query.isEmpty) {
            noMatches++;
            await automaticEditor.recordAutomaticMetadataLookup(
              track,
              AutomaticMetadataLookupOutcome.noMatch,
            );
          } else {
            final candidates = await _metadataProvider.searchMetadata(
              query,
              limit: 8,
            );
            consecutiveErrors = 0;
            if (generation != _automaticLookupGeneration) return;
            final latestTrack =
                await active.getTrack(track.identity.sourceId) ?? track;
            if (!automaticEditor
                .shouldLookupMetadataAutomatically(latestTrack)) {
              continue;
            }
            final match = _confidentAutomaticMatch(latestTrack, candidates);
            if (match == null) {
              noMatches++;
              await automaticEditor.recordAutomaticMetadataLookup(
                latestTrack,
                AutomaticMetadataLookupOutcome.noMatch,
              );
            } else {
              final updated = await automaticEditor.applyAutomaticMetadata(
                latestTrack,
                match,
              );
              matched++;
              automaticMetadataRevision.value++;
              consecutiveErrors = 0;
              debugPrint(
                '[LocalMetadata] Identified "${track.title}" as '
                '"${updated.title}" by ${updated.artist}',
              );
            }
          }
        } catch (error, stack) {
          consecutiveErrors++;
          errors++;
          debugPrint(
            '[LocalMetadata] Automatic lookup failed for ${track.title}: '
            '$error\n$stack',
          );
          try {
            await automaticEditor.recordAutomaticMetadataLookup(
              track,
              AutomaticMetadataLookupOutcome.error,
            );
          } catch (_) {}
          if (consecutiveErrors >= 6) {
            debugPrint(
              '[LocalMetadata] Automatic lookup paused after repeated errors',
            );
            break;
          }
        } finally {
          completed++;
          automaticMetadataProgress.value = completed / pending.length;
        }
      }
    } finally {
      if (generation == _automaticLookupGeneration) {
        isAutomaticallyIdentifyingMetadata.value = false;
      }
      debugPrint(
        '[LocalMetadata] Automatic lookup finished: '
        '$matched matched, $noMatches without a confident match, '
        '$errors errors',
      );
    }
  }

  TrackMetadataCandidate? _confidentAutomaticMatch(
    ProviderTrack local,
    List<TrackMetadataCandidate> candidates,
  ) {
    final ranked = candidates.toList()
      ..sort((a, b) => _metadataScore(
            mediaItemFromTrack(local),
            b,
          ).compareTo(_metadataScore(mediaItemFromTrack(local), a)));
    final localTitle = _metadataComparable(local.title);
    final localArtist = _metadataComparable(local.artist);
    for (final candidate in ranked) {
      final candTitle = _metadataComparable(candidate.title);
      final titleExact = candTitle == localTitle;
      final titleClose = titleExact ||
          candTitle.startsWith(localTitle) ||
          localTitle.startsWith(candTitle);
      if (!titleClose) continue;

      final durationMatches = local.duration == null ||
          candidate.duration == null ||
          (local.duration! - candidate.duration!).inSeconds.abs() <= 12;
      if (!durationMatches) continue;

      if (_isUnknownMetadataArtist(localArtist)) {
        if (titleExact ||
            (local.duration != null &&
                candidate.duration != null &&
                (local.duration! - candidate.duration!).inSeconds.abs() <= 5)) {
          return candidate;
        }
        continue;
      }
      if (_artistsOverlap(localArtist, candidate.artist)) return candidate;
    }
    return null;
  }

  bool _isUnknownMetadataArtist(String value) =>
      value.isEmpty ||
      value == 'unknown artist' ||
      value == 'artista desconocido';

  bool _artistsOverlap(String localArtist, String candidateArtist) {
    final localTokens = _metadataComparable(localArtist)
        .split(' ')
        .where((token) => token.length >= 3)
        .toSet();
    final candidateTokens = _metadataComparable(candidateArtist)
        .split(' ')
        .where((token) => token.length >= 3)
        .toSet();
    return localTokens.intersection(candidateTokens).isNotEmpty;
  }

  Future<List<ProviderTrack>> tracks() => provider.getTracks();
  Future<List<ProviderAlbum>> albums() => provider.getAlbums();
  Future<List<ProviderArtist>> artists() => provider.getArtists();
  Future<ProviderSearchResults> searchTyped(String query) =>
      provider.search(query);

  bool canEditMetadata(MediaItem item) {
    final active = provider;
    if (active is! MusicMetadataEditor) return false;
    final identity = identityFromMediaItem(item);
    return identity.providerId == activeProviderId &&
        identity.profileId == activeProfileId &&
        (item.extras?['url']?.toString().isNotEmpty ?? false);
  }

  Future<String> suggestedMetadataQuery(MediaItem item) async {
    final active = provider;
    if (active is! MusicMetadataEditor) {
      throw const MusicProviderException(
        'The active provider cannot edit metadata',
      );
    }
    final editor = active as MusicMetadataEditor;
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final track = await active.getTrack(identity.sourceId) ??
        _trackFromMediaItem(item, identity);
    return editor.suggestedMetadataQuery(track);
  }

  /// Searches an account-free public catalog. The metadata provider is kept
  /// outside profile registration and never receives Joss Red credentials.
  Future<List<TrackMetadataCandidate>> searchTrackMetadata(
    MediaItem localItem,
    String query,
  ) async {
    if (!canEditMetadata(localItem)) {
      throw const MusicProviderException(
        'Metadata identification is unavailable for this track',
      );
    }
    final normalized = query.trim();
    if (normalized.isEmpty) return const [];
    await (_metadataProviderReady ??= _metadataProvider.initialize(
      const MusicProviderContext(profileId: 'public-metadata'),
    ));
    final candidates = await _metadataProvider.searchMetadata(
      normalized,
      limit: 20,
    );
    return _rankMetadataCandidates(localItem, candidates);
  }

  Future<MediaItem> applyTrackMetadata(
    MediaItem item,
    TrackMetadataCandidate candidate,
  ) async {
    final active = provider;
    if (active is! MusicMetadataEditor) {
      throw const MusicProviderException(
        'The active provider cannot edit metadata',
      );
    }
    final editor = active as MusicMetadataEditor;
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final track = await active.getTrack(identity.sourceId) ??
        _trackFromMediaItem(item, identity);
    final updated = await editor.applyMetadata(track, candidate);
    automaticMetadataRevision.value++;
    return mediaItemFromTrack(updated);
  }

  ProviderTrack _trackFromMediaItem(
    MediaItem item,
    MusicIdentity identity,
  ) =>
      ProviderTrack(
        identity: identity,
        title: item.title,
        artist: item.artist ?? 'Unknown artist',
        album: item.album ?? 'Unknown album',
        duration: item.duration,
        artworkUri: item.artUri,
        filePath: item.extras?['url']?.toString(),
        metadata: item.extras ?? const {},
      );

  List<TrackMetadataCandidate> _rankMetadataCandidates(
    MediaItem localItem,
    List<TrackMetadataCandidate> candidates,
  ) {
    final ranked = candidates.toList();
    ranked.sort((a, b) =>
        _metadataScore(localItem, b).compareTo(_metadataScore(localItem, a)));
    return ranked;
  }

  int _metadataScore(MediaItem local, TrackMetadataCandidate candidate) {
    final localTitle = _metadataComparable(local.title);
    final candidateTitle = _metadataComparable(candidate.title);
    var score = localTitle == candidateTitle
        ? 100
        : (candidateTitle.contains(localTitle) ||
                localTitle.contains(candidateTitle)
            ? 50
            : 0);
    final localArtist = _metadataComparable(local.artist ?? '');
    final candidateArtist = _metadataComparable(candidate.artist);
    if (localArtist.isNotEmpty && localArtist == candidateArtist) score += 50;
    if (local.duration != null && candidate.duration != null) {
      final difference =
          (local.duration! - candidate.duration!).inSeconds.abs();
      if (difference <= 3) score += 25;
    }
    return score;
  }

  String _metadataComparable(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9áéíóúüñ]+'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  MediaItem mediaItemFromTrack(ProviderTrack track) => MediaItem(
        id: track.identity.sourceId,
        title: track.title,
        artist: track.artist,
        album: track.album,
        duration: track.duration,
        artUri: track.artworkUri?.scheme == 'data' ? null : track.artworkUri,
        extras: {
          'providerId': track.identity.providerId,
          'profileId': track.identity.profileId,
          'sourceId': track.identity.sourceId,
          'url': track.filePath,
          'album': {'name': track.album},
          'artists': [
            {'name': track.artist}
          ],
          'length':
              track.duration == null ? null : _durationLabel(track.duration!),
          ...track.metadata,
        },
      );

  Future<PlaybackSource> resolvePlayback(MediaItem item) async {
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final cacheKey = _sourceCacheKey(identity, 'stream');
    final cached = await _readCachedSource(cacheKey);
    if (cached != null) return cached;
    final track = ProviderTrack(
      identity: identity,
      title: item.title,
      artist: item.artist ?? 'Unknown artist',
      album: item.album ?? 'Unknown album',
      duration: item.duration,
      artworkUri: item.artUri,
      filePath: item.extras?['url']?.toString(),
      metadata: item.extras ?? const {},
    );
    final source = await provider.getPlayback(track);
    await _writeCachedSource(cacheKey, source);
    return source;
  }

  Future<PlaybackSource> resolveDownload(
    MediaItem item, {
    required String format,
  }) async {
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final cacheKey = _sourceCacheKey(identity, 'download|$format');
    final cached = await _readCachedSource(cacheKey);
    if (cached != null) return cached;
    final activeProvider = provider;
    if (activeProvider is! MusicDownloadProvider) {
      throw const MusicProviderException(
        'The active provider does not expose downloadable media',
      );
    }
    final track = ProviderTrack(
      identity: identity,
      title: item.title,
      artist: item.artist ?? 'Unknown artist',
      album: item.album ?? 'Unknown album',
      duration: item.duration,
      artworkUri: item.artUri,
      filePath: item.extras?['url']?.toString(),
      metadata: item.extras ?? const {},
    );
    final source = await (activeProvider as MusicDownloadProvider).getDownload(
      track,
      format: format,
    );
    await _writeCachedSource(cacheKey, source);
    return source;
  }

  Future<void> invalidatePlayback(MediaItem item) async {
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    await _deleteCachedSource(_sourceCacheKey(identity, 'stream'));
    final activeProvider = provider;
    if (activeProvider is MusicSourceCacheControl) {
      (activeProvider as MusicSourceCacheControl)
          .invalidatePlaybackSource(identity);
    }
  }

  Future<void> invalidateDownload(
    MediaItem item, {
    required String format,
  }) async {
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    await _deleteCachedSource(
      _sourceCacheKey(identity, 'download|$format'),
    );
    final activeProvider = provider;
    if (activeProvider is MusicSourceCacheControl) {
      (activeProvider as MusicSourceCacheControl)
          .invalidateDownloadSource(identity, format: format);
    }
  }

  String _sourceCacheKey(MusicIdentity identity, String purpose) =>
      'provider-source-v1|${identity.namespacedId}|$purpose';

  Future<PlaybackSource?> _readCachedSource(String key) async {
    if (!SqliteStore.isInitialized || !SqliteStore.isBoxOpen('SongsUrlCache')) {
      return null;
    }
    final box = SqliteStore.box<dynamic>('SongsUrlCache');
    final raw = box.get(key);
    if (raw is! List || raw.length < 2 || raw[1] is! Map) return null;
    final data = Map<String, dynamic>.from(
      (raw[1] as Map).map((key, value) => MapEntry('$key', value)),
    );
    final expiresAt = DateTime.tryParse(data['expiresAt']?.toString() ?? '');
    if (expiresAt == null ||
        !DateTime.now().add(const Duration(seconds: 45)).isBefore(expiresAt)) {
      await box.delete(key);
      return null;
    }
    final uri = Uri.tryParse(data['url']?.toString() ?? '');
    if (uri == null || !uri.hasScheme) {
      await box.delete(key);
      return null;
    }
    final typeName = data['type']?.toString();
    final type = PlaybackSourceType.values.firstWhere(
      (value) => value.name == typeName,
      orElse: () => PlaybackSourceType.authorizedStream,
    );
    final rawHeaders = data['headers'];
    final headers = rawHeaders is Map
        ? rawHeaders.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          )
        : const <String, String>{};
    return PlaybackSource(
      type: type,
      uri: uri,
      headers: headers,
      mimeType: data['mimeType']?.toString(),
      expiresAt: expiresAt,
      bitrate: _cachedInt(data['bitrate']),
      contentLength: _cachedInt(data['contentLength']),
      loudnessDb: _cachedDouble(data['loudnessDb']) ?? 0,
    );
  }

  Future<void> _writeCachedSource(
    String key,
    PlaybackSource source,
  ) async {
    final expiresAt = source.expiresAt;
    if (source.type != PlaybackSourceType.authorizedStream ||
        expiresAt == null ||
        !SqliteStore.isInitialized ||
        !SqliteStore.isBoxOpen('SongsUrlCache')) {
      return;
    }
    await SqliteStore.box<dynamic>('SongsUrlCache').put(key, [
      true,
      {
        'type': source.type.name,
        'url': source.uri.toString(),
        'headers': source.headers,
        'mimeType': source.mimeType,
        'expiresAt': expiresAt.toUtc().toIso8601String(),
        'bitrate': source.bitrate,
        'contentLength': source.contentLength,
        'loudnessDb': source.loudnessDb,
      },
    ]);
  }

  Future<void> _deleteCachedSource(String key) async {
    if (!SqliteStore.isInitialized || !SqliteStore.isBoxOpen('SongsUrlCache')) {
      return;
    }
    await SqliteStore.box<dynamic>('SongsUrlCache').delete(key);
  }

  int? _cachedInt(dynamic value) =>
      value is num ? value.toInt() : int.tryParse(value?.toString() ?? '');

  double? _cachedDouble(dynamic value) => value is num
      ? value.toDouble()
      : double.tryParse(value?.toString() ?? '');

  Future<ProviderLyrics?> lyricsFor(MediaItem item) async {
    if (!capabilities.lyrics) return null;
    final identity = identityFromMediaItem(item);
    _assertActiveIdentity(identity);
    final track = await provider.getTrack(identity.sourceId) ??
        ProviderTrack(
          identity: identity,
          title: item.title,
          artist: item.artist ?? 'Unknown artist',
          album: item.album ?? 'Unknown album',
          duration: item.duration,
          artworkUri: item.artUri,
          filePath: item.extras?['url']?.toString(),
          metadata: item.extras ?? const {},
        );
    return provider.getLyrics(track);
  }

  MusicIdentity identityFromMediaItem(MediaItem item) => MusicIdentity(
        providerId: item.extras?['providerId']?.toString() ?? activeProviderId,
        profileId: item.extras?['profileId']?.toString() ?? activeProfileId,
        sourceId: item.extras?['sourceId']?.toString() ?? item.id,
      );

  void _assertActiveIdentity(MusicIdentity identity) {
    if (identity.providerId != activeProviderId ||
        identity.profileId != activeProfileId) {
      throw MusicProviderException(
        'Track belongs to ${identity.providerId}/${identity.profileId}, '
        'but $activeProviderId/$activeProfileId is active',
      );
    }
  }

  // Compatibility shapes for the existing view models. The data source is
  // still the active MusicProvider; widgets never select a concrete provider.
  Future<List<String>> getSearchSuggestion(String query) async {
    if (!capabilities.search) return const [];
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getSearchSuggestion(query);
    }
    final result = await provider.search(query);
    return result.tracks
        .map((track) => track.title)
        .take(10)
        .toList(growable: false);
  }

  Future<Map<String, dynamic>> search(
    String query, {
    String? filter,
    String? scope,
    int limit = 30,
    bool ignoreSpelling = false,
    String? filterParams,
  }) async {
    if (!capabilities.search) return const {};
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.searchCatalog(
        query,
        filter: filter,
        scope: scope,
        limit: limit,
        ignoreSpelling: ignoreSpelling,
        filterParams: filterParams,
      );
    }
    final result = await provider.search(query);
    final data = <String, dynamic>{};
    if (filter == null || filter == 'songs') {
      data['Songs'] =
          result.tracks.take(limit).map(mediaItemFromTrack).toList();
    }
    if (filter == null || filter == 'albums') {
      data['Albums'] = result.albums.take(limit).map(_legacyAlbum).toList();
    }
    if (filter == null || filter == 'artists') {
      data['Artists'] = result.artists.take(limit).map(_legacyArtist).toList();
    }
    data['searchEndpoint'] = {
      if (result.tracks.isNotEmpty) 'Songs': null,
      if (result.albums.isNotEmpty) 'Albums': null,
      if (result.artists.isNotEmpty) 'Artists': null,
    };
    return data;
  }

  Future<Map<String, dynamic>> getSearchContinuation(
      Map<dynamic, dynamic> params) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const {};
    return discovery.getSearchContinuation(params);
  }

  Future<List<dynamic>> getHome({int limit = 4}) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getHome(limit: limit);
    }
    final result = <dynamic>[];
    if (capabilities.tracks) {
      final values =
          (await provider.getTracks()).map(mediaItemFromTrack).toList();
      if (values.isNotEmpty) {
        result.add({
          'title': '${provider.displayName} library',
          'contents': values,
        });
      }
    }
    if (capabilities.albums) {
      final values = (await provider.getAlbums()).map(_legacyAlbum).toList();
      if (values.isNotEmpty) {
        result.add({'title': 'Albums', 'contents': values});
      }
    }
    if (capabilities.artists) {
      final values = (await provider.getArtists()).map(_legacyArtist).toList();
      if (values.isNotEmpty) {
        result.add({'title': 'Artists', 'contents': values});
      }
    }
    return result.take(limit).toList();
  }

  Future<List<dynamic>> getCharts(String category,
      {String? countryCode}) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.getCharts(category, countryCode: countryCode);
  }

  Future<List<dynamic>> explore({int limit = 4}) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.explore(limit: limit);
  }

  Future<List<dynamic>> podcastDiscover({int limit = 4}) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.podcastDiscover(limit: limit);
  }

  Future<Map<String, dynamic>> podcast(String sourceId) {
    final discovery = _discoveryProvider;
    return discovery != null
        ? discovery.podcast(sourceId)
        : getPlaylistOrAlbumSongs(albumId: sourceId);
  }

  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs({
    String? playlistId,
    String? albumId,
    int limit = 3000,
    bool related = false,
    int suggestionsLimit = 0,
  }) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getPlaylistOrAlbumSongs(
        playlistId: playlistId,
        albumId: albumId,
        limit: limit,
        related: related,
        suggestionsLimit: suggestionsLimit,
      );
    }
    final sourceId = albumId ?? playlistId;
    if (sourceId == null || !capabilities.albums) {
      return {'playlistId': playlistId ?? '', 'tracks': <MediaItem>[]};
    }
    final album = await provider.getAlbum(sourceId);
    if (album == null) {
      throw MusicProviderException('Album not found: $sourceId');
    }
    return {
      'browseId': album.identity.sourceId,
      'playlistId': playlistId,
      'title': album.title,
      'artists': [
        {'name': album.artist}
      ],
      'thumbnails': [
        {'url': album.artworkUri?.toString() ?? ''}
      ],
      'tracks': album.tracks.map(mediaItemFromTrack).toList(growable: false),
      'trackCount': album.tracks.length,
    };
  }

  Future<Map<String, dynamic>> getArtist(String sourceId) async {
    if (!capabilities.artists) {
      throw const MusicProviderException('Artists are unsupported');
    }
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getArtistDetails(sourceId);
    }
    final artist = await provider.getArtist(sourceId);
    if (artist == null) {
      throw MusicProviderException('Artist not found: $sourceId');
    }
    return {
      'name': artist.name,
      'channelId': artist.identity.sourceId,
      'thumbnails': [
        {'url': artist.artworkUri?.toString() ?? ''}
      ],
      'Songs': {
        'title': 'Songs',
        'content':
            artist.tracks.map(mediaItemFromTrack).toList(growable: false),
      },
      'Albums': {
        'title': 'Albums',
        'content': artist.albums.map(_legacyAlbum).toList(growable: false),
      },
    };
  }

  Future<Map<String, dynamic>> getArtistRealtedContent(
    Map<String, dynamic> endpoint,
    String category, {
    String additionalParams = '',
  }) async {
    final discovery = _discoveryProvider;
    if (discovery == null) {
      return {'results': endpoint['content'] ?? const []};
    }
    return discovery.getArtistRelatedContent(endpoint, category,
        additionalParams: additionalParams);
  }

  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
      String sourceId, String languageCode) async {
    final discovery = _discoveryProvider;
    if (discovery == null) return const [];
    return discovery.getContentRelatedToSong(sourceId, languageCode);
  }

  Future<Map<String, dynamic>> getWatchPlaylist({
    String videoId = '',
    String? playlistId,
    int limit = 25,
    bool radio = false,
    bool shuffle = false,
    String? additionalParamsNext,
    bool onlyRelated = false,
  }) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getWatchPlaylist(
        videoId: videoId,
        playlistId: playlistId,
        limit: limit,
        radio: radio,
        shuffle: shuffle,
        additionalParamsNext: additionalParamsNext,
        onlyRelated: onlyRelated,
      );
    }
    if (onlyRelated) return const {'lyrics': null, 'related': null};
    final track = await provider.getTrack(videoId);
    return {
      'tracks': track == null ? <MediaItem>[] : [mediaItemFromTrack(track)],
      'playlistId': playlistId,
    };
  }

  Future<List<dynamic>> getSongWithId(String sourceId) async {
    final discovery = _discoveryProvider;
    if (discovery != null) {
      return discovery.getSongWithId(sourceId);
    }
    final track = await provider.getTrack(sourceId);
    return [
      track != null,
      track == null ? null : [mediaItemFromTrack(track)]
    ];
  }

  Future<void> setContentLanguage(String languageCode) async {
    // Provider-specific locale changes belong in profile settings. Providers
    // that need it receive the value during their next initialization.
  }

  Future<String?> getLyrics(String sourceId) async {
    final track = await provider.getTrack(sourceId);
    if (track == null || !capabilities.lyrics) return null;
    return (await provider.getLyrics(track))?.plain;
  }

  Album _legacyAlbum(ProviderAlbum album) => Album(
        title: album.title,
        browseId: album.identity.sourceId,
        providerId: album.identity.providerId,
        profileId: album.identity.profileId,
        sourceId: album.identity.sourceId,
        artists: [
          {'name': album.artist}
        ],
        thumbnailUrl: album.artworkUri?.toString() ?? '',
      );

  Artist _legacyArtist(ProviderArtist artist) => Artist(
        name: artist.name,
        browseId: artist.identity.sourceId,
        providerId: artist.identity.providerId,
        profileId: artist.identity.profileId,
        sourceId: artist.identity.sourceId,
        thumbnailUrl: artist.artworkUri?.toString() ?? '',
      );

  String _durationLabel(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onClose() {
    _automaticLookupGeneration++;
    _activeProfileWorker?.dispose();
    unawaited(_metadataProvider.dispose());
    super.onClose();
  }
}
