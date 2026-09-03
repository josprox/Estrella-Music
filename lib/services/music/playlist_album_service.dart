import 'package:audio_service/audio_service.dart' show MediaItem;
import 'package:estrella_music/services/system/nav_parser.dart';
import 'package:estrella_music/services/system/utils.dart';
import 'package:estrella_music/services/system/continuations.dart';
import 'package:estrella_music/services/music/music_service.dart';

class PlaylistAlbumService {
  final MusicServices _musicServices;

  PlaylistAlbumService(this._musicServices);

  Future<String> getAlbumBrowseId(String audioPlaylistId) async {
    // Public HTML scraping used to happen in Flutter. Provider catalog calls
    // now go exclusively through eMusic, so retain the canonical ID here.
    return audioPlaylistId;
  }

  Future<Map<String, dynamic>> getPlaylistOrAlbumSongs(
      {String? playlistId,
      String? albumId,
      int limit = 3000,
      bool related = false,
      int suggestionsLimit = 0}) async {
    String browseId = playlistId != null
        ? (playlistId.startsWith("VL") ? playlistId : "VL$playlistId")
        : (albumId!.startsWith("OLAK5uy") ? "VL$albumId" : albumId);
    final data = Map.from(_musicServices.context);
    data['browseId'] = browseId;
    final Map<String, dynamic> response =
        (await _musicServices.sendRequest('browse', data)).data;
    if (playlistId != null) {
      final dynamic headerRaw =
          nav(response, ['header', "musicDetailHeaderRenderer"]) ??
              nav(response, ['header', "musicResponsiveHeaderRenderer"]) ??
              nav(response, [
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
              ]);
      final Map<String, dynamic> header =
          headerRaw is Map<String, dynamic> ? headerRaw : (headerRaw is Map ? Map<String, dynamic>.from(headerRaw) : <String, dynamic>{});

      final dynamic resultsRaw =
          nav(response, musicPlaylistShelfRenderer) ??
              nav(
                response,
                [
                  'contents',
                  "singleColumnBrowseResultsRenderer",
                  "tabs",
                  0,
                  "tabRenderer",
                  "content",
                  'sectionListRenderer',
                  'contents',
                  0,
                  "musicPlaylistShelfRenderer"
                ],
              );
      final Map<String, dynamic> results =
          resultsRaw is Map<String, dynamic> ? resultsRaw : (resultsRaw is Map ? Map<String, dynamic>.from(resultsRaw) : <String, dynamic>{});

      final Map<String, dynamic> playlist = {'id': results['playlistId'] ?? playlistId};

      playlist['title'] = nav(header, title_text) ?? '';
      playlist['thumbnails'] = nav(header, thumnail_cropped) ??
          nav(header, [
            "thumbnail",
            "musicThumbnailRenderer",
            "thumbnail",
            "thumbnails"
          ]) ??
          [];
      playlist["description"] = nav(header, description) ?? '';
      final runs = nav(header, ['subtitle', 'runs']) as List?;
      final int runCount = runs?.length ?? 0;
      if (runCount > 1) {
        playlist['author'] = {
          'name': nav(header, subtitle2) ?? '',
          'id': nav(header, ['subtitle', 'runs', 2] + navigation_browse_id)
        };
        if (runCount == 5) {
          playlist['year'] = nav(header, subtitle3);
        }
      }

      final secondRuns = nav(header, ['secondSubtitle', 'runs']) as List?;
      final int secondSubtitleRunCount = secondRuns?.length ?? 0;
      int songCount = 0;
      if (secondSubtitleRunCount > 0) {
        final textVal = secondRuns![secondSubtitleRunCount % 3]['text']?.toString() ?? '';
        final count = (textVal.split(' ')[0]).split(',').join();
        songCount = int.tryParse(count) ?? 0;
        if (secondSubtitleRunCount > 1 && (secondSubtitleRunCount % 3) + 2 < secondSubtitleRunCount) {
          playlist['duration'] =
              secondRuns[(secondSubtitleRunCount % 3) + 2]['text'];
        }
      }
      playlist['trackCount'] = songCount;

      requestFuncCountinuation(cont) async =>
          (await _musicServices.sendRequest("browse", {...data, ...cont})).data;

      final dynamic playlistContents = results['contents'];
      if (playlistContents is List && playlistContents.isNotEmpty) {
        playlist['tracks'] = parsePlaylistItems(playlistContents);
        limit = songCount > 0 ? songCount : limit;

        List<dynamic> parseFunc(contents) => parsePlaylistItems(contents);

        playlist['tracks'] = [
          ...(playlist['tracks']),
          ...(await getContinuationsPlaylist(
              results, limit, requestFuncCountinuation, parseFunc))
        ];
      } else {
        playlist['tracks'] = <MediaItem>[];
      }
      playlist['duration_seconds'] = sumTotalDuration(playlist);
      return playlist;
    }

    //album content
    final album = parseAlbumHeader(response);
    dynamic results = nav(
          response,
          [
            'contents',
            "twoColumnBrowseResultsRenderer",
            "secondaryContents",
            'sectionListRenderer',
            'contents',
            0,
            'musicShelfRenderer'
          ],
        ) ??
        nav(
          response,
          [
            'contents',
            "singleColumnBrowseResultsRenderer",
            "tabs",
            0,
            "tabRenderer",
            "content",
            'sectionListRenderer',
            'contents',
            0,
            'musicShelfRenderer'
          ],
        );

    final dynamic contents = results is Map ? results['contents'] : null;
    album['tracks'] = (contents is List)
        ? parsePlaylistItems(contents,
            artistsM: album['artists'],
            thumbnailsM: album["thumbnails"],
            albumIdName: {"id": albumId, 'name': album['title']},
            albumYear: album['year'],
            isAlbum: true)
        : <MediaItem>[];
    results = nav(
      response,
      [...single_column_tab, ...section_list, 1, 'musicCarouselShelfRenderer'],
    );
    if (results != null) {
      List contents = [];
      if (results.runtimeType.toString().contains("Iterable") ||
          results.runtimeType.toString().contains("List")) {
        for (dynamic result in results) {
          contents.add(parseAlbum(result['musicTwoRowItemRenderer']));
        }
      } else {
        contents
            .add(parseAlbum(results['contents'][0]['musicTwoRowItemRenderer']));
      }
      album['other_versions'] = contents;
    }
    album['duration_seconds'] = sumTotalDuration(album);

    return album;
  }
}
