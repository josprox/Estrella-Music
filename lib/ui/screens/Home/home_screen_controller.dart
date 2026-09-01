import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

import '/models/media_item_builder.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/utils/helpers/update_check_flag_file.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import '/models/album.dart';
import '/models/playlist.dart';
import '/models/artist.dart';
import 'package:estrella_music/generated/l10n.dart';
import '/models/quick_picks.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/ui/screens/Settings/settings_screen_controller.dart';
import '/ui/widgets/new_version_dialog.dart';

class HomeScreenController extends GetxController {
  static const supportedStartupTabs = {0, 1, 3, 4, 5};
  static const _homeCacheTtl = Duration(minutes: 30);
  static const _recommendationsCacheTtl = Duration(minutes: 30);

  static int _initialTabIndex() {
    final saved = SqliteStore.box('AppPrefs').get('startupTabIndex');
    final index = saved is int ? saved : int.tryParse('$saved');
    return supportedStartupTabs.contains(index) ? index! : 0;
  }

  final MusicCatalogService _musicServices = Get.find<MusicCatalogService>();
  final isContentFetched = false.obs;
  final tabIndex = _initialTabIndex().obs;
  final networkError = false.obs;
  final quickPicks = QuickPicks([]).obs;
  final middleContent = [].obs;
  final fixedContent = [].obs;

  final randomMusic = Rx<QuickPicks?>(null);
  final mostListened = <MediaItem>[].obs;
  final forgottenFavorites = Rx<QuickPicks?>(null);
  final dailyDiscover = Rx<QuickPicks?>(null);
  final communityPlaylists = Rx<QuickPicks?>(null);
  final keepListening = Rx<QuickPicks?>(null);
  final similarRecommendations = Rx<QuickPicks?>(null);

  final showVersionDialog = true.obs;
  //isHomeScreenOnTop var only useful if bottom nav enabled
  final isHomeSreenOnTop = true.obs;
  final List<ScrollController> contentScrollControllers = [];
  bool reverseAnimationtransiton = false;

  final exploreNetworkError = false.obs;
  final List<StreamSubscription<dynamic>> _localSectionSubscriptions = [];
  Timer? _localSectionsRefreshDebounce;
  Timer? _recommendationsDelay;
  Future<void>? _activeContentLoad;
  Future<void>? _activeRecommendationsLoad;

  @override
  onInit() {
    super.onInit();
    _watchLocalSections();
    _initAndLoad();
  }

  Future<void> reloadRecommendations({bool force = false}) {
    final activeLoad = _activeRecommendationsLoad;
    if (activeLoad != null) return activeLoad;
    final operation = _reloadRecommendations(force: force);
    _activeRecommendationsLoad = operation;
    return operation.whenComplete(() {
      if (identical(_activeRecommendationsLoad, operation)) {
        _activeRecommendationsLoad = null;
      }
    });
  }

  Future<void> _reloadRecommendations({required bool force}) async {
    if (!force &&
        _hasRestoredRecommendations &&
        _isCacheFresh('homeRecommendationsTime', _recommendationsCacheTtl)) {
      return;
    }
    await _loadDailyDiscover();
    await _loadCommunityPlaylists();
    await _loadKeepListening();
    await _loadSimilarRecommendations();
    await _cacheRecommendations();
  }

  Future<void> _initAndLoad() async {
    await _musicServices.init();
    await loadContent();
    if (updateCheckFlag) _checkNewVersion();
    // Home itself has priority. Recommendation sections are expensive catalog
    // lookups, so let the cached/primary view settle before requesting them.
    _recommendationsDelay?.cancel();
    _recommendationsDelay = Timer(const Duration(seconds: 2), () {
      unawaited(reloadRecommendations());
    });
  }

  void _watchLocalSections() {
    for (final boxName in const ['SongsCache', 'LIBFAV', 'LIBRP']) {
      _localSectionSubscriptions.add(
        SqliteStore.box(boxName).watch().listen((_) {
          _localSectionsRefreshDebounce?.cancel();
          _localSectionsRefreshDebounce = Timer(
            const Duration(milliseconds: 250),
            () => loadLocalCustomSections(),
          );
        }),
      );
    }
  }

