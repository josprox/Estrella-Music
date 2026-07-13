import 'dart:async';
import 'dart:io';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:dio/dio.dart';
import 'package:harmonymusic/services/system/translation_service.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:harmonymusic/models/playling_from.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/download/downloader.dart';
import 'package:harmonymusic/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/services/music/synced_lyrics_service.dart';
import '/ui/screens/Settings/settings_screen_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:harmonymusic/services/music/windows_audio_service.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/ui/utils/theme_controller.dart';
import '/models/media_item_builder.dart';
import 'package:harmonymusic/ui/screens/Home/home_screen_controller.dart';
import 'package:harmonymusic/ui/widgets/sliding_up_panel.dart';
import '/models/durationstate.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/utils/localization/l10n_extensions.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/services/social/colistening_service.dart';
import 'package:harmonymusic/services/system/discord_rpc_service.dart';

enum PlayButtonState { paused, playing, loading }

class CustomLyricUI extends UINetease {
  double get lyricsTextScale {
    try {
      return Get.find<PlayerController>().lyricsTextScale.value;
    } catch (_) {
      return 1.0;
    }
  }

  LyricAlign get lyricAlignConfig {
    try {
      return Get.find<PlayerController>().lyricsAlignment.value;
    } catch (_) {
      return LyricAlign.LEFT;
    }
  }

  CustomLyricUI({
    super.defaultSize,
    super.defaultExtSize,
    super.otherMainSize,
    super.bias,
    super.lineGap,
    super.inlineGap,
    super.lyricAlign,
    super.lyricBaseLine,
    super.highlight,
    super.highlightDirection,
  });

  @override
  TextStyle getPlayingMainTextStyle() => TextStyle(
        color: Colors.white,
        fontSize: defaultSize * lyricsTextScale,
        fontWeight: FontWeight.w900,
      );

  @override
  TextStyle getOtherMainTextStyle() => TextStyle(
        color: Colors.white.withValues(alpha: 0.35),
        fontSize: otherMainSize * lyricsTextScale,
        fontWeight: FontWeight.w600,
      );

  @override
  double getLineSpace() => lineGap * lyricsTextScale;

  @override
  double getPlayingLineBias() => bias;

  @override
  Color getLyricHightlightColor() => Colors.white;

  @override
  LyricAlign get lyricAlign => lyricAlignConfig;
}

class PlayerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _audioHandler = Get.find<AudioHandler>();
  final _catalogRecoveryService = Get.find<CatalogRecoveryService>();
  final _musicServices = Get.find<MusicServices>();
  final currentQueue = <MediaItem>[].obs;

  final playerPaneOpacity = (1.0).obs;
  final panelPosition = 0.0.obs;
  final isPlayerpanelTopVisible = true.obs;
  final isPanelGTHOpened = false.obs;
  final isQueuePanelOpened = false.obs;
  final playerPanelMinHeight = 0.0.obs;
  bool initFlagForPlayer = true;
  final isQueueReorderingInProcess = false.obs;
  PanelController playerPanelController = PanelController();
  PanelController queuePanelController = PanelController();
  AnimationController? gesturePlayerStateAnimationController;
  Animation<double>? gesturePlayerStateAnimation;
  bool isRadioModeOn = false;
  String? radioContinuationParam;
  dynamic radioInitiatorItem;
  Timer? sleepTimer;
  int timerDuration = 0;
  final timerDurationLeft = 0.obs;
  final isSleepTimerActive = false.obs;
  final isSleepEndOfSongActive = false.obs;
  final volume = 100.obs;

  final progressBarStatus = ProgressBarState(
          buffered: Duration.zero, current: Duration.zero, total: Duration.zero)
      .obs;

  final currentSongIndex = (0).obs;
  final isFirstSong = true;
  final isLastSong = true;
  final isQueueLoopModeEnabled = false.obs;
  final isLoopModeEnabled = false.obs;
  final isShuffleModeEnabled = false.obs;
  final currentSong = Rxn<MediaItem>();
  final isCurrentSongFav = false.obs;
  final playinfrom = PlaylingFrom(type: PlaylingFromType.SELECTION).obs;
  final showLyricsflag = false.obs;
  final isLyricsLoading = false.obs;
  final lyricsMode = 0.obs;
  final lyricsTextScale = (1.0).obs;
  final lyricsAlignment = (LyricAlign.LEFT).obs;
  final isTranslationEnabled = false.obs;
  final isTranslationLoading = false.obs;
  final translatedLyrics =
      <String, dynamic>{"synced": "", "plainLyrics": ""}.obs;
  bool isDesktopLyricsDialogOpen = false;
  // 0 for play, 1 for pause, 2 for blank
  final gesturePlayerVisibleState = 2.obs;
  final lyricUi = CustomLyricUI(
    highlight: true,
    defaultSize: 24, // Active line size
    otherMainSize: 18, // Inactive lines size
    defaultExtSize: 14,
    lineGap: 28, // More space between lines
    inlineGap: 10,
    bias: 0.45, // Keep active line centered
  );
  RxMap<String, dynamic> lyrics =
      <String, dynamic>{"synced": "", "plainLyrics": ""}.obs;
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> homeScaffoldkey = GlobalKey<ScaffoldState>();

  final buttonState = PlayButtonState.paused.obs;

  // track whether wakelock is currently enabled to avoid repeated calls
  bool _wakelockActive = false;

  var _newSongFlag = true;
  final isCurrentSongBuffered = false.obs;
  final isPlayerVisible = false.obs;

  late StreamSubscription<bool> keyboardSubscription;
  Timer? _persistenceTimer;

  @override
  onInit() {
    _init();
    super.onInit();
  }

  @override
  void onReady() {
    if (GetPlatform.isWindows) {
      Get.put(WindowsAudioService());
    }
    _restorePrevSession();
    super.onReady();
  }

  void _init() async {
    //_createAppDocDir();
    DiscordRpcService().init();
    _listenForChangesInPlayerState();
    _listenForChangesInPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInDuration();
    _listenForPlaylistChange();
    _listenForKeyboardActivity();
    _setInitLyricsMode();
    final appPrefs = SqliteStore.box("AppPrefs");
    isLoopModeEnabled.value = appPrefs.get("isLoopModeEnabled") ?? false;
    isShuffleModeEnabled.value = appPrefs.get("isShuffleModeEnabled") ?? false;
    isQueueLoopModeEnabled.value =
        appPrefs.get("queueLoopModeEnabled") ?? false;

    if (GetPlatform.isDesktop) {
      setVolume(appPrefs.get("volume") ?? 100);
    }

    if ((appPrefs.get("playerUi") ?? 0) == 1) {
      initGesturePlayerStateAnimationController();
    }

    // only for android auto
    if (GetPlatform.isAndroid) {
      _listenForCustomEvents();
    }
  }

  void initGesturePlayerStateAnimationController() {
    gesturePlayerStateAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    gesturePlayerStateAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: gesturePlayerStateAnimationController!,
            curve: Curves.easeIn));
  }

  void _setInitLyricsMode() {
    lyricsMode.value = SqliteStore.box("AppPrefs").get("lyricsMode") ?? 0;
  }

  void panellistener(double x) {
    panelPosition.value = x;
    if (x >= 0 && x <= 0.2) {
      playerPaneOpacity.value = 1 - (x * 5);
      isPlayerpanelTopVisible.value = true;
    } else if (x > 0.2) {
      isPlayerpanelTopVisible.value = false;
    }

    if (x > 0.6) {
      if (!isPanelGTHOpened.value) {
        isPanelGTHOpened.value = true;
        updateMinHeight();
      }
    } else {
      if (isPanelGTHOpened.value) {
        isPanelGTHOpened.value = false;
        updateMinHeight();
      }
    }
  }

  void _listenForKeyboardActivity() {
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (playerPanelController.isAttached) {
        visible ? playerPanelController.hide() : playerPanelController.show();
      }
    });
  }

  void _listenForChangesInPlayerState() {
    _audioHandler.playbackState.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == AudioProcessingState.loading) {
        buttonState.value = PlayButtonState.loading;
      } else if (processingState == AudioProcessingState.buffering) {
        buttonState.value = PlayButtonState.loading;
      } else if (!isPlaying || processingState == AudioProcessingState.error) {
        buttonState.value = PlayButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        buttonState.value = PlayButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }

      final settings = Get.find<SettingsScreenController>();
      // Keep the screen awake whenever playback is active and the setting is enabled.
      final shouldEnable = settings.keepScreenAwake.isTrue && isPlaying;
      _setWakelock(shouldEnable);

      if (currentSong.value != null) {
        _updateDiscordRPC(currentSong.value!, isPlaying);
      }
    });
  }

  void _setWakelock(bool enable) {
    if (_wakelockActive == enable) return; // no-op if already in desired state

    try {
      if (enable) {
        printINFO("Enabling wakelock");
        WakelockPlus.enable();
        _wakelockActive = true;
      } else {
        printINFO("Disabling wakelock");
        WakelockPlus.disable();
        _wakelockActive = false;
      }
    } catch (e) {
      printERROR(e);
    }
  }

  void _listenForChangesInPosition() {
    AudioService.position.listen((position) {
      final oldState = progressBarStatus.value;
      if (isSleepEndOfSongActive.isTrue) {
        timerDurationLeft.value = oldState.total.inSeconds - position.inSeconds;
        if (timerDurationLeft.value == 1) {
          pause();
          cancelSleepTimer();
        }
      }
      progressBarStatus.update((val) {
        val!.current = position;
        val.buffered = oldState.buffered;
        val.total = oldState.total;
      });
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressBarStatus.value;
      if (progressBarStatus.value.total.inSeconds != 0 &&
          playbackState.bufferedPosition.inSeconds /
                  progressBarStatus.value.total.inSeconds >=
              0.98) {
        if (_newSongFlag) {
          _audioHandler.customAction(
              "checkWithCacheDb", {'mediaItem': currentSong.value!});
          _newSongFlag = false;
        }
      }
      progressBarStatus.update((val) {
        val!.buffered = playbackState.bufferedPosition;
        val.current = oldState.current;
        val.total = oldState.total;
      });
    });
  }

  void _listenForChangesInDuration() {
    _audioHandler.mediaItem.listen((mediaItem) async {
      final oldState = progressBarStatus.value;
      progressBarStatus.update((val) {
        val!.total = mediaItem?.duration ?? Duration.zero;
        val.current = oldState.current;
        val.buffered = oldState.buffered;
      });
      if (mediaItem != null) {
        printINFO(mediaItem.title);
        _newSongFlag = true;
        isCurrentSongBuffered.value = false;
        currentSong.value = mediaItem;
        currentSongIndex.value = currentQueue
            .indexWhere((element) => element.id == currentSong.value!.id);
        await _checkFav();
        await _addToRP(currentSong.value!);
        _updateDiscordRPC(
            mediaItem, buttonState.value == PlayButtonState.playing);
        if (isRadioModeOn && (currentSong.value!.id == currentQueue.last.id)) {
          await _addRadioContinuation(radioInitiatorItem!);
        }
        lyrics.value = {"synced": "", "plainLyrics": ""};
        translatedLyrics.value = {"synced": "", "plainLyrics": ""};
        showLyricsflag.value = false;
        if (isDesktopLyricsDialogOpen) {
          Navigator.pop(Get.context!);
        }

        // Auto-load lyrics and translation in background
        Future.delayed(const Duration(milliseconds: 800), () {
          if (currentSong.value?.id == mediaItem.id) {
            loadLyrics().then((_) {
              if (isTranslationEnabled.value) {
                loadTranslation();
              }
            });
          }
        });

        // Update dynamic theme based on album art
        if (mediaItem.artUri != null) {
          final imageProvider = mediaItem.artUri!.isScheme('file')
              ? FileImage(File(mediaItem.artUri!.toFilePath()))
              : CachedNetworkImageProvider(mediaItem.artUri.toString())
                  as ImageProvider;
          Get.find<ThemeController>().setTheme(imageProvider, mediaItem.id);
        }

        _saveSession();
        _broadcastPlaybackState();
      }
    });
  }

  void _listenForPlaylistChange() {
    _audioHandler.queue.listen((queue) {
      currentQueue.value = queue;
      currentQueue.refresh();
    });
  }

  Future<void> _restorePrevSession() async {
    final restrorePrevSessionEnabled =
        SqliteStore.box("AppPrefs").get("restrorePlaybackSession") ?? false;
    if (restrorePrevSessionEnabled) {
      final prevSessionData = await SqliteStore.openBox("prevSessionData");
      if (prevSessionData.keys.isNotEmpty) {
        final songList = (prevSessionData.get("queue") as List)
            .map((e) => MediaItemBuilder.fromJson(e))
            .toList();
        final int currentIndex = prevSessionData.get("index");
        final int position = prevSessionData.get("position");
        prevSessionData.close();
        await _audioHandler.addQueueItems(songList);
        _playerPanelCheck(restoreSession: true);
        await _audioHandler.customAction("playByIndex", {
          "index": currentIndex,
          "position": position,
          "restoreSession": true
        });
      }
    }
    _startSessionPersistence();
  }

  void _startSessionPersistence() {
    _persistenceTimer?.cancel();
    _persistenceTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (buttonState.value == PlayButtonState.playing) {
        _saveSession();
      }
    });
  }

  Future<void> _saveSession() async {
    if (currentQueue.isEmpty || currentSong.value == null) return;
    try {
      final box = await SqliteStore.openBox("prevSessionData");
      await box.put("queue",
          currentQueue.map((e) => MediaItemBuilder.toJson(e)).toList());
      await box.put("index", currentSongIndex.value);
      await box.put("position", progressBarStatus.value.current.inMilliseconds);
      await box.close();
    } catch (e) {
      printERROR("Failed to save session: $e");
    }
  }

  void _listenForCustomEvents() {
    _audioHandler.customEvent.listen((event) {
      if (event['eventType'] == 'playFromMediaId') {
        _playViaAndroidAuto(event['songId'], event['libraryId']);
      }
    });
  }

  ///pushSongToPlaylist method clear previous song queue, plays the tapped song and push related
  ///songs into Queue
  Future<void> pushSongToQueue(MediaItem? mediaItem,
      {String? playlistid, bool radio = false}) async {
    /// update playing from value
    playinfrom.value = PlaylingFrom(
        type: PlaylingFromType.SELECTION,
        name: radio ? S.current.randomRadio : S.current.randomSelection);

    /// set global radio mode flag
    isRadioModeOn = radio;

    MediaItem? queueSeedSong = mediaItem;

    Future.delayed(
      Duration.zero,
      () async {
        try {
          final content = await _musicServices.getWatchPlaylist(
            videoId: queueSeedSong?.id ?? "",
            radio: radio,
            playlistId: playlistid,
          );
          radioContinuationParam = content['additionalParamsForNext'];
          await _audioHandler
              .updateQueue(List<MediaItem>.from(content['tracks']));
          if (isShuffleModeEnabled.isTrue) {
            await _audioHandler.customAction("shuffleCmd", {"index": 0});
          }

          // added here to broadcast current mediaitem via Audio Service as list is updated
          // if radio is started on current playing song
          if (radio && (currentSong.value?.id == queueSeedSong?.id)) {
            _audioHandler
                .customAction("upadateMediaItemInAudioService", {"index": 0});
          }
        } on NetworkError catch (error) {
          printERROR("Error resolving queue for song: $error");
          final recoveredSong = await _recoverQueueSeedSong(queueSeedSong);
          if (recoveredSong == null) {
            return;
          }
          queueSeedSong = recoveredSong;
          final content = await _musicServices.getWatchPlaylist(
            videoId: recoveredSong.id,
            radio: radio,
            playlistId: playlistid,
          );
          radioContinuationParam = content['additionalParamsForNext'];
          await _audioHandler
              .updateQueue(List<MediaItem>.from(content['tracks']));
          if (isShuffleModeEnabled.isTrue) {
            await _audioHandler.customAction("shuffleCmd", {"index": 0});
          }
          if (radio && (currentSong.value?.id == recoveredSong.id)) {
            _audioHandler
                .customAction("upadateMediaItemInAudioService", {"index": 0});
          }
        } catch (e) {
          printERROR("Error resolving queue for song: $e");
        }
      },
    ).then((value) async {
      if (playlistid != null) {
        _playerPanelCheck();
        await _audioHandler.customAction("playByIndex", {"index": 0});
      } else {
        if (SqliteStore.box("AppPrefs").get("discoverContentType") == "BOLI") {
          Get.find<HomeScreenController>().changeDiscoverContent("BOLI",
              songId: queueSeedSong?.id ?? mediaItem!.id);
        }
      }
    });

    if (playlistid != null ||
        (radio && (currentSong.value?.id == mediaItem?.id))) {
      return;
    }

    //currentSong.value = mediaItem;
    _playerPanelCheck();
    await _audioHandler
        .customAction("setSourceNPlay", {'mediaItem': mediaItem});

    // disable queue loop mode when radio is started
    if (radio &&
        isQueueLoopModeEnabled.isTrue &&
        isShuffleModeEnabled.isFalse) {
      toggleQueueLoopMode();
    }
  }

  Future<void> playPlayListSong(List<MediaItem> mediaItems, int index,
      {PlaylingFrom? playfrom}) async {
    isRadioModeOn = false;
    //open player pane,set current song and push first song into playing list,

    /// update playing from value
    playinfrom.value =
        playfrom ?? PlaylingFrom(type: PlaylingFromType.SELECTION);

    //for changing home content based on last interation
    Future.delayed(const Duration(seconds: 3), () {
      if (SqliteStore.box("AppPrefs").get("discoverContentType") == "BOLI") {
        Get.find<HomeScreenController>()
            .changeDiscoverContent("BOLI", songId: mediaItems[index].id);
      }
    });

    _playerPanelCheck();
    await _audioHandler.updateQueue(mediaItems);
    if (isShuffleModeEnabled.value) {
      await _audioHandler.customAction("shuffleCmd", {"index": index});
    }
    await _audioHandler.customAction("playByIndex", {"index": index});
  }

  Future<void> startRadio(MediaItem? mediaItem, {String? playlistid}) async {
    radioInitiatorItem = mediaItem ?? playlistid;
    await pushSongToQueue(mediaItem, playlistid: playlistid, radio: true);
  }

  Future<MediaItem?> _recoverQueueSeedSong(MediaItem? song) async {
    if (song == null) {
      return null;
    }

    final recoveredSong = await _catalogRecoveryService.findSimilarSong(
      title: song.title,
      artistName: song.artist,
      albumName: song.album,
    );
    if (recoveredSong == null || recoveredSong.id == song.id) {
      return null;
    }

    await _catalogRecoveryService.persistRecoveredSong(
      oldSong: song,
      recoveredSong: recoveredSong,
    );
    return recoveredSong;
  }

  Future<void> _addRadioContinuation(dynamic item) async {
    final isSong = item.runtimeType.toString() == "MediaItem";
    final content = await _musicServices.getWatchPlaylist(
        videoId: isSong ? item.id : "",
        radio: true,
        limit: 24,
        playlistId: isSong ? null : item,
        additionalParamsNext: radioContinuationParam);
    radioContinuationParam = content['additionalParamsForNext'];
    await enqueueSongList(List<MediaItem>.from(content['tracks']));
  }

  ///enqueueSong   append a song to current queue
  ///if current queue is empty, push the song into Queue and play that song
  Future<void> enqueueSong(MediaItem mediaItem) async {
    if (currentQueue.isEmpty) {
      await playPlayListSong([mediaItem], 0);
      return;
    }
    //check if song is available in queue and if not add it to queue
    if (!currentQueue.contains(mediaItem)) {
      _audioHandler.addQueueItem(mediaItem);
    }
  }

  ///enqueueSongList method add song List to current queue
  Future<void> enqueueSongList(List<MediaItem> mediaItems) async {
    if (currentQueue.isEmpty) {
      await playPlayListSong(mediaItems, 0);
      return;
    }
    final listToEnqueue = <MediaItem>[];
    for (MediaItem item in mediaItems) {
      if (!currentQueue.contains(item)) {
        listToEnqueue.add(item);
      }
    }
    _audioHandler.addQueueItems(listToEnqueue);
  }

  void _playViaAndroidAuto(String songId, String libraryId) {
    SqliteStore.openBox(sanitizeBoxName(libraryId)).then((box) {
      List<MediaItem> songList = [];
      final songJson = box.values.toList();
      int songIndex = 0;
      for (int i = 0; i < box.length; i++) {
        final song = MediaItemBuilder.fromJson(songJson[i]);
        if (song.id == songId) {
          songIndex = i;
        }
        songList.add(song);
      }
      playPlayListSong(songList, songIndex);
      if (libraryId != "SongDownloads") {
        box.close();
      }
    });
  }

  void playNext(MediaItem song) {
    if (currentQueue.isEmpty) {
      enqueueSong(song);
      return;
    }
    int index = -1;
    for (int i = 0; i < currentQueue.length; i++) {
      if (song.id == (currentQueue[i]).id) {
        index = i;
        break;
      }
    }
    final currentIndx = currentSongIndex.value;
    if (index == currentIndx) {
      return;
    }
    if (index != -1) {
      if (currentQueue.length == 1 ||
          (currentQueue.length == 2 && index == 1)) {
        return;
      }
      onReorder(index, currentSongIndex.value + 1);
    } else {
      //Will add song just below the current song
      (currentIndx == currentQueue.length - 1)
          ? enqueueSong(song)
          : _audioHandler.customAction("addPlayNextItem", {"mediaItem": song});
    }
  }

  void _playerPanelCheck({bool restoreSession = false}) {
    isPlayerVisible.value = true;
    final isWideScreen = Get.size.width > 800;
    final autoOpenPlayer = SqliteStore.box("AppPrefs").get("autoOpenPlayer") ?? true;
    if ((!isWideScreen && autoOpenPlayer && playerPanelController.isAttached) &&
        !restoreSession) {
      playerPanelController.open();
    }

    if (initFlagForPlayer) {
      updateMinHeight();
      initFlagForPlayer = false;
    }
  }

  void updateMinHeight() {
    final isWideScreen = Get.width > 800;
    if (isWideScreen) {
      playerPanelMinHeight.value = 105.0 + Get.mediaQuery.padding.bottom;
      return;
    }

    final isBottomNavBarEnabled =
        Get.find<SettingsScreenController>().isBottomNavBarEnabled.isTrue;
    bool isHomeOnTop = false;
    if (Get.isRegistered<HomeScreenController>()) {
      isHomeOnTop = Get.find<HomeScreenController>().isHomeSreenOnTop.isTrue;
    }

    final isBottomNavBarVisible =
        isBottomNavBarEnabled && isHomeOnTop && isPanelGTHOpened.isFalse;

    playerPanelMinHeight.value =
        74.0 + (isBottomNavBarVisible ? 0.0 : Get.mediaQuery.padding.bottom);
  }

  void removeFromQueue(MediaItem song) {
    _audioHandler.removeQueueItem(song);
  }

  void clearQueue() {
    _audioHandler.customAction("clearQueue");
  }

  void shuffleQueue() {
    _audioHandler.customAction("shuffleQueue");
  }

  Future<void> toggleShuffleMode() async {
    final shuffleModeEnabled = isShuffleModeEnabled.value;
    shuffleModeEnabled
        ? _audioHandler.setShuffleMode(AudioServiceShuffleMode.none)
        : _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    isShuffleModeEnabled.value = !shuffleModeEnabled;
    await SqliteStore.box("AppPrefs").put("isShuffleModeEnabled", !shuffleModeEnabled);
    // restrict queue loop mode when shuffle mode is enabled
    if (isShuffleModeEnabled.isTrue && isQueueLoopModeEnabled.isFalse) {
      isQueueLoopModeEnabled.value = true;
    } else if (isShuffleModeEnabled.isFalse) {
      isQueueLoopModeEnabled.value =
          SqliteStore.box("AppPrefs").get("queueLoopModeEnabled", defaultValue: false);
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    _audioHandler.customAction(
        "reorderQueue", {"oldIndex": oldIndex, "newIndex": newIndex});
  }

  void onReorderStart(int index) {
    isQueueReorderingInProcess.value = true;
  }

  void onReorderEnd(int index) {
    isQueueReorderingInProcess.value = false;
  }

  void play() {
    _audioHandler.play();
    _broadcastPlaybackState();
  }

  void pause() {
    _audioHandler.pause();
    _broadcastPlaybackState();
  }

  void closePlayer() {
    pause();
    isPlayerVisible.value = false;
    playerPanelMinHeight.value = 0.0;
    DiscordRpcService().clearPresence();
  }

  void playPause() {
    if (initFlagForPlayer) return;
    _audioHandler.playbackState.value.playing ? pause() : play();
  }

  void prev() {
    _audioHandler.skipToPrevious();
  }

  Future<void> next() async {
    await _audioHandler.skipToNext();
  }

  void seek(Duration position) {
    _audioHandler.seek(position);
    if (currentSong.value != null) {
      _updateDiscordRPC(
          currentSong.value!, buttonState.value == PlayButtonState.playing,
          position: position);
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      _broadcastPlaybackState();
    });
  }

  void _broadcastPlaybackState() {
    final colistening = Get.find<ColisteningService>();
    if (colistening.isConnected.isTrue &&
        colistening.currentRoomCode.isNotEmpty) {
      if (currentSong.value != null) {
        colistening.sendPlaybackSync({
          "videoId": currentSong.value!.id,
          "position": progressBarStatus.value.current.inMilliseconds,
          "isPlaying": buttonState.value == PlayButtonState.playing,
          "title": currentSong.value!.title,
          "artist": currentSong.value!.artist,
          "artUri": currentSong.value!.artUri?.toString(),
        });
      }
    }
  }

  void _updateDiscordRPC(MediaItem mediaItem, bool isPlaying,
      {Duration? position}) {
    DiscordRpcService().updatePresence(
      title: mediaItem.title,
      artist: mediaItem.artist ?? "",
      album: mediaItem.album,
      isPlaying: isPlaying,
      currentPosition: position ?? progressBarStatus.value.current,
      totalDuration: progressBarStatus.value.total,
    );
  }

  void seekByIndex(int index) {
    _audioHandler.customAction("playByIndex", {"index": index});
  }

  void toggleSkipSilence(bool enable) {
    _audioHandler.customAction("toggleSkipSilence", {"enable": enable});
  }

  void toggleLoudnessNormalization(bool enable) {
    _audioHandler
        .customAction("toggleLoudnessNormalization", {"enable": enable});
  }

  Future<void> toggleLoopMode() async {
    isLoopModeEnabled.isFalse
        ? _audioHandler.setRepeatMode(AudioServiceRepeatMode.one)
        : _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
    isLoopModeEnabled.value = !isLoopModeEnabled.value;
    await SqliteStore.box("AppPrefs")
        .put("isLoopModeEnabled", isLoopModeEnabled.value);
  }

  Future<void> toggleQueueLoopMode({bool showMessage = true}) async {
    if (isShuffleModeEnabled.isTrue && isQueueLoopModeEnabled.isTrue) {
      if (!showMessage) return;
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
          Get.context!, S.current.queueLoopNotDisMsg1,
          size: SanckBarSize.BIG, duration: const Duration(seconds: 2)));
      return;
    }

    if (isRadioModeOn && isQueueLoopModeEnabled.isFalse) {
      if (!showMessage) return;
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
          Get.context!, S.current.queueLoopNotDisMsg2,
          size: SanckBarSize.BIG, duration: const Duration(seconds: 2)));
      return;
    }

    isQueueLoopModeEnabled.value = !isQueueLoopModeEnabled.value;
    await _audioHandler.customAction(
        "toggleQueueLoopMode", {"enable": isQueueLoopModeEnabled.value});
    await SqliteStore.box("AppPrefs")
        .put("queueLoopModeEnabled", isQueueLoopModeEnabled.value);
  }

  Future<void> setVolume(int value) async {
    _audioHandler.customAction("setVolume", {"value": value});
    volume.value = value;
    await SqliteStore.box("AppPrefs").put("volume", value);
  }

  Future<void> mute() async {
    int? vol;
    if (volume.value != 0) {
      vol = 0;
    } else {
      vol = await SqliteStore.box("AppPrefs").get("volume", defaultValue: 10);
      if (vol == 0) {
        vol = 10;
        await SqliteStore.box("AppPrefs").put("volume", vol);
      }
    }
    _audioHandler.customAction("setVolume", {"value": vol!});
    volume.value = vol;
  }

  Future<void> _checkFav() async {
    if (currentSong.value == null) return;
    isCurrentSongFav.value =
        (await SqliteStore.openBox("LIBFAV")).containsKey(currentSong.value!.id);
  }

  Future<void> refreshFavoriteState() => _checkFav();

  Future<void> toggleFavourite() async {
    final currMediaItem = currentSong.value!;
    final wasFavorite = isCurrentSongFav.value;
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final track = MediaItemBuilder.toJson(currMediaItem);
      await syncService.recordFavoriteChange(
        currMediaItem.id,
        deleted: wasFavorite,
        track: track,
      );
      final box = await SqliteStore.openBox("LIBFAV");
      if (wasFavorite) {
        await box.delete(currMediaItem.id);
      } else {
        await box.put(currMediaItem.id, track);
      }
    });
    try {
      final playlistController = Get.find<PlaylistScreenController>(
          tag: const Key("LIBFAV").hashCode.toString());
      !wasFavorite
          ? playlistController.addNRemoveItemsinList(currMediaItem,
              action: 'add', index: 0)
          : playlistController.addNRemoveItemsinList(currMediaItem,
              action: 'remove');

      // ignore: empty_catches
    } catch (e) {}
    isCurrentSongFav.value = !wasFavorite;
    if (Get.find<SettingsScreenController>()
            .autoDownloadFavoriteSongEnabled
            .isTrue &&
        isCurrentSongFav.isTrue) {
      Get.find<Downloader>().download(currMediaItem);
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var recentItem;

  /// This function is used to add a mediaItem/Song to Recently played playlist
  Future<void> _addToRP(MediaItem mediaItem) async {
    if (recentItem != mediaItem) {
      final box = await SqliteStore.openBox("LIBRP");
      String? removedSongId;
      if (box.keys.length >= 30) {
        removedSongId = box.getAt(0)['videoId'];
        box.deleteAt(0);
      }
      final valuesCopy = box.values.toList();
      for (int i = valuesCopy.length - 1; i >= 0; i--) {
        if (valuesCopy[i]['videoId'] == mediaItem.id) {
          box.deleteAt(i);
        }
      }

      // Update Playtime and LastPlayed
      int currentPlayTime = mediaItem.extras?['totalPlayTime'] ?? 0;
      int songDuration = mediaItem.duration?.inSeconds ?? 0;
      mediaItem.extras?['totalPlayTime'] = currentPlayTime + songDuration;
      mediaItem.extras?['lastPlayed'] = DateTime.now().millisecondsSinceEpoch;

      final songJson = MediaItemBuilder.toJson(mediaItem);
      box.add(songJson);

      // Save to SongsCache if it exists to keep play history available globally
      final songsCacheBox = await SqliteStore.openBox("SongsCache");
      if (songsCacheBox.containsKey(mediaItem.id)) {
        songsCacheBox.put(mediaItem.id, songJson);
      }
      try {
        final playlistController = Get.find<PlaylistScreenController>(
            tag: const Key("LIBRP").hashCode.toString());
        if (removedSongId != null) {
          playlistController.songList
              .removeWhere((element) => element.id == removedSongId);
        }
        // removes current duplicate item from list
        playlistController.songList
            .removeWhere((element) => element.id == mediaItem.id);
        // adds current item to list
        playlistController.addNRemoveItemsinList(mediaItem,
            action: 'add', index: 0);

        // ignore: empty_catches
      } catch (e) {}
      Get.find<SyncService>().triggerPush();
    }
    recentItem = mediaItem;
  }

  Future<void> loadLyrics() async {
    if (lyrics["synced"].isEmpty && lyrics['plainLyrics'].isEmpty) {
      isLyricsLoading.value = true;
      try {
        final Map<String, dynamic>? lyricsR =
            await SyncedLyricsService.getSyncedLyrics(
                currentSong.value!, progressBarStatus.value.total.inSeconds);
        if (lyricsR != null) {
          lyrics.value = lyricsR;
          isLyricsLoading.value = false;
          return;
        }
        final related = await _musicServices.getWatchPlaylist(
            videoId: currentSong.value!.id, onlyRelated: true);
        final relatedLyricsId = related['lyrics'];
        if (relatedLyricsId != null) {
          final lyrics_ = await _musicServices.getLyrics(relatedLyricsId);
          lyrics.value = {"synced": "", "plainLyrics": lyrics_};
        } else {
          lyrics.value = {"synced": "", "plainLyrics": "NA"};
        }
      } catch (e) {
        lyrics.value = {"synced": "", "plainLyrics": "NA"};
      }
      isLyricsLoading.value = false;
    }
  }

  Future<void> showLyrics() async {
    showLyricsflag.value = !showLyricsflag.value;
    if (showLyricsflag.value) {
      await loadLyrics();
      if (isTranslationEnabled.value) {
        await loadTranslation();
      }
    }
  }

  Future<void> loadTranslation() async {
    final song = currentSong.value;
    if (song == null) return;

    if (translatedLyrics["synced"].isNotEmpty ||
        translatedLyrics["plainLyrics"].isNotEmpty) {
      return;
    }

    isTranslationLoading.value = true;
    try {
      final lyricsBox = await SqliteStore.openBox("lyrics");
      final cached = lyricsBox.get(song.id);
      if (cached != null && cached is Map) {
        final cachedTranslatedSynced =
            cached["translatedSynced"]?.toString() ?? "";
        final cachedTranslatedPlain =
            cached["translatedPlain"]?.toString() ?? "";
        if (cachedTranslatedSynced.isNotEmpty ||
            cachedTranslatedPlain.isNotEmpty) {
          translatedLyrics.value = {
            "synced": cachedTranslatedSynced,
            "plainLyrics": cachedTranslatedPlain,
          };
          isTranslationLoading.value = false;
          await lyricsBox.close();
          return;
        }
      }
      await lyricsBox.close();

      if (lyrics["synced"].isEmpty && lyrics["plainLyrics"].isEmpty) {
        await loadLyrics();
      }

      final originalSynced = lyrics["synced"].toString();
      final originalPlain = lyrics["plainLyrics"].toString();

      if (originalSynced.isEmpty && originalPlain.isEmpty) {
        translatedLyrics.value = {"synced": "", "plainLyrics": ""};
        isTranslationLoading.value = false;
        return;
      }

      final neteaseRes = await TranslationService.fetchNetEaseTranslation(
          song.title, song.artist ?? "");
      if (neteaseRes != null) {
        final tSynced = neteaseRes["synced"] ?? "";
        final tPlain = neteaseRes["plain"] ?? "";
        translatedLyrics.value = {
          "synced": tSynced,
          "plainLyrics": tPlain,
        };
        await SyncedLyricsService.saveTranslation(song.id, tSynced, tPlain);
        isTranslationLoading.value = false;
        return;
      }

      String sourceText =
          originalSynced.isNotEmpty ? originalSynced : originalPlain;
      final isSynced = originalSynced.isNotEmpty;

      String translatedResult = "";
      if (isSynced) {
        translatedResult = await TranslationService.translateLrcWithGoogle(
            sourceText,
            targetLang: "es");
      } else {
        final res = await Dio().get(
          "https://translate.googleapis.com/translate_a/single",
          queryParameters: {
            'client': 'gtx',
            'sl': 'auto',
            'tl': 'es',
            'dt': 't',
            'q': sourceText,
          },
        );
        if (res.statusCode == 200 && res.data != null && res.data[0] is List) {
          final List segments = res.data[0];
          final StringBuffer sb = StringBuffer();
          for (var segment in segments) {
            if (segment is List && segment.isNotEmpty) {
              sb.write(segment[0].toString());
            }
          }
          translatedResult = sb.toString();
        }
      }

      final tSynced = isSynced ? translatedResult : "";
      final tPlain = isSynced ? "" : translatedResult;

      translatedLyrics.value = {
        "synced": tSynced,
        "plainLyrics": tPlain,
      };

      await SyncedLyricsService.saveTranslation(song.id, tSynced, tPlain);
    } catch (e) {
      printERROR("Failed to load lyrics translation: $e");
      translatedLyrics.value = {"synced": "", "plainLyrics": ""};
    } finally {
      isTranslationLoading.value = false;
    }
  }

  Future<void> toggleTranslation() async {
    isTranslationEnabled.value = !isTranslationEnabled.value;
    if (isTranslationEnabled.value) {
      await loadTranslation();
    }
  }

  void changeLyricsMode(int? val) {
    SqliteStore.box("AppPrefs").put("lyricsMode", val);
    lyricsMode.value = val!;
  }

  void sleepEndOfSong() {
    isSleepTimerActive.value = true;
    isSleepEndOfSongActive.value = true;
  }

  void startSleepTimer(int minutes) {
    timerDuration = minutes * 60;
    isSleepTimerActive.value = true;
    if ((sleepTimer != null && !sleepTimer!.isActive) || sleepTimer == null) {
      sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick == timerDuration) {
          sleepTimer?.cancel();
          pause();
          isSleepTimerActive.value = false;
          timerDuration = 0;
          timerDurationLeft.value = 0;
        } else {
          timerDurationLeft.value = timerDuration - timer.tick;
        }
      });
    }
  }

  void addFiveMinutes() {
    timerDuration += 300;
  }

  void cancelSleepTimer() {
    if (isSleepEndOfSongActive.isTrue) {
      isSleepEndOfSongActive.value = false;
    }
    sleepTimer?.cancel();
    isSleepTimerActive.value = false;
    timerDuration = 0;
    timerDurationLeft.value = 0;
  }

  Future<void> openEqualizer() async {
    await _audioHandler.customAction("openEqualizer");
  }

  /// Called from audio handler in case audio is not playable
  /// or returned streamInfo null due to network error
  void notifyPlayError(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
        Get.context!, message == "networkError" ? message.t : message,
        size: SanckBarSize.MEDIUM));
  }

  @override
  void dispose() {
    // AudioHandler is registered as a permanent app service. Disposing the
    // native media_kit player from this UI controller can leave native Windows
    // callbacks alive during hot restart and crash the Flutter runner.
    keyboardSubscription.cancel();
    _persistenceTimer?.cancel();
    scrollController.dispose();
    gesturePlayerStateAnimationController?.dispose();
    sleepTimer?.cancel();
    if (GetPlatform.isWindows) {
      Get.delete<WindowsAudioService>();
    }
    DiscordRpcService().close();
    // ensure wakelock disabled when player controller disposed
    try {
      _setWakelock(false);
    } on Exception catch (e) {
      printERROR("Failed to set wakelock or title color: $e");
    }
    super.dispose();
  }
}
