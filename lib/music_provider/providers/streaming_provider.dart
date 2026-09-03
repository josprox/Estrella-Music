import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_provider.dart';
import '../music_download_provider.dart';
import '../music_discovery_provider.dart';
import '../music_source_cache_control.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/music/music_service.dart';
import 'public_ip_resolver.dart';

typedef ProviderTokenLoader = Future<String?> Function();
typedef ProviderPlaybackContextLoader = Future<StreamingPlaybackContext>
    Function();

class StreamingPlaybackContext {
  const StreamingPlaybackContext({
    this.clientIp,
    this.visitorData,
  });

  final String? clientIp;
  final String? visitorData;

  Map<String, dynamic> toJson() => {
        if (clientIp != null && clientIp!.isNotEmpty) 'clientIp': clientIp,
        if (visitorData != null && visitorData!.isNotEmpty)
          'visitorData': visitorData,
      };
}

class StreamingProvider
    implements
        MusicProvider,
        MusicDiscoveryProvider,
        MusicDownloadProvider,
        MusicSourceCacheControl {
  StreamingProvider({
    required String Function() baseUrl,
    required ProviderTokenLoader tokenLoader,
    ProviderPlaybackContextLoader? playbackContextLoader,
    PublicIpResolver? ipResolver,
    Dio? client,
  })  : _baseUrl = baseUrl,
        _tokenLoader = tokenLoader,
        _playbackContextLoader = playbackContextLoader,
        _ipResolver = ipResolver ?? PublicIpResolver(),
        _client = client ?? Dio();

  static const providerId = 'joss.streaming';
  static const legacyProviderId = 'joss.emusic';

  final String Function() _baseUrl;
  final ProviderTokenLoader _tokenLoader;
  final ProviderPlaybackContextLoader? _playbackContextLoader;
  final PublicIpResolver _ipResolver;
  final Dio _client;
  String? _profileId;
  String? _customServerUrl;
  ProviderCapabilities _capabilities = const ProviderCapabilities();
  MusicServices? _catalog;
  final Map<String, _CatalogCacheEntry> _catalogCache = {};
  final Map<String, Future<Map<String, dynamic>>> _catalogInFlight = {};
  _StreamingLibrarySnapshot? _libraryCache;
  DateTime? _libraryCachedAt;
  Future<_StreamingLibrarySnapshot>? _libraryInFlight;
  final Map<String, _PlaybackSourceCacheEntry> _sourceCache = {};
  final Map<String, Future<PlaybackSource>> _sourceInFlight = {};
  Future<void> _serverResolutionTail = Future.value();

  static const _catalogCacheLimit = 64;
  static const _libraryCacheTtl = Duration(minutes: 2);

  @override
  String get id => providerId;

  @override
  String get displayName => 'Streaming Externo';

  @override
  ProviderCapabilities get capabilities => _capabilities;

  @override
  Future<void> initialize(MusicProviderContext context) async {
    _profileId = context.profileId;
    final configuredUrl = context.settings['serverUrl']?.toString().trim();
    _customServerUrl = (configuredUrl != null && configuredUrl.isNotEmpty)
        ? configuredUrl
        : null;
    final playbackContext = await _playbackContextLoader?.call() ??
        const StreamingPlaybackContext();
    final clientName = context.settings['clientName']?.toString().trim();
    _catalog = MusicServices(
      request: _catalogRequest,
      visitorData: playbackContext.visitorData,
      languageCode: context.settings['languageCode']?.toString() ?? 'en',
      clientName: (clientName != null && clientName.isNotEmpty) ? clientName : null,
    );
    try {
      final response = await _request('GET', 'capabilities');
      _capabilities = ProviderCapabilities.fromJson(
        _map(response['capabilities'] ?? response['data']),
      );
    } on MusicProviderException catch (error) {
      if (error.cause is! DioException) rethrow;
      printINFO('[StreamingProvider] Starting offline: $error');
      _capabilities = const ProviderCapabilities(
        tracks: true,
        artists: true,
        albums: true,
        artwork: true,
        lyrics: true,
        playlists: true,
        favorites: true,
        history: true,
        sync: true,
        home: true,
      );
    }
  }

  @override
  Future<void> refresh() async {
    _libraryCache = null;
    _libraryCachedAt = null;
    _catalogCache.clear();
  }

  MusicServices get _discovery {
    final value = _catalog;
    if (value == null) {
      throw const MusicProviderException(
          'Streaming provider is not initialized');
    }
    return value;
  }

  Future<Map<String, dynamic>> _catalogRequest(
    String action,
    Map<dynamic, dynamic> payload,
    String additionalParams,
  ) async {
    final cacheKey = '$action|${jsonEncode(payload)}|$additionalParams';
    final cached = _catalogCache[cacheKey];
    if (cached != null && !cached.isExpired) {
      return cached.copy();
    }
    final inFlight = _catalogInFlight[cacheKey];
    if (inFlight != null) return inFlight;

    final playbackContext = await _playbackContextLoader?.call() ??
        const StreamingPlaybackContext();

    final request = _request(
      'POST',
      'catalog',
      body: {
        'action': action,
        'payload': payload,
        'additionalParams': additionalParams,
        if (playbackContext.visitorData != null &&
            playbackContext.visitorData!.isNotEmpty)
          'visitorData': playbackContext.visitorData,
        if (playbackContext.clientIp != null &&
            playbackContext.clientIp!.isNotEmpty)
          'clientIp': playbackContext.clientIp,
      },
    );
    _catalogInFlight[cacheKey] = request;
    try {
      final raw = await request;
      final payloadResponse =
          (raw.containsKey('response') && raw['response'] is Map)
              ? _map(raw['response'])
              : raw;
      if (_catalogCache.length >= _catalogCacheLimit) {
        _catalogCache.remove(_catalogCache.keys.first);
      }
      _catalogCache[cacheKey] = _CatalogCacheEntry(payloadResponse);
      return payloadResponse;
    } finally {
      _catalogInFlight.remove(cacheKey);
    }
  }

  @override
  Future<ProviderSearchResults> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return const ProviderSearchResults();

    final response = await _catalogRequest('search', {'query': trimmed}, '');
    final data = _map(response['data'] ?? response);
    final rawTracks =
        _list(data['tracks'] ?? data['songs'] ?? response['tracks']);
    final rawAlbums = _list(data['albums'] ?? response['albums']);
    final rawArtists = _list(data['artists'] ?? response['artists']);

    if (rawTracks.isEmpty && rawAlbums.isEmpty && rawArtists.isEmpty) {
      final items = _list(data['items'] ?? response['items']);
      return ProviderSearchResults(
        tracks: items
            .where((item) =>
                item['type'] == 'track' ||
                item['type'] == 'song' ||
                item['videoId'] != null)
            .map(_track)
            .toList(growable: false),
        albums: items
            .where(
                (item) => item['type'] == 'album' || item['browseId'] != null)
            .map(_album)
            .toList(growable: false),
        artists: items
            .where(
                (item) => item['type'] == 'artist' || item['channelId'] != null)
            .map(_artist)
            .toList(growable: false),
      );
    }

    return ProviderSearchResults(
      tracks: rawTracks.map(_track).toList(growable: false),
      albums: rawAlbums.map(_album).toList(growable: false),
      artists: rawArtists.map(_artist).toList(growable: false),
    );
  }

  @override
  Future<List<ProviderTrack>> getTracks() async {
    final snapshot = await _loadLibrarySnapshot();
    return snapshot.tracks;
  }

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async {
    final snapshot = await _loadLibrarySnapshot();
    for (final track in snapshot.tracks) {
      if (track.identity.sourceId == sourceId) return track;
    }
    try {
      final response = await _request('GET', 'tracks/$sourceId');
      return _track(_map(response['track'] ?? response));
    } on MusicProviderException catch (e) {
      if (e.message.toLowerCase().contains('missing') ||
          e.message.toLowerCase().contains('not found')) {
        return null;
      }
      rethrow;
    }
  }

  @override
  Future<List<ProviderAlbum>> getAlbums() async {
    final snapshot = await _loadLibrarySnapshot();
    return snapshot.albums;
  }

  @override
  Future<ProviderAlbum?> getAlbum(String sourceId) async {
    final snapshot = await _loadLibrarySnapshot();
    for (final album in snapshot.albums) {
      if (album.identity.sourceId == sourceId) return album;
    }
    try {
      final response = await _request('GET', 'albums/$sourceId');
      return _album(_map(response['album'] ?? response));
    } on MusicProviderException catch (e) {
      if (e.message.toLowerCase().contains('missing') ||
          e.message.toLowerCase().contains('not found')) {
        return null;
      }
      rethrow;
    }
  }

  @override
  Future<List<ProviderArtist>> getArtists() async {
    final snapshot = await _loadLibrarySnapshot();
    return snapshot.artists;
  }

  @override
  Future<ProviderArtist?> getArtist(String sourceId) async {
    final snapshot = await _loadLibrarySnapshot();
    for (final artist in snapshot.artists) {
      if (artist.identity.sourceId == sourceId) return artist;
    }
    try {
      final response = await _request('GET', 'artists/$sourceId');
      return _artist(_map(response['artist'] ?? response));
    } on MusicProviderException catch (e) {
      if (e.message.toLowerCase().contains('missing') ||
          e.message.toLowerCase().contains('not found')) {
        return null;
      }
      rethrow;
    }
  }

  @override
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity) async {
    final response = await _request('GET', 'artwork/${identity.sourceId}');
    final url = response['url']?.toString();
    if (url == null || url.isEmpty) return null;
    return ProviderArtwork(uri: Uri.parse(url));
  }

  @override
  Future<ProviderLyrics?> getLyrics(ProviderTrack track) async {
    final response = await _request('GET', 'lyrics/${track.identity.sourceId}');
    return ProviderLyrics(
      synced: response['synced']?.toString(),
      plain: response['plain']?.toString(),
    );
  }

  @override
  Future<List<String>> getSearchSuggestion(String query) =>
      _discovery.getSearchSuggestion(query);

  @override
  Future<Map<String, dynamic>> searchCatalog(
    String query, {
    String? filter,
    String? scope,
    int limit = 30,
    bool ignoreSpelling = false,
    String? filterParams,
  }) =>
      _discovery.search(
        query,
        filter: filter,
        scope: scope,
        limit: limit,
        ignoreSpelling: ignoreSpelling,
        filterParams: filterParams,
      );

  @override
  Future<Map<String, dynamic>> getSearchContinuation(
    Map<dynamic, dynamic> params,
  ) =>
      _discovery.getSearchContinuation(params);

  @override
  Future<List<dynamic>> getHome({int limit = 4}) async {
    final res = await _discovery.getHome(limit: limit);
    return res is List ? res : const [];
  }

  @override
  Future<List<dynamic>> getCharts(String category, {String? countryCode}) =>
      _discovery.getCharts(category, countryCode: countryCode);

  @override
  Future<List<dynamic>> explore({int limit = 4}) async {
    final res = await _discovery.explore(limit: limit);
    return res is List ? res : const [];
  }

  @override
  Future<List<dynamic>> podcastDiscover({int limit = 4}) async {
    final res = await _discovery.podcastDiscover(limit: limit);
    return res is List ? res : const [];
  }

  @override
  Future<Map<String, dynamic>> podcast(String sourceId) =>
      _discovery.podcast(sourceId);

  @override
  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs({
    String? playlistId,
    String? albumId,
    int limit = 3000,
    bool related = false,
    int suggestionsLimit = 0,
  }) =>
      _discovery.getPlaylistOrAlbumSongs(
        playlistId: playlistId,
        albumId: albumId,
        limit: limit,
        related: related,
        suggestionsLimit: suggestionsLimit,
      );

  @override
  Future<Map<String, dynamic>> getArtistDetails(String sourceId) =>
      _discovery.getArtist(sourceId);

  @override
  Future<Map<String, dynamic>> getArtistRelatedContent(
    Map<String, dynamic> endpoint,
    String category, {
    String additionalParams = '',
  }) =>
      _discovery.getArtistRealtedContent(
        endpoint,
        category,
        additionalParams: additionalParams,
      );

  @override
  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
    String sourceId,
    String languageCode,
  ) =>
      _discovery.getContentRelatedToSong(sourceId, languageCode);

  @override
  Future<Map<String, dynamic>> getWatchPlaylist({
    String videoId = '',
    String? playlistId,
    int limit = 25,
    bool radio = false,
    bool shuffle = false,
    String? additionalParamsNext,
    bool onlyRelated = false,
  }) =>
      _discovery.getWatchPlaylist(
        videoId: videoId,
        playlistId: playlistId,
        limit: limit,
        radio: radio,
        shuffle: shuffle,
        additionalParamsNext: additionalParamsNext,
        onlyRelated: onlyRelated,
      );

  @override
  Future<List<dynamic>> getSongWithId(String sourceId) =>
      _discovery.getSongWithId(sourceId);

  Future<_StreamingLibrarySnapshot> _loadLibrarySnapshot() async {
    final cached = _libraryCache;
    final cachedAt = _libraryCachedAt;
    if (cached != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _libraryCacheTtl) {
      return cached;
    }
    final inFlight = _libraryInFlight;
    if (inFlight != null) return inFlight;

    final request = _fetchLibrarySnapshot();
    _libraryInFlight = request;
    try {
      final snapshot = await request;
      _libraryCache = snapshot;
      _libraryCachedAt = DateTime.now();
      return snapshot;
    } finally {
      _libraryInFlight = null;
    }
  }

  Future<_StreamingLibrarySnapshot> _fetchLibrarySnapshot() async {
    final response = await _request('GET', 'library');
    final data = _map(response['library'] ?? response['data'] ?? response);
    return _StreamingLibrarySnapshot(
      tracks: _list(data['tracks']).map(_track).toList(growable: false),
      albums: _list(data['albums']).map(_album).toList(growable: false),
      artists: _list(data['artists']).map(_artist).toList(growable: false),
    );
  }

  Future<PlaybackSource> _loadPlaybackSource(
    String key,
    Future<PlaybackSource> Function() loader,
  ) async {
    final namespacedKey = '$_requireProfileId|$key';
    final cached = _sourceCache[namespacedKey];
    if (cached != null && cached.isUsable) return cached.source;
    if (cached != null) _sourceCache.remove(namespacedKey);

    final current = _sourceInFlight[namespacedKey];
    if (current != null) return current;

    final request = loader();
    _sourceInFlight[namespacedKey] = request;
    try {
      final source = await request;
      _sourceCache[namespacedKey] = _PlaybackSourceCacheEntry(source);
      return source;
    } finally {
      _sourceInFlight.remove(namespacedKey);
    }
  }

  DateTime? _expiryFromUri(Uri uri) {
    final raw = uri.queryParameters['expire'] ??
        uri.queryParameters['expires'] ??
        uri.queryParameters['expiry'];
    if (raw == null || raw.isEmpty) return null;
    final unix = int.tryParse(raw);
    if (unix != null) {
      final milliseconds = unix > 9999999999 ? unix : unix * 1000;
      return DateTime.fromMillisecondsSinceEpoch(milliseconds);
    }
    return DateTime.tryParse(raw);
  }

  Future<T> _serializeServerResolution<T>(Future<T> Function() loader) async {
    final previous = _serverResolutionTail;
    final release = Completer<void>();
    _serverResolutionTail = release.future;
    await previous;
    try {
      return await loader();
    } finally {
      release.complete();
    }
  }

  @override
  Future<PlaybackSource> getPlayback(ProviderTrack track) async {
    return _loadPlaybackSource(
      'stream|${track.identity.sourceId}',
      () => _resolvePlayback(track),
    );
  }

  Future<PlaybackSource?> _resolveViaRecipe(
    String sourceId, {
    String? requestedFormat,
    StreamingPlaybackContext? context,
  }) async {
    try {
      final recipeResponse = await _request(
        'POST',
        'orchestrator/resolve-recipe',
        body: {
          'videoId': sourceId,
          if (context?.visitorData != null && context!.visitorData!.isNotEmpty)
            'visitorData': context.visitorData,
        },
      );

      final recipeData = _map(recipeResponse['data'] ?? recipeResponse);
      final rawCandidates = _list(recipeData['candidates']);
      if (rawCandidates.isEmpty) return null;

      final requestedCodec =
          (requestedFormat == 'm4a') ? 'mp4a' : requestedFormat;

      for (final rawCandidate in rawCandidates) {
        final candidate = _map(rawCandidate);
        final url = candidate['url']?.toString();
        if (url == null || url.isEmpty) continue;

        final method = candidate['method']?.toString() ?? 'POST';
        final headers = _map(candidate['headers'])
            .map((k, v) => MapEntry(k.toString(), v.toString()));
        final body = candidate['body'];
        final playbackHeaders = _map(candidate['playbackHeaders'])
            .map((k, v) => MapEntry(k.toString(), v.toString()));

        try {
          final response = await _client.request<dynamic>(
            url,
            data: body,
            options: Options(
              method: method,
              headers: headers,
              validateStatus: (status) => status != null && status < 500,
            ),
          );

          final respData = _map(response.data);
          final playability = _map(respData['playabilityStatus']);
          final status = playability['status']?.toString();
          if (status != null && status != 'OK') {
            continue;
          }

          final streamingData = _map(respData['streamingData']);
          final formats = _list(
            streamingData['adaptiveFormats'] ??
                streamingData['formats'] ??
                respData['adaptiveFormats'] ??
                respData['formats'],
          );

          if (formats.isEmpty) continue;

          Map<String, dynamic>? selected;
          Map<String, dynamic>? fallback;

          for (final rawFmt in formats) {
            final fmt = _map(rawFmt);
            final fmtUrl = fmt['url']?.toString();
            final mime = fmt['mimeType']?.toString() ?? '';
            if (fmtUrl == null || fmtUrl.isEmpty || !mime.contains('audio/')) {
              continue;
            }

            final bitrate = _int(fmt['bitrate']) ?? 0;
            if (fallback == null ||
                bitrate > (_int(fallback['bitrate']) ?? 0)) {
              fallback = fmt;
            }

            if (requestedCodec != null && requestedCodec.isNotEmpty) {
              final isOpus = mime.contains('opus');
              final codec = isOpus ? 'opus' : 'mp4a';
              if (codec == requestedCodec) {
                if (selected == null ||
                    bitrate > (_int(selected['bitrate']) ?? 0)) {
                  selected = fmt;
                }
              }
            }
          }

          final targetFmt = selected ?? fallback;
          if (targetFmt == null) continue;

          final streamUrl = targetFmt['url']?.toString();
          if (streamUrl == null || streamUrl.isEmpty) continue;

          final uri = Uri.parse(streamUrl);
          final isOpus =
              (targetFmt['mimeType']?.toString() ?? '').contains('opus');
          final mimeType = isOpus ? 'audio/webm' : 'audio/mp4';

          return PlaybackSource(
            type: PlaybackSourceType.authorizedStream,
            uri: uri,
            headers: playbackHeaders,
            mimeType: targetFmt['mimeType']?.toString() ?? mimeType,
            bitrate: _int(targetFmt['bitrate']),
            contentLength:
                _int(targetFmt['contentLength'] ?? targetFmt['size']),
            loudnessDb: _double(targetFmt['loudnessDb']) ?? 0,
            expiresAt: _expiryFromUri(uri),
          );
        } catch (_) {
          continue;
        }
      }
    } catch (_) {
      // Recipe resolution failed, will fall back to server
    }
    return null;
  }

  Future<PlaybackSource> _resolvePlayback(ProviderTrack track) async {
    _requireCapability(_capabilities.playback, 'playback');
    final playbackContext = await _playbackContextLoader?.call() ??
        const StreamingPlaybackContext();

    final recipeSource = await _resolveViaRecipe(
      track.identity.sourceId,
      context: playbackContext,
    );
    if (recipeSource != null) {
      return recipeSource;
    }

    var clientIp = playbackContext.clientIp;
    if (clientIp == null || clientIp.trim().isEmpty) {
      clientIp = await _ipResolver.getPublicIp();
    }

    final data = await _serializeServerResolution(
      () => _request(
        'POST',
        'playback',
        body: {
          'trackId': track.identity.sourceId,
          if (playbackContext.visitorData != null &&
              playbackContext.visitorData!.isNotEmpty)
            'visitorData': playbackContext.visitorData,
          if (clientIp != null && clientIp.isNotEmpty) 'clientIp': clientIp,
        },
      ),
    );
    final url = data['url']?.toString();
    if (url == null || url.isEmpty) {
      throw MusicProviderException(
        data['message']?.toString() ??
            'Streaming server did not return a playback source',
      );
    }
    final rawHeaders = _map(data['headers']);
    final uri = Uri.parse(url);
    return PlaybackSource(
      type: PlaybackSourceType.authorizedStream,
      uri: uri,
      headers: rawHeaders.map((key, value) => MapEntry(key, value.toString())),
      mimeType: data['mimeType']?.toString(),
      bitrate: _int(data['bitrate']),
      contentLength: _int(data['size'] ?? data['contentLength']),
      loudnessDb: _double(data['loudnessDb']) ?? 0,
      expiresAt: data['expiresAt'] == null
          ? _expiryFromUri(uri)
          : DateTime.tryParse(data['expiresAt'].toString()),
    );
  }

  @override
  Future<PlaybackSource> getDownload(
    ProviderTrack track, {
    required String format,
  }) async {
    return _loadPlaybackSource(
      'download|$format|${track.identity.sourceId}',
      () => _resolveDownload(track, format: format),
    );
  }

  @override
  void invalidatePlaybackSource(MusicIdentity identity) {
    _sourceCache.remove(
      '${identity.profileId}|stream|${identity.sourceId}',
    );
  }

  @override
  void invalidateDownloadSource(
    MusicIdentity identity, {
    required String format,
  }) {
    _sourceCache.remove(
      '${identity.profileId}|download|$format|${identity.sourceId}',
    );
  }

  Future<PlaybackSource> _resolveDownload(
    ProviderTrack track, {
    required String format,
  }) async {
    final playbackContext = await _playbackContextLoader?.call() ??
        const StreamingPlaybackContext();

    final recipeSource = await _resolveViaRecipe(
      track.identity.sourceId,
      requestedFormat: format,
      context: playbackContext,
    );
    if (recipeSource != null) {
      return recipeSource;
    }

    var clientIp = playbackContext.clientIp;
    if (clientIp == null || clientIp.trim().isEmpty) {
      clientIp = await _ipResolver.getPublicIp();
    }

    final data = await _serializeServerResolution(
      () => _request(
        'POST',
        'download',
        body: {
          'trackId': track.identity.sourceId,
          'format': format,
          if (playbackContext.visitorData != null &&
              playbackContext.visitorData!.isNotEmpty)
            'visitorData': playbackContext.visitorData,
          if (clientIp != null && clientIp.isNotEmpty) 'clientIp': clientIp,
        },
      ),
    );
    final url = data['url']?.toString();
    if (url == null || url.isEmpty) {
      throw MusicProviderException(
        data['message']?.toString() ??
            'Streaming server did not return a downloadable source',
      );
    }
    final uri = Uri.parse(url);
    return PlaybackSource(
      type: PlaybackSourceType.authorizedStream,
      uri: uri,
      headers: _map(data['headers'])
          .map((key, value) => MapEntry(key, value.toString())),
      mimeType: data['mimeType']?.toString(),
      bitrate: _int(data['bitrate']),
      contentLength: _int(data['size'] ?? data['contentLength']),
      loudnessDb: _double(data['loudnessDb']) ?? 0,
      expiresAt: data['expiresAt'] == null
          ? _expiryFromUri(uri)
          : DateTime.tryParse(data['expiresAt'].toString()),
    );
  }

  ProviderTrack _track(Map<String, dynamic> json) {
    final sourceId =
        _first(json, const ['sourceId', 'trackId', 'videoId', 'id']);
    final artists = _list(json['artists']);
    final artist = json['artist']?.toString() ??
        (artists.isEmpty
            ? 'Unknown artist'
            : _map(artists.first)['name']?.toString()) ??
        'Unknown artist';
    final albumValue = json['album'];
    final album = albumValue is Map
        ? _map(albumValue)['name']?.toString()
        : albumValue?.toString();
    return ProviderTrack(
      identity: MusicIdentity(
        providerId: providerId,
        profileId: _requireProfileId,
        sourceId: sourceId,
      ),
      title: json['title']?.toString() ??
          json['name']?.toString() ??
          'Unknown track',
      artist: artist,
      album: album ?? 'Unknown album',
      duration: _duration(json['duration'] ?? json['durationMs']),
      artworkUri:
          _uri(json['artworkUrl'] ?? json['thumbnailUrl'] ?? _thumbnail(json)),
      metadata: Map.unmodifiable(json),
    );
  }

  ProviderAlbum _album(Map<String, dynamic> json) => ProviderAlbum(
        identity: MusicIdentity(
          providerId: providerId,
          profileId: _requireProfileId,
          sourceId: _first(json,
              const ['sourceId', 'albumId', 'browseId', 'playlistId', 'id']),
        ),
        title: json['title']?.toString() ??
            json['name']?.toString() ??
            'Unknown album',
        artist: json['artist']?.toString() ??
            json['artistsText']?.toString() ??
            'Unknown artist',
        artworkUri: _uri(
            json['artworkUrl'] ?? json['thumbnailUrl'] ?? _thumbnail(json)),
        tracks: _list(json['tracks']).map(_track).toList(growable: false),
      );

  ProviderArtist _artist(Map<String, dynamic> json) => ProviderArtist(
        identity: MusicIdentity(
          providerId: providerId,
          profileId: _requireProfileId,
          sourceId: _first(json,
              const ['sourceId', 'artistId', 'channelId', 'browseId', 'id']),
        ),
        name: json['name']?.toString() ??
            json['title']?.toString() ??
            'Unknown artist',
        artworkUri: _uri(
            json['artworkUrl'] ?? json['thumbnailUrl'] ?? _thumbnail(json)),
        tracks: _list(json['tracks']).map(_track).toList(growable: false),
        albums: _list(json['albums']).map(_album).toList(growable: false),
      );

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  }) async {
    final base =
        (_customServerUrl ?? _baseUrl()).replaceAll(RegExp(r'/+$'), '');
    if (base.isEmpty) {
      throw const MusicProviderException(
          'No se ha configurado la URL del servidor para este perfil.');
    }

    final token = await _tokenLoader();
    if (token == null || token.isEmpty) {
      throw const MusicProviderException(
          'A valid Joss Red session is required');
    }

    final fullPath = path.startsWith('/')
        ? '$base$path'
        : (path.startsWith('orchestrator/')
            ? '$base/api/music/$path'
            : '$base/api/music/provider/$path');
    try {
      final response = await _client.request<dynamic>(
        fullPath,
        queryParameters: query,
        data: body,
        options: Options(
          method: method,
          headers: {
            if (token.isNotEmpty) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'X-Music-Profile-Id': _requireProfileId,
          },
          validateStatus: (_) => true,
        ),
      );
      final data = _map(response.data);
      if ((response.statusCode ?? 500) >= 400 || data['status'] == 'error') {
        throw MusicProviderException(
          data['message']?.toString() ??
              'Streaming request failed (${response.statusCode})',
        );
      }
      return _map(data['data'] ?? data);
    } on DioException catch (error) {
      throw MusicProviderException('Unable to reach streaming server',
          cause: error);
    }
  }

  String get _requireProfileId {
    final value = _profileId;
    if (value == null) {
      throw const MusicProviderException(
          'Streaming provider is not initialized');
    }
    return value;
  }

  void _requireCapability(bool supported, String name) {
    if (!supported) {
      throw MusicProviderException('Streaming server does not support $name');
    }
  }

  Map<String, dynamic> _map(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, item) => MapEntry(key.toString(), item));
    }
    return const {};
  }

  List<Map<String, dynamic>> _list(dynamic value) => value is List
      ? value.map(_map).where((item) => item.isNotEmpty).toList(growable: false)
      : const [];

  String _first(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = json[key]?.toString();
      if (value != null && value.isNotEmpty && value != 'null') return value;
    }
    throw const MusicProviderException(
        'Provider entity has no source identity');
  }

  dynamic _thumbnail(Map<String, dynamic> json) {
    final values = json['thumbnails'];
    if (values is List && values.isNotEmpty) return _map(values.last)['url'];
    return null;
  }

  Uri? _uri(dynamic value) {
    final text = value?.toString();
    return text == null || text.isEmpty ? null : Uri.tryParse(text);
  }

  int? _int(dynamic value) =>
      value is num ? value.toInt() : int.tryParse(value?.toString() ?? '');
  double? _double(dynamic value) => value is num
      ? value.toDouble()
      : double.tryParse(value?.toString() ?? '');

  Duration? _duration(dynamic value) {
    if (value is num) return Duration(seconds: value.toInt());
    final text = value?.toString();
    if (text == null || text.isEmpty) return null;
    final parts = text.split(':').map(int.tryParse).toList();
    if (parts.any((part) => part == null)) return null;
    var seconds = 0;
    for (final part in parts) {
      seconds = seconds * 60 + part!;
    }
    return Duration(seconds: seconds);
  }

  @override
  Future<void> dispose() async {
    _catalog = null;
    _catalogCache.clear();
    _catalogInFlight.clear();
    _libraryCache = null;
    _libraryCachedAt = null;
    _libraryInFlight = null;
    _sourceCache.clear();
    _sourceInFlight.clear();
    _profileId = null;
    _customServerUrl = null;
    _capabilities = const ProviderCapabilities();
  }
}

