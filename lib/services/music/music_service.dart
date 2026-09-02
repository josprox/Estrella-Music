// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:estrella_music/services/system/nav_parser.dart';

import 'home_service.dart';
import 'search_service.dart';
import 'artist_service.dart';
import 'playlist_album_service.dart';
import 'podcast_service.dart';
import 'track_service.dart';

enum AudioQuality {
  Low,
  High,
}

typedef MusicCatalogRequest = Future<Map<String, dynamic>> Function(
  String action,
  Map<dynamic, dynamic> payload,
  String additionalParams,
);

/// eMusic catalog and response parser owned by an online provider.
///
/// Every request is delegated to eMusic.
class MusicServices {
  MusicServices({
    required MusicCatalogRequest request,
    String? visitorData,
    String languageCode = 'en',
  }) : _request = request {
    final date = DateTime.now();
    _context['context']['client']['clientVersion'] =
        '1.${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}.01.00';
    _context['context']['client']['hl'] = languageCode;
    if (visitorData != null && visitorData.isNotEmpty) {
      _context['context']['client']['visitorData'] = visitorData;
    }
    homeService = HomeService(this);
    searchService = SearchService(this);
    artistService = ArtistService(this);
    playlistAlbumService = PlaylistAlbumService(this);
    podcastService = PodcastService(this);
    trackService = TrackService(this);
  }

  final MusicCatalogRequest _request;

  final Map<String, dynamic> _context = {
    'context': {
      'client': {
        "clientName": "WEB_REMIX",
        "clientVersion": "1.20230213.01.00",
        "visitorData": null,
      },
      'user': {}
    }
  };

  late final HomeService homeService;
  late final SearchService searchService;
  late final ArtistService artistService;
  late final PlaylistAlbumService playlistAlbumService;
  late final PodcastService podcastService;
  late final TrackService trackService;

  Map<String, dynamic> get context => _context;

  set hlCode(String code) {
    _context['context']['client']['hl'] = code;
  }

  Future<Response> sendRequest(String action, Map<dynamic, dynamic> data,
      {additionalParams = "", int attempt = 0}) async {
    try {
      final response = await _request(action, data, '$additionalParams');
      final dynamic rawData =
          (response.containsKey('response') && response['response'] is Map)
              ? response['response']
              : response;
      return Response<dynamic>(
        requestOptions: RequestOptions(path: action),
        statusCode: 200,
        data: rawData,
      );
    } catch (error) {
      // Do not immediately duplicate an expensive catalog request. A 502 or
      // timeout commonly means the upstream/server is already saturated; an
      // automatic retry from every client amplifies that outage. UI retries
      // remain explicit and provider-level caches serve successful responses.
      if (error is NetworkError) rethrow;
      throw NetworkError(message: '$error');
    }
  }

  String continuationParamsFromRenderer(dynamic renderer) {
    final continuationKey = nav(
        renderer, ['continuations', 0, 'nextContinuationData', 'continuation']);
    return continuationKey == null
        ? '&ctoken=null&continuation=null'
        : '&ctoken=$continuationKey&continuation=$continuationKey';
  }

  String continuationParamsFromResponse(Map<String, dynamic> response) {
    final appendedItems = nav(response, [
      'onResponseReceivedActions',
      0,
      'appendContinuationItemsAction',
      'continuationItems'
    ]);
    final appendedContinuationKey =
        appendedItems is List && appendedItems.isNotEmpty
            ? nav(appendedItems.last, [
                'continuationItemRenderer',
                'continuationEndpoint',
                'continuationCommand',
                'token'
              ])
            : null;
    final continuationKey = nav(response, [
          'continuationContents',
          'gridContinuation',
          'continuations',
          0,
          'nextContinuationData',
          'continuation'
        ]) ??
        nav(response, [
          'continuationContents',
          'musicPlaylistShelfContinuation',
          'continuations',
          0,
          'nextContinuationData',
          'continuation'
        ]) ??
        nav(response, [
          'continuationContents',
          'musicShelfContinuation',
          'continuations',
          0,
          'nextContinuationData',
          'continuation'
        ]) ??
        appendedContinuationKey;
    return continuationKey == null
        ? '&ctoken=null&continuation=null'
        : '&ctoken=$continuationKey&continuation=$continuationKey';
  }

