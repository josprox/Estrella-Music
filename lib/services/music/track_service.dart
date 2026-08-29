import 'package:estrella_music/services/system/nav_parser.dart';
import 'package:estrella_music/services/system/utils.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/system/continuations.dart';
import 'package:estrella_music/services/music/music_service.dart';

class TrackService {
  final MusicServices _musicServices;

  TrackService(this._musicServices);

  Future<Map<String, dynamic>> getWatchPlaylist(
      {String videoId = "",
      String? playlistId,
      int limit = 25,
      bool radio = false,
      bool shuffle = false,
      String? additionalParamsNext,
      bool onlyRelated = false}) async {
    if (videoId.isNotEmpty && videoId.substring(0, 4) == "MPED") {
      videoId = videoId.substring(4);
    }
    final data = Map.from(_musicServices.context);
    data['enablePersistentPlaylistPanel'] = true;
    data['isAudioOnly'] = true;
    data['tunerSettingValue'] = 'AUTOMIX_SETTING_NORMAL';
    if (videoId == "" && playlistId == null) {
      throw Exception(
          "You must provide either a video id, a playlist id, or both");
    }
    if (videoId != "") {
      data['videoId'] = videoId;
      playlistId ??= "RDAMVM$videoId";

      if (!(radio || shuffle)) {
        data['watchEndpointMusicSupportedConfigs'] = {
          'watchEndpointMusicConfig': {
            'hasPersistentPlaylistPanel': true,
            'musicVideoType': "MUSIC_VIDEO_TYPE_ATV",
          }
        };
      }
    }

    playlistId = validatePlaylistId(playlistId!);
    data['playlistId'] = playlistId;
    final isPlaylist =
        playlistId.startsWith('PL') || playlistId.startsWith('OLA');
    if (shuffle) {
      data['params'] = "wAEB8gECKAE%3D";
    }
    if (radio) {
      data['params'] = "wAEB";
    }

    final List<dynamic> tracks = [];
    dynamic lyricsBrowseId, relatedBrowseId, playlist;
    final results = {};

    if (additionalParamsNext == null) {
      final response = (await _musicServices.sendRequest("next", data)).data;
      final watchNextRenderer = nav(response, [
        'contents',
        'singleColumnMusicWatchNextResultsRenderer',
        'tabbedRenderer',
        'watchNextTabbedResultsRenderer'
      ]);

      lyricsBrowseId = getTabBrowseId(watchNextRenderer, 1);
      relatedBrowseId = getTabBrowseId(watchNextRenderer, 2);
      if (onlyRelated) {
        return {
          'lyrics': lyricsBrowseId,
          'related': relatedBrowseId,
        };
      }

      results.addAll(nav(watchNextRenderer, [
        ...tab_content,
        'musicQueueRenderer',
        'content',
        'playlistPanelRenderer'
      ]));
      playlist = results['contents']
          .map((content) => nav(content,
              ['playlistPanelVideoRenderer', ...navigation_playlist_id]))
          .where((e) => e != null)
          .toList()
          .first;
      tracks.addAll(parseWatchPlaylist(results['contents']));
    }

    dynamic additionalParamsForNext;
    if (results.containsKey('continuations') || additionalParamsNext != null) {
      requestFunc(additionalParams) async => (await _musicServices
              .sendRequest("next", data, additionalParams: additionalParams))
          .data;
      parseFunc(contents) => parseWatchPlaylist(contents);
      final x = await getContinuations(results, 'playlistPanelContinuation',
          limit - tracks.length, requestFunc, parseFunc,
          ctokenPath: isPlaylist ? '' : 'Radio',
          isAdditionparamReturnReq: true,
          additionalParams_: additionalParamsNext);
      additionalParamsForNext = x[1];
      tracks.addAll(List<dynamic>.from(x[0]));
    }

    return {
      'tracks': tracks,
      'playlistId': playlist,
      'lyrics': lyricsBrowseId,
      'related': relatedBrowseId,
      'additionalParamsForNext': additionalParamsForNext
    };
  }

  Future<List<Map<String, dynamic>>> getContentRelatedToSong(
      String videoId, String hlCode) async {
    try {
      final params =
          await getWatchPlaylist(videoId: videoId, onlyRelated: true);
      if (params['related'] == null) return [];

      final data = Map.from(_musicServices.context);
      data['browseId'] = params['related'];
      data['context']['client']['hl'] = hlCode;

      final response = (await _musicServices.sendRequest('browse', data)).data;
      final sections = nav(response, ['contents'] + section_list);
      if (sections == null) return [];

      final x = parseMixedContent(sections);
      return x;
    } catch (e) {
      printERROR("getContentRelatedToSong failed: $e");
      return [];
    }
  }

  dynamic getLyrics(String browseId) async {
    final data = Map.from(_musicServices.context);
    data['browseId'] = browseId;
    final response = (await _musicServices.sendRequest('browse', data)).data;
    return nav(
      response,
      ['contents', ...section_list_item, ...description_shelf, ...description],
    );
  }

  Future<List> getSongWithId(String songId) async {
    final data = Map.of(_musicServices.context);
    data['videoId'] = songId;
    try {
      final response = (await _musicServices.sendRequest("player", data)).data;
      final category =
          nav(response, ["microformat", "microformatDataRenderer", "category"]);
      if (category == "Music" ||
          (response["videoDetails"]).containsKey("musicVideoType")) {
        final list = await getWatchPlaylist(videoId: songId);
        return [true, list['tracks']];
      }
    } on NetworkError catch (error) {
      printERROR("No fue posible resolver la cancion $songId: $error");
    }
    return [false, null];
  }

  Future<String?> getSongYear(String songId) async {
    final data = Map.from(_musicServices.context);
    data['browseId'] = "MPTC$songId";
    try {
      final response = (await _musicServices.sendRequest('browse', data)).data;
      String? year = nav(response, [
        "onResponseReceivedActions",
        0,
        "openPopupAction",
        "popup",
        "dismissableDialogRenderer",
        "metadata",
        "musicMultiRowListItemRenderer",
        "secondTitle",
        "runs",
        2,
        "text"
      ]);
      return year;
    } catch (e) {
      rethrow;
    }
  }
}
