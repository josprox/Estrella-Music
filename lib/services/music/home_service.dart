import 'package:harmonymusic/services/system/nav_parser.dart';
import 'package:harmonymusic/services/system/continuations.dart';
import 'package:harmonymusic/services/music/music_service.dart';

class HomeService {
  final MusicServices _musicServices;

  HomeService(this._musicServices);

  Future<dynamic> getHome({int limit = 4}) async {
    final data = Map.from(_musicServices.context);
    data["browseId"] = "FEmusic_home";
    final response = await _musicServices.sendRequest("browse", data);
    final results = nav(response.data, single_column_tab + section_list);
    final home = [...parseMixedContent(results)];

    final sectionList =
        nav(response.data, single_column_tab + ['sectionListRenderer']);
    if (sectionList.containsKey('continuations')) {
      requestFunc(additionalParams) async {
        return (await _musicServices.sendRequest("browse", data,
                additionalParams: additionalParams))
            .data;
      }

      parseFunc(contents) => parseMixedContent(contents);
      final x = (await getContinuations(sectionList, 'sectionListContinuation',
          limit - home.length, requestFunc, parseFunc));
      home.addAll([...x]);
    }

    return home;
  }

  Future<List<Map<String, dynamic>>> getCharts(String catogory,
      {String? countryCode}) async {
    final List<Map<String, dynamic>> charts = [];
    final data = Map.from(_musicServices.context);

    data['browseId'] = 'FEmusic_charts';
    data['context']['client']["hl"] = 'en';
    if (countryCode != null) {
      data['formData'] = {
        'selectedValues': [countryCode]
      };
    }
    final response = (await _musicServices.sendRequest('browse', data)).data;
    final results = nav(response, single_column_tab + section_list);
    results.removeAt(0);
    for (dynamic result in results) {
      if (nav(result, [
            "musicCarouselShelfRenderer",
            "header",
            "musicCarouselShelfBasicHeaderRenderer",
            ...title_text
          ]) ==
          "Video charts") {
        for (dynamic item in result['musicCarouselShelfRenderer']['contents']) {
          final chartItem =
              await getChartItems(parseChartsItemBrowseId(item), catogory);
          charts.add(chartItem);
        }
      } else {
        continue;
      }
    }

    return charts;
  }

  Future<Map<String, dynamic>> getChartItems(
      Map<String, dynamic> item, String catogory) async {
    final catString = catogory == "TMV" ? "Top Music Videos" : "Trending";
    if ((item['title'])!.contains(catString)) {
      final songs = (await _musicServices.getPlaylistOrAlbumSongs(
          playlistId: item['browseId']))['tracks'];
      final limitedSongs = songs.length > 24 ? songs.sublist(0, 24) : songs;
      return {'title': item['title'], 'contents': limitedSongs};
    }
    return {'title': item['title'], 'contents': []};
  }

  Future<dynamic> home() async {
    final data = Map.from(_musicServices.context);
    data["browseId"] = "FEmusic_home";
    final response = await _musicServices.sendRequest("browse", data);
    final results = nav(response.data, single_column_tab + section_list) ?? [];
    return parseMixedContent(results);
  }

  Future<dynamic> explore({int limit = 4}) async {
    final data = Map.from(_musicServices.context);
    data["browseId"] = "FEmusic_explore";
    final response = await _musicServices.sendRequest("browse", data);
    final results = nav(response.data, single_column_tab + section_list) ?? [];
    return parseMixedContent(results).take(limit).toList();
  }
}
