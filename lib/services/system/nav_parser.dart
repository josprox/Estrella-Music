//navigations
// ignore_for_file: constant_identifier_names, empty_catches

import 'package:audio_service/audio_service.dart';

import '/models/media_item_builder.dart';
import 'package:harmonymusic/services/system/utils.dart';
import 'package:harmonymusic/models/album.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/models/playlist.dart';

const single_column = ['contents', 'singleColumnBrowseResultsRenderer'];
const tab_content = ['tabs', 0, 'tabRenderer', 'content'];
const List<dynamic> single_column_tab = [
  'contents',
  'singleColumnBrowseResultsRenderer',
  'tabs',
  0,
  'tabRenderer',
  'content'
];
const section_list = ['sectionListRenderer', 'contents'];
const description_shelf = ['musicDescriptionShelfRenderer'];
const run_text = ['runs', 0, 'text'];
const description = ['description', 'runs', 0, 'text'];
const carousel_title = [
  'header',
  'musicCarouselShelfBasicHeaderRenderer',
  'title',
  'runs',
  0
];
const mtrir = 'musicTwoRowItemRenderer';
const mrlir = 'musicResponsiveListItemRenderer';
const mmrlir = 'musicMultiRowListItemRenderer';
const n_title = ['title', 'runs', 0]; //titile
const navigation_browse = ['navigationEndpoint', 'browseEndpoint'];
const page_type = [
  'browseEndpointContextSupportedConfigs',
  'browseEndpointContextMusicConfig',
  'pageType'
];
const navigation_watch_playlist_id = [
  'navigationEndpoint',
  'watchPlaylistEndpoint',
  'playlistId'
];
const audio_watch_playlist_id = [
  ...menu_items,
  0,
  'menuNavigationItemRenderer',
  ...navigation_watch_playlist_id
];
const title_text = ['title', 'runs', 0, 'text'];
const thumbnail_renderer = [
  'thumbnailRenderer',
  'musicThumbnailRenderer',
  'thumbnail',
  'thumbnails'
];
const navigation_playlist_id = [
  'navigationEndpoint',
  'watchEndpoint',
  'playlistId'
];
const navigation_video_id = ['navigationEndpoint', 'watchEndpoint', 'videoId'];
const subtitle2 = ['subtitle', 'runs', 2, 'text'];
const navigation_browse_id = [
  'navigationEndpoint',
  'browseEndpoint',
  'browseId'
];

const text_run_navigation_browse_id = [];

const subtitle_badge_label = [
  'subtitleBadges',
  0,
  'musicInlineBadgeRenderer',
  'accessibilityData',
  'accessibilityData',
  'label'
];
const text_run_text = ['text', 'runs', 0, 'text'];
const text_run = ['text', 'runs', 0];
const badge_label = [
  'badges',
  0,
  'musicInlineBadgeRenderer',
  'accessibilityData',
  'accessibilityData',
  'label'
];
const thumbnail = ['thumbnail', 'thumbnails'];
const thumbnails = [
  'thumbnail',
  'musicThumbnailRenderer',
  'thumbnail',
  'thumbnails'
];

const navigation_video_type = [
  'watchEndpoint',
  'watchEndpointMusicSupportedConfigs',
  'watchEndpointMusicConfig',
  'musicVideoType'
];
const toggle_menu = 'toggleMenuServiceItemRenderer';
const List<dynamic> menu_items = ['menu', 'menuRenderer', 'items'];
const menu_service = ['menuServiceItemRenderer', 'serviceEndpoint'];
const play_button = [
  'overlay',
  'musicItemThumbnailOverlayRenderer',
  'content',
  'musicPlayButtonRenderer'
];
const menu_like_status = [
  'menu',
  'menuRenderer',
  'topLevelButtons',
  0,
  'likeButtonRenderer',
  'likeStatus'
];
const List<dynamic> section_list_item = ['sectionListRenderer', 'contents', 0];
const List<dynamic> thumnail_cropped = [
  'thumbnail',
  'croppedSquareThumbnailRenderer',
  'thumbnail',
  'thumbnails'
];
const subtitle = ['subtitle', 'runs', 0, 'text'];
const subtitle3 = ['subtitle', 'runs', 4, 'text'];
const feedback_token = ['feedbackEndpoint', 'feedbackToken'];
const musicPlaylistShelfRenderer = [
  "contents",
  "twoColumnBrowseResultsRenderer",
  "secondaryContents",
  "sectionListRenderer",
  "contents",
  0,
  "musicPlaylistShelfRenderer",
];

List<Map<String, dynamic>> parseMixedContent(List<dynamic> rows) {
  List<Map<String, dynamic>> items = [];
  //inspect(rows);

  for (var row in rows) {
    dynamic title;
    dynamic contents = [];
    if (description_shelf[0] == row.keys.first.toString()) {
      var results = nav(row, description_shelf);
      title = nav(results, ['header', 'runs', 0, 'text']);
      contents = nav(results, description);
    } else {
      var results = row.values.first;
      if (!results.containsKey('contents')) {
        continue;
      }
      title = nav(results, carousel_title + ['text']);

      for (var result in results['contents']) {
        var data = nav(result, [mtrir]);
        dynamic content;
        if (data != null) {
          content = parseTwoRowItem(data);
        } else {
          data = nav(result, [mrlir]);
          if (data != null) {
            content = isEpisodeRenderer(data)
                ? parseEpisodeFlat(data)
                : parseSongFlat(data);
          } else {
            data = nav(result, [mmrlir]);
            if (data != null) {
              content = parseMultiRowEpisode(data);
            } else {
              continue;
            }
          }
        }

        if (content != null) {
          contents.add(content);
        }
      }

      items.add({'title': title, 'contents': contents});
    }
  }
  return items;
}

dynamic parseVideo(dynamic result) {
  final runs = nav(result, ['subtitle', 'runs']) as List?;
  if (runs == null || runs.isEmpty) return null;
  final runsLength = runs.length;
  final artistsLen = runsLength == 3 ? 1 : getDotSeparatorIndex(runs);
  return MediaItemBuilder.fromJson({
    'title': nav(result, title_text),
    'videoId': nav(result, navigation_video_id) ??
        nav(
          result,
          navigation_browse_id,
        ),
    'artists': parseSongArtistsRuns(runs.sublist(0, artistsLen)),
    'playlistId': nav(result, navigation_playlist_id),
    'thumbnails': nav(result, thumbnail_renderer) ??
        [
          {'url': ''}
        ],
    'views': runs[runs.length - 1]['text']?.split(' ')?.first
  });
}

dynamic parseSingle(dynamic result) {
  dynamic year;
  try {
    year = int.parse(nav(result, subtitle));
  } catch (e) {
    year = nav(result, ["subtitle", "runs", 2, "text"]);
  }
  return Album.fromJson({
    'title': nav(result, title_text),
    'artists': [
      {'name': 'Single'}
    ],
    'audioPlaylistId': nav(result, audio_watch_playlist_id),
    'year': "${year ?? ""}",
    'browseId': getRendererBrowseId(result),
    'thumbnails': nav(result, thumbnail_renderer) ??
        [
          {'url': ''}
        ],
    'description': (nav(result, ["subtitle", "runs"]) as List?)
            ?.map((run) => run['text'])
            .join('') ??
        ''
  });
}

