import 'package:audio_service/audio_service.dart';
import 'package:harmonymusic/services/system/nav_parser.dart';
import 'package:harmonymusic/services/system/utils.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/music/music_service.dart';

class PodcastService {
  final MusicServices _musicServices;

  PodcastService(this._musicServices);

  Future<dynamic> podcastDiscover({int limit = 4}) async {
    final data = Map.from(_musicServices.context);
    data["browseId"] = "FEmusic_non_music_audio";
    final response = await _musicServices.sendRequest("browse", data);
    final results = nav(response.data, single_column_tab + section_list) ?? [];
    final home = [...parseMixedContent(results)];
    return home;
  }

  Future<Map<String, dynamic>> podcast(String channelId) async {
    final data = Map.from(_musicServices.context);
    data['context']['client']["hl"] = 'en';
    data['browseId'] = channelId;
    final response = (await _musicServices.sendRequest("browse", data)).data;

    final sectionListRenderer = nav(response, [
          'contents',
          'twoColumnBrowseResultsRenderer',
          'tabs',
          0,
          'tabRenderer',
          'content',
          'sectionListRenderer'
        ]) ??
        nav(response, [
          'contents',
          'singleColumnBrowseResultsRenderer',
          'tabs',
          0,
          'tabRenderer',
          'content',
          'sectionListRenderer'
        ]);
    final results = nav(sectionListRenderer, ['contents']) ?? [];

    final header = nav(results, [0, 'musicResponsiveHeaderRenderer']) ??
        response['header']?['podcastHeaderRenderer'] ??
        response['header']?['musicImmersiveHeaderRenderer'] ??
        response['header']?['musicVisualHeaderRenderer'];

    final secondarySections = nav(response, [
          'contents',
          'twoColumnBrowseResultsRenderer',
          'secondaryContents',
          'sectionListRenderer',
          'contents'
        ]) ??
        results;

    final descriptionShelf =
        findObjectByKey(results, description_shelf[0], isKey: true) ??
            findObjectByKey(secondarySections, description_shelf[0], isKey: true);

    final title = nav(header, title_text) ?? "";
    final authorRun = nav(header, ['straplineTextOne', 'runs', 0]);
    final thumbnailsList = nav(header, thumbnails) ??
        nav(header, thumbnail_renderer) ??
        nav(header, [
          'thumbnail',
          'musicThumbnailRenderer',
          'thumbnail',
          'thumbnails'
        ]) ??
        [{'url': ''}];

    List<dynamic>? episodeContents;
    dynamic episodeShelf;
    for (final section in secondarySections) {
      episodeShelf = section['musicShelfRenderer'] ??
          section['musicPlaylistShelfRenderer'];
      if (episodeShelf != null) {
        episodeContents = episodeShelf['contents'];
        if (episodeContents != null) break;
      }
    }

    final podcastRef = {'id': channelId, 'title': title};
    final episodes = (episodeContents ?? [])
        .map((item) {
          if (item.containsKey(mmrlir)) {
            return parseMultiRowEpisode(item[mmrlir], podcast: podcastRef);
          }
          if (item.containsKey(mrlir)) {
            return parseEpisodeFlat(Map<String, dynamic>.from(item[mrlir]));
          }
          if (item.containsKey(mtrir)) {
            return parseEpisode(item[mtrir]);
          }
          return null;
        })
        .whereType<MediaItem>()
        .toList();

    final Map<String, dynamic> podcastData = {
      'title': title,
      'name': title,
      'browseId': channelId,
      'channelId': channelId,
      'description': nav(descriptionShelf, description),
      'thumbnails': thumbnailsList,
      'isPodcast': true,
      'artists': authorRun == null
          ? [
              {'name': ''}
            ]
          : [
              {
                'name': authorRun['text'],
                'id': nav(authorRun, navigation_browse_id),
              }
            ],
      'episodeCount': nav(header, ['secondSubtitle', 'runs', 0, 'text']),
      'tracks': episodes,
      'Episodes': {
        'content': episodes,
        'additionalParams': episodeShelf == null
            ? '&ctoken=null&continuation=null'
            : _musicServices.continuationParamsFromRenderer(episodeShelf),
      },
    };

    podcastData.addAll(parseArtistContents(results));
    podcastData['tracks'] = episodes;
    podcastData['Episodes'] = {
      'content': episodes,
      'additionalParams': episodeShelf == null
          ? '&ctoken=null&continuation=null'
          : _musicServices.continuationParamsFromRenderer(episodeShelf),
    };

    return podcastData;
  }

  Future<List<dynamic>> getPodcastEpisodes(String browseId, String params, {int limit = 100}) async {
    final data = Map.from(_musicServices.context);
    data['browseId'] = browseId;
    data['params'] = params;
    
    final response = (await _musicServices.sendRequest("browse", data)).data;
    final results = nav(response, [...single_column_tab, ...section_list, 0, 'musicPlaylistShelfRenderer', 'contents']) ?? [];
    
    final episodes = parsePlaylistItems(results);
    return episodes;
  }

  Future<List<dynamic>> savedPodcastShows() async {
    final data = Map.from(_musicServices.context);
    data['browseId'] = "FEmusic_library_non_music_audio_list";
    try {
      final response = (await _musicServices.sendRequest("browse", data)).data;
      final contents = nav(response, [
        'contents',
        'singleColumnBrowseResultsRenderer',
        'tabs',
        0,
        'tabRenderer',
        'content',
        'sectionListRenderer',
        'contents',
        0
      ]);

      List items = [];
      if (contents?['gridRenderer'] != null) {
        items = contents?['gridRenderer']['items']
            ?.map((item) => parseTwoRowItem(item['musicTwoRowItemRenderer']))
            ?.where((e) => e != null)
            ?.toList() ?? [];
      } else if (contents?['musicShelfRenderer'] != null) {
        items = contents?['musicShelfRenderer']['contents']
            ?.map((item) => parseSongFlat(item['musicResponsiveListItemRenderer']))
            ?.where((e) => e != null)
            ?.toList() ?? [];
      }
      return items.where((element) => element.isPodcast == true).toList();
    } catch (e) {
      printERROR("savedPodcastShows failed: $e");
      return [];
    }
  }

  Future<List<dynamic>> episodesForLater() async {
    final data = Map.from(_musicServices.context);
    data['browseId'] = "VLSE";
    try {
      final response = (await _musicServices.sendRequest("browse", data)).data;
      final contents = nav(response, [
        'contents',
        'twoColumnBrowseResultsRenderer',
        'secondaryContents',
        'sectionListRenderer',
        'contents',
        0
      ]);

      final shelfContents = contents?['musicPlaylistShelfRenderer']?['contents'] ??
          contents?['musicShelfRenderer']?['contents'];

      if (shelfContents == null) return [];

      return shelfContents
          .map((item) => parseEpisodeFlat(item['musicResponsiveListItemRenderer'] ?? item))
          .where((item) => item != null)
          .toList();
    } catch (e) {
      printERROR("episodesForLater failed: $e");
      return [];
    }
  }
}
