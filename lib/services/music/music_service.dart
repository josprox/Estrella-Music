// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:harmonymusic/services/storage/sqlite_store.dart';

import 'package:harmonymusic/services/system/utils.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/system/constant.dart';
import 'package:harmonymusic/services/system/nav_parser.dart';

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

class MusicServices extends getx.GetxService {
  final Map<String, String> _headers = {
    'user-agent': userAgent,
    'accept': '*/*',
    'accept-encoding': 'gzip, deflate',
    'content-type': 'application/json',
    'content-encoding': 'gzip',
    'origin': domain,
    'cookie': 'CONSENT=YES+1',
  };

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

  @override
  void onInit() {
    homeService = HomeService(this);
    searchService = SearchService(this);
    artistService = ArtistService(this);
    playlistAlbumService = PlaylistAlbumService(this);
    podcastService = PodcastService(this);
    trackService = TrackService(this);
    init();
    super.onInit();
  }

  final dio = Dio();

  Map<String, dynamic> get context => _context;
  Map<String, String> get headers => _headers;

  Future<void>? _initFuture;

  Future<void> init() {
    _initFuture ??= _initImpl();
    return _initFuture!;
  }

  Future<void> _initImpl() async {
    //check visitor id in data base, if not generate one , set lang code
    final date = DateTime.now();
    _context['context']['client']['clientVersion'] =
        "1.${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}.01.00";
    final signatureTimestamp = getDatestamp() - 1;
    _context['playbackContext'] = {
      'contentPlaybackContext': {'signatureTimestamp': signatureTimestamp},
    };

    final appPrefsBox = SqliteStore.box('AppPrefs');
    hlCode = appPrefsBox.get('contentLanguage') ?? "en";
    if (appPrefsBox.containsKey('visitorId')) {
      final visitorData = appPrefsBox.get("visitorId");
      if (visitorData != null && !isExpired(epoch: visitorData['exp'])) {
        _headers['X-Goog-Visitor-Id'] = visitorData['id'];
        _context['context']['client']['visitorData'] = visitorData['id'];
        appPrefsBox.put("visitorId", {
          'id': visitorData['id'],
          'exp': DateTime.now().millisecondsSinceEpoch ~/ 1000 + 2590200
        });
        printINFO("Got Visitor id (${visitorData['id']}) from SqliteBox");
        return;
      }
    }

    final visitorId = await genrateVisitorId();
    if (visitorId != null) {
      _headers['X-Goog-Visitor-Id'] = visitorId;
      _context['context']['client']['visitorData'] = visitorId;
      printINFO("New Visitor id generated ($visitorId)");
      appPrefsBox.put("visitorId", {
        'id': visitorId,
        'exp': DateTime.now().millisecondsSinceEpoch ~/ 1000 + 2592000
      });
      return;
    }
    // not able to generate in that case
    final defaultId = visitorId ?? "CgttN24wcmd5UzNSWSi2lvq2BjIKCgJKUBIEGgAgYQ%3D%3D";
    _headers['X-Goog-Visitor-Id'] = defaultId;
    _context['context']['client']['visitorData'] = defaultId;
  }

  void setVisitorId(String id) {
    _headers['X-Goog-Visitor-Id'] = id;
    _context['context']['client']['visitorData'] = id;
    final appPrefsBox = SqliteStore.box('AppPrefs');
    appPrefsBox.put("visitorId", {
      'id': id,
      'exp': DateTime.now().millisecondsSinceEpoch ~/ 1000 + 2592000
    });
    printINFO("Visitor id updated manually ($id)");
  }

  set hlCode(String code) {
    _context['context']['client']['hl'] = code;
  }

  Future<String?> genrateVisitorId() async {
    // Try to get from sw.js_data first (Kotlin-like logic) with clean headers
    try {
      final swResponse = await dio.get(
        "https://music.youtube.com/sw.js_data",
        options: Options(
          headers: {
            'user-agent': userAgent,
            'accept': '*/*',
            'accept-encoding': 'gzip, deflate',
          },
          responseType: ResponseType.plain,
        ),
      );
      final rawData = swResponse.data.toString();
      String jsonStr = rawData;
      if (jsonStr.startsWith(")]}'")) {
        jsonStr = jsonStr.substring(jsonStr.indexOf('\n') + 1);
      }
      final decoded = json.decode(jsonStr);
      if (decoded is List && decoded.isNotEmpty) {
        final level1 = decoded[0];
        if (level1 is List && level1.length > 2) {
          final level2 = level1[2];
          if (level2 is List) {
            final visitorRegex = RegExp(r'^Cg[t|s]');
            for (var item in level2) {
              if (item is String && visitorRegex.hasMatch(item)) {
                printINFO("Got Visitor ID from sw.js_data: $item");
                return item;
              }
            }
          }
        }
      }
    } catch (e) {
      printERROR("Failed to get visitor data from sw.js_data: $e");
    }

    // Fallback to original ytcfg extraction with clean headers
    try {
      final response = await dio.get(
        domain,
        options: Options(
          headers: {
            'user-agent': userAgent,
            'accept': '*/*',
          },
          responseType: ResponseType.plain,
        ),
      );
      final reg = RegExp(r'ytcfg\.set\s*\(\s*({.+?})\s*\)\s*;');
      final matches = reg.firstMatch(response.data.toString());
      String? visitorId;
      if (matches != null) {
        final ytcfg = json.decode(matches.group(1).toString());
        visitorId = ytcfg['VISITOR_DATA']?.toString();
      }
      return visitorId;
    } catch (e) {
      printERROR("Failed to get visitor data from domain ytcfg: $e");
      return null;
    }
  }