MediaItem parseSong(Map<String, dynamic> result) {
  final playableVideoId = nav(result, navigation_video_id) ??
      nav(result, [
        ...play_button,
        'playNavigationEndpoint',
        'watchEndpoint',
        'videoId'
      ]) ??
      nav(result, ['onTap', 'watchEndpoint', 'videoId']);
  var song = {
    'title': nav(result, title_text),
    // Artist popular tracks commonly expose the playable id only inside the
    // thumbnail overlay. A browseId identifies catalog navigation and cannot
    // be sent to the audio resolver as if it were a video id.
    'videoId': playableVideoId ?? nav(result, navigation_browse_id),
    'playlistId': nav(result, navigation_playlist_id,
        noneIfAbsent: true, funName: "parseSong"),
    'thumbnails': nav(result, thumbnail_renderer) ??
        [
          {'url': ''}
        ],
  };

  final runs = nav(result, ['subtitle', 'runs']);
  if (runs != null) {
    song.addAll(parseSongRuns(runs));
  }
  return MediaItemBuilder.fromJson(song);
}

Map<String, dynamic> parseSongRuns(List<dynamic> runs) {
  final Map<String, dynamic> parsed = {'artists': []};
  final split = cleanMetadataSections(splitBySeparator(runs));

  if (split.isEmpty) return parsed;

  // First section: Artists (usually)
  parsed['artists'] = parseSongArtistsRuns(split[0]);

  if (split.length > 1) {
    for (int i = 1; i < split.length; i++) {
      final section = split[i];
      if (section.isEmpty) continue;
      final text = section[0]['text'];
      final browseId = nav(section[0], navigation_browse_id);
      final pageTypeVal = nav(section[0], navigation_browse + page_type);

      if (browseId != null) {
        if (browseId.startsWith('MPRE') ||
            pageTypeVal == "MUSIC_PAGE_TYPE_ALBUM") {
          parsed['album'] = {'name': text, 'id': browseId};
        } else if (pageTypeVal == "MUSIC_PAGE_TYPE_ARTIST" ||
            pageTypeVal == "MUSIC_PAGE_TYPE_USER_CHANNEL") {
          parsed['artists'].add({'name': text, 'id': browseId});
        }
      } else {
        // Fallback for text-only metadata
        if (RegExp(r"^(\d+:)*\d+:\d+$").hasMatch(text)) {
          parsed['length'] = text;
          parsed['duration_seconds'] = parseDuration(text);
        } else if (RegExp(r"^\d{4}$").hasMatch(text)) {
          parsed['year'] = text;
        } else if (text.toLowerCase().contains('vistas') ||
            text.toLowerCase().contains('views')) {
          parsed['views'] = text.split(' ')[0];
        }
      }
    }
  }
  return parsed;
}

List<List<dynamic>> cleanMetadataSections(List<List<dynamic>> sections) {
  if (sections.isEmpty || sections.first.isEmpty) return sections;
  final firstRun = sections.first.first;
  final firstText = firstRun['text']?.toString() ?? '';
  final hasNavigation = firstRun['navigationEndpoint'] != null;
  final looksLikePlainTypeLabel = !hasNavigation &&
      !RegExp(r'[&,]').hasMatch(firstText) &&
      !RegExp(r'^(\d+:)*\d+:\d+$').hasMatch(firstText) &&
      !RegExp(r'^\d{4}$').hasMatch(firstText);
  return looksLikePlainTypeLabel ? sections.skip(1).toList() : sections;
}

Album parseAlbum(Map<String, dynamic> result, {bool reqAlbumObj = true}) {
  final List runs = nav(result, ['subtitle', 'runs']) ?? [];
  final Map<String, dynamic> artistInfo = parseSongRuns(runs);
  Map albumMap = {
    'title': nav(result, title_text),
    'browseId': getRendererBrowseId(result),
    'thumbnails': nav(result, thumbnail_renderer) ??
        [
          {'url': ''}
        ],
    'audioPlaylistId': nav(result, audio_watch_playlist_id),
    'description': (nav(result, ["subtitle", "runs"]) as List?)
            ?.map((run) => run['text'])
            .join('') ??
        ''
  };
  albumMap.addAll(artistInfo);
  return Album.fromJson(albumMap);
}

Artist parseRelatedArtist(Map<String, dynamic> data) {
  final type = getPageType(data);
  return Artist.fromJson({
    'artist': nav(data, title_text),
    'browseId': getRendererBrowseId(data),
    'thumbnails': nav(data, thumbnail_renderer),
    'isProfile': type == "MUSIC_PAGE_TYPE_USER_CHANNEL",
  });
}

Playlist parsePlaylist(Map<String, dynamic> data) {
  //inspect(data);
  Map<String, dynamic> playlist = {
    'title': nav(data, title_text),
    'playlistId': getRendererBrowseId(data),
    'browseId': getRendererBrowseId(data),
    'thumbnails': nav(data, thumbnail_renderer) ??
        [
          {'url': ''}
        ]
  };

  var subtitle = data['subtitle'];
  if (subtitle != null && subtitle.containsKey('runs')) {
    var runs = subtitle['runs'];
    playlist['description'] = runs.map((run) => run['text']).join('');
    if (runs.length == 3 && RegExp(r'\d+ ').hasMatch(nav(data, subtitle2))) {
      playlist['count'] = nav(data, subtitle2).split(' ')[0];
      playlist['author'] = parseSongArtistsRuns(runs.sublist(0, 1));
    }
  }

  return Playlist.fromJson(playlist);
}

List<dynamic> parseSongArtistsRuns(List<dynamic> runs) {
  //print(runs);
  List<Map<String, dynamic>> artists = [];
  for (var j = 0; j < runs.length; j += 2) {
    artists.add({
      'name': runs[j]['text'],
      'id': nav(runs[j], navigation_browse_id,
          noneIfAbsent: false, funName: "parseSongArtistsRuns"),
    });
  }
  return artists;
}

MediaItem parseSongFlat(Map<String, dynamic> data) {
  //print(data);
  List<Map<String, dynamic>> columns = [];
  for (int i = 0; i < data['flexColumns'].length; i++) {
    columns.add(getFlexColumnItem(data, i));
  }

  Map<String, dynamic> song = {
    'title': nav(columns[0], text_run_text),
    'videoId': nav(columns[0], text_run + navigation_video_id,
            noneIfAbsent: true, funName: "parseSongFlat") ??
        nav(columns[0], text_run + navigation_browse_id,
            noneIfAbsent: true, funName: "parseSongFlat") ??
        nav(data, ['playlistItemData', 'videoId'],
            noneIfAbsent: true, funName: "parseSongFlat") ??
        (nav(data, play_button) != null &&
                nav(data, play_button)['playNavigationEndpoint'] != null &&
                nav(data, play_button)['playNavigationEndpoint']
                        ['watchEndpoint'] !=
                    null
            ? nav(data, play_button)['playNavigationEndpoint']['watchEndpoint']
                ['videoId']
            : null) ??
        nav(data, ['onTap', 'watchEndpoint', 'videoId']),
    'artists': parseSongArtists(data, 1),
    'thumbnails': nav(data, thumbnails) ??
        [
          {'url': ''}
        ],
    //'isExplicit': nav(data, badge_label, noneIfAbsent: true) != null
  };
//checkpoint .contains
  if (columns.length > 2 && columns[2].isNotEmpty) {
    if (nav(columns[2], text_run).containsKey('navigationEndpoint')) {
      song['album'] = {
        'name': nav(columns[2], text_run_text),
        'id': nav(columns[2], text_run + navigation_browse_id)
      };
    }
  }

  return MediaItemBuilder.fromJson(song);
}

