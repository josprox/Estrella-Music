import 'package:estrella_music/services/system/nav_parser.dart';
import 'package:estrella_music/services/system/utils.dart';
import 'package:estrella_music/services/music/music_service.dart';

class ArtistService {
  final MusicServices _musicServices;

  ArtistService(this._musicServices);

  Future<Map<String, dynamic>> getArtist(String channelId) async {
    if (channelId.startsWith("MPLA")) {
      channelId = channelId.substring(4);
    }
    final data = Map.from(_musicServices.context);
    data['context']['client']["hl"] = 'en';
    data['browseId'] = channelId;
    final response = (await _musicServices.sendRequest("browse", data)).data;
    final results =
        nav(response, [...single_column_tab, ...section_list]) ?? [];

    final Map<String, dynamic> artist = {'description': null, 'views': null};

    // Header can be immersive, visual, or responsive (for profiles)
    final dynamic header = response['header']
            ?['musicImmersiveHeaderRenderer'] ??
        response['header']?['musicVisualHeaderRenderer'] ??
        response['header']?['musicHeaderRenderer'] ??
        response['header']?['musicEditablePlaylistDetailHeaderRenderer']
            ?['header']?['musicResponsiveHeaderRenderer'];

    if (header != null) {
      artist['name'] =
          nav(header, title_text) ?? nav(header, ['title', 'runs', 0, 'text']);
      artist['thumbnails'] = nav(header, thumbnails) ??
          nav(header, thumbnail_renderer) ??
          nav(header, ['thumbnail', 'thumbnails']) ??
          [
            {'url': ''}
          ];

      final dynamic subscriptionButton = header['subscriptionButton'] != null
          ? header['subscriptionButton']['subscribeButtonRenderer']
          : null;

      artist['subscribers'] = subscriptionButton != null
          ? nav(subscriptionButton, ['subscriberCountText', 'runs', 0, 'text'])
          : null;

      artist['isSubscribed'] = subscriptionButton != null
          ? (nav(subscriptionButton, ['subscribed']) ?? false)
          : false;
      artist['monthlyListeners'] =
          nav(header, ['monthlyListenerCount', 'runs', 0, 'text']);

      artist['shuffleId'] = nav(header,
          ['playButton', 'buttonRenderer', ...navigation_watch_playlist_id]);
      artist['radioId'] = nav(header,
          ['startRadioButton', 'buttonRenderer'] + navigation_playlist_id);
    }

    artist['channelId'] = channelId;

    final descriptionShelf =
        findObjectByKey(results, description_shelf[0], isKey: true);
    if (descriptionShelf != null) {
      artist['description'] = nav(descriptionShelf, description);
      artist['views'] = descriptionShelf['subheader'] == null
          ? null
          : descriptionShelf['subheader']['runs'][0]['text'];
    }

    artist.addAll(parseArtistContents(results));
    return artist;
  }

  Future<Map<String, dynamic>> getArtistRealtedContent(
      Map<String, dynamic> browseEndpoint, String category,
      {String additionalParams = ""}) async {
    final Map<String, dynamic> result = {
      "results": [],
    };
    final data = Map.of(browseEndpoint);
    data.remove("content");
    if (data.isEmpty) return result;

    // We need to merge with the client context
    final requestData = Map.from(_musicServices.context);
    requestData.addAll(data);

    final response = (await _musicServices.sendRequest("browse", requestData,
            additionalParams: additionalParams))
        .data;

    List<dynamic> contentList = [];
    dynamic renderer;

    if (additionalParams.isNotEmpty) {
      contentList = nav(response,
              ['continuationContents', 'gridContinuation', 'items']) ??
          nav(response, [
            'continuationContents',
            'musicPlaylistShelfContinuation',
            'contents'
          ]) ??
          nav(response,
              ['continuationContents', 'musicShelfContinuation', 'contents']) ??
          nav(response, [
            'onResponseReceivedActions',
            0,
            'appendContinuationItemsAction',
            'continuationItems'
          ]) ??
          [];
      result['additionalParams'] =
          _musicServices.continuationParamsFromResponse(response);
    } else {
      final firstSection = nav(response, [
        'contents',
        'singleColumnBrowseResultsRenderer',
        'tabs',
        0,
        'tabRenderer',
        'content',
        'sectionListRenderer',
        'contents',
        0,
      ]);
      renderer = firstSection?['gridRenderer'] ??
          firstSection?['musicCarouselShelfRenderer'] ??
          firstSection?['musicShelfRenderer'] ??
          firstSection?['musicPlaylistShelfRenderer'];
      contentList = renderer?['items'] ?? renderer?['contents'] ?? [];
      result['additionalParams'] = renderer == null
          ? '&ctoken=null&continuation=null'
          : _musicServices.continuationParamsFromRenderer(renderer);
    }

    result['results'] = _parseArtistRelatedItems(contentList, category);
    return result;
  }

  List<dynamic> _parseArtistRelatedItems(
      List<dynamic> contentList, String category) {
    return contentList
        .map((item) {
          if (item.containsKey(mtrir)) {
            return category == 'Singles'
                ? parseSingle(item[mtrir])
                : parseTwoRowItem(item[mtrir]);
          }
          if (item.containsKey(mrlir)) {
            final renderer = Map<String, dynamic>.from(item[mrlir]);
            return isEpisodeRenderer(renderer)
                ? parseEpisodeFlat(renderer)
                : parseSongFlat(renderer);
          }
          if (item.containsKey(mmrlir)) {
            return parseMultiRowEpisode(item[mmrlir]);
          }
          return null;
        })
        .where((e) => e != null)
        .toList();
  }
}