class _StreamingLibrarySnapshot {
  const _StreamingLibrarySnapshot({
    required this.tracks,
    required this.albums,
    required this.artists,
  });

  final List<ProviderTrack> tracks;
  final List<ProviderAlbum> albums;
  final List<ProviderArtist> artists;
}

class _PlaybackSourceCacheEntry {
  _PlaybackSourceCacheEntry(this.source) : createdAt = DateTime.now();

  final PlaybackSource source;
  final DateTime createdAt;

  bool get isUsable {
    final expiresAt =
        source.expiresAt ?? createdAt.add(const Duration(minutes: 2));
    return DateTime.now().add(const Duration(seconds: 45)).isBefore(expiresAt);
  }
}

class _CatalogCacheEntry {
  _CatalogCacheEntry(Map<String, dynamic> data)
      : _data = copyOf(data),
        createdAt = DateTime.now();

  final Map<String, dynamic> _data;
  final DateTime createdAt;

  bool get isExpired =>
      DateTime.now().difference(createdAt) > const Duration(minutes: 5);

  Map<String, dynamic> copy() => copyOf(_data);

  static Map<String, dynamic> copyOf(Map<String, dynamic> value) =>
      Map<String, dynamic>.from(jsonDecode(jsonEncode(value)) as Map);
}
