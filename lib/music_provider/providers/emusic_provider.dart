import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

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

typedef ProviderTokenLoader = Future<String?> Function();
typedef ProviderPlaybackContextLoader = Future<EMusicPlaybackContext>
    Function();

class EMusicPlaybackContext {
  const EMusicPlaybackContext({
    this.clientIp,
    this.visitorData,
    this.poToken,
  });

  final String? clientIp;
  final String? visitorData;
  final String? poToken;

  Map<String, dynamic> toJson() => {
        if (clientIp != null && clientIp!.isNotEmpty) 'clientIp': clientIp,
        if (visitorData != null && visitorData!.isNotEmpty)
          'visitorData': visitorData,
        if (poToken != null && poToken!.isNotEmpty) 'poToken': poToken,
      };
}

class EMusicProvider
    implements
        MusicProvider,
        MusicDiscoveryProvider,
        MusicDownloadProvider,
        MusicSourceCacheControl {
  EMusicProvider({
    required String Function() baseUrl,
    required ProviderTokenLoader tokenLoader,
    ProviderPlaybackContextLoader? playbackContextLoader,
    Dio? client,
  })  : _baseUrl = baseUrl,
        _tokenLoader = tokenLoader,
        _playbackContextLoader = playbackContextLoader,
        _client = client ?? Dio();

  static const providerId = 'joss.emusic';

  final String Function() _baseUrl;
  final ProviderTokenLoader _tokenLoader;
  final ProviderPlaybackContextLoader? _playbackContextLoader;
  final Dio _client;
  String? _profileId;
  ProviderCapabilities _capabilities = const ProviderCapabilities();
  MusicServices? _catalog;
  final Map<String, _CatalogCacheEntry> _catalogCache = {};
  final Map<String, Future<Map<String, dynamic>>> _catalogInFlight = {};
  _EMusicLibrarySnapshot? _libraryCache;
  DateTime? _libraryCachedAt;
  Future<_EMusicLibrarySnapshot>? _libraryInFlight;
  _RecipeCacheEntry? _recipeCache;
  Future<Map<String, dynamic>>? _recipeInFlight;
  final Map<String, _PlaybackSourceCacheEntry> _sourceCache = {};
  final Map<String, Future<PlaybackSource>> _sourceInFlight = {};
  Future<void> _serverResolutionTail = Future.value();

  static const _catalogCacheLimit = 64;
  static const _libraryCacheTtl = Duration(minutes: 2);
  static const _recipeCacheTtl = Duration(minutes: 15);

  @override
  String get id => providerId;

  @override
  String get displayName => 'eMusic';

  @override
  ProviderCapabilities get capabilities => _capabilities;

  @override
  Future<void> initialize(MusicProviderContext context) async {
    _profileId = context.profileId;
    final playbackContext =
        await _playbackContextLoader?.call() ?? const EMusicPlaybackContext();
    _catalog = MusicServices(
      request: _catalogRequest,
      visitorData: playbackContext.visitorData,
      languageCode: context.settings['languageCode']?.toString() ?? 'en',
    );
    try {
      final response = await _request('GET', 'capabilities');
      _capabilities = ProviderCapabilities.fromJson(
        _map(response['capabilities'] ?? response['data']),
      );
    } on MusicProviderException catch (error) {
      if (error.cause is! DioException) rethrow;
      // A profile that was already configured must remain usable offline. In
      // particular, its namespaced SongDownloads are local playback sources;
      // failing a capability probe must not silently switch the user to Local.
      printINFO('[EMusicProvider] Starting offline: $error');
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
      throw const MusicProviderException('eMusic provider is not initialized');
    }
    return value;
  }

  Future<Map<String, dynamic>> _catalogRequest(
    String action,
    Map<dynamic, dynamic> payload,
    String additionalParams,
  ) async {
    final normalizedPayload =
        payload.map((key, value) => MapEntry('$key', value));
    final key = '$_requireProfileId|$action|$additionalParams|'
        '${jsonEncode(normalizedPayload)}';
    final cached = _catalogCache[key];
    if (cached != null && !cached.isExpired) return cached.copy();

    final current = _catalogInFlight[key];
    if (current != null) return current;

    final request = _loadCatalogRequest(
      action: action,
      payload: normalizedPayload,
      additionalParams: additionalParams,
    );
    _catalogInFlight[key] = request;
    try {
      return await request;
    } finally {
      _catalogInFlight.remove(key);
    }
  }

  Future<Map<String, dynamic>> _loadCatalogRequest({
    required String action,
    required Map<String, dynamic> payload,
    required String additionalParams,
  }) async {
    final context =
        await _playbackContextLoader?.call() ?? const EMusicPlaybackContext();
    final data = await _request(
      'POST',
      'catalog',
      body: {
        'action': action,
        'payload': payload,
        'additionalParams': additionalParams,
        ...context.toJson(),
      },
    );
    final result = _map(data['response'] ?? data);
    if (_catalogCache.length >= _catalogCacheLimit) {
      _catalogCache.remove(_catalogCache.keys.first);
    }
    _catalogCache['$_requireProfileId|$action|$additionalParams|'
        '${jsonEncode(payload)}'] = _CatalogCacheEntry(result);
    return _CatalogCacheEntry.copyOf(result);
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
          Map<dynamic, dynamic> params) =>
      _discovery.getSearchContinuation(params);

  @override
  Future<List<dynamic>> getHome({int limit = 4}) async =>
      List<dynamic>.from(await _discovery.getHome(limit: limit));

  @override
  Future<List<dynamic>> getCharts(String category,
          {String? countryCode}) async =>
      List<dynamic>.from(
          await _discovery.getCharts(category, countryCode: countryCode));

  @override
  Future<List<dynamic>> explore({int limit = 4}) async =>
      List<dynamic>.from(await _discovery.explore(limit: limit));

  @override
  Future<List<dynamic>> podcastDiscover({int limit = 4}) async =>
      List<dynamic>.from(await _discovery.podcastDiscover(limit: limit));

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
      _discovery.getArtistRealtedContent(endpoint, category,
          additionalParams: additionalParams);

  @override
  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
          String sourceId, String languageCode) =>
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
  Future<List<dynamic>> getSongWithId(String sourceId) async =>
      List<dynamic>.from(await _discovery.getSongWithId(sourceId));

  @override
  Future<ProviderSearchResults> search(String query) async {
    _requireCapability(_capabilities.search, 'search');
    final data = await _request('GET', 'search', query: {'q': query});
    return ProviderSearchResults(
      tracks: _list(data['tracks']).map(_track).toList(growable: false),
      albums: _list(data['albums']).map(_album).toList(growable: false),
      artists: _list(data['artists']).map(_artist).toList(growable: false),
    );
  }

  @override
  Future<List<ProviderTrack>> getTracks() async {
    _requireCapability(_capabilities.tracks, 'tracks');
    return (await _loadLibrarySnapshot()).tracks;
  }

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async {
    _requireCapability(_capabilities.tracks, 'tracks');
    return _findBySourceId(
      (await _loadLibrarySnapshot()).tracks,
      sourceId,
      (track) => track.identity,
    );
  }

  Future<_EMusicLibrarySnapshot> _loadLibrarySnapshot() async {
    final cached = _libraryCache;
    final cachedAt = _libraryCachedAt;
    if (cached != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _libraryCacheTtl) {
      return cached;
    }

    final current = _libraryInFlight;
    if (current != null) return current;

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

  Future<_EMusicLibrarySnapshot> _fetchLibrarySnapshot() async {
    Map<String, dynamic> data;
    try {
      data = await _request('GET', 'library');
    } on MusicProviderException catch (error) {
      if (!error.message.contains('(404)')) rethrow;
      // Compatibility during a staggered deployment. Requests are sequential
      // and still sit behind this method's single in-flight Future.
      final tracks = await _request('GET', 'tracks');
      final albums = await _request('GET', 'albums');
      final artists = await _request('GET', 'artists');
      data = {
        'tracks': tracks['tracks'] ?? tracks['data'],
        'albums': albums['albums'] ?? albums['data'],
        'artists': artists['artists'] ?? artists['data'],
      };
    }
    return _EMusicLibrarySnapshot(
      tracks: List.unmodifiable(_list(data['tracks']).map(_track)),
      albums: List.unmodifiable(_list(data['albums']).map(_album)),
      artists: List.unmodifiable(_list(data['artists']).map(_artist)),
    );
  }

  T? _findBySourceId<T>(
    Iterable<T> values,
    String sourceId,
    MusicIdentity Function(T value) identityOf,
  ) {
    for (final value in values) {
      if (identityOf(value).sourceId == sourceId) return value;
    }
    return null;
  }

  @override
  Future<List<ProviderAlbum>> getAlbums() async {
    _requireCapability(_capabilities.albums, 'albums');
    return (await _loadLibrarySnapshot()).albums;
  }

  @override
  Future<ProviderAlbum?> getAlbum(String sourceId) async {
    _requireCapability(_capabilities.albums, 'albums');
    return _findBySourceId(
      (await _loadLibrarySnapshot()).albums,
      sourceId,
      (album) => album.identity,
    );
  }

  @override
  Future<List<ProviderArtist>> getArtists() async {
    _requireCapability(_capabilities.artists, 'artists');
    return (await _loadLibrarySnapshot()).artists;
  }

  @override
  Future<ProviderArtist?> getArtist(String sourceId) async {
    _requireCapability(_capabilities.artists, 'artists');
    return _findBySourceId(
      (await _loadLibrarySnapshot()).artists,
      sourceId,
      (artist) => artist.identity,
    );
  }

  @override
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity) async {
    _requireCapability(_capabilities.artwork, 'artwork');
    final library = await _loadLibrarySnapshot();
    final track = _findBySourceId(
      library.tracks,
      identity.sourceId,
      (item) => item.identity,
    );
    final album = _findBySourceId(
      library.albums,
      identity.sourceId,
      (item) => item.identity,
    );
    final artist = _findBySourceId(
      library.artists,
      identity.sourceId,
      (item) => item.identity,
    );
    final url = (track?.artworkUri ?? album?.artworkUri ?? artist?.artworkUri)
        ?.toString();
    final encoded = track?.metadata['artworkBytes']?.toString();
    if ((url == null || url.isEmpty) && (encoded == null || encoded.isEmpty)) {
      return null;
    }
    return ProviderArtwork(
      uri: url == null || url.isEmpty ? null : Uri.tryParse(url),
      bytes: encoded == null || encoded.isEmpty
          ? null
          : Uint8List.fromList(base64Decode(encoded)),
      mimeType: null,
    );
  }

  @override
  Future<ProviderLyrics?> getLyrics(ProviderTrack track) async {
    _requireCapability(_capabilities.lyrics, 'lyrics');
    final data = await _request(
      'GET',
      'lyrics/${Uri.encodeComponent(track.identity.sourceId)}',
    );
    return ProviderLyrics(
      plain: data['plain']?.toString(),
      synced: data['synced']?.toString(),
    );
  }

  Future<Map<String, dynamic>> _loadResolveRecipe(
    String videoId,
    EMusicPlaybackContext playbackContext,
  ) async {
    final cached = _recipeCache;
    if (cached != null && !cached.isExpired) return cached.copy();

    final current = _recipeInFlight;
    if (current != null) return current;

    final request = _request(
      'POST',
      'orchestrator/resolve-recipe',
      body: {
        'videoId': videoId,
        ...playbackContext.toJson(),
      },
    );
    _recipeInFlight = request;
    try {
      final result = await request;
      _recipeCache = _RecipeCacheEntry(result);
      return _RecipeCacheEntry.copyOf(result);
    } finally {
      _recipeInFlight = null;
    }
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

  Future<PlaybackSource> _resolvePlayback(ProviderTrack track) async {
    _requireCapability(_capabilities.playback, 'playback');
    final playbackContext =
        await _playbackContextLoader?.call() ?? const EMusicPlaybackContext();

    final videoId = track.identity.sourceId;
    printINFO(
        '[EMusicProvider] getPlayback requested for $videoId ("${track.title}")');

    // 1. Resolve stream using dynamic eMusic orchestrator recipe on client device
    List<dynamic> recommendedClients = const [];
    int sts = 20684;
    String? visitorData = playbackContext.visitorData;

    try {
      final recipeData = await _loadResolveRecipe(videoId, playbackContext);
      final orchestration = _map(recipeData['orchestration']);
      recommendedClients = _list(orchestration['recommendedClients']);
      sts = _int(recipeData['signatureTimestamp']) ?? 20684;
      if ((visitorData == null || visitorData.isEmpty) &&
          recipeData['visitorData'] != null) {
        visitorData = recipeData['visitorData'].toString();
      }
      printINFO(
          '[EMusicProvider] Recipe received: ${recommendedClients.length} clients, sts=$sts');
    } catch (e) {
      printERROR('[EMusicProvider] Recipe request failed: $e');
    }

    for (final rawSpec in recommendedClients) {
      final clientSpec = _map(rawSpec);
      final clientName = clientSpec['name']?.toString() ??
          clientSpec['clientName']?.toString() ??
          'UNKNOWN';
      final apiUrl = clientSpec['apiUrl']?.toString();
      if (apiUrl == null || apiUrl.isEmpty) {
        continue;
      }
      final clientObj = Map<String, dynamic>.from(_map(clientSpec['client']));
      final useSts = clientSpec['useSts'] == true;
      final useVisitor = clientSpec['useVisitor'] == true;
      final contentCheckOk = clientSpec['contentCheckOk'] == true;
      final racyCheckOk = clientSpec['racyCheckOk'] == true;

      if (useVisitor && visitorData != null && visitorData.isNotEmpty) {
        clientObj['visitorData'] = visitorData;
      }

      final payload = <String, dynamic>{
        'context': {'client': clientObj},
        'videoId': videoId,
        if (playbackContext.poToken != null &&
            playbackContext.poToken!.isNotEmpty)
          'serviceIntegrityDimensions': {
            'poToken': playbackContext.poToken,
          },
        if (useSts)
          'playbackContext': {
            'contentPlaybackContext': {
              'html5Preference': 'HTML5_PREF_WANTS',
              'signatureTimestamp': sts,
            }
          },
        if (contentCheckOk) 'contentCheckOk': true,
        if (racyCheckOk) 'racyCheckOk': true,
      };

      final reqHeaders =
          Map<String, String>.from(_map(clientSpec['requestHeaders']));

      if (useVisitor && visitorData != null && visitorData.isNotEmpty) {
        reqHeaders['X-Goog-Visitor-Id'] = visitorData;
      }
      if (playbackContext.poToken != null &&
          playbackContext.poToken!.isNotEmpty) {
        reqHeaders['X-YouTube-Po-Token'] = playbackContext.poToken!;
      }

      final playHeaders =
          Map<String, String>.from(_map(clientSpec['playbackHeaders']));

      printINFO(
          '[EMusicProvider] Resolving stream with client: $clientName ($apiUrl)');

      try {
        final clientDio = Dio();
        final streamResp = await clientDio.post<dynamic>(
          apiUrl,
          data: payload,
          options: Options(headers: reqHeaders, validateStatus: (_) => true),
        );
        final streamData = _map(streamResp.data);
        final status =
            _map(streamData['playabilityStatus'])['status']?.toString();
        printINFO('[EMusicProvider] Client $clientName status: $status');
        if (status == 'OK') {
          final formats =
              _list(_map(streamData['streamingData'])['adaptiveFormats']);
          final audioFormats = formats
              .where((f) =>
                  f['url'] != null &&
                  f['url'].toString().isNotEmpty &&
                  (f['mimeType']?.toString().contains('audio') ?? false))
              .toList();
          if (audioFormats.isNotEmpty) {
            audioFormats.sort((a, b) =>
                (_int(b['bitrate']) ?? 0).compareTo(_int(a['bitrate']) ?? 0));
            final best = audioFormats.first;
            final url = best['url'].toString();
            printINFO(
                '[EMusicProvider] Successfully resolved stream with $clientName. Bitrate: ${best['bitrate']}, PlaybackHeaders: $playHeaders');
            final uri = Uri.parse(url);
            return PlaybackSource(
              type: PlaybackSourceType.authorizedStream,
              uri: uri,
              headers: playHeaders,
              mimeType: best['mimeType']?.toString() ?? 'audio/mp4',
              bitrate: _int(best['bitrate']),
              contentLength: _int(best['contentLength']),
              loudnessDb: _double(best['loudnessDb']) ?? 0,
              expiresAt: _expiryFromUri(uri),
            );
          }
        }
      } catch (e) {
        printERROR('[EMusicProvider] Client $clientName resolution error: $e');
        continue;
      }
    }

    // 2. Fallback to server-side resolution endpoint
    final data = await _serializeServerResolution(
      () => _request(
        'POST',
        'playback',
        body: {
          'trackId': track.identity.sourceId,
          ...playbackContext.toJson(),
        },
      ),
    );
    final url = data['url']?.toString();
    if (url == null || url.isEmpty) {
      throw MusicProviderException(
        data['message']?.toString() ??
            'eMusic did not return a playback source',
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
    final clientSource = await _resolveDownloadWithClientRecipe(track, format);
    if (clientSource != null) return clientSource;

    final playbackContext =
        await _playbackContextLoader?.call() ?? const EMusicPlaybackContext();
    final data = await _serializeServerResolution(
      () => _request(
        'POST',
        'download',
        body: {
          'trackId': track.identity.sourceId,
          'format': format,
          ...playbackContext.toJson(),
        },
      ),
    );
    final url = data['url']?.toString();
    if (url == null || url.isEmpty) {
      throw MusicProviderException(
        data['message']?.toString() ??
            'eMusic did not return a downloadable source',
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

  /// The server owns the client recipe, while the device performs the final
  /// authorized request. This preserves the source binding expected by some
  /// providers and avoids treating a server-side playback session as the
  /// user's download session.
  Future<PlaybackSource?> _resolveDownloadWithClientRecipe(
    ProviderTrack track,
    String format,
  ) async {
    final playbackContext =
        await _playbackContextLoader?.call() ?? const EMusicPlaybackContext();
    final preferredCodec = format == 'm4a' ? 'mp4a' : format;
    try {
      final recipeData = await _loadResolveRecipe(
        track.identity.sourceId,
        playbackContext,
      );
      final orchestration = _map(recipeData['orchestration']);
      final clients = _list(orchestration['recommendedClients']);
      final sts = _int(recipeData['signatureTimestamp']) ?? 20684;
      final visitorData =
          playbackContext.visitorData ?? recipeData['visitorData']?.toString();

      for (final rawSpec in clients) {
        final spec = _map(rawSpec);
        final apiUrl = spec['apiUrl']?.toString();
        if (apiUrl == null || apiUrl.isEmpty) continue;
        final client = Map<String, dynamic>.from(_map(spec['client']));
        final useVisitor = spec['useVisitor'] == true;
        final useSts = spec['useSts'] == true;
        if (useVisitor && visitorData != null && visitorData.isNotEmpty) {
          client['visitorData'] = visitorData;
        }
        final payload = <String, dynamic>{
          'context': {'client': client},
          'videoId': track.identity.sourceId,
          if (playbackContext.poToken != null &&
              playbackContext.poToken!.isNotEmpty)
            'serviceIntegrityDimensions': {
              'poToken': playbackContext.poToken,
            },
          if (useSts)
            'playbackContext': {
              'contentPlaybackContext': {
                'html5Preference': 'HTML5_PREF_WANTS',
                'signatureTimestamp': sts,
              }
            },
          if (spec['contentCheckOk'] == true) 'contentCheckOk': true,
          if (spec['racyCheckOk'] == true) 'racyCheckOk': true,
        };
        final headers = Map<String, String>.from(_map(spec['requestHeaders']));
        if (useVisitor && visitorData != null && visitorData.isNotEmpty) {
          headers['X-Goog-Visitor-Id'] = visitorData;
        }
        if (playbackContext.poToken != null &&
            playbackContext.poToken!.isNotEmpty) {
          headers['X-YouTube-Po-Token'] = playbackContext.poToken!;
        }
        final response = await Dio().post<dynamic>(
          apiUrl,
          data: payload,
          options: Options(headers: headers, validateStatus: (_) => true),
        );
        final data = _map(response.data);
        if (_map(data['playabilityStatus'])['status']?.toString() != 'OK') {
          continue;
        }
        final formats = _list(_map(data['streamingData'])['adaptiveFormats'])
            .where((item) =>
                item['url'] != null &&
                item['url'].toString().isNotEmpty &&
                (item['mimeType']?.toString().contains('audio') ?? false))
            .toList();
        final matching = formats
            .where((item) =>
                item['mimeType']
                    ?.toString()
                    .toLowerCase()
                    .contains(preferredCodec) ==
                true)
            .toList();
        final candidates = matching.isEmpty ? formats : matching;
        if (candidates.isEmpty) continue;
        candidates.sort((a, b) =>
            (_int(b['bitrate']) ?? 0).compareTo(_int(a['bitrate']) ?? 0));
        final selected = candidates.first;
        final playbackHeaders = Map<String, String>.from(
          _map(spec['playbackHeaders']),
        );
        printINFO(
          '[EMusicProvider] Download source resolved with '
          '${spec['name'] ?? spec['clientName'] ?? 'UNKNOWN'} '
          '(${selected['bitrate'] ?? 0} bps, $preferredCodec)',
        );
        final uri = Uri.parse(selected['url'].toString());
        return PlaybackSource(
          type: PlaybackSourceType.authorizedStream,
          uri: uri,
          headers: playbackHeaders,
          mimeType: selected['mimeType']?.toString(),
          bitrate: _int(selected['bitrate']),
          contentLength: _int(selected['contentLength']),
          loudnessDb: _double(selected['loudnessDb']) ?? 0,
          expiresAt: _expiryFromUri(uri),
        );
      }
    } catch (error) {
      printWarning(
        '[EMusicProvider] Client download recipe failed; using server fallback: '
        '$error',
      );
    }
    return null;
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
    final token = await _tokenLoader();
    if (token == null || token.isEmpty) {
      throw const MusicProviderException(
          'A valid Joss Red session is required');
    }
    final base = _baseUrl().replaceAll(RegExp(r'/+$'), '');
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
            'Authorization': 'Bearer $token',
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
              'eMusic request failed (${response.statusCode})',
        );
      }
      return _map(data['data'] ?? data);
    } on DioException catch (error) {
      throw MusicProviderException('Unable to reach eMusic', cause: error);
    }
  }

  String get _requireProfileId {
    final value = _profileId;
    if (value == null) {
      throw const MusicProviderException('eMusic provider is not initialized');
    }
    return value;
  }

  void _requireCapability(bool supported, String name) {
    if (!supported) {
      throw MusicProviderException('eMusic does not support $name');
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
    _recipeCache = null;
    _recipeInFlight = null;
    _sourceCache.clear();
    _sourceInFlight.clear();
    _profileId = null;
    _capabilities = const ProviderCapabilities();
  }
}

class _EMusicLibrarySnapshot {
  const _EMusicLibrarySnapshot({
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
    // Signed URLs should not be handed to the player immediately before they
    // expire. Sources without an explicit expiry are kept only briefly.
    final expiresAt =
        source.expiresAt ?? createdAt.add(const Duration(minutes: 2));
    return DateTime.now().add(const Duration(seconds: 45)).isBefore(expiresAt);
  }
}

class _RecipeCacheEntry {
  _RecipeCacheEntry(Map<String, dynamic> data)
      : _data = copyOf(data),
        createdAt = DateTime.now();

  final Map<String, dynamic> _data;
  final DateTime createdAt;

  bool get isExpired =>
      DateTime.now().difference(createdAt) > EMusicProvider._recipeCacheTtl;

  Map<String, dynamic> copy() => copyOf(_data);

  static Map<String, dynamic> copyOf(Map<String, dynamic> value) =>
      Map<String, dynamic>.from(jsonDecode(jsonEncode(value)) as Map);
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