List<dynamic>? parseSongArtists(Map<String, dynamic> data, int index) {
  dynamic flexItem = getFlexColumnItem(data, index);
  if (flexItem == null || flexItem.length == 0) {
    return null;
  } else {
    var runs = flexItem['text']['runs'];
    return parseSongArtistsRuns(runs);
  }
}

Map<String, dynamic> getFlexColumnItem(Map<String, dynamic> item, int index) {
  if (item['flexColumns'] == null ||
      (item['flexColumns']).length <= index ||
      item['flexColumns'][index]['musicResponsiveListItemFlexColumnRenderer'] ==
          null ||
      !item['flexColumns'][index]['musicResponsiveListItemFlexColumnRenderer']
          .containsKey('text') ||
      item['flexColumns'][index]['musicResponsiveListItemFlexColumnRenderer']
              ['text'] ==
          null ||
      !item['flexColumns'][index]['musicResponsiveListItemFlexColumnRenderer']
              ['text']
          .containsKey('runs')) {
    return {};
  }

  return item['flexColumns'][index]
      ['musicResponsiveListItemFlexColumnRenderer'];
}

Map<String, dynamic> parseWatchPlaylistHome(Map<String, dynamic> data) {
  return {
    'title': nav(data, title_text),
    'playlistId': nav(data, navigation_watch_playlist_id),
    'thumbnails': nav(data, thumbnail_renderer),
  };
}

//For Song Watch Playlist

List<dynamic> parseWatchPlaylist(List<dynamic> results) {
  final tracks = [];
  const PPVWR = 'playlistPanelVideoWrapperRenderer';
  const PPVR = 'playlistPanelVideoRenderer';
  for (var result in results) {
    Map<String, dynamic>? counterpart;
    if (result.containsKey(PPVWR)) {
      counterpart =
          result[PPVWR]['counterpart'][0]['counterpartRenderer'][PPVR];
      result = result[PPVWR]['primaryRenderer'];
    }
    if (!result.containsKey(PPVR)) {
      continue;
    }
    final data = result[PPVR];
    if (data.containsKey('unplayableText')) {
      continue;
    }
    final track = parseWatchTrack(data);
    if (counterpart != null) {
      track['counterpart'] = parseWatchTrack(counterpart);
    }
    tracks.add(MediaItemBuilder.fromJson(track));
  }
  return tracks;
}

Map<String, dynamic> parseWatchTrack(Map<String, dynamic> data) {
  final songInfo = parseSongRuns(data['longBylineText']['runs']);

  final track = {
    'videoId': data['videoId'],
    'title': nav(data, title_text),
    'length': nav(data, ['lengthText', 'runs', 0, 'text']),
    'thumbnails': nav(data, thumbnail) ??
        [
          {'url': ''}
        ],
    'videoType': nav(data, ['navigationEndpoint'] + navigation_video_type),
  };
  track.addAll(songInfo);
  return track;
}

String? getTabBrowseId(Map<String, dynamic>? watchNextRenderer, int tabId) {
  final tabs = watchNextRenderer?['tabs'];
  if (tabs is! List || tabId < 0 || tabId >= tabs.length) return null;
  final tab = tabs[tabId];
  if (tab is! Map) return null;
  final renderer = tab['tabRenderer'];
  if (renderer is! Map || renderer.containsKey('unselectable')) return null;

  final browseId = nav(renderer, ['endpoint', 'browseEndpoint', 'browseId']) ??
      nav(renderer, ['navigationEndpoint', 'browseEndpoint', 'browseId']) ??
      nav(renderer, ['onTap', 'browseEndpoint', 'browseId']);
  return browseId?.toString();
}

///Parse playlist songs, Also used in Album Song parsing
///
///[dynamic album,dynamic artists] used in Album case
List<dynamic> parsePlaylistItems(List<dynamic> results,
    {List<List<dynamic>>? menuEntries,
    dynamic thumbnailsM,
    dynamic artistsM,
    String? albumYear,
    dynamic albumIdName,
    bool isAlbum = false}) {
  List<MediaItem> songs = [];

  //int count = 1;
  for (dynamic result in results) {
    // count += 1;
    if (!result.containsKey('musicResponsiveListItemRenderer')) {
      continue;
    }
    dynamic data = result['musicResponsiveListItemRenderer'];
    String? videoId;
    String? trackDetails;

    videoId = nav(data, ['playlistItemData', 'videoId']);

    if (videoId == null && isAlbum) {
      final creditId = nav(data, [
        'menu',
        'menuRenderer',
        'items',
        5,
        'menuNavigationItemRenderer',
        'navigationEndpoint',
        'browseEndpoint',
        'browseId'
      ]);
      videoId = creditId?.split("MPTC")[1];
    }

    if (isAlbum) {
      // Contains track number and total tracks
      trackDetails = data?["index"] != null
          ? "${nav(data, ['index', 'runs', 0, 'text'])}/${results.length}"
          : null;
    }

    // if the item has a menu, find its setVideoId
    if (videoId == null) {
      if (data.containsKey('menu')) {
        for (dynamic item in nav(data, menu_items)) {
          if (item.containsKey('menuServiceItemRenderer')) {
            dynamic menuService = nav(item, menu_service);
            //inspect(menuService);

            if (menuService.containsKey('playlistEditEndpoint')) {
              videoId = menuService['playlistEditEndpoint']['actions'][0]
                  ['removedVideoId'];
              // print("$videoId");
            }
          }
        }
      }
    }

    // if item is not playable, the videoId was retrieved above
    if (videoId == null && nav(data, play_button) != null) {
      if (nav(data, play_button).containsKey('playNavigationEndpoint')) {
        videoId = nav(data, play_button)['playNavigationEndpoint']
            ['watchEndpoint']['videoId'];
      }
    }

    String? title = getItemText(data, 0);
    if (title == 'Song deleted') {
      continue;
    }

    List? artists = parseSongArtists(data, 1);

    dynamic album = isAlbum ? albumIdName : parseSongAlbum({...data}, 2);

    dynamic duration;
    if (data.containsKey('fixedColumns')) {
      if (getFixedColumnItem(data, 0)!['text'].containsKey('simpleText')) {
        duration = getFixedColumnItem(data, 0)!['text']['simpleText'];
      } else {
        duration = getFixedColumnItem(data, 0)!['text']['runs'][0]['text'];
      }
    }

    dynamic thumbnails_;
    if (data.containsKey('thumbnail')) {
      thumbnails_ = nav(data, thumbnails);
    }

    bool isAvailable = true;
    if (data.containsKey('musicItemRendererDisplayPolicy')) {
      isAvailable = data['musicItemRendererDisplayPolicy'] !=
          'MUSIC_ITEM_RENDERER_DISPLAY_POLICY_GREY_OUT';
    }

    //print('here');
    dynamic song = {
      'videoId': videoId,
      'title': title,
      'album': album,
      'artists': artists ?? artistsM,
      'thumbnails': (isAlbum ? thumbnailsM : thumbnails_ ?? thumbnailsM) ??
          [
            {'url': ''}
          ],
      'isAvailable': isAvailable,
      'trackDetails': trackDetails
    };

    if (duration != null) {
      song['length'] = duration;
      song['duration_seconds'] = parseDuration(duration);
    }

    if (menuEntries != null) {
      for (final List<dynamic> menuEntry in menuEntries) {
        song[menuEntry.last] = nav(data,
            menu_items + menuEntry.map((e) => e).whereType<String>().toList());
      }
    }
    if (song['videoId'] != null) {
      songs.add(MediaItemBuilder.fromJson(song));
    }
  }
  return songs;
}

