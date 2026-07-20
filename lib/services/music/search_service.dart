import 'package:audio_service/audio_service.dart';
import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/services/system/nav_parser.dart';
import 'package:harmonymusic/services/system/utils.dart';
import 'package:harmonymusic/services/system/continuations.dart';
import 'package:harmonymusic/services/music/music_service.dart';

extension ListExtension<T> on List<T> {
  List<T> distinctBy(dynamic Function(T) keySelector) {
    final seen = <dynamic>{};
    return where((item) => seen.add(keySelector(item))).toList();
  }
}

class SearchService {
  final MusicServices _musicServices;

  SearchService(this._musicServices);

  Future<List<String>> getSearchSuggestion(String queryStr) async {
    final data = Map.from(_musicServices.context);
    data['input'] = queryStr;
    final res = nav(
            (await _musicServices.sendRequest("music/get_search_suggestions", data)).data,
            ['contents', 0, 'searchSuggestionsSectionRenderer', 'contents']) ??
        [];
    return res
        .map<String?>((item) {
          return (nav(item, [
            'searchSuggestionRenderer',
            'navigationEndpoint',
            'searchEndpoint',
            'query'
          ])).toString();
        })
        .whereType<String>()
        .toList();
  }

  Future<Map<String, dynamic>> search(String query,
      {String? filter,
      String? scope,
      int limit = 30,
      bool ignoreSpelling = false,
      String? filterParams}) async {
    final data = Map.of(_musicServices.context);
    data['context']['client']["hl"] = 'en';
    data['query'] = query;

    final Map<String, dynamic> searchResults = {};
    final filters = [
      'albums',
      'artists',
      'playlists',
      'community_playlists',
      'featured_playlists',
      'songs',
      'videos',
      'podcasts',
      'episodes',
      'profiles'
    ];

    if (filter != null && !filters.contains(filter)) {
      throw Exception(
          'Invalid filter provided. Please use one of the following filters or leave out the parameter: ${filters.join(', ')}');
    }

    final scopes = ['library', 'uploads'];

    if (scope != null && !scopes.contains(scope)) {
      throw Exception(
          'Invalid scope provided. Please use one of the following scopes or leave out the parameter: ${scopes.join(', ')}');
    }

    if (scope == scopes[1] && filter != null) {
      throw Exception(
          'No filter can be set when searching uploads. Please unset the filter parameter when scope is set to uploads.');
    }

    final params = getSearchParams(filter, scope, ignoreSpelling);

    if (filterParams != null || params != null) {
      data['params'] = filterParams ?? params;
    }

    final response = (await _musicServices.sendRequest("search", data)).data;

    dynamic results;

    if (response['contents'] != null && (response['contents']).containsKey('tabbedSearchResultsRenderer')) {
      final tabIndex =
          scope == null || filter != null ? 0 : scopes.indexOf(scope) + 1;
      results = response['contents']['tabbedSearchResultsRenderer']['tabs']
          [tabIndex]['tabRenderer']['content'];
    } else {
      results = response['contents'];
    }

    if (results == null) return searchResults;

    // Search Chips
    if (filter == null) {
      final searchChips = nav(results,
          ['sectionListRenderer', 'header', "chipCloudRenderer", "chips"]);

      searchResults['searchEndpoint'] = {};
      if (searchChips != null) {
        for (dynamic chipsItemRenderer in searchChips) {
          final chip = chipsItemRenderer['chipCloudChipRenderer'];
          final chipText = nav(chip, ['text', 'runs', 0, 'text']);
          searchResults['searchEndpoint'][chipText] =
              nav(chip, ['navigationEndpoint', 'searchEndpoint', 'params']);
        }
      }

      if ((searchResults['searchEndpoint'])
              .containsKey("Community playlists") &&
          !searchResults.containsKey("Community playlists")) {
        searchResults["Community playlists"] = [];
      }

      if ((searchResults['searchEndpoint']).containsKey("Featured playlists") &&
          !searchResults.containsKey("Featured playlists")) {
        searchResults["Featured playlists"] = [];
      }
    }

    results = nav(results, ['sectionListRenderer', 'contents']);
    if (results == null) return searchResults;

    String? type = filter?.substring(0, filter.length - 1).toLowerCase();

    for (var res in results) {
      if (res is! Map) continue;

      // Extract additional chips if present in sections (common in some YTM responses)
      final sectionChips = nav(res, ['itemSectionRenderer', 'header', "chipCloudRenderer", "chips"]) ??
                           nav(res, ["chipCloudRenderer", "chips"]);
      if (sectionChips != null && filter == null) {
        for (dynamic chipsItemRenderer in sectionChips) {
          final chip = chipsItemRenderer['chipCloudChipRenderer'];
          final chipText = nav(chip, ['text', 'runs', 0, 'text']);
          if (chipText != null) {
            searchResults['searchEndpoint'][chipText] =
                nav(chip, ['navigationEndpoint', 'searchEndpoint', 'params']);
          }
        }
      }

      if (res.containsKey('musicCardShelfRenderer')) {
        final card = res['musicCardShelfRenderer'];
        final topResult = parseTopResult(card,
            ['artist', 'playlist', 'song', 'video', 'station', 'podcast', 'episode', 'profile']);
        if (topResult != null) {
          _addToSearchResults(searchResults, 'Top result', [topResult]);
          
          if (card.containsKey('contents')) {
            final cardItems = parseSearchResults(card['contents'],
                ['artist', 'playlist', 'song', 'video', 'station', 'podcast', 'episode', 'profile'], null, 'Top result');
            if (filter == null) {
              _groupResultsByType(cardItems, searchResults);
            }
          }
        }
      } else if (res.containsKey('musicShelfRenderer')) {
        await _parseAndAddShelf(res['musicShelfRenderer'], searchResults, filter, type, data, limit);
      } else if (res.containsKey('musicCarouselShelfRenderer')) {
        await _parseAndAddShelf(res['musicCarouselShelfRenderer'], searchResults, filter, type, data, limit);
      } else if (res.containsKey('itemSectionRenderer')) {
        final sectionContents = res['itemSectionRenderer']['contents'];
        if (sectionContents is List) {
          bool hasShelves = false;
          for (var content in sectionContents) {
            if (content is Map && (content.containsKey('musicShelfRenderer') || content.containsKey('musicCarouselShelfRenderer'))) {
              hasShelves = true;
              break;
            }
          }
          if (hasShelves) {
            for (var content in sectionContents) {
              if (content is! Map) continue;
              if (content.containsKey('musicShelfRenderer')) {
                await _parseAndAddShelf(content['musicShelfRenderer'], searchResults, filter, type, data, limit);
              } else if (content.containsKey('musicCarouselShelfRenderer')) {
                await _parseAndAddShelf(content['musicCarouselShelfRenderer'], searchResults, filter, type, data, limit);
              }
            }
          } else {
            final parsedItems = parseSearchResults(
              sectionContents,
              ['artist', 'playlist', 'song', 'video', 'station', 'podcast', 'episode', 'profile'],
              type,
              'mixed',
            );
            if (parsedItems.isNotEmpty) {
              if (filter == null) {
                _groupResultsByType(parsedItems, searchResults);
              } else {
                _addToSearchResults(searchResults, 'mixed', parsedItems);
              }
            }
          }
        }
      }
    }

    if (filter == null) {
      final List<String> orderedKeys = [
        'Top result',
        'Songs',
        'Videos',
        'Albums',
        'Podcasts',
        'Episodes',
        'Artists',
        'Profiles',
        'Playlists',
        'Community playlists',
        'Featured playlists'
      ];
      final Map<String, dynamic> orderedResults = {};
      
      if (searchResults.containsKey('searchEndpoint')) {
        orderedResults['searchEndpoint'] = searchResults['searchEndpoint'];
      }
      
      for (var key in orderedKeys) {
        if (searchResults.containsKey(key) && searchResults[key] != null && (searchResults[key] as List).isNotEmpty) {
           orderedResults[key] = (searchResults[key] as List).distinctBy((item) => item is MediaItem ? item.id : (item is Artist ? item.browseId : (item is Album ? item.browseId : (item is Playlist ? item.playlistId : item.toString())))).toList();
        }
      }
      
      searchResults.forEach((key, value) {
        if (!orderedResults.containsKey(key) && key != 'searchEndpoint') {
          orderedResults[key] = value;
        }
      });
      
      return orderedResults;
    }

    return searchResults;
  }