  Future<void> _loadDailyDiscover() async {
    try {
      final favBox = await SqliteStore.openBox('LIBFAV');
      if (favBox.isEmpty) {
        printINFO("Daily Discover: No favorites found in LIBFAV");
        return;
      }

      final allFavs =
          favBox.values.map((e) => MediaItemBuilder.fromJson(e)).toList();
      allFavs.shuffle();
      final seeds = allFavs.take(2).toList();

      List<MediaItem> recommendations = [];

      for (final seed in seeds) {
        final items = await _relatedOrCatalogSongs(seed, limit: 8);
        if (items.isNotEmpty) {
          items.shuffle();
          recommendations.add(items.first);
        }
      }

      if (recommendations.isNotEmpty) {
        final uniqueRecs = <String, MediaItem>{};
        for (var rec in recommendations) {
          uniqueRecs[rec.id] = rec;
        }
        var finalRecs = uniqueRecs.values.toList();
        finalRecs.shuffle();
        dailyDiscover.value =
            QuickPicks(finalRecs, title: S.current.dailyDiscover);
        printINFO("Daily Discover: Loaded ${finalRecs.length} recommendations");
      } else {
        printWarning(
            "Daily Discover: No recommendations could be generated from seeds");
      }
    } catch (e) {
      printERROR("Daily Discover failed: $e");
    }
  }

  Future<void> _loadCommunityPlaylists() async {
    try {
      final favBox = await SqliteStore.openBox('LIBFAV');
      if (favBox.isEmpty) return;

      final allFavs =
          favBox.values.map((e) => MediaItemBuilder.fromJson(e)).toList();
      allFavs.shuffle();
      final seeds = allFavs.take(1).toList();

      List<MediaItem> recommendations = [];

      for (final seed in seeds) {
        final res = await _musicServices.search(seed.title,
            filter: "community_playlists");
        if (res.containsKey("Community playlists")) {
          // 'Community playlists' are Playlists, but recommendations expects MediaItems.
          // In `loadCommunityPlaylists`, we probably shouldn't mix Playlists into a list of MediaItems.
          // But wait, the original code tried to cast them to MediaItem.
          // QuickPicks requires a list of MediaItem.
          // So if we get a Playlist, maybe we should convert it to a MediaItem using MediaItemBuilder?
          // Let's just create a MediaItem from the Playlist properties, or skip if it's meant to be a QuickPick (which usually holds songs/videos).
          // Wait, QuickPicks can hold playlists if their ID is used to navigate.
          final items = (res["Community playlists"] as List).map((e) {
            if (e is Playlist) {
              return MediaItem(
                id: e.playlistId,
                title: e.title,
                artist: e.description ?? "eMusic",
                artUri: Uri.tryParse(e.thumbnailUrl),
                extras: {'resultType': 'playlist'},
              );
            }
            return e as MediaItem;
          }).toList();
          items.shuffle();
          if (items.isNotEmpty) recommendations.add(items.first);
        }
      }

      if (recommendations.isNotEmpty) {
        final uniqueRecs = <String, MediaItem>{};
        for (var rec in recommendations) {
          uniqueRecs[rec.id] = rec;
        }
        var finalRecs = uniqueRecs.values.toList();
        finalRecs.shuffle();
        communityPlaylists.value =
            QuickPicks(finalRecs, title: S.current.communityplaylists);
      }
    } catch (e) {
      printERROR("Community Playlists failed: $e");
    }
  }