Map<String, dynamic>? parseSongAlbum(Map<String, dynamic> data, int index) {
  Map<String, dynamic> flexItem = getFlexColumnItem(data, index);
  // print("here");
  if (flexItem.isNotEmpty) {
    return {
      'name': getItemText(data, index),
      'id': getBrowseId(flexItem, 0),
    };
  }
  return null;
}

String? getBrowseId(Map<String, dynamic> item, int index) {
  if (item['text']['runs'][index].containsKey('navigationEndpoint')) {
    return nav(item['text']['runs'][index], navigation_browse_id);
  }
  return null;
}

Map<String, dynamic> parseSongMenuTokens(Map<String, dynamic> item) {
  Map<String, dynamic> toggleMenu = item[toggle_menu];
  String serviceType = toggleMenu['defaultIcon']['iconType'];
  Map<String, dynamic> libraryAddToken =
      nav(toggleMenu, ['defaultServiceEndpoint', ...feedback_token]);
  Map<String, dynamic> libraryRemoveToken =
      nav(toggleMenu, ['toggledServiceEndpoint', ...feedback_token]);

  if (serviceType == "LIBRARY_REMOVE") {
    // swap if already in library
    Map<String, dynamic> temp = libraryAddToken;
    libraryAddToken = libraryRemoveToken;
    libraryRemoveToken = temp;
  }

  return {'add': libraryAddToken, 'remove': libraryRemoveToken};
}

dynamic nav(dynamic root, List items,
    {bool noneIfAbsent = false, String funName = "d"}) {
  try {
    dynamic res = root;
    for (final item in items) {
      res = res[item];
    }
    return res;
  } catch (e) {
    return null;
  }
}

//search parsers
dynamic parseTopResult(
    Map<String, dynamic> data, List<String> searchResultTypes) {
  Map<String, dynamic> searchResult = {};
  final subtitleRuns = nav(data, ['subtitle', 'runs']);

  String? resultType;
  final onTapBrowse = nav(data, ['onTap', 'browseEndpoint']);
  final onTapPageType = nav(onTapBrowse, [
    'browseEndpointContextSupportedConfigs',
    'browseEndpointContextMusicConfig',
    'pageType'
  ]);
  if (onTapPageType == 'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE') {
    resultType = 'podcast';
  } else if (onTapPageType == 'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE') {
    resultType = 'episode';
  } else if (onTapPageType == 'MUSIC_PAGE_TYPE_ALBUM' ||
      onTapPageType == 'MUSIC_PAGE_TYPE_AUDIOBOOK') {
    resultType = 'album';
  } else if (onTapPageType == 'MUSIC_PAGE_TYPE_ARTIST' ||
      onTapPageType == 'MUSIC_PAGE_TYPE_USER_CHANNEL') {
    resultType =
        onTapPageType == 'MUSIC_PAGE_TYPE_USER_CHANNEL' ? 'profile' : 'artist';
  } else if (onTapPageType == 'MUSIC_PAGE_TYPE_PLAYLIST') {
    resultType = 'playlist';
  }

  if (subtitleRuns != null && subtitleRuns.isNotEmpty) {
    resultType ??= getSearchResultType(subtitleRuns[0], searchResultTypes);
  }

  if (resultType == null) {
    final titleRun = nav(data, ['title', 'runs', 0]);
    if (titleRun != null) {
      resultType = getSearchResultType(titleRun, searchResultTypes);
    }
  }

  searchResult['resultType'] = resultType;

  if (resultType == 'artist' || resultType == 'profile') {
    searchResult['artist'] = nav(data, title_text);
    searchResult['title'] = searchResult['artist'];
    searchResult['browseId'] = nav(onTapBrowse, ['browseId']) ??
        nav(data, ['title', 'runs', 0, ...navigation_browse_id]);
    searchResult['isProfile'] = resultType == 'profile';
    if (subtitleRuns != null && subtitleRuns.length >= 3) {
      searchResult['subscribers'] = subtitleRuns[2]['text'].split(' ')[0];
    }
    searchResult['thumbnails'] = nav(data, [
          'thumbnail',
          'musicThumbnailRenderer',
          'thumbnail',
          'thumbnails'
        ]) ??
        [
          {'url': ''}
        ];
    return Artist.fromJson(searchResult);
  }

  if (resultType == 'playlist') {
    searchResult['title'] = nav(data, title_text) ??
        nav(data, [
          'header',
          'musicCardShelfHeaderBasicRenderer',
          'title',
          'runs',
          0,
          'text'
        ]);
    searchResult['playlistId'] = nav(onTapBrowse, ['browseId']) ??
        nav(data, ['title', 'runs', 0, ...navigation_browse_id]);
    searchResult['browseId'] = searchResult['playlistId'];
    searchResult['thumbnails'] = nav(data, [
          'thumbnail',
          'musicThumbnailRenderer',
          'thumbnail',
          'thumbnails'
        ]) ??
        nav(data, thumbnails) ??
        [
          {'url': ''}
        ];
    searchResult['description'] =
        subtitleRuns?.map((run) => run['text']).join('') ?? 'Playlist';
    return Playlist.fromJson(searchResult);
  }

  if (resultType == 'song' ||
      resultType == 'video' ||
      resultType == 'album' ||
      resultType == 'podcast' ||
      resultType == 'episode') {
    searchResult['title'] = nav(data, title_text);
    searchResult['thumbnails'] = nav(data, [
          'thumbnail',
          'musicThumbnailRenderer',
          'thumbnail',
          'thumbnails'
        ]) ??
        nav(data, thumbnails) ??
        [
          {'url': ''}
        ];

    if (subtitleRuns != null) {
      final split = splitBySeparator(subtitleRuns);
      // Metrolist logic: first subtitle is usually the type (e.g. "Song")
      // We skip the first part if it matches a known type label
      final infoRuns = [];
      int startIdx = 0;
      if (split.isNotEmpty && split[0].isNotEmpty) {
        final firstText = split[0][0]['text']?.toLowerCase();
        if (firstText != null &&
            (firstText.contains('canción') ||
                firstText.contains('song') ||
                firstText.contains('video') ||
                firstText.contains('álbum') ||
                firstText.contains('album') ||
                firstText.contains('artista') ||
                firstText.contains('artist') ||
                firstText.contains('podcast') ||
                firstText.contains('episodio') ||
                firstText.contains('episode'))) {
          startIdx = 1;
        }
      }

      for (int i = startIdx; i < split.length; i++) {
        infoRuns.addAll(split[i]);
        if (i < split.length - 1) infoRuns.add({'text': ' • '});
      }
      searchResult.addAll(parseSongRuns(infoRuns));
    }

    if (resultType == 'album' || resultType == 'podcast') {
      searchResult['isPodcast'] = (resultType == 'podcast');
      searchResult['browseId'] = nav(onTapBrowse, ['browseId']) ??
          nav(data, ['title', 'runs', 0, ...navigation_browse_id]);
      return Album.fromJson(searchResult);
    }

    if (resultType == 'episode') {
      final sections = splitBySeparator(subtitleRuns);
      final podcast = extractPodcastMetadata(sections);
      searchResult['isEpisode'] = true;
      searchResult['podcastId'] = podcast['podcastId'];
      searchResult['podcastTitle'] = podcast['podcastTitle'];
      searchResult['publishDate'] = podcast['publishDate'];
      searchResult['album'] = podcast['podcastTitle'] == null
          ? null
          : {'name': podcast['podcastTitle'], 'id': podcast['podcastId']};
      searchResult['artists'] = podcast['podcastTitle'] == null
          ? null
          : [
              {'name': podcast['podcastTitle'], 'id': podcast['podcastId']}
            ];
      searchResult['length'] ??= extractDurationText(sections);
    }
    searchResult['videoId'] =
        nav(data, ['onTap', 'watchEndpoint', 'videoId']) ??
            nav(data, ['title', 'runs', 0, ...navigation_video_id]);

    return MediaItemBuilder.fromJson(searchResult);
  }

  return searchResult;
}