  void _addToSearchResults(Map<String, dynamic> searchResults, String category, List<dynamic> items) {
    if (searchResults.containsKey(category)) {
      (searchResults[category] as List).addAll(items);
    } else {
      searchResults[category] = List<dynamic>.from(items);
    }
  }

  void _groupResultsByType(List<dynamic> items, Map<String, dynamic> searchResults) {
    for (var item in items) {
      String itemType = "Other";
      if (item is MediaItem) {
        final String? resType = item.extras?['resultType'];
        if (resType == 'episode') {
          itemType = "Episodes";
        } else if (resType == 'song') {
          itemType = "Songs";
        } else if (resType == 'video') {
          itemType = "Videos";
        }
      } else if (item is Artist) {
        itemType = item.isProfile ? "Profiles" : "Artists";
      } else if (item is Album) {
        itemType = item.isPodcast ? "Podcasts" : "Albums";
      } else if (item is Playlist) {
        itemType = "Playlists";
      }
      
      if (!searchResults.containsKey(itemType)) {
        searchResults[itemType] = [];
      }
      
      if ((searchResults[itemType] as List).length < 10) {
        (searchResults[itemType] as List).add(item);
      }
    }
  }

  Future<void> _parseAndAddShelf(
    Map<String, dynamic> shelf,
    Map<String, dynamic> searchResults,
    String? filter,
    String? type,
    Map<String, dynamic> data,
    int limit,
  ) async {
    final itemResults = shelf['contents'];
    if (itemResults == null) return;
    
    final apiTitle = nav(shelf, title_text) ?? nav(shelf, ['header', 'musicCarouselShelfBasicHeaderRenderer', 'title', 'runs', 0, 'text']);
    final category = apiTitle ?? "mixed";

    final mixedItems = parseSearchResults(
      itemResults,
      ['artist', 'playlist', 'song', 'video', 'station', 'podcast', 'episode', 'profile'],
      type,
      category,
    );

    if (filter == null) {
      if (apiTitle != null) {
        _addToSearchResults(searchResults, apiTitle, mixedItems);
      } else {
        _groupResultsByType(mixedItems, searchResults);
      }
    } else {
      _addToSearchResults(searchResults, category, mixedItems);
    }

    if (filter != null) {
      requestFunc(additionalParams) async =>
          (await _musicServices.sendRequest("search", data,
                  additionalParams: additionalParams))
              .data;
      parseFunc(contents) => parseSearchResults(contents,
          ['artist', 'playlist', 'song', 'video', 'station', 'podcast', 'episode', 'profile'], type, category);

      if (searchResults.containsKey(category)) {
        final x = await getContinuations(
            shelf,
            'musicShelfContinuation',
            limit - ((searchResults[category] as List).length),
            requestFunc,
            parseFunc,
            isAdditionparamReturnReq: true);

        searchResults["params"] = {
          'data': data,
          "type": type,
          "category": category,
          'additionalParams': x[1],
        };

        searchResults[category] = [
          ...(searchResults[category] as List),
          ...(x[0])
        ];
      }
    }
  }

  Future<Map<String, dynamic>> getSearchContinuation(Map additionalParamsNext,
      {int limit = 10}) async {
    final data = additionalParamsNext['data'];
    final type = additionalParamsNext['type'];
    final category = additionalParamsNext['category'];
    final Map<String, dynamic> searchResults = {};

    requestFunc(additionalParams) async =>
        (await _musicServices.sendRequest("search", data, additionalParams: additionalParams))
            .data;

    parseFunc(contents) => parseSearchResults(contents,
        ['artist', 'playlist', 'song', 'video', 'station', 'podcast', 'episode', 'profile'], type, category);

    final x = await getContinuations(
        {}, 'musicShelfContinuation', limit, requestFunc, parseFunc,
        isAdditionparamReturnReq: true,
        additionalParams_: additionalParamsNext['additionalParams']);

    searchResults["params"] = {
      "data": data,
      "type": type,
      "category": category,
      'additionalParams': x[1],
    };

    searchResults[category] = x[0];
    return searchResults;
  }
}