  Future<void> _loadKeepListening() async {
    try {
      final favBox = await SqliteStore.openBox('LIBFAV');
      if (favBox.isEmpty) return;

      final allFavs =
          favBox.values.map((e) => MediaItemBuilder.fromJson(e)).toList();
      // Sort by lastPlayed descending to get most recently played
      final keepList = List<MediaItem>.from(allFavs)
        ..sort((a, b) {
          final lastA = a.extras?['lastPlayed'] as int? ?? 0;
          final lastB = b.extras?['lastPlayed'] as int? ?? 0;
          return lastB.compareTo(lastA);
        });

      final seeds = keepList.take(1).toList();
      List<MediaItem> recommendations = [];
      recommendations.addAll(seeds);

      for (final seed in seeds) {
        final items = await _relatedOrCatalogSongs(seed, limit: 8);
        if (items.isNotEmpty) {
          items.shuffle();
          recommendations.add(items.first);
        }
      }

      if (recommendations.isNotEmpty) {
        final uniqueRecs = <String, MediaItem>{};
        for (var rec in recommendations) {
          uniqueRecs[rec.id] = rec;
        }
        var finalRecs = uniqueRecs.values.toList();
        finalRecs.shuffle();
        keepListening.value =
            QuickPicks(finalRecs, title: S.current.keepListening);
      }
    } catch (e) {
      printERROR("Keep Listening failed: $e");
    }
  }

  Future<void> _loadSimilarRecommendations() async {
    try {
      final favBox = await SqliteStore.openBox('LIBFAV');
      if (favBox.isEmpty) {
        printINFO("Similar Recommendations: No favorites found in LIBFAV");
        return;
      }

      final allFavs =
          favBox.values.map((e) => MediaItemBuilder.fromJson(e)).toList();
      allFavs.shuffle();
      final seed = allFavs.first;

      final recommendations = await _relatedOrCatalogSongs(seed, limit: 15);

      if (recommendations.isNotEmpty) {
        final uniqueRecs = <String, MediaItem>{};
        for (var rec in recommendations) {
          uniqueRecs[rec.id] = rec;
        }
        var finalRecs = uniqueRecs.values.toList();
        finalRecs.shuffle();
        similarRecommendations.value =
            QuickPicks(finalRecs, title: S.current.similarToTitle(seed.title));
        printINFO(
            "Similar Recommendations: Loaded ${finalRecs.length} recommendations for seed ${seed.title}");
      } else {
        printWarning(
            "Similar Recommendations: No recommendations could be generated from seed ${seed.title}");
      }
    } catch (e) {
      printERROR("Similar Recommendations failed: $e");
    }
  }

  Future<List<MediaItem>> _relatedOrCatalogSongs(
    MediaItem seed, {
    required int limit,
  }) async {
    final unique = <String, MediaItem>{};

    if (seed.id.isNotEmpty) {
      final related = await _musicServices.getContentRelatedToSong(
        seed.id,
        getContentHlCode(),
      );
      for (final section in related) {
        final contents = section['contents'];
        if (contents is! List) continue;
        for (final item in contents.whereType<MediaItem>()) {
          if (item.id.isNotEmpty && item.id != seed.id) {
            unique[item.id] = item;
          }
        }
      }
    }

    if (unique.isNotEmpty) {
      return unique.values.take(limit).toList();
    }

    // Legacy favorites can outlive their related browse tab. The fallback
    // stays provider-neutral and searches the active online catalog.
    final queries = <String>{
      if (seed.artist != null &&
          seed.artist!.trim().isNotEmpty &&
          seed.artist!.toLowerCase() != 'unknown artist')
        seed.artist!.trim(),
      seed.title.trim(),
    };
    for (final query in queries) {
      if (query.isEmpty) continue;
      final results = await _musicServices.search(
        query,
        filter: 'songs',
        limit: limit + 5,
      );
      for (final value in results.values) {
        if (value is! List) continue;
        for (final item in value.whereType<MediaItem>()) {
          if (item.id.isNotEmpty && item.id != seed.id) {
            unique[item.id] = item;
          }
        }
      }
      if (unique.length >= limit) break;
    }
    if (unique.isNotEmpty) {
      printINFO(
        'Recommendations: catalog fallback found ${unique.length} songs '
        'for ${seed.title}',
      );
    }
    return unique.values.take(limit).toList();
  }