String? getSearchResultType(dynamic data, List<String> resultTypesLocal) {
  // If data is a run (from subtitle)
  if (data is Map &&
      data.containsKey('text') &&
      !data.containsKey('flexColumns')) {
    final text = data['text']?.toLowerCase();
    if (text == null) return null;
    if (text.contains('canción') || text.contains('song')) return 'song';
    if (text.contains('video')) return 'video';
    if (text.contains('álbum') || text.contains('album')) return 'album';
    if (text.contains('artista') || text.contains('artist')) return 'artist';
    if (text.contains('podcast')) return 'podcast';
    if (text.contains('episodio') || text.contains('episode')) return 'episode';
    if (text.contains('profile')) return 'profile';
    if (text.contains('playlist') || text.contains('lista')) return 'playlist';
    return null;
  }

  // If data is a renderer
  final pageTypeVal = nav(data, navigation_browse + page_type);

  if (pageTypeVal == 'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE') {
    return 'podcast';
  }
  if (pageTypeVal == 'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE') {
    return 'episode';
  }
  if (pageTypeVal == 'MUSIC_PAGE_TYPE_ALBUM' ||
      pageTypeVal == 'MUSIC_PAGE_TYPE_AUDIOBOOK') {
    return 'album';
  }
  if (pageTypeVal == 'MUSIC_PAGE_TYPE_USER_CHANNEL') {
    return 'profile';
  }
  if (pageTypeVal == 'MUSIC_PAGE_TYPE_ARTIST' ||
      pageTypeVal == 'MUSIC_PAGE_TYPE_LIBRARY_ARTIST') {
    return 'artist';
  }
  if (pageTypeVal == 'MUSIC_PAGE_TYPE_PLAYLIST') {
    return 'playlist';
  }

  if (data is Map && data.containsKey('flexColumns')) {
    if (isEpisodeRenderer(Map<String, dynamic>.from(data))) {
      return 'episode';
    }
    String? resultTypeLocal = getItemText(Map<String, dynamic>.from(data), 1);
    if (resultTypeLocal != null) {
      resultTypeLocal = resultTypeLocal.toLowerCase();
      if (resultTypesLocal.contains(resultTypeLocal)) {
        return resultTypeLocal;
      }
      if (resultTypeLocal.contains('canción') ||
          resultTypeLocal.contains('song')) {
        return 'song';
      }
      if (resultTypeLocal.contains('video')) return 'video';
      if (resultTypeLocal.contains('álbum') ||
          resultTypeLocal.contains('album')) {
        return 'album';
      }
      if (resultTypeLocal.contains('artista') ||
          resultTypeLocal.contains('artist')) {
        return 'artist';
      }
      if (resultTypeLocal.contains('podcast')) return 'podcast';
      if (resultTypeLocal.contains('episodio') ||
          resultTypeLocal.contains('episode')) {
        return 'episode';
      }
      if (resultTypeLocal.contains('profile')) return 'profile';
      if (resultTypeLocal.contains('playlist') ||
          resultTypeLocal.contains('lista')) {
        return 'playlist';
      }
    }
  }

  return null;
}

List<dynamic> parseSearchResults(List<dynamic> results,
    List<String> searchResultTypes, String? resultType, String category) {
  return results
      .map((result) {
        if (result is! Map) return null;
        if (result.containsKey('musicResponsiveListItemRenderer')) {
          return parseSearchResult(
              Map<String, dynamic>.from(
                  result['musicResponsiveListItemRenderer']),
              searchResultTypes,
              resultType,
              category);
        } else if (result.containsKey('musicTwoRowItemRenderer')) {
          return parseTwoRowItem(
              Map<String, dynamic>.from(result['musicTwoRowItemRenderer']));
        }
        return parseSearchResult(Map<String, dynamic>.from(result),
            searchResultTypes, resultType, category);
      })
      .where((e) => e != null)
      .toList();
}