  // --- HOME & EXPLORE DELEGATIONS ---
  Future<dynamic> getHome({int limit = 4}) => homeService.getHome(limit: limit);

  Future<List<Map<String, dynamic>>> getCharts(String catogory,
          {String? countryCode}) =>
      homeService.getCharts(catogory, countryCode: countryCode);

  Future<Map<String, dynamic>> getChartItems(
          Map<String, dynamic> item, String catogory) =>
      homeService.getChartItems(item, catogory);

  Future<dynamic> home() => homeService.home();

  Future<dynamic> explore({int limit = 4}) => homeService.explore(limit: limit);

  // --- SEARCH DELEGATIONS ---
  Future<List<String>> getSearchSuggestion(String queryStr) =>
      searchService.getSearchSuggestion(queryStr);

  Future<Map<String, dynamic>> search(String query,
          {String? filter,
          String? scope,
          int limit = 30,
          bool ignoreSpelling = false,
          String? filterParams}) =>
      searchService.search(query,
          filter: filter,
          scope: scope,
          limit: limit,
          ignoreSpelling: ignoreSpelling,
          filterParams: filterParams);

  Future<Map<String, dynamic>> getSearchContinuation(Map additionalParamsNext,
          {int limit = 10}) =>
      searchService.getSearchContinuation(additionalParamsNext, limit: limit);

  // --- ARTIST DELEGATIONS ---
  Future<Map<String, dynamic>> getArtist(String channelId) =>
      artistService.getArtist(channelId);

  Future<Map<String, dynamic>> getArtistRealtedContent(
          Map<String, dynamic> browseEndpoint, String category,
          {String additionalParams = ""}) =>
      artistService.getArtistRealtedContent(browseEndpoint, category,
          additionalParams: additionalParams);

  // --- PLAYLIST & ALBUM DELEGATIONS ---
  Future<String> getAlbumBrowseId(String audioPlaylistId) =>
      playlistAlbumService.getAlbumBrowseId(audioPlaylistId);

  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs(
          {String? playlistId,
          String? albumId,
          int limit = 3000,
          bool related = false,
          int suggestionsLimit = 0}) =>
      playlistAlbumService.getPlaylistOrAlbumSongs(
          playlistId: playlistId,
          albumId: albumId,
          limit: limit,
          related: related,
          suggestionsLimit: suggestionsLimit);

  // --- PODCAST DELEGATIONS ---
  Future<dynamic> podcastDiscover({int limit = 4}) =>
      podcastService.podcastDiscover(limit: limit);

  Future<Map<String, dynamic>> podcast(String channelId) =>
      podcastService.podcast(channelId);

  Future<List<dynamic>> getPodcastEpisodes(String browseId, String params,
          {int limit = 100}) =>
      podcastService.getPodcastEpisodes(browseId, params, limit: limit);

  Future<List<dynamic>> savedPodcastShows() =>
      podcastService.savedPodcastShows();

  Future<List<dynamic>> episodesForLater() => podcastService.episodesForLater();

  // --- TRACK & PLAYER DELEGATIONS ---
  Future<Map<String, dynamic>> getWatchPlaylist(
          {String videoId = "",
          String? playlistId,
          int limit = 25,
          bool radio = false,
          bool shuffle = false,
          String? additionalParamsNext,
          bool onlyRelated = false}) =>
      trackService.getWatchPlaylist(
          videoId: videoId,
          playlistId: playlistId,
          limit: limit,
          radio: radio,
          shuffle: shuffle,
          additionalParamsNext: additionalParamsNext,
          onlyRelated: onlyRelated);

  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
          String videoId, String hlCode) =>
      trackService.getContentRelatedToSong(videoId, hlCode);

  dynamic getLyrics(String browseId) => trackService.getLyrics(browseId);

  Future<List> getSongWithId(String songId) =>
      trackService.getSongWithId(songId);

  Future<String?> getSongYear(String songId) =>
      trackService.getSongYear(songId);
}

class NetworkError implements Exception {
  NetworkError({
    this.statusCode,
    this.responseData,
    this.message = "Network Error !",
  });

  final int? statusCode;
  final dynamic responseData;
  final String message;

  @override
  String toString() {
    return 'NetworkError(statusCode: $statusCode, message: $message, responseData: $responseData)';
  }
}