  Future<Response> sendRequest(String action, Map<dynamic, dynamic> data,
      {additionalParams = "", int attempt = 0}) async {
    //print("$baseUrl$action$fixedParms$additionalParams          data:$data");
    try {
      final response =
          await dio.post("$baseUrl$action$fixedParms$additionalParams",
              options: Options(
                headers: _headers,
                validateStatus: (_) => true,
              ),
              data: data);

      if (response.statusCode == 200) {
        return response;
      }
      if (_shouldRetry(response.statusCode) && attempt < 1) {
        return sendRequest(
          action,
          data,
          additionalParams: additionalParams,
          attempt: attempt + 1,
        );
      }
      throw NetworkError(
        statusCode: response.statusCode,
        responseData: response.data,
        message: 'Request failed for $action',
      );
    } on DioException catch (e) {
      printINFO("Error $e");
      if (_shouldRetry(e.response?.statusCode) && attempt < 1) {
        return sendRequest(
          action,
          data,
          additionalParams: additionalParams,
          attempt: attempt + 1,
        );
      }
      throw NetworkError(
        statusCode: e.response?.statusCode,
        responseData: e.response?.data,
        message: e.message ?? 'Network Error',
      );
    }
  }

  bool _shouldRetry(int? statusCode) {
    if (statusCode == null) {
      return true;
    }
    return statusCode == 429 || statusCode >= 500;
  }

  String continuationParamsFromRenderer(dynamic renderer) {
    final continuationKey = nav(renderer, [
      'continuations',
      0,
      'nextContinuationData',
      'continuation'
    ]);
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

  Future<List<Map<String, dynamic>>> getCharts(String catogory, {String? countryCode}) =>
      homeService.getCharts(catogory, countryCode: countryCode);

  Future<Map<String, dynamic>> getChartItems(Map<String, dynamic> item, String catogory) =>
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

  Future<Map<String, dynamic>> getSearchContinuation(Map additionalParamsNext, {int limit = 10}) =>
      searchService.getSearchContinuation(additionalParamsNext, limit: limit);

  // --- ARTIST DELEGATIONS ---
  Future<Map<String, dynamic>> getArtist(String channelId) => artistService.getArtist(channelId);

  Future<Map<String, dynamic>> getArtistRealtedContent(Map<String, dynamic> browseEndpoint, String category,
          {String additionalParams = ""}) =>
      artistService.getArtistRealtedContent(browseEndpoint, category, additionalParams: additionalParams);

  // --- PLAYLIST & ALBUM DELEGATIONS ---
  Future<String> getAlbumBrowseId(String audioPlaylistId) => playlistAlbumService.getAlbumBrowseId(audioPlaylistId);

  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs(
          {String? playlistId, String? albumId, int limit = 3000, bool related = false, int suggestionsLimit = 0}) =>
      playlistAlbumService.getPlaylistOrAlbumSongs(
          playlistId: playlistId,
          albumId: albumId,
          limit: limit,
          related: related,
          suggestionsLimit: suggestionsLimit);

  // --- PODCAST DELEGATIONS ---
  Future<dynamic> podcastDiscover({int limit = 4}) => podcastService.podcastDiscover(limit: limit);

  Future<Map<String, dynamic>> podcast(String channelId) => podcastService.podcast(channelId);

  Future<List<dynamic>> getPodcastEpisodes(String browseId, String params, {int limit = 100}) =>
      podcastService.getPodcastEpisodes(browseId, params, limit: limit);

  Future<List<dynamic>> savedPodcastShows() => podcastService.savedPodcastShows();

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

  Future<List<Map<String, dynamic>>> getContentRelatedToSong(String videoId, String hlCode) =>
      trackService.getContentRelatedToSong(videoId, hlCode);

  dynamic getLyrics(String browseId) => trackService.getLyrics(browseId);

  Future<List> getSongWithId(String songId) => trackService.getSongWithId(songId);

  Future<String?> getSongYear(String songId) => trackService.getSongYear(songId);

  @override
  void onClose() {
    dio.close();
    super.onClose();
  }
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