dynamic parseSearchResult(Map<String, dynamic> data,
    List<String> searchResultTypes, String? resultType, String? category) {
  if ((resultType != null && resultType.contains("playlist")) ||
      (category != null && category.toLowerCase().contains("playlist"))) {
    resultType = 'playlist';
  }

  if (resultType == null && isEpisodeRenderer(data)) {
    resultType = 'episode';
  }

  String? videoType = nav(data,
      [...play_button, 'playNavigationEndpoint', ...navigation_video_type]);
  if (videoType != null && resultType != 'episode') {
    resultType = (videoType == 'MUSIC_VIDEO_TYPE_ATV') ? 'song' : 'video';
  }

  resultType =
      (resultType ?? getSearchResultType(data, searchResultTypes)) ?? 'other';

  Map<String, dynamic> searchResult = {
    'category': category,
    'resultType': resultType,
  };

  if (resultType != 'artist') {
    searchResult['title'] = getItemText(data, 0);
  }

  final flexItem1 = getFlexColumnItem(data, 1);
  final List? runs = flexItem1['text']?['runs'];

  if (resultType == 'artist' || resultType == 'profile') {
    searchResult['artist'] = getItemText(data, 0);
    searchResult['title'] = searchResult['artist'];
    searchResult['isProfile'] = (resultType == 'profile');
    if (runs != null && runs.length >= 3) {
      searchResult['subscribers'] = runs[2]['text']?.split(' ')?.first;
    }
  } else if (resultType == 'album') {
    searchResult['audioPlaylistId'] = nav(data, audio_watch_playlist_id);
    if (runs != null) {
      searchResult.addAll(parseSongRuns(runs));
      searchResult['description'] = runs.map((run) => run['text']).join('');
    }
  } else if (resultType == 'playlist') {
    if (runs != null) {
      final split = splitBySeparator(runs);
      if (split.isNotEmpty) {
        searchResult['author'] = parseSongArtistsRuns(split[0]);
      }
      if (split.length > 1) {
        searchResult['itemCount'] =
            split[split.length - 1][0]['text']?.split(' ')?.first;
      }
      searchResult['description'] = runs.map((run) => run['text']).join('');
    }
  } else if (resultType == 'podcast') {
    searchResult['isPodcast'] = true;
    if (runs != null) {
      final split = splitBySeparator(runs);
      if (split.isNotEmpty) {
        searchResult['artists'] = parseSongArtistsRuns(split[0]);
      }
      if (split.length > 1) {
        searchResult['episodeCount'] = split[split.length - 1][0]['text'];
        searchResult['description'] = runs.map((run) => run['text']).join('');
      }
    }
  } else if (resultType == 'episode') {
    final episode = parseEpisodeFlat(data);
    if (episode != null) {
      return episode;
    }
  } else if (resultType == 'song' || resultType == 'video') {
    if (runs != null) {
      searchResult.addAll(parseSongRuns(runs));
    }
  } else if (resultType == 'station') {
    searchResult['videoId'] =
        nav(data, navigation_video_id) ?? nav(data, navigation_browse_id);
    searchResult['playlistId'] = nav(data, navigation_playlist_id);
  }

  // Common fields fallback
  searchResult['videoId'] ??= nav(data,
      [...play_button, 'playNavigationEndpoint', 'watchEndpoint', 'videoId']);
  searchResult['browseId'] ??= nav(data, navigation_browse_id);
  searchResult['thumbnails'] = nav(data, thumbnails) ??
      [
        {'url': ''}
      ];
  searchResult['isExplicit'] = nav(data, badge_label) != null;

  // Conversion to models
  if (resultType == 'song' ||
      resultType == 'video' ||
      resultType == 'episode') {
    if (searchResult['videoId'] != null) {
      return MediaItemBuilder.fromJson(searchResult);
    }
  } else if (resultType == 'playlist') {
    if (searchResult['browseId'] != null ||
        searchResult['playlistId'] != null) {
      return Playlist.fromJson(searchResult);
    }
  } else if (resultType == 'podcast') {
    if (searchResult['browseId'] != null) {
      return Album.fromJson(searchResult);
    }
  } else if (resultType == 'album') {
    if (searchResult['browseId'] != null) {
      return Album.fromJson(searchResult);
    }
  } else if (resultType == 'artist' || resultType == 'profile') {
    if (searchResult['browseId'] != null) {
      return Artist.fromJson(searchResult);
    }
  }

  return searchResult;
}

//parse album Header
Map<String, dynamic> parseAlbumHeader(Map<String, dynamic> response) {
  Map<String, dynamic> header = nav(response, [
        'contents',
        "twoColumnBrowseResultsRenderer",
        'tabs',
        0,
        "tabRenderer",
        "content",
        "sectionListRenderer",
        "contents",
        0,
        "musicResponsiveHeaderRenderer"
      ]) ??
      nav(response, ["header", "musicDetailHeaderRenderer"]);
  Map<String, dynamic> album = {
    'title': nav(header, title_text),
    'type': nav(header, subtitle),
    'thumbnails': nav(header, thumnail_cropped) ??
        nav(header,
            ["thumbnail", "musicThumbnailRenderer", "thumbnail", "thumbnails"])
  };

  album["description"] = nav(header, [
        "description",
        "musicDescriptionShelfRenderer",
        "description",
        "runs",
        0,
        "text"
      ]) ??
      (nav(header, ["subtitle", "runs"]) as List?)
          ?.map((item) => item['text'])
          .toList()
          .join(" ") ??
      '';

  Map<String, dynamic> albumInfo = {};
  final subtitleRuns = nav(header, ["subtitle", "runs"]) as List?;
  if (subtitleRuns != null) {
    final split = splitBySeparator(subtitleRuns);
    if (split.length > 1) {
      final infoRuns = [];
      for (int i = 1; i < split.length; i++) {
        infoRuns.addAll(split[i]);
        if (i < split.length - 1) infoRuns.add({'text': ' • '});
      }
      albumInfo = parseSongRuns(infoRuns);
    } else {
      albumInfo = parseSongRuns(subtitleRuns);
    }
  }

  try {
    if (header["straplineTextOne"] != null) {
      albumInfo.addAll(parseSongRuns(header["straplineTextOne"]['runs']));
    }
  } catch (e) {}
  album.addAll(albumInfo);

  if (header['secondSubtitle']['runs'].length > 1) {
    album['trackCount'] = (header['secondSubtitle']['runs'][0]['text']);
    album['duration'] = header['secondSubtitle']['runs'][2]['text'];
  } else {
    album['duration'] = header['secondSubtitle']['runs'][0]['text'];
  }

  // add to library/uploaded

  final canonicalUrl =
      nav(response, ['microformat', "microformatDataRenderer", "urlCanonical"])
          ?.toString();
  if (canonicalUrl != null && canonicalUrl.contains("list=")) {
    album['audioPlaylistId'] = canonicalUrl.split("list=")[1];
  }

  return album;
}

Map<String, dynamic> parseArtistContents(List results) {
  final Map<String, dynamic> navigationEndpointsNContent = {
    'Songs': null,
    'Videos': null,
    'Albums': null,
    'Singles': null,
    'Playlists': null,
    'Podcasts': null,
    'Episodes': null,
    'Artists': null,
  };

  for (dynamic result in results) {
    if (result.containsKey('musicShelfRenderer')) {
      final title =
          nav(result, ['musicShelfRenderer', 'title', 'runs', 0, 'text']) ??
              nav(result, [
                'musicShelfRenderer',
                'header',
                'musicShelfBasicHeaderRenderer',
                'title',
                'runs',
                0,
                'text'
              ]) ??
              "";
      if (title.toString().isEmpty) continue;
      final browseEndpoint = nav(result,
              ['musicShelfRenderer', 'bottomEndpoint', 'browseEndpoint']) ??
          nav(result, [
            'musicShelfRenderer',
            'title',
            'runs',
            0,
            'navigationEndpoint',
            'browseEndpoint'
          ]);

      final contentList = nav(result, ['musicShelfRenderer', 'contents']) ?? [];
      final content = _parseShelfContents(contentList);

      if (browseEndpoint == null) {
        navigationEndpointsNContent[title] = {"content": content};
      } else {
        navigationEndpointsNContent[title] = {
          'browseId': browseEndpoint['browseId'],
          'params': browseEndpoint['params'],
          "content": content
        };
      }
    } else if (result.containsKey('musicCarouselShelfRenderer')) {
      final browseEndpoint = nav(result, [
        'musicCarouselShelfRenderer',
        'header',
        'musicCarouselShelfBasicHeaderRenderer',
        'moreContentButton',
        'buttonRenderer',
        'navigationEndpoint',
        'browseEndpoint'
      ]);

      final title = nav(result, [
        'musicCarouselShelfRenderer',
        'header',
        'musicCarouselShelfBasicHeaderRenderer',
        'title',
        'runs',
        0,
        'text'
      ]);
      if (title == null || title.toString().isEmpty) continue;

      final contentList =
          nav(result, ['musicCarouselShelfRenderer', 'contents']) ?? [];
      final content = _parseShelfContents(contentList, sectionTitle: title);

      if (browseEndpoint != null) {
        navigationEndpointsNContent[title] = {
          'browseId': browseEndpoint['browseId'],
          'params': browseEndpoint['params'],
          'content': content
        };
      } else {
        navigationEndpointsNContent[title] = {'content': content};
      }
    }
  }
  return navigationEndpointsNContent;
}