  Future<void> loadLocalCustomSections() async {
    try {
      final songsCacheBox = await SqliteStore.openBox('SongsCache');
      final favBox = await SqliteStore.openBox('LIBFAV');

      final allCachedSongs = songsCacheBox.values
          .map((e) => MediaItemBuilder.fromJson(e))
          .toList();

      if (quickPicks.value.songList.isEmpty) {
        final localQuickPicks = <String, MediaItem>{};
        for (final song in allCachedSongs) {
          if (song.id.isNotEmpty) localQuickPicks[song.id] = song;
        }
        for (final value in favBox.values) {
          final song = MediaItemBuilder.fromJson(value);
          if (song.id.isNotEmpty) localQuickPicks[song.id] = song;
        }
        // Fallback: If SongsCache & favBox are empty, load directly from provider (e.g. LocalMusicProvider)
        if (localQuickPicks.isEmpty &&
            Get.isRegistered<MusicCatalogService>()) {
          try {
            final catalog = Get.find<MusicCatalogService>();
            final tracks = await catalog.tracks();
            for (final track in tracks) {
              final item = catalog.mediaItemFromTrack(track);
              if (item.id.isNotEmpty) localQuickPicks[item.id] = item;
            }
          } catch (_) {}
        }
        if (localQuickPicks.isNotEmpty) {
          final songs = localQuickPicks.values.toList()..shuffle();
          quickPicks.value = QuickPicks(
            songs.take(15).toList(),
            title: S.current.quickpicks,
          );
          isContentFetched.value = true;
        }
      }

      // Random Music (limit 15)
      if (allCachedSongs.isNotEmpty) {
        final randomList = List<MediaItem>.from(allCachedSongs)..shuffle();
        randomMusic.value = QuickPicks(randomList.take(15).toList(),
            title: S.current.randomSelection);
      }

      // Most Listened (sort by totalPlayTime descending)
      final mostListenedList = List<MediaItem>.from(allCachedSongs)
        ..sort((a, b) {
          final playA = a.extras?['totalPlayTime'] as int? ?? 0;
          final playB = b.extras?['totalPlayTime'] as int? ?? 0;
          return playB.compareTo(playA); // descending
        });
      mostListened.value = mostListenedList
          .where((e) => (e.extras?['totalPlayTime'] ?? 0) > 0)
          .take(15)
          .toList();

      // Forgotten Favorites
      if (favBox.isNotEmpty) {
        final allFavs =
            favBox.values.map((e) => MediaItemBuilder.fromJson(e)).toList();
        final forgottenList = List<MediaItem>.from(allFavs)
          ..sort((a, b) {
            final lastA = a.extras?['lastPlayed'] as int? ?? 0;
            final lastB = b.extras?['lastPlayed'] as int? ?? 0;
            return lastA.compareTo(lastB); // ascending (oldest first)
          });
        forgottenFavorites.value = QuickPicks(forgottenList.take(15).toList(),
            title: S.current.forgottenFavorites);
      }
    } catch (e) {
      printERROR("Fallo al cargar secciones locales en Home: $e");
    }
  }

  Future<void> loadContent({bool forceRefresh = false}) {
    final activeLoad = _activeContentLoad;
    if (activeLoad != null) return activeLoad;

    final operation = _loadContent(forceRefresh: forceRefresh);
    _activeContentLoad = operation;
    return operation.whenComplete(() {
      if (identical(_activeContentLoad, operation)) {
        _activeContentLoad = null;
      }
    });
  }

  Future<void> refreshContent() async {
    await loadContent(forceRefresh: true);
    await reloadRecommendations(force: true);
  }

  Future<void> _loadContent({required bool forceRefresh}) async {
    final loadedFromCache = await loadContentFromDb();
    await loadLocalCustomSections();
    if (!forceRefresh &&
        loadedFromCache &&
        _isCacheFresh('homeScreenDataTime', _homeCacheTtl)) {
      return;
    }
    await loadContentFromNetwork(silent: loadedFromCache);
  }

