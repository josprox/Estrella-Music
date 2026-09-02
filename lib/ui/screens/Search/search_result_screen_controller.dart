import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import '/ui/widgets/sort_widget.dart';

class SearchResultScreenController extends GetxController {
  final isResultContentFetced = false.obs;
  final resultContent = <String, dynamic>{}.obs;
  final musicServices = Get.find<MusicCatalogService>();
  final queryString = ''.obs;

  // Lista de filtros disponibles (Chips)
  final filters = <String>[].obs;
  final currentFilter = 'All'.obs;

  final additionalParamNext = {}.obs;
  bool continuationInProgress = false;

  final ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    _getInitSearchResult();
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    scrollController.addListener(_onScroll);
    super.onReady();
  }

  void _onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200 && currentFilter.value != 'All') {
      if (!continuationInProgress &&
          additionalParamNext['additionalParams'] != null &&
          additionalParamNext['additionalParams'] !=
              '&ctoken=null&continuation=null') {
        continuationInProgress = true;
        getContinuationContents();
      }
    }
  }

  Future<void> getContinuationContents() async {
    final x = await musicServices.getSearchContinuation(additionalParamNext);

    // Anexamos los nuevos resultados a resultContent
    final Map<String, dynamic> currentData = Map.from(resultContent);
    x.forEach((key, value) {
      if (key != 'params' && key != 'searchEndpoint') {
        if (currentData.containsKey(key)) {
          currentData[key].addAll(value);
        } else {
          currentData[key] = value;
        }
      }
    });

    resultContent.value = currentData;
    if (x['params'] != null) {
      additionalParamNext.value = x['params'];
    }

    continuationInProgress = false;
  }

  Future<void> applyFilter(String filterName) async {
    if (currentFilter.value == filterName) return;

    currentFilter.value = filterName;
    isResultContentFetced.value = false;

    if (filterName == 'All') {
      // Re-fetch all
      resultContent.value = await musicServices.search(queryString.value);
    } else {
      final filterMap = (resultContent['searchEndpoint'] as Map?) ?? {};
      final itemCount = (filterName == 'Songs' ||
              filterName == 'Videos' ||
              filterName == 'Episodes')
          ? 25
          : 10;
      final x = await musicServices.search(queryString.value,
          filter: filterName.replaceAll(" ", "_").toLowerCase(),
          limit: itemCount,
          filterParams: filterMap[filterName]);

      // En este modo, resultContent solo tendrá la llave del filtro (ej. "Songs") y "params"
      resultContent.value = x;
      if (x['params'] != null) {
        additionalParamNext.value = x['params'];
      } else {
        additionalParamNext.clear();
      }
    }
    isResultContentFetced.value = true;

    // Reset scroll al aplicar filtro
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
  }

  Future<void> _getInitSearchResult() async {
    isResultContentFetced.value = false;
    final args = Get.arguments;
    if (args != null) {
      queryString.value = args;
      resultContent.value = await musicServices.search(args);

      final Set<String> allCategories = {'All'};

      if (resultContent.containsKey('searchEndpoint')) {
        allCategories.addAll(
            (resultContent['searchEndpoint'] as Map).keys.cast<String>());
      }

      final List<String> orderedList = [
        "All",
        "Songs",
        "Videos",
        "Albums",
        "Artists",
        "Playlists",
        "Podcasts",
        "Episodes",
        "Community playlists",
        "Featured playlists",
        "Profiles"
      ];

      final List<String> sortedKeys = allCategories.toList();
      sortedKeys.sort((a, b) {
        int indexA = orderedList.indexOf(a);
        int indexB = orderedList.indexOf(b);
        if (indexA == -1) indexA = 99;
        if (indexB == -1) indexB = 99;
        return indexA.compareTo(indexB);
      });

      filters.value = sortedKeys;
      isResultContentFetced.value = true;
    }
  }

  void onSort(SortType sortType, bool isAscending, String title) {
    if (!resultContent.containsKey(title)) return;

    if (title == "Songs" || title == "Videos" || title == "Episodes") {
      final songList = resultContent[title].toList();
      sortSongsNVideos(songList, sortType, isAscending);
      resultContent[title] = songList;
    } else if (title.toLowerCase().contains('playlist')) {
      final playlists = resultContent[title].toList();
      sortPlayLists(playlists, sortType, isAscending);
      resultContent[title] = playlists;
    } else if (title == "Artists" || title == "Profiles") {
      final artistList = resultContent[title].toList();
      sortArtist(artistList, sortType, isAscending);
      resultContent[title] = artistList;
    } else if (title == "Albums" || title == "Podcasts") {
      final albumList = resultContent[title].toList();
      sortAlbumNSingles(albumList, sortType, isAscending);
      resultContent[title] = albumList;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    super.onClose();
  }
}
