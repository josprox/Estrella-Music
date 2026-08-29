import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../models/music_identity.dart';
import '../models/playback_source.dart';
import '../models/provider_capabilities.dart';
import '../models/provider_entities.dart';
import '../music_provider.dart';
import '../music_discovery_provider.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/music/music_service.dart';

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

class EMusicProvider implements MusicProvider, MusicDiscoveryProvider {
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
    final response = await _request('GET', 'capabilities');
    _capabilities = ProviderCapabilities.fromJson(
      _map(response['capabilities'] ?? response['data']),
    );
  }

  @override
  Future<void> refresh() async {}

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
    final context =
        await _playbackContextLoader?.call() ?? const EMusicPlaybackContext();
    final data = await _request(
      'POST',
      'catalog',
      body: {
        'action': action,
        'payload': payload.map((key, value) => MapEntry('$key', value)),
        'additionalParams': additionalParams,
        ...context.toJson(),
      },
    );
    return _map(data['response'] ?? data);
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
    final data = await _request('GET', 'tracks');
    return _list(data['tracks'] ?? data['data'])
        .map(_track)
        .toList(growable: false);
  }

  @override
  Future<ProviderTrack?> getTrack(String sourceId) async {
    _requireCapability(_capabilities.tracks, 'tracks');
    final data =
        await _request('GET', 'tracks/${Uri.encodeComponent(sourceId)}');
    final value = _map(data['track'] ?? data['data']);
    return value.isEmpty ? null : _track(value);
  }

  @override
  Future<List<ProviderAlbum>> getAlbums() async {
    _requireCapability(_capabilities.albums, 'albums');
    final data = await _request('GET', 'albums');
    return _list(data['albums'] ?? data['data'])
        .map(_album)
        .toList(growable: false);
  }

  @override
  Future<ProviderAlbum?> getAlbum(String sourceId) async {
    _requireCapability(_capabilities.albums, 'albums');
    final data =
        await _request('GET', 'albums/${Uri.encodeComponent(sourceId)}');
    final value = _map(data['album'] ?? data['data']);
    return value.isEmpty ? null : _album(value);
  }

  @override
  Future<List<ProviderArtist>> getArtists() async {
    _requireCapability(_capabilities.artists, 'artists');
    final data = await _request('GET', 'artists');
    return _list(data['artists'] ?? data['data'])
        .map(_artist)
        .toList(growable: false);
  }

  @override
  Future<ProviderArtist?> getArtist(String sourceId) async {
    _requireCapability(_capabilities.artists, 'artists');
    final data =
        await _request('GET', 'artists/${Uri.encodeComponent(sourceId)}');
    final value = _map(data['artist'] ?? data['data']);
    return value.isEmpty ? null : _artist(value);
  }

  @override
  Future<ProviderArtwork?> getArtwork(MusicIdentity identity) async {
    _requireCapability(_capabilities.artwork, 'artwork');
    final data = await _request(
      'GET',
      'artwork/${Uri.encodeComponent(identity.sourceId)}',
    );
    final url = data['url']?.toString();
    final encoded = data['bytes']?.toString();
    return ProviderArtwork(
      uri: url == null || url.isEmpty ? null : Uri.tryParse(url),
      bytes: encoded == null || encoded.isEmpty
          ? null
          : Uint8List.fromList(base64Decode(encoded)),
      mimeType: data['mimeType']?.toString(),
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

  @override
  Future<PlaybackSource> getPlayback(ProviderTrack track) async {
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
      final recipeData = await _request(
        'POST',
        'orchestrator/resolve-recipe',
        body: {'videoId': videoId},
      );
      final orchestration = _map(recipeData['orchestration']);
      recommendedClients = _list(orchestration['recommendedClients']);
      sts = _int(recipeData['signatureTimestamp']) ?? 20684;
      if (recipeData['visitorData'] != null) {
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
        printINFO(
            '[EMusicProvider] Client $clientName status: $status');
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
            return PlaybackSource(
              type: PlaybackSourceType.authorizedStream,
              uri: Uri.parse(url),
              headers: playHeaders,
              mimeType: best['mimeType']?.toString() ?? 'audio/mp4',
              bitrate: _int(best['bitrate']),
              loudnessDb: _double(best['loudnessDb']) ?? 0,
            );
          }
        }
      } catch (e) {
        printERROR('[EMusicProvider] Client $clientName resolution error: $e');
        continue;
      }
    }

    // 2. Fallback to server-side resolution endpoint
    final data = await _request(
      'POST',
      'playback',
      body: {
        'trackId': track.identity.sourceId,
        ...playbackContext.toJson(),
      },
    );
    final url = data['url']?.toString();
    if (url == null || url.isEmpty) {
      throw MusicProviderException(
        data['message']?.toString() ??
            'eMusic did not return a playback source',
      );
    }
    final rawHeaders = _map(data['headers']);
    return PlaybackSource(
      type: PlaybackSourceType.authorizedStream,
      uri: Uri.parse(url),
      headers: rawHeaders.map((key, value) => MapEntry(key, value.toString())),
      mimeType: data['mimeType']?.toString(),
      bitrate: _int(data['bitrate']),
      loudnessDb: _double(data['loudnessDb']) ?? 0,
      expiresAt: data['expiresAt'] == null
          ? null
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
          sourceId: _first(
              json, const ['sourceId', 'albumId', 'browseId', 'playlistId', 'id']),
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
    _profileId = null;
    _capabilities = const ProviderCapabilities();
  }
}