  Future<bool> loadContentFromDb() async {
    final homeScreenData = await SqliteStore.openBox("homeScreenData");
    if (homeScreenData.keys.isNotEmpty) {
      final String quickPicksType =
          homeScreenData.get("quickPicksType")?.toString() ??
              S.current.quickpicks;
      final List quickPicksData = homeScreenData.get("quickPicks") ?? [];
      final List middleContentData = homeScreenData.get("middleContent") ?? [];
      final List fixedContentData = homeScreenData.get("fixedContent") ?? [];
      quickPicks.value = QuickPicks(
          quickPicksData.map((e) => MediaItemBuilder.fromJson(e)).toList(),
          title: quickPicksType);
      middleContent.value = middleContentData.map((e) {
        if (e["type"] == "Album Content") return AlbumContent.fromJson(e);
        if (e["type"] == "QuickPicks Content") return QuickPicks.fromJson(e);
        if (e["type"] == "Artist Content") return ArtistContent.fromJson(e);
        return PlaylistContent.fromJson(e);
      }).toList();
      fixedContent.value = fixedContentData.map((e) {
        if (e["type"] == "Album Content") return AlbumContent.fromJson(e);
        if (e["type"] == "QuickPicks Content") return QuickPicks.fromJson(e);
        if (e["type"] == "Artist Content") return ArtistContent.fromJson(e);
        return PlaylistContent.fromJson(e);
      }).toList();
      _restoreRecommendations(homeScreenData.get('recommendations'));
      isContentFetched.value = true;
      printINFO("Loaded from offline db");
      return true;
    } else {
      return false;
    }
  }

  bool get _hasRestoredRecommendations =>
      dailyDiscover.value != null ||
      communityPlaylists.value != null ||
      keepListening.value != null ||
      similarRecommendations.value != null;

  bool _isCacheFresh(String key, Duration ttl) {
    final raw = SqliteStore.box('AppPrefs').get(key);
    final timestamp = raw is int ? raw : int.tryParse('$raw');
    if (timestamp == null) return false;
    return DateTime.now().millisecondsSinceEpoch - timestamp <
        ttl.inMilliseconds;
  }

  void _restoreRecommendations(dynamic raw) {
    if (raw is! Map) return;
    QuickPicks? decode(dynamic value) {
      if (value is! Map) return null;
      try {
        return QuickPicks.fromJson(value);
      } catch (_) {
        return null;
      }
    }

    dailyDiscover.value = decode(raw['dailyDiscover']);
    communityPlaylists.value = decode(raw['communityPlaylists']);
    keepListening.value = decode(raw['keepListening']);
    similarRecommendations.value = decode(raw['similarRecommendations']);
  }