List<dynamic> _parseShelfContents(List<dynamic> contentList,
    {String? sectionTitle}) {
  return contentList
      .map((item) {
        final twoRow = item[mtrir];
        if (twoRow != null) {
          if (sectionTitle == "Singles") return parseSingle(twoRow);
          return parseTwoRowItem(twoRow);
        }

        final responsive = item[mrlir];
        if (responsive != null) {
          if (isEpisodeRenderer(Map<String, dynamic>.from(responsive))) {
            return parseEpisodeFlat(Map<String, dynamic>.from(responsive));
          }
          return parseSongFlat(Map<String, dynamic>.from(responsive));
        }

        final multiRow = item[mmrlir];
        if (multiRow != null) {
          return parseMultiRowEpisode(multiRow);
        }
        return null;
      })
      .where((e) => e != null)
      .toList();
}

dynamic parseContentList(results, Function parseFunc) {
  var contents = [];
  for (dynamic result in results) {
    contents.add(parseFunc(result['musicTwoRowItemRenderer']));
  }

  return contents;
}

Map<String, dynamic> parseChartsItemBrowseId(dynamic result) {
  final title =
      nav(result, ["musicTwoRowItemRenderer", "title", "runs", 0, "text"]);
  final browseId = nav(result, [
    "musicTwoRowItemRenderer",
    "title",
    "runs",
    0,
    "navigationEndpoint",
    "browseEndpoint",
    "browseId"
  ]);
  if (title.contains('Trending')) {
    return {'title': "Trending", 'browseId': browseId};
  } else if (title.contains('Daily Top')) {
    return {'title': "Top Music Videos", 'browseId': browseId};
  } else {
    return {'title': title, 'browseId': browseId};
  }
}

Map<String, dynamic> parseChartsItem(dynamic result) {
  final contentList = nav(result, ['musicCarouselShelfRenderer', 'contents']);
  final String category = nav(result, [
    'musicCarouselShelfRenderer',
    'header',
    'musicCarouselShelfBasicHeaderRenderer',
    'title',
    ...run_text
  ]);
  if (category.contains('videos')) {
    final videoList = contentList
        .map((video) => parseVideo(video['musicTwoRowItemRenderer']))
        .toList();
    return {'title': category, 'contents': videoList};
  } else if (category.contains('artists')) {
    final artists = contentList
        .map((artist) =>
            parseChartsArtist(artist['musicResponsiveListItemRenderer']))
        .toList();
    return {'title': category, 'contents': artists};
  } else if (category.contains('Genres')) {
    final playlists = contentList
        .map((playlist) => parsePlaylist(playlist['musicTwoRowItemRenderer']))
        .toList();
    return {'title': category, 'contents': playlists};
  } else if (category.contains('Trending')) {
    final videoList = contentList
        .map((video) =>
            parseChartsTrending(video['musicResponsiveListItemRenderer']))
        .whereType<MediaItem>()
        .toList();
    return {'title': category, 'contents': videoList};
  }
  return {};
}

Artist parseChartsArtist(dynamic data) {
  final subscribers = getFlexColumnItem(data, 1);
  dynamic subs;
  if (subscribers.isNotEmpty) {
    subs = nav(subscribers, text_run_text).split(' ')[0];
  }

  final parsed = {
    'artist': nav(getFlexColumnItem(data, 0), text_run_text),
    'browseId': nav(data, navigation_browse_id),
    'subscribers': subs,
    'thumbnails': nav(data, thumbnails),
  };

  return Artist.fromJson(parsed);
}

MediaItem? parseChartsTrending(dynamic data) {
  final flex_0 = getFlexColumnItem(data, 0);
  final artists = parseSongArtists(data, 1);

  final video = {
    'title': nav(flex_0, text_run_text),
    'videoId': nav(
          flex_0,
          text_run + navigation_video_id,
        ) ??
        nav(data, ['playlistItemData', 'videoId']),
    'playlistId': nav(flex_0, text_run + navigation_playlist_id),
    'artists': artists,
    'thumbnails': nav(data, thumbnails) ??
        [
          {'url': ''}
        ],
  };
  if (video['videoId'] == null) {
    return null;
  }
  return MediaItemBuilder.fromJson(video);
}

List<List<dynamic>> splitBySeparator(List<dynamic>? runs) {
  if (runs == null) return [];
  final List<List<dynamic>> res = [];
  List<dynamic> tmp = [];
  for (var run in runs) {
    final text = run['text']?.toString().trim();
    if (text == "•" || text == "·" || text == "•" || text == "Â·") {
      if (tmp.isNotEmpty) res.add(tmp);
      tmp = [];
    } else {
      tmp.add(run);
    }
  }
  if (tmp.isNotEmpty) res.add(tmp);
  return res;
}

List<dynamic> oddElements(List<dynamic> list) {
  final List<dynamic> result = [];
  for (int i = 0; i < list.length; i++) {
    if (i % 2 == 0) result.add(list[i]);
  }
  return result;
}

String? getPageType(Map<String, dynamic> data) {
  return nav(data, n_title + navigation_browse + page_type) ??
      nav(data, navigation_browse + page_type);
}

String? getRendererBrowseId(Map<String, dynamic> data) {
  return nav(data, n_title + navigation_browse_id) ??
      nav(data, navigation_browse_id);
}

dynamic parseTwoRowItem(Map<String, dynamic> data) {
  final pageTypeVal = getPageType(data);
  final hasWatchEndpoint = nav(data, navigation_video_id) != null ||
      nav(data, [
            ...play_button,
            'playNavigationEndpoint',
            'watchEndpoint',
            'videoId'
          ]) !=
          null;

  if (pageTypeVal == "MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE" ||
      pageTypeVal == "MUSIC_PAGE_TYPE_PODCAST_EPISODE") {
    return parseEpisode(data);
  }
  if (pageTypeVal == "MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE") {
    return parsePodcast(data);
  }
  if (pageTypeVal == "MUSIC_PAGE_TYPE_ALBUM" ||
      pageTypeVal == "MUSIC_PAGE_TYPE_AUDIOBOOK") {
    return parseAlbum(data, reqAlbumObj: false);
  }
  if (pageTypeVal == "MUSIC_PAGE_TYPE_ARTIST" ||
      pageTypeVal == "MUSIC_PAGE_TYPE_LIBRARY_ARTIST" ||
      pageTypeVal == "MUSIC_PAGE_TYPE_USER_CHANNEL") {
    return parseRelatedArtist(Map<String, dynamic>.from(data));
  }
  if (pageTypeVal == "MUSIC_PAGE_TYPE_PLAYLIST" ||
      pageTypeVal == "MUSIC_PAGE_TYPE_PODCAST_SHOW") {
    return parsePlaylist(Map<String, dynamic>.from(data));
  }
  if (hasWatchEndpoint) {
    return parseSong(Map<String, dynamic>.from(data));
  }
  return null;
}

