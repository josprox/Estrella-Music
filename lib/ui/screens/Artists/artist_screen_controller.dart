import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';

import 'package:harmonymusic/ui/widgets/add_to_playlist.dart';
import '/ui/widgets/sort_widget.dart';
import 'package:harmonymusic/models/artist.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import '/ui/screens/Home/home_screen_controller.dart';
import '/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/models/media_item_builder.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';

class ArtistScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final isArtistContentFetced = false.obs;
  final navigationRailCurrentIndex = 0.obs;
  final musicServices = Get.find<MusicServices>();
  final railItems = <String>[].obs;
  final artistData = <String, dynamic>{}.obs;
  final sepataredContent = <String, dynamic>{}.obs;
  final isSeparatedArtistContentFetced = false.obs;
  final isAddedToLibrary = false.obs;
  final isOffline = false.obs;
  final offlineDownloadedSongs = <MediaItem>[].obs;
  final songScrollController = ScrollController();
  final videoScrollController = ScrollController();
  final albumScrollController = ScrollController();
  final singlesScrollController = ScrollController();
  SortWidgetController? sortWidgetController;
  final additionalOperationMode = OperationMode.none.obs;
  bool continuationInProgress = false;
  late Artist artist_;
  bool hasArtistSeed = false;
  Map<String, List> tempListContainer = {};
  final likedSongsOfArtist = <MediaItem>[].obs;
  TabController? tabController;
  bool isTabTransitionReversed = false;

  // Metrolist-parity: exposed reactive metadata
  final monthlyListeners = RxnString();
  final isSubscribed = false.obs;
  final shuffleId = RxnString();

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null) {
      if (args is List && args.length >= 2) {
        _init(args[0] as bool, args[1]);
      } else if (args is String) {
        _init(true, args);
      } else {
        // Assume Artist object or other dynamic
        try {
          _init(false, args);
        } catch (e) {
          printERROR("Error initializing artist screen with args: $args. Error: $e");
        }
      }
    }

    if (GetPlatform.isDesktop ||
        Get.find<SettingsScreenController>().isBottomNavBarEnabled.isTrue) {
      tabController = TabController(vsync: this, length: 5);
      tabController?.animation?.addListener(() {
        int indexChange = tabController!.offset.round();
        int index = tabController!.index + indexChange;

        if (index != navigationRailCurrentIndex.value) {
          onDestinationSelected(index);
          navigationRailCurrentIndex.value = index;
        }
      });
    }

    // Listen to changes in LIBFAV for reactivity
    SqliteStore.box("LIBFAV").listenable().addListener(_loadLikedSongsOfArtist);

    super.onInit();
  }

  @override
  void onReady() {
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    super.onReady();
  }

  Future<void> _init(bool isIdOnly, dynamic artist) async {
    if (!isIdOnly) {
      artist_ = artist as Artist;
      hasArtistSeed = true;
    }
    final artistId = isIdOnly ? artist as String : artist.browseId;
    await _checkIfAddedToLibrary(artistId);
    await _fetchArtistContent(artistId);
  }

  Future<void> _checkIfAddedToLibrary(String id) async {
    final box = await SqliteStore.openBox("LibraryArtists");
    isAddedToLibrary.value = box.containsKey(id);
    if (isAddedToLibrary.value) {
      artist_ = Artist.fromJson(box.get(id));
      hasArtistSeed = true;
    }
    await box.close();
  }

  Future<void> _fetchArtistContent(String id) async {
    try {
      final content = await musicServices.getArtist(id);
      _applyArtistContent(
        content,
        browseId: id,
      );
      // Save the artist thumbnail URL for offline use
      _cacheArtistThumbnail(id);
    } on NetworkError catch (error) {
      printERROR("Error fetching artist details: $error");
      // Try catalog recovery first
      final recoveredArtist =
          await Get.find<CatalogRecoveryService>().findSimilarArtist(
        artistName: _artistNameHint(),
      );
      if (recoveredArtist != null && recoveredArtist.browseId != id) {
        try {
          final content =
              await musicServices.getArtist(recoveredArtist.browseId);
          _applyArtistContent(
            content,
            browseId: recoveredArtist.browseId,
            persistRecovery: isAddedToLibrary.isTrue,
            previousBrowseId: id,
          );
          _cacheArtistThumbnail(recoveredArtist.browseId);
        } catch (_) {
          await _loadOfflineMode(id);
        }
      } else {
        await _loadOfflineMode(id);
      }
    } catch (e) {
      printERROR("Error fetching artist details: $e");
      _ensureArtistPlaceholder(id);
    } finally {
      isArtistContentFetced.value = true;
    }
  }

  /// Persists the artist thumbnail URL to SqliteStore for offline access
  Future<void> _cacheArtistThumbnail(String artistId) async {
    try {
      if (!hasArtistSeed) return;
      final thumbnailUrl = artist_.thumbnailUrl;
      if (thumbnailUrl.isEmpty) return;
      final box = await SqliteStore.openBox('ArtistThumbnails');
      box.put(artistId, thumbnailUrl);
    } catch (_) {}
  }

  /// Gets a cached thumbnail URL for offline display
  Future<String> _getCachedThumbnail(String artistId) async {
    try {
      final box = await SqliteStore.openBox('ArtistThumbnails');
      return box.get(artistId, defaultValue: '') as String;
    } catch (_) {
      return '';
    }
  }

  /// Loads offline mode: uses cached artist data + songs from SongDownloads
  Future<void> _loadOfflineMode(String id) async {
    _ensureArtistPlaceholder(id);
    isOffline.value = true;

    // Try to restore thumbnail URL from SqliteStore cache
    final cachedThumbnail = await _getCachedThumbnail(id);
    if (cachedThumbnail.isNotEmpty) {
      artist_ = Artist(
        browseId: artist_.browseId,
        name: artist_.name,
        thumbnailUrl: cachedThumbnail,
        subscribers: artist_.subscribers ?? '',
        radioId: artist_.radioId,
      );
      hasArtistSeed = true;
    }

    // Load downloaded songs that belong to this artist
    await _loadOfflineDownloadedSongs();
  }

  /// Loads songs from SongDownloads that match this artist
  Future<void> _loadOfflineDownloadedSongs() async {
    try {
      final dlBox = SqliteStore.box('SongDownloads');
      final artistName = _artistNameHint().toLowerCase();
      if (artistName.isEmpty) return;

      final List<MediaItem> songs = [];
      for (final value in dlBox.values) {
        if (value is! Map) continue;
        // Check artist field
        final artist = (value['artist'] as String?)?.toLowerCase() ?? '';
        // Check artists list
        final artistsList = value['extras']?['artists'] as List?;
        bool matches = artist.contains(artistName);
        if (!matches && artistsList != null) {
          for (final a in artistsList) {
            final name = (a['name'] as String?)?.toLowerCase() ?? '';
            if (name.contains(artistName)) {
              matches = true;
              break;
            }
          }
        }
        if (matches) {
          final item = MediaItemBuilder.fromJson(value);
          songs.add(item);
        }
      }
      offlineDownloadedSongs.assignAll(songs);
    } catch (e) {
      printERROR('Error loading offline downloaded songs: $e');
    }
  }

  void _applyArtistContent(
    Map<String, dynamic> content, {
    required String browseId,
    bool persistRecovery = false,
    String? previousBrowseId,
  }) {
    artistData.value = content;
    // Map various possible names to standard keys
    artistData["Singles"] = artistData["Singles"] ?? artistData["Singles & EPs"] ?? artistData["Sencillos y EPs"];
    artistData["Songs"] = artistData["Songs"] ?? artistData["Top songs"] ?? artistData["Canciones populares"];
    artistData["Albums"] = artistData["Albums"] ?? artistData["Ãlbumes"];
    artistData["Videos"] = artistData["Videos"] ?? artistData["Popular music videos"] ?? artistData["Vídeos"];
    artistData["Playlists"] = artistData["Playlists"] ?? artistData["Listas de reproducción"];
    artistData["Podcasts"] = artistData["Podcasts"] ?? artistData["Podcast shows"] ?? artistData["Podcasts"];
    artistData["Episodes"] = artistData["Episodes"] ?? artistData["New episodes"] ?? artistData["Episodios"];

    final subscribers = artistData['subscribers']?.toString().trim();
    final monthly = artistData['monthlyListeners']?.toString().trim();
    final subBool = artistData['isSubscribed'] == true;
    final shuffleEndpointId = artistData['shuffleId']?.toString();

    monthlyListeners.value = (monthly != null && monthly.isNotEmpty) ? monthly : null;
    isSubscribed.value = subBool;
    shuffleId.value = shuffleEndpointId;

    artist_ = Artist(
      browseId: browseId,
      name: artistData['name'] ?? _artistNameHint(fallback: 'Artista'),
      thumbnailUrl: artistData['thumbnails'] != null &&
              (artistData['thumbnails'] as List).isNotEmpty
          ? artistData['thumbnails'][0]['url']
          : "",
      subscribers: subscribers == null || subscribers.isEmpty
          ? ""
          : "$subscribers subscribers",
      radioId: artistData["radioId"],
      shuffleId: shuffleEndpointId,
      isSubscribed: subBool,
      monthlyListeners: (monthly != null && monthly.isNotEmpty) ? monthly : null,
    );
    hasArtistSeed = true;

    if (persistRecovery && previousBrowseId != null) {
      Get.find<CatalogRecoveryService>().persistRecoveredArtist(
        oldBrowseId: previousBrowseId,
        artist: artist_,
      );
    }

    // Load liked songs of this artist
    _loadLikedSongsOfArtist();
  }

  /// Fetches the full list of items for a category using its browseEndpoint
  Future<List<dynamic>> fetchCategoryContent(String category) async {
    final section = artistData[category];
    if (section == null) return [];
    
    // If we have params, it means there's more to fetch
    if (section is Map && (section.containsKey('browseId') || section.containsKey('params'))) {
      try {
        final result = await musicServices.getArtistRealtedContent(
          Map<String, dynamic>.from(section),
          category,
        );
        final results = result['results'] ?? [];
        if (results.isNotEmpty) {
          final updatedSection = Map<String, dynamic>.from(artistData[category]);
          updatedSection['content'] = results;
          artistData[category] = updatedSection;
          artistData.refresh();
        }
        return results;
      } catch (e) {
        printERROR("Error fetching full category $category: $e");
      }
    }
    
    // Fallback to what we already have
    return (section['content'] as List?) ?? [];
  }

  Future<void> _loadLikedSongsOfArtist() async {
    try {
      final box = SqliteStore.box("LIBFAV");
      final artistName = artist_.name.toLowerCase();

      // Optimize: filter and map in a single pass without constructing full MediaItem for every item
      final List<MediaItem> filtered = [];
      for (final e in box.values) {
        if (e is! Map) continue;
        
        bool matches = false;
        final artistsList = e['artists'] as List?;
        if (artistsList != null) {
          for (final a in artistsList) {
            final name = (a['name'] as String?)?.toLowerCase() ?? '';
            if (name.contains(artistName)) {
              matches = true;
              break;
            }
          }
        }

        if (matches) {
          filtered.add(MediaItemBuilder.fromJson(e));
        }
      }

      likedSongsOfArtist.assignAll(filtered);
    } catch (e) {
      printERROR("Error loading liked songs of artist: $e");
    }
  }

  String _artistNameHint({String fallback = ''}) {
    if (hasArtistSeed) {
      final value = artist_.name.trim();
      if (value.isNotEmpty) {
        return value;
      }
    }
    final value = artistData['name']?.toString().trim();
    if (value != null && value.isNotEmpty) {
      return value;
    }
    return fallback;
  }

  void _ensureArtistPlaceholder(String browseId) {
    if (!hasArtistSeed) {
      artist_ = Artist(
        browseId: browseId,
        name: _artistNameHint(fallback: 'Artista'),
        thumbnailUrl: '',
        subscribers: '',
      );
      hasArtistSeed = true;
    }
    artistData.value = {
      'name': artist_.name,
      'thumbnails': [
        {'url': artist_.thumbnailUrl}
      ],
      'description': '',
      'subscribers': artist_.subscribers ?? '',
      'radioId': artist_.radioId,
    };
    artistData["Singles"] = artistData["Singles & EPs"];
    artistData["Songs"] = artistData["Top songs"];
  }

  Future<bool> addNremoveFromLibrary({bool add = true}) async {
    try {
      final box = await SqliteStore.openBox("LibraryArtists");
      add
          ? box.put(artist_.browseId, artist_.toJson())
          : box.delete(artist_.browseId);
      isAddedToLibrary.value = add;
      //Update frontend
      Get.find<LibraryArtistsController>().refreshLib();
      Get.find<SyncService>().triggerPush();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> onDestinationSelected(int val) async {
    isTabTransitionReversed = val > navigationRailCurrentIndex.value;
    navigationRailCurrentIndex.value = val;
    final tabName = ["About", "Songs", "Videos", "Albums", "Singles"][val];

    //cancel additional operations in case of tab change
    if (sortWidgetController != null) {
      sortWidgetController?.setActiveMode(OperationMode.none);
      cancelAdditionalOperation();
    }

    //skip for about page
    if (val == 0 || sepataredContent.containsKey(tabName)) return;
    if (artistData[tabName] == null) {
      isSeparatedArtistContentFetced.value = true;
      return;
    }
    isSeparatedArtistContentFetced.value = false;

    //check if params available for continuation
    //tab browse endpoint & top result stored in [artistData], tabContent & addtionalParams for continuation stored in Separated Content
    if ((artistData[tabName]).containsKey("params")) {
      sepataredContent[tabName] = await musicServices.getArtistRealtedContent(
          artistData[tabName], tabName);
    } else {
      sepataredContent[tabName] = {"results": artistData[tabName]['content']};
      isSeparatedArtistContentFetced.value = true;
      return;
    }

    // observered - continuation available only for song & vid
    if (val != 0) {
      final scrollController = val == 1
          ? songScrollController
          : val == 2
              ? videoScrollController
              : val == 3
                  ? albumScrollController
                  : singlesScrollController;

      scrollController.addListener(() {
        double maxScroll = scrollController.position.maxScrollExtent;
        double currentScroll = scrollController.position.pixels;
        if (currentScroll >= maxScroll / 2 &&
            sepataredContent[tabName]['additionalParams'] !=
                '&ctoken=null&continuation=null') {
          if (!continuationInProgress) {
            continuationInProgress = true;
            getContinuationContents(artistData[tabName], tabName);
          }
        }
      });
    }
    isSeparatedArtistContentFetced.value = true;
  }

  Future<void> getContinuationContents(browseEndpoint, tabName) async {
    final x = await musicServices.getArtistRealtedContent(
        browseEndpoint, tabName,
        additionalParams: sepataredContent[tabName]['additionalParams']);
    (sepataredContent[tabName]['results']).addAll(x['results']);
    sepataredContent[tabName]['additionalParams'] = x['additionalParams'];
    sepataredContent.refresh();

    continuationInProgress = false;
  }

  void onSort(SortType sortType, bool isAscending, String title) {
    if (sepataredContent[title] == null) {
      return;
    }
    if (title == "Songs" || title == "Videos") {
      final songlist = sepataredContent[title]['results'].toList();
      sortSongsNVideos(songlist, sortType, isAscending);
      sepataredContent[title]['results'] = songlist;
    } else if (title == "Albums" || title == "Singles") {
      final albumList = sepataredContent[title]['results'].toList();
      sortAlbumNSingles(albumList, sortType, isAscending);
      sepataredContent[title]['results'] = albumList;
    }
    sepataredContent.refresh();
  }

  void onSearchStart(String? tag) {
    final title = tag?.split("_")[0];
    tempListContainer[title!] = sepataredContent[title]['results'].toList();
  }

  void onSearch(String value, String? tag) {
    final title = tag?.split("_")[0];
    final list = tempListContainer[title]!
        .where((element) =>
            element.title.toLowerCase().contains(value.toLowerCase()))
        .toList();
    sepataredContent[title]['results'] = list;
    sepataredContent.refresh();
  }

  void onSearchClose(String? tag) {
    final title = tag?.split("_")[0];
    sepataredContent[title]['results'] = (tempListContainer[title]!).toList();
    sepataredContent.refresh();
    (tempListContainer[title]!).clear();
  }

  //Additional operations
  final additionalOperationTempList = <MediaItem>[].obs;
  final additionalOperationTempMap = <int, bool>{}.obs;

  void startAdditionalOperation(
      SortWidgetController sortWidgetController_, OperationMode mode) {
    sortWidgetController = sortWidgetController_;
    final tabName = [
      "About",
      "Songs",
      "Videos",
      "Albums",
      "Singles"
    ][navigationRailCurrentIndex.value];
    additionalOperationTempList.value =
        sepataredContent[tabName]['results'].toList();
    if (mode == OperationMode.addToPlaylist || mode == OperationMode.delete) {
      for (int i = 0; i < additionalOperationTempList.length; i++) {
        additionalOperationTempMap[i] = false;
      }
    }
    additionalOperationMode.value = mode;
  }

  void checkIfAllSelected() {
    sortWidgetController!.isAllSelected.value =
        !additionalOperationTempMap.containsValue(false);
  }

  void selectAll(bool selected) {
    for (int i = 0; i < additionalOperationTempList.length; i++) {
      additionalOperationTempMap[i] = selected;
    }
  }

  void performAdditionalOperation() {
    final currMode = additionalOperationMode.value;
    if (currMode == OperationMode.addToPlaylist) {
      showDialog(
        context: Get.context!,
        builder: (context) => AddToPlaylist(selectedSongs()),
      ).whenComplete(() {
        Get.delete<AddToPlaylistController>();
        sortWidgetController?.setActiveMode(OperationMode.none);
        cancelAdditionalOperation();
      });
    }
  }

  List<MediaItem> selectedSongs() {
    return additionalOperationTempMap.entries
        .map((item) {
          if (item.value) {
            return additionalOperationTempList[item.key];
          }
        })
        .whereType<MediaItem>()
        .toList();
  }

  void cancelAdditionalOperation() {
    sortWidgetController!.isAllSelected.value = false;
    sortWidgetController = null;
    additionalOperationMode.value = OperationMode.none;
    additionalOperationTempList.clear();
    additionalOperationTempMap.clear();
  }

  @override
  void onClose() {
    tempListContainer.clear();
    songScrollController.dispose();
    videoScrollController.dispose();
    albumScrollController.dispose();
    singlesScrollController.dispose();
    tabController?.dispose();
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    super.onClose();
  }
}