  Future<void> _cacheRecommendations() async {
    if (!_hasRestoredRecommendations) return;
    final box = await SqliteStore.openBox('homeScreenData');
    await box.put('recommendations', {
      if (dailyDiscover.value != null)
        'dailyDiscover': dailyDiscover.value!.toJson(),
      if (communityPlaylists.value != null)
        'communityPlaylists': communityPlaylists.value!.toJson(),
      if (keepListening.value != null)
        'keepListening': keepListening.value!.toJson(),
      if (similarRecommendations.value != null)
        'similarRecommendations': similarRecommendations.value!.toJson(),
    });
    await SqliteStore.box('AppPrefs').put(
      'homeRecommendationsTime',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<void> loadContentFromNetwork({bool silent = false}) async {
    final box = SqliteStore.box("AppPrefs");
    String contentType = box.get("discoverContentType") ?? "QP";

    networkError.value = false;
    try {
      List middleContentTemp = [];
      QuickPicks? networkQuickPicks;
      final homeContentListMap = await _musicServices.getHome(
          limit:
              Get.find<SettingsScreenController>().noOfHomeScreenContent.value);
      if (contentType == "TR") {
        final index = homeContentListMap
            .indexWhere((element) => element['title'] == "Trending");
        if (index != -1) {
          networkQuickPicks = QuickPicks(
              List<MediaItem>.from(homeContentListMap[index]["contents"]),
              title: S.current.trending);
        } else if (index == -1) {
          List charts = await _musicServices.getCharts(contentType);
          final index = charts.indexWhere((element) =>
              element['title'] ==
              (contentType == "TMV" ? "Top Music Videos" : "Trending"));
          if (index != -1) {
            networkQuickPicks = QuickPicks(
                List<MediaItem>.from(charts[index]["contents"]),
                title: charts[index]['title']);
            middleContentTemp.addAll(charts);
          }
        }
      } else if (contentType == "TMV") {
        final index = homeContentListMap
            .indexWhere((element) => element['title'] == "Top music videos");
        if (index != -1) {
          final con = homeContentListMap.removeAt(index);
          networkQuickPicks = QuickPicks(List<MediaItem>.from(con["contents"]),
              title: con["title"]);
        } else if (index == -1) {
          List charts = await _musicServices.getCharts(contentType);
          final index = charts.indexWhere((element) =>
              element['title'] ==
              (contentType == "TMV" ? "Top Music Videos" : "Trending"));
          if (index != -1) {
            networkQuickPicks = QuickPicks(
                List<MediaItem>.from(charts[index]["contents"]),
                title: charts[index]["title"]);
            middleContentTemp.addAll(charts);
          }
        }
      } else if (contentType == "BOLI") {
        try {
          final songId = box.get("recentSongId");
          if (songId != null) {
            final rel = await _musicServices.getContentRelatedToSong(
                songId, getContentHlCode());
            if (rel.isNotEmpty) {
              final con = rel.removeAt(0);
              final List<MediaItem> items =
                  (con["contents"] as List).whereType<MediaItem>().toList();
              networkQuickPicks = QuickPicks(items,
                  title: con["title"] ?? S.current.basedOnLast);
              middleContentTemp.addAll(rel);
            }
          }
        } catch (e) {
          printERROR(
              "Seems Based on last interaction content currently not available: $e");
        }
      }

      networkQuickPicks ??= _takeQuickPicksSection(homeContentListMap);
      if (networkQuickPicks != null && networkQuickPicks.songList.isNotEmpty) {
        quickPicks.value = networkQuickPicks;
      } else if (quickPicks.value.songList.isEmpty) {
        // Keep Home useful when the personalized provider response temporarily
        // contains only albums/playlists. The local section will be refreshed
        // again automatically after an EMusic pull changes SQLite.
        await loadLocalCustomSections();
        if (quickPicks.value.songList.isEmpty) {
          printWarning(
              "No song-type content found for QuickPicks; waiting for local or synced songs.");
        }
      }

      // Merge Explore and Podcast content
      try {
        final exploreData = await _musicServices.explore();
        homeContentListMap.addAll(exploreData);

        final podcastData = await _musicServices.podcastDiscover();
        homeContentListMap.addAll(podcastData);
      } catch (e) {
        printERROR("Failed to fetch explore/podcast content: $e");
      }

      middleContent.value = _setContentList(middleContentTemp);
      fixedContent.value = _setContentList(homeContentListMap);

      isContentFetched.value = true;

      cachedHomeScreenData(updateAll: true);
      final appPrefs = await SqliteStore.openBox("AppPrefs");
      await appPrefs.put(
          "homeScreenDataTime", DateTime.now().millisecondsSinceEpoch);
    } catch (r) {
      printERROR("Home Content not loaded: $r");
      await Future.delayed(const Duration(seconds: 1));
      networkError.value = !silent;
    }
  }

  QuickPicks? _takeQuickPicksSection(List<dynamic> sections) {
    if (sections.isEmpty) return null;

    final preferredIndex = sections.indexWhere((section) {
      final title = section['title']?.toString().toLowerCase() ?? '';
      final items = (section['contents'] as List?)?.whereType<MediaItem>();
      return title.contains('quick') && items != null && items.isNotEmpty;
    });
    final fallbackIndex = preferredIndex != -1
        ? preferredIndex
        : sections.indexWhere((section) {
            final items =
                (section['contents'] as List?)?.whereType<MediaItem>();
            return items != null && items.isNotEmpty;
          });
    if (fallbackIndex == -1) return null;

    final section = sections.removeAt(fallbackIndex);
    final songs = (section['contents'] as List).whereType<MediaItem>().toList();
    return QuickPicks(
      songs,
      title: section['title']?.toString() ?? S.current.quickpicks,
    );
  }

  List _setContentList(List<dynamic> contents) {
    List contentTemp = [];
    for (var content in contents) {
      final items = content["contents"] as List?;
      if (items == null || items.isEmpty) continue;

      final firstItem = items[0];
      if (firstItem is Playlist) {
        final playlistList = items.whereType<Playlist>().toList();
        if (playlistList.isNotEmpty) {
          contentTemp.add(PlaylistContent(
              playlistList: playlistList, title: content["title"]));
        }
      } else if (firstItem is Album) {
        final albumList = items.whereType<Album>().toList();
        if (albumList.isNotEmpty) {
          contentTemp
              .add(AlbumContent(albumList: albumList, title: content["title"]));
        }
      } else if (firstItem is MediaItem) {
        final songList = items.whereType<MediaItem>().toList();
        if (songList.isNotEmpty) {
          contentTemp.add(QuickPicks(songList, title: content["title"]));
        }
      } else if (firstItem is Artist) {
        final artistList = items.whereType<Artist>().toList();
        if (artistList.isNotEmpty) {
          contentTemp.add(ArtistContent(artistList, title: content["title"]));
        }
      }
    }
    return contentTemp;
  }

  Future<void> changeDiscoverContent(dynamic val, {String? songId}) async {
    QuickPicks? quickPicks_;
    if (val == 'QP') {
      final homeContentListMap = await _musicServices.getHome(limit: 3);
      if (homeContentListMap.isNotEmpty) {
        quickPicks_ = QuickPicks(
            List<MediaItem>.from(homeContentListMap[0]["contents"]),
            title: homeContentListMap[0]["title"]);
      }
    } else if (val == "TMV" || val == 'TR') {
      try {
        final charts = await _musicServices.getCharts(val);
        final index = charts.indexWhere((element) =>
            element['title'] ==
            (val == "TMV" ? "Top Music Videos" : "Trending"));
        if (index != -1) {
          quickPicks_ = QuickPicks(
              List<MediaItem>.from(charts[index]["contents"]),
              title: charts[index]["title"]);
        }
      } catch (e) {
        printERROR(
            "Seems ${val == "TMV" ? "Top music videos" : "Trending songs"} currently not available!");
      }
    } else {
      songId ??= SqliteStore.box("AppPrefs").get("recentSongId");
      if (songId != null) {
        try {
          final value = await _musicServices.getContentRelatedToSong(
              songId, getContentHlCode());
          if (value.isNotEmpty) {
            middleContent.value = _setContentList(value);
            if ((value[0]['title'] ?? "")
                    .toString()
                    .toLowerCase()
                    .contains("like") ||
                (value[0]['title'] ?? "")
                    .toString()
                    .toLowerCase()
                    .contains("similar")) {
              final List<MediaItem> items = (value[0]["contents"] as List)
                  .whereType<MediaItem>()
                  .toList();
              quickPicks_ = QuickPicks(items, title: value[0]["title"]);
              SqliteStore.box("AppPrefs").put("recentSongId", songId);
            }
          }
        } catch (e) {
          printERROR("changeDiscoverContent failed: $e");
        }
      }
    }
    if (quickPicks_ == null) return;

    quickPicks.value = quickPicks_;

    cachedHomeScreenData(updateQuickPicksNMiddleContent: true);
    await SqliteStore.box("AppPrefs")
        .put("homeScreenDataTime", DateTime.now().millisecondsSinceEpoch);
  }

  String getContentHlCode() {
    const List<String> unsupportedLangIds = ["ia", "ga", "fj", "eo"];
    final userLangId =
        Get.find<SettingsScreenController>().currentAppLanguageCode.value;
    return unsupportedLangIds.contains(userLangId) ? "en" : userLangId;
  }

  void onSideBarTabSelected(int index) {
    reverseAnimationtransiton = index > tabIndex.value;
    tabIndex.value = index;
  }

  void onBottonBarTabSelected(int index) {
    reverseAnimationtransiton = index > tabIndex.value;
    tabIndex.value = index;
  }

  void _checkNewVersion() {
    showVersionDialog.value =
        SqliteStore.box("AppPrefs").get("newVersionVisibility") ?? true;
    if (showVersionDialog.isTrue) {
      newVersionCheck(Get.find<SettingsScreenController>().currentVersion.value)
          .then((value) {
        if (value) {
          showDialog(
              context: Get.context!,
              builder: (context) => const NewVersionDialog());
        }
      });
    }
  }

  void onChangeVersionVisibility(bool val) {
    SqliteStore.box("AppPrefs").put("newVersionVisibility", !val);
    showVersionDialog.value = !val;
  }

  void whenHomeScreenOnTop() {
    if (Get.find<SettingsScreenController>().isBottomNavBarEnabled.isTrue) {
      final currentRoute = getCurrentRouteName();
      final isHomeOnTop = currentRoute == '/homeScreen';
      final isResultScreenOnTop = currentRoute == '/searchResultScreen';
      final playerCon = Get.find<PlayerController>();

      isHomeSreenOnTop.value = isHomeOnTop;

      if (!playerCon.initFlagForPlayer) {
        Future.delayed(
            isResultScreenOnTop
                ? const Duration(milliseconds: 300)
                : Duration.zero, () {
          playerCon.updateMinHeight();
        });
      }
    }
  }

  Future<void> cachedHomeScreenData({
    bool updateAll = false,
    bool updateQuickPicksNMiddleContent = false,
  }) async {
    if (Get.find<SettingsScreenController>().cacheHomeScreenData.isFalse ||
        quickPicks.value.songList.isEmpty) {
      return;
    }

    final homeScreenData = await SqliteStore.openBox("homeScreenData");

    if (updateQuickPicksNMiddleContent) {
      await homeScreenData.putAll({
        "quickPicksType": quickPicks.value.title,
        "quickPicks": _getContentDataInJson(quickPicks.value.songList,
            isQuickPicks: true),
        "middleContent": _getContentDataInJson(middleContent.toList()),
      });
    } else if (updateAll) {
      await homeScreenData.putAll({
        "quickPicksType": quickPicks.value.title,
        "quickPicks": _getContentDataInJson(quickPicks.value.songList,
            isQuickPicks: true),
        "middleContent": _getContentDataInJson(middleContent.toList()),
        "fixedContent": _getContentDataInJson(fixedContent.toList())
      });
    }

    printINFO("Saved Homescreen data data");
  }

  List<Map<String, dynamic>> _getContentDataInJson(List content,
      {bool isQuickPicks = false}) {
    if (isQuickPicks) {
      return content.toList().map((e) => MediaItemBuilder.toJson(e)).toList();
    } else {
      return content.map((e) {
        if (e.runtimeType == AlbumContent) {
          return (e as AlbumContent).toJson();
        } else if (e.runtimeType == QuickPicks) {
          return (e as QuickPicks).toJson();
        } else if (e.runtimeType == ArtistContent) {
          return (e as ArtistContent).toJson();
        } else {
          return (e as PlaylistContent).toJson();
        }
      }).toList();
    }
  }

  void disposeDetachedScrollControllers({bool disposeAll = false}) {
    final scrollControllersCopy = contentScrollControllers.toList();
    for (final contoller in scrollControllersCopy) {
      if (!contoller.hasClients || disposeAll) {
        contentScrollControllers.remove(contoller);
        contoller.dispose();
      }
    }
  }

  @override
  void dispose() {
    _recommendationsDelay?.cancel();
    _localSectionsRefreshDebounce?.cancel();
    for (final subscription in _localSectionSubscriptions) {
      subscription.cancel();
    }
    disposeDetachedScrollControllers(disposeAll: true);
    super.dispose();
  }
}