bool isEpisodeRenderer(Map<String, dynamic> data) {
  final pageTypeVal = nav(data, navigation_browse + page_type);
  if (pageTypeVal == "MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE" ||
      pageTypeVal == "MUSIC_PAGE_TYPE_PODCAST_EPISODE") {
    return true;
  }

  final runs = nav(getFlexColumnItem(data, 1), ['text', 'runs']) as List?;
  if (runs == null || runs.isEmpty) return false;
  if ((runs.first['text'] ?? '').toString().toLowerCase() == 'episode') {
    return true;
  }

  final hasPodcastLink = runs.any((run) =>
      nav(run, navigation_browse + page_type) ==
      "MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE");
  final hasVideoId = nav(data, ['playlistItemData', 'videoId']) != null ||
      nav(data, navigation_video_id) != null ||
      nav(data, [
            ...play_button,
            'playNavigationEndpoint',
            'watchEndpoint',
            'videoId'
          ]) !=
          null;
  return hasPodcastLink && hasVideoId;
}

Map<String, String?> extractPodcastMetadata(List<List<dynamic>> sections) {
  String? podcastId;
  String? podcastTitle;
  String? publishDate;

  for (int i = 0; i < sections.length; i++) {
    final section = sections[i];
    final podcastRun = section.cast<dynamic>().firstWhere(
          (run) =>
              run != null &&
              nav(run, navigation_browse + page_type) ==
                  "MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE",
          orElse: () => null,
        );
    if (podcastRun != null) {
      podcastTitle = podcastRun['text'];
      podcastId = nav(podcastRun, navigation_browse_id);
      if (i > 0 && sections[i - 1].isNotEmpty) {
        publishDate = sections[i - 1][0]['text'];
      }
      break;
    }
  }

  return {
    'podcastId': podcastId,
    'podcastTitle': podcastTitle,
    'publishDate': publishDate,
  };
}

String? extractDurationText(List<List<dynamic>> sections) {
  final durationRegExp = RegExp(r'^(\d+:)*\d+:\d+$');
  for (final section in sections.reversed) {
    for (final run in section.reversed) {
      final text = run['text']?.toString();
      if (text != null && durationRegExp.hasMatch(text)) {
        return text;
      }
    }
  }
  return null;
}

MediaItem? parseEpisodeFlat(Map<String, dynamic> data) {
  final title = getItemText(data, 0, noneIfAbsent: true);
  final videoId = nav(data, ['playlistItemData', 'videoId']) ??
      nav(data, navigation_video_id) ??
      nav(data, [
        ...play_button,
        'playNavigationEndpoint',
        'watchEndpoint',
        'videoId'
      ]);
  final runs = nav(getFlexColumnItem(data, 1), ['text', 'runs']) as List?;
  final sections = splitBySeparator(runs);
  final podcast = extractPodcastMetadata(sections);
  final podcastTitle = podcast['podcastTitle'];

  if (title == null || videoId == null) return null;

  return MediaItemBuilder.fromJson({
    'title': title,
    'videoId': videoId,
    'thumbnails': nav(data, thumbnails) ??
        [
          {'url': ''}
        ],
    'artists': podcastTitle == null
        ? null
        : [
            {'name': podcastTitle, 'id': podcast['podcastId']}
          ],
    'album': podcastTitle == null
        ? null
        : {'name': podcastTitle, 'id': podcast['podcastId']},
    'isEpisode': true,
    'resultType': 'episode',
    'podcastId': podcast['podcastId'],
    'podcastTitle': podcastTitle,
    'publishDate': podcast['publishDate'],
    'length': extractDurationText(sections),
  });
}

MediaItem? parseMultiRowEpisode(Map<String, dynamic> data,
    {Map<String, dynamic>? podcast}) {
  final title = nav(data, ['title', 'runs', 0, 'text']);
  final videoId = nav(data, ['onTap', 'watchEndpoint', 'videoId']);
  if (title == null || videoId == null) return null;

  final sections = splitBySeparator(nav(data, ['subtitle', 'runs']));
  final podcastId = podcast?['id'];
  final podcastTitle = podcast?['title'];

  return MediaItemBuilder.fromJson({
    'title': title,
    'videoId': videoId,
    'thumbnails': nav(data, thumbnails) ??
        [
          {'url': ''}
        ],
    'artists': podcastTitle == null
        ? null
        : [
            {'name': podcastTitle, 'id': podcastId}
          ],
    'album':
        podcastTitle == null ? null : {'name': podcastTitle, 'id': podcastId},
    'isEpisode': true,
    'resultType': 'episode',
    'podcastId': podcastId,
    'podcastTitle': podcastTitle,
    'publishDate': sections.isNotEmpty && sections.first.isNotEmpty
        ? sections.first[0]['text']
        : null,
    'length': extractDurationText(sections),
  });
}

MediaItem? parseEpisode(Map<String, dynamic> result) {
  final title = nav(result, title_text);
  final videoId = nav(result, navigation_video_id) ??
      nav(result, [
        ...play_button,
        'playNavigationEndpoint',
        'watchEndpoint',
        'videoId'
      ]) ??
      nav(result, ['playlistItemData', 'videoId']);
  if (title == null || videoId == null) return null;

  final runs = nav(result, ['subtitle', 'runs']);
  final secondaryLine = splitBySeparator(runs);
  final podcast = extractPodcastMetadata(secondaryLine);

  // Find podcast link in subtitle (has pageType MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE)
  String? publishDate;
  publishDate = podcast['publishDate'];

  return MediaItemBuilder.fromJson({
    'title': title,
    'videoId': videoId,
    'thumbnails': nav(result, thumbnail_renderer) ??
        [
          {'url': ''}
        ],
    'artists': podcast['podcastTitle'] == null
        ? null
        : [
            {'name': podcast['podcastTitle'], 'id': podcast['podcastId']}
          ],
    'album': podcast['podcastTitle'] == null
        ? null
        : {'name': podcast['podcastTitle'], 'id': podcast['podcastId']},
    'isEpisode': true,
    'resultType': 'episode',
    'podcastId': podcast['podcastId'],
    'podcastTitle': podcast['podcastTitle'],
    'publishDate': publishDate,
    'length': extractDurationText(secondaryLine),
  });
}

Album parsePodcast(Map<String, dynamic> result) {
  final runs = nav(result, ['subtitle', 'runs']);
  final secondaryLine = splitBySeparator(runs);
  final author = secondaryLine.isNotEmpty && secondaryLine[0].isNotEmpty
      ? {
          'name': secondaryLine[0][0]['text'],
          'id': nav(secondaryLine[0][0], navigation_browse_id),
        }
      : null;

  return Album.fromJson({
    'title': nav(result, title_text),
    'browseId': getRendererBrowseId(result),
    'thumbnails': nav(result, thumbnail_renderer) ??
        [
          {'url': ''}
        ],
    'isPodcast': true,
    'artists': author == null ? null : [author],
    'author': author?['name'],
    'episodeCount':
        secondaryLine.length > 1 ? secondaryLine.last[0]['text'] : null,
  });
}
