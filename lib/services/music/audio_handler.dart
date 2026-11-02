// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_service/audio_service.dart';
// ignore: depend_on_referenced_packages
import 'package:rxdart/rxdart.dart';

import '/models/album.dart';
import 'package:estrella_music/services/auth/catalog_recovery_service.dart';
import 'package:estrella_music/models/playlist.dart';
import 'package:estrella_music/services/music/equalizer.dart';
import 'package:estrella_music/services/music/playback_source_resolver.dart';
import '/models/hm_streaming_data.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';
import 'package:estrella_music/utils/helpers/queue_reorder.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import '/models/media_item_builder.dart';
import 'package:estrella_music/ui/screens/Settings/settings_screen_controller.dart';
import 'package:estrella_music/ui/screens/Library/library_controller.dart';
// ignore: unused_import, implementation_imports, depend_on_referenced_packages
import "package:media_kit/src/player/platform_player.dart" show MPVLogLevel;
import 'package:estrella_music/generated/l10n.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      // Used when the current item has no album artwork (or Android cannot
      // load it).  Keep this tied to Estrella Music's launcher identity, not
      // the inherited monochrome resource.
      androidNotificationIcon: 'mipmap/launcher_icon',
      androidNotificationChannelId: 'com.mycompany.myapp.audio',
      androidNotificationChannelName: 'Estrella Music Notification',
      androidNotificationOngoing: false,
      androidStopForegroundOnPause: false,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler with GetxServiceMixin {
  late final String _cacheDir;
  late AudioPlayer _player;
  late MediaLibrary _mediaLibrary;
  // ignore: prefer_typing_uninitialized_variables
  dynamic currentIndex;
  int currentShuffleIndex = 0;
  late String? currentSongUrl;
  bool isPlayingUsingLockCachingSource = false;
  bool loopModeEnabled = false;
  bool queueLoopModeEnabled = false;
  bool shuffleModeEnabled = false;
  bool loudnessNormalizationEnabled = false;
  // var networkErrorPause = false;
  bool isSongLoading = true;
  int _playbackRequestId = 0;
  bool _isTriggeringNext = false;
  final Map<String, int> _playbackRecoveryAttempts = {};
  int? _lastCompletedSongIndex;
  DateTime? _lastTrackCompletionTime;
  bool _userInitiatedPause = false;

  bool get _supportsPitchControl => GetPlatform.isAndroid;

  // list of shuffled queue songs ids
  List<String> shuffledQueue = [];

  final _playList =
      ConcatenatingAudioSource(children: [], useLazyPreparation: false);

  MyAudioHandler() {
    if (GetPlatform.isWindows || GetPlatform.isLinux) {
      JustAudioMediaKit.title = 'Estrella Music';
      JustAudioMediaKit.protocolWhitelist = const ['http', 'https', 'file'];
    }
    _mediaLibrary = MediaLibrary();
    _player = AudioPlayer(
        audioLoadConfiguration: const AudioLoadConfiguration(
      androidLoadControl: AndroidLoadControl(
        minBufferDuration: Duration(seconds: 60),
        maxBufferDuration: Duration(seconds: 180),
        bufferForPlaybackDuration: Duration(milliseconds: 100),
        bufferForPlaybackAfterRebufferDuration: Duration(seconds: 3),
      ),
      darwinLoadControl: DarwinLoadControl(
        preferredForwardBufferDuration: Duration(seconds: 60),
      ),
    ));
    _createCacheDir();
    _addEmptyList();
    _notifyAudioHandlerAboutPlaybackEvents();
    _player.playerStateStream.listen((playerState) async {
      _broadcastPlaybackState();
      if (!_userInitiatedPause && !playerState.playing && !isSongLoading && !_isTriggeringNext) {
        final duration = _resolveEffectiveDuration();
        if (duration != null && duration.inMilliseconds > 1500) {
          final pos = _player.position;
          final remainingMs = duration.inMilliseconds - pos.inMilliseconds;
          if (remainingMs <= 4000) {
            printINFO("Playback halted at end of track ($pos of $duration) without user pause; auto-advancing");
            await _handleTrackCompletion();
          }
        }
      }
    });
    _listenToPlaybackForNextSong();
    _listenForSequenceStateChanges();
    final appPrefsBox = SqliteStore.box("AppPrefs");
    _player
        .setSkipSilenceEnabled(appPrefsBox.get("skipSilenceEnabled") ?? false);
    loopModeEnabled = appPrefsBox.get("isLoopModeEnabled") ?? false;
    shuffleModeEnabled = appPrefsBox.get("isShuffleModeEnabled") ?? false;
    queueLoopModeEnabled =
        SqliteStore.box("AppPrefs").get("queueLoopModeEnabled") ?? false;
    loudnessNormalizationEnabled =
        appPrefsBox.get("loudnessNormalizationEnabled") ?? false;
    final double initialSpeed =
        ((appPrefsBox.get("playbackSpeed") ?? 1.0) as num).toDouble();
    final double initialPitch =
        ((appPrefsBox.get("playbackPitch") ?? 1.0) as num).toDouble();
    _player.setSpeed(initialSpeed);
    _setPitchIfSupported(initialPitch, isInitialValue: true);
    _listenForDurationChanges();


    try {
      SqliteStore.box("SongsUrlCache").clear();
    } catch (_) {}
  }

  Future<void> _createCacheDir() async {
    _cacheDir = (await getTemporaryDirectory()).path;
    if (!Directory("$_cacheDir/cachedSongs/").existsSync()) {
      Directory("$_cacheDir/cachedSongs/").createSync(recursive: true);
    }
  }

  void _addEmptyList() {
    try {
      _player.setAudioSource(_playList);
    } catch (r) {
      printERROR(r.toString());
    }
  }



  void _broadcastPlaybackState([dynamic _]) {
    final playing = _player.playing;
    final justAudioState = _player.processingState;
    final isExplicitLoading = isSongLoading || _isTriggeringNext;

    final AudioProcessingState calculatedProcessingState;
    if (isExplicitLoading) {
      calculatedProcessingState = AudioProcessingState.loading;
    } else {
      switch (justAudioState) {
        case ProcessingState.idle:
          calculatedProcessingState = AudioProcessingState.idle;
          break;
        case ProcessingState.loading:
          calculatedProcessingState = AudioProcessingState.loading;
          break;
        case ProcessingState.buffering:
          calculatedProcessingState = AudioProcessingState.buffering;
          break;
        case ProcessingState.ready:
          calculatedProcessingState = AudioProcessingState.ready;
          break;
        case ProcessingState.completed:
          calculatedProcessingState = AudioProcessingState.completed;
          break;
      }
    }

    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: calculatedProcessingState,
      repeatMode: loopModeEnabled
          ? AudioServiceRepeatMode.one
          : AudioServiceRepeatMode.none,
      shuffleMode: (shuffleModeEnabled)
          ? AudioServiceShuffleMode.all
          : AudioServiceShuffleMode.none,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: currentIndex,
    ));
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
      _broadcastPlaybackState(event);
    }, onError: (Object e, StackTrace st) async {
      printERROR('Audio player playback stream error: $e');
      if (isSongLoading) {
        return;
      }
      final requestId = _playbackRequestId;
      Duration curPos = _player.position;
      final savedIndex = currentIndex;
      await _player.stop();

      if (requestId != _playbackRequestId || isSongLoading) {
        return;
      }

      // Check if we are still on the same song and attempt to recover
      if (savedIndex == currentIndex &&
          savedIndex is int &&
          savedIndex >= 0 &&
          savedIndex < queue.value.length) {
        final failedSong = queue.value[savedIndex];
        try {
          final cacheBox = SqliteStore.box("SongsUrlCache");
          if (cacheBox.containsKey(failedSong.id)) {
            await cacheBox.delete(failedSong.id);
          }
        } catch (_) {}
        final attempts = _playbackRecoveryAttempts[failedSong.id] ?? 0;
        if (attempts >= 2) {
          isSongLoading = false;
          Get.find<PlayerController>()
              .notifyPlayError(S.current.operationFailed);
          playbackState.add(playbackState.value.copyWith(
            processingState: AudioProcessingState.error,
            errorMessage: e.toString(),
          ));
          return;
        }
        _playbackRecoveryAttempts[failedSong.id] = attempts + 1;
        printINFO(
            "Attempting to recover playback for song index $currentIndex at position $curPos");
        try {
          await customAction("playByIndex", {
            'index': currentIndex,
            'newUrl': true,
            'forceCatalogRecovery': attempts > 0,
          });
          if (_playbackRequestId != requestId + 1) {
            return;
          }
          await _player.seek(curPos);
          playbackState.add(playbackState.value.copyWith(
            updatePosition: curPos,
          ));
          unawaited(_startPlayback());
        } catch (recoveryErr) {
          printERROR("Auto recovery failed: $recoveryErr");
        }
      }
    });
  }

  Timer? _nearEndWatchdogTimer;
  Duration? _lastNearEndPosition;

  void _cancelNearEndTimer() {
    _nearEndWatchdogTimer?.cancel();
    _nearEndWatchdogTimer = null;
    _lastNearEndPosition = null;
  }

  Duration? _resolveEffectiveDuration() {
    final playerDur = _player.duration;
    final mediaDur = mediaItem.value?.duration;
    if (playerDur != null && playerDur.inMilliseconds > 1500) {
      if (mediaDur != null && mediaDur.inMilliseconds > 1500) {
        return playerDur < mediaDur ? playerDur : mediaDur;
      }
      return playerDur;
    }
    return mediaDur;
  }

  void _startNearEndWatchdog(Duration currentPos) {
    if (_isTriggeringNext || isSongLoading) {
      _cancelNearEndTimer();
      return;
    }
    _lastNearEndPosition = currentPos;
    _nearEndWatchdogTimer?.cancel();
    _nearEndWatchdogTimer = Timer(const Duration(milliseconds: 1000), () async {
      if (_isTriggeringNext || isSongLoading) return;
      if (_userInitiatedPause) return;

      final duration = _resolveEffectiveDuration();
      if (duration == null || duration.inMilliseconds <= 1500) return;

      final currentPosition = _player.position;
      final remainingMs = duration.inMilliseconds - currentPosition.inMilliseconds;

      if (remainingMs <= 4000) {
        final advanced = currentPosition - (_lastNearEndPosition ?? Duration.zero);
        if (advanced.inMilliseconds.abs() < 100) {
          printINFO("Near-end stall detected at $currentPosition of $duration; triggering completion");
          await _handleTrackCompletion();
        }
      }
    });
  }

  Future<void> _handleTrackCompletion() async {
    if (isSongLoading || _isTriggeringNext) {
      return;
    }
    final now = DateTime.now();
    if (_lastTrackCompletionTime != null &&
        now.difference(_lastTrackCompletionTime!) < const Duration(milliseconds: 1200) &&
        _lastCompletedSongIndex == currentIndex) {
      return;
    }
    _lastTrackCompletionTime = now;
    _lastCompletedSongIndex = currentIndex is int ? currentIndex as int : null;
    _isTriggeringNext = true;
    _userInitiatedPause = false;
    _cancelNearEndTimer();
    _broadcastPlaybackState();
    try {
      await _triggerNext();
    } catch (e) {
      printERROR("Error during track completion next song: $e");
    } finally {
      _isTriggeringNext = false;
      _broadcastPlaybackState();
    }
  }

  /// Universal cross-platform lead time for track transition (Android, Windows, Linux, macOS, iOS, Web).
  /// Absorbs remote container padding, sample rate metadata rounding and audio sink latency uniformly.
  static const int universalTrackTransitionOffsetMs = 1500;

  int _calculateUniversalOffsetMs(Duration duration) {
    if (duration.inMilliseconds < 4000) {
      return (duration.inMilliseconds * 0.2).round();
    }
    return universalTrackTransitionOffsetMs;
  }

  void _listenToPlaybackForNextSong() {
    _player.positionStream.listen((value) async {
      if (isSongLoading || _isTriggeringNext) {
        _cancelNearEndTimer();
        return;
      }
      if (value >= const Duration(seconds: 5) &&
          currentIndex is int &&
          currentIndex >= 0 &&
          currentIndex < queue.value.length) {
        _playbackRecoveryAttempts.remove(queue.value[currentIndex].id);
      }
      final duration = _resolveEffectiveDuration();
      if (duration != null && duration.inMilliseconds > 1500) {
        final effectiveOffset = _calculateUniversalOffsetMs(duration);
        final remainingMs = duration.inMilliseconds - value.inMilliseconds;
        if (remainingMs <= effectiveOffset) {
          _cancelNearEndTimer();
          await _handleTrackCompletion();
          return;
        }

        // Arm universal watchdog if within 4 seconds of end to catch premature EOF stalls on any platform
        if (remainingMs <= 4000) {
          _startNearEndWatchdog(value);
        } else {
          _cancelNearEndTimer();
        }
      }
    });
    _player.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed &&
          !isSongLoading &&
          !_isTriggeringNext) {
        _cancelNearEndTimer();
        await _handleTrackCompletion();
      }
    });
  }

  /// just_audio's play() only completes when playback pauses or ends, so it
  /// must never be awaited by flows that hold transition flags.
  Future<void> _startPlayback() async {
    try {
      await _player.play();
    } catch (e) {
      printERROR('Player play() failed: ');
    }
  }

  Future<void> _triggerNext() async {
    if (loopModeEnabled) {
      await _player.seek(Duration.zero);
      if (!_player.playing) {
        unawaited(_startPlayback());
      }
      return;
    }
    await skipToNext();
  }

  void _listenForSequenceStateChanges() {
    _player.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
    });
  }

  void _listenForDurationChanges() {
    _player.durationStream.listen((duration) async {
      if (isSongLoading) return;
      final currQueue = queue.value;
      if (currentIndex == null ||
          currentIndex < 0 ||
          currentIndex >= currQueue.length ||
          currQueue.isEmpty ||
          duration == null) {
        return;
      }
      final currentSong = currQueue[currentIndex];
      if (currentSong.duration == null || currentIndex == 0) {
        final newMediaItem = currentSong.copyWith(duration: duration);
        mediaItem.add(newMediaItem);
      }
    });
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // notify system
    final newQueue = List<MediaItem>.from(queue.value)..addAll(mediaItems);
    queue.add(newQueue);

    if (shuffleModeEnabled) {
      final mediaItemsIds = mediaItems.toList().map((item) => item.id).toList();
      final notPlayedshuffledQueue = shuffledQueue.isNotEmpty
          ? shuffledQueue.toList().sublist(currentShuffleIndex + 1)
          : shuffledQueue;
      notPlayedshuffledQueue.addAll(mediaItemsIds);
      notPlayedshuffledQueue.shuffle();
      shuffledQueue.replaceRange(
          currentShuffleIndex, shuffledQueue.length, notPlayedshuffledQueue);
    }
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    final newQueue = List<MediaItem>.from(queue);
    this.queue.add(newQueue);
    if (shuffleModeEnabled) {
      final newIds = newQueue.map((item) => item.id).toList()..shuffle();
      shuffledQueue = newIds;
      currentShuffleIndex = 0;
    } else {
      shuffledQueue = [];
      currentShuffleIndex = 0;
    }
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    if (shuffleModeEnabled) {
      shuffledQueue.add(mediaItem.id);
    }

    // notify system
    final newQueue = List<MediaItem>.from(queue.value)..add(mediaItem);
    queue.add(newQueue);
  }

  AudioSource _createAudioSource(MediaItem mediaItem) {
    final url = mediaItem.extras!['url'] as String;
    final rawHeaders = mediaItem.extras?['playbackHeaders'];
    Map<String, String>? headers;
    if (rawHeaders is Map && rawHeaders.isNotEmpty) {
      headers = Map<String, String>.from(
        rawHeaders.map((k, v) => MapEntry(k.toString(), v.toString())),
      );
    }
    if (url.contains('/cache') ||
        (Get.find<SettingsScreenController>().cacheSongs.isTrue &&
            url.contains("http"))) {
      printINFO("Playing Using LockCaching");
      isPlayingUsingLockCachingSource = true;
      // ignore: experimental_member_use
      return LockCachingAudioSource(
        Uri.parse(url),
        headers: headers,
        cacheFile: File("$_cacheDir/cachedSongs/${mediaItem.id}.mp3"),
        tag: mediaItem,
      );
    }

    printINFO("Playing Using AudioSource.uri (headers: $headers)");
    isPlayingUsingLockCachingSource = false;
    final uri = url.startsWith('http://') ||
            url.startsWith('https://') ||
            url.startsWith('file:')
        ? Uri.parse(url)
        : Uri.file(url);
    return AudioSource.uri(
      uri,
      headers: headers,
      tag: mediaItem,
    );
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> removeQueueItem(MediaItem mediaItem_) async {
    if (shuffleModeEnabled) {
      final id = mediaItem_.id;
      final itemIndex = shuffledQueue.indexOf(id);
      if (currentShuffleIndex > itemIndex) {
        currentShuffleIndex -= 1;
      }
      shuffledQueue.remove(id);
    }

    final currentQueue = queue.value;
    final currentSong = mediaItem.value;
    final itemIndex = currentQueue.indexOf(mediaItem_);
    if (currentIndex > itemIndex) {
      currentIndex -= 1;
    }
    currentQueue.remove(mediaItem_);
    queue.add(currentQueue);
    mediaItem.add(currentSong);
  }

  @override
  Future<void> play() async {
    _userInitiatedPause = false;
    if (currentSongUrl == null ||
        (GetPlatform.isDesktop &&
            (_player.duration == null ||
                _player.duration?.inMilliseconds == 0))) {
      await customAction("playByIndex", {'index': currentIndex});
      return;
    }
    if (_player.processingState == ProcessingState.idle) {
      final curPos = _player.position;
      await customAction("playByIndex", {'index': currentIndex});
      if (curPos > Duration.zero) {
        await _player.seek(curPos);
        playbackState.add(playbackState.value.copyWith(
          updatePosition: curPos,
        ));
      }
      return;
    }
    await _player.play();
  }

  @override
  Future<void> pause() {
    _userInitiatedPause = true;
    _cancelNearEndTimer();
    return _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    _cancelNearEndTimer();
    await _player.seek(position);
    playbackState.add(playbackState.value.copyWith(
      updatePosition: position,
    ));
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    await customAction("playByIndex", {'index': index});
  }

  int _getNextSongIndex() {
    if (shuffleModeEnabled) {
      if (currentShuffleIndex + 1 >= shuffledQueue.length) {
        shuffledQueue.shuffle();
        currentShuffleIndex = 0;
      } else {
        currentShuffleIndex += 1;
      }
      return queue.value
          .indexWhere((item) => item.id == shuffledQueue[currentShuffleIndex]);
    }

    if (queue.value.length > currentIndex + 1) {
      return currentIndex + 1;
    } else if (queueLoopModeEnabled) {
      return 0;
    } else {
      return currentIndex;
    }
  }

  int _getPrevSongIndex() {
    if (shuffleModeEnabled) {
      if (currentShuffleIndex - 1 < 0) {
        shuffledQueue.shuffle();
        currentShuffleIndex = shuffledQueue.length - 1;
      } else {
        currentShuffleIndex -= 1;
      }
      return queue.value
          .indexWhere((item) => item.id == shuffledQueue[currentShuffleIndex]);
    }

    if (currentIndex - 1 >= 0) {
      return currentIndex - 1;
    } else {
      return currentIndex;
    }
  }

  @override
  Future<void> skipToNext() async {
    final index = _getNextSongIndex();
    if (index != currentIndex) {
      await customAction("playByIndex", {'index': index});
    } else {
      await _player.pause();
      await _player.seek(Duration.zero);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_player.position.inMilliseconds > 5000) {
      await _player.seek(Duration.zero);
      return;
    }
    final index = _getPrevSongIndex();
    if (index != currentIndex) {
      await customAction("playByIndex", {'index': index});
    } else {
      await _player.seek(Duration.zero);
    }
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    loopModeEnabled = repeatMode != AudioServiceRepeatMode.none;
    try {
      await _player.setLoopMode(LoopMode.off);
    } catch (_) {}
    playbackState.add(playbackState.value.copyWith(
      repeatMode: loopModeEnabled
          ? AudioServiceRepeatMode.one
          : AudioServiceRepeatMode.none,
    ));
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      shuffleModeEnabled = false;
      shuffledQueue.clear();
    } else {
      _shuffleCmd(currentIndex);
      shuffleModeEnabled = true;
    }
  }

  Future<void> _preparePlayerForNewTrack(int queueIndex) async {
    _cancelNearEndTimer();
    _userInitiatedPause = false;
    playbackState.add(playbackState.value.copyWith(
      processingState: AudioProcessingState.loading,
      playing: false,
      updatePosition: Duration.zero,
      bufferedPosition: Duration.zero,
      queueIndex: queueIndex,
    ));
    try {
      if (_player.playing) {
        await _player.pause();
      }
    } catch (_) {}
    try {
      if (_player.position != Duration.zero) {
        await _player.seek(Duration.zero);
      }
    } catch (_) {}
    try {
      if (_playList.children.isNotEmpty) {
        await _playList.clear();
      }
    } catch (_) {}
  }

  @override
  Future<void> customAction(String name, [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'dispose':
        await _player.dispose();
        super.stop();
        break;

      case 'setQueueAndPlay':
        final rawQueue = extras!['queue'];
        final List<MediaItem> newItems = rawQueue is List
            ? rawQueue.whereType<MediaItem>().toList()
            : <MediaItem>[];
        final int targetIndex = extras['index'] as int;
        queue.add(newItems);
        if (shuffleModeEnabled) {
          _shuffleCmd(targetIndex);
        } else {
          shuffledQueue = [];
          currentShuffleIndex = 0;
        }
        await customAction('playByIndex', {'index': targetIndex});
        break;

      case 'playByIndex':
        final int songIndex = extras!['index'] as int;
        if (songIndex < 0 || songIndex >= queue.value.length) {
          return;
        }
        final requestId = ++_playbackRequestId;
        currentIndex = songIndex;
        currentSongUrl = null;
        isSongLoading = true;
        final isNewUrlReq = extras['newUrl'] ?? false;
        final forceCatalogRecovery = extras['forceCatalogRecovery'] ?? false;
        final bool restoreSession = extras['restoreSession'] ?? false;
        var currentSong = queue.value[currentIndex];
        final String originalSongId = currentSong.id;
        if (shuffleModeEnabled) {
          final foundShuffleIdx = shuffledQueue.indexOf(currentSong.id);
          if (foundShuffleIdx != -1) {
            currentShuffleIndex = foundShuffleIdx;
          }
        }
        mediaItem.add(currentSong);
        final futurePlayback = _resolveSongPlayback(
          currentSong,
          generateNewUrl: isNewUrlReq,
          forceCatalogRecovery: forceCatalogRecovery,
        );
        await _preparePlayerForNewTrack(currentIndex);

        final resolvedPlayback = await futurePlayback;
        if (requestId != _playbackRequestId || songIndex != currentIndex) {
          return;
        }
        currentSong = resolvedPlayback.song;
        final streamInfo = resolvedPlayback.streamInfo;
        if (!streamInfo.playable) {
          currentSongUrl = null;
          isSongLoading = false;
          Get.find<PlayerController>().notifyPlayError(streamInfo.statusMSG);
          playbackState.add(playbackState.value.copyWith(
              processingState: AudioProcessingState.error,
              errorCode: 404,
              errorMessage: streamInfo.statusMSG));
          // Auto-skip to the next song so the user isn't stuck on an
          // unavailable track.
          final nextIndex = _getNextSongIndex();
          if (nextIndex != songIndex && queue.value.length > 1) {
            printINFO(
              'Auto-skipping unavailable song ${currentSong.id} to next',
            );
            await Future.delayed(const Duration(milliseconds: 500));
            if (requestId != _playbackRequestId) {
              return;
            }
            await customAction('playByIndex', {'index': nextIndex});
          }
          return;
        }
        currentSongUrl = currentSong.extras!['url'] = streamInfo.audio!.url;
        currentSong.extras!['playbackHeaders'] = streamInfo.audio!.headers;
        if (currentIndex >= 0 && currentIndex < queue.value.length) {
          final updatedQueue = List<MediaItem>.from(queue.value);
          if (updatedQueue[currentIndex].id == originalSongId ||
              updatedQueue[currentIndex].id == currentSong.id) {
            updatedQueue[currentIndex] = currentSong;
            queue.add(updatedQueue);
          }
        }
        mediaItem.add(currentSong);
        playbackState
            .add(playbackState.value.copyWith(queueIndex: currentIndex));
        if (_playList.children.isNotEmpty) {
          await _playList.clear();
        }
        try {
          await _playList.add(_createAudioSource(currentSong));
        } catch (_) {
          await _player.setAudioSource(_playList);
          await _playList.add(_createAudioSource(currentSong));
        }
        if (requestId != _playbackRequestId) {
          return;
        }

        isSongLoading = false;
        _broadcastPlaybackState();
        if (loudnessNormalizationEnabled && GetPlatform.isAndroid) {
          _normalizeVolume(streamInfo.audio!.loudnessDb);
        }

        if (restoreSession) {
          final position = extras['position'];
          await _player.load();
          await _player.seek(
            Duration(
              milliseconds: position,
            ),
          );
          if (GetPlatform.isDesktop) {
            await _player.pause();
          } else {
            await _player.seek(
              Duration(
                milliseconds: position,
              ),
            );
          }
          _broadcastPlaybackState();
        } else {
          try {
            await _player.seek(Duration.zero);
          } catch (_) {}
          unawaited(_startPlayback());
          _broadcastPlaybackState();
        }
        break;

      case 'checkWithCacheDb':
        if (isPlayingUsingLockCachingSource) {
          final song = extras!['mediaItem'] as MediaItem;
          final songsCacheBox = SqliteStore.box("SongsCache");
          if (!songsCacheBox.containsKey(song.id) &&
              await File("$_cacheDir/cachedSongs/${song.id}.mp3").exists()) {
            song.extras!['url'] = currentSongUrl;
            song.extras!['date'] = DateTime.now().millisecondsSinceEpoch;
            final dbStreamData = SqliteStore.box("SongsUrlCache").get(song.id);
            final jsonData = MediaItemBuilder.toJson(song);
            jsonData['duration'] = _player.duration!.inSeconds;
            // playbility status and info
            jsonData['streamInfo'] = dbStreamData != null
                ? [
                    true,
                    dbStreamData[
                        SqliteStore.box('AppPrefs').get('streamingQuality') == 0
                            ? 'lowQualityAudio'
                            : "highQualityAudio"]
                  ]
                : null;
            songsCacheBox.put(song.id, jsonData);
            LibrarySongsController librarySongsController =
                Get.find<LibrarySongsController>();
            if (!librarySongsController.isClosed) {
              librarySongsController.librarySongsList.value =
                  librarySongsController.librarySongsList.toList() + [song];
            }
          }
        }
        break;

      case 'setSourceNPlay':
        var currMed = (extras!['mediaItem'] as MediaItem);
        final String originalSeedId = currMed.id;
        final requestId = ++_playbackRequestId;
        isSongLoading = true;
        currentIndex = 0;
        currentSongUrl = null;
        mediaItem.add(currMed);
        queue.add(<MediaItem>[currMed]);
        final futurePlayback = _resolveSongPlayback(currMed);
        await _preparePlayerForNewTrack(0);
        final resolvedPlayback = await futurePlayback;
        if (requestId != _playbackRequestId) {
          return;
        }
        currMed = resolvedPlayback.song;
        final streamInfo = resolvedPlayback.streamInfo;
        if (!streamInfo.playable) {
          currentSongUrl = null;
          isSongLoading = false;
          Get.find<PlayerController>().notifyPlayError(streamInfo.statusMSG);
          playbackState.add(playbackState.value
              .copyWith(processingState: AudioProcessingState.error));
          return;
        }
        currentSongUrl = currMed.extras!['url'] = streamInfo.audio!.url;
        currMed.extras!['playbackHeaders'] = streamInfo.audio!.headers;
        mediaItem.add(currMed);
        final updatedQueue = List<MediaItem>.from(queue.value);
        if (updatedQueue.isEmpty) {
          updatedQueue.add(currMed);
          currentIndex = 0;
        } else {
          final existingIndex = updatedQueue.indexWhere(
            (item) => item.id == currMed.id || item.id == originalSeedId,
          );
          if (existingIndex >= 0) {
            updatedQueue[existingIndex] = currMed;
            currentIndex = existingIndex;
          } else {
            updatedQueue.insert(0, currMed);
            currentIndex = 0;
          }
        }
        queue.add(updatedQueue);
        playbackState
            .add(playbackState.value.copyWith(queueIndex: currentIndex));

        if (_playList.children.isNotEmpty) {
          await _playList.clear();
        }
        try {
          await _playList.add(_createAudioSource(currMed));
        } catch (_) {
          await _player.setAudioSource(_playList);
          await _playList.add(_createAudioSource(currMed));
        }
        if (requestId != _playbackRequestId) {
          return;
        }
        isSongLoading = false;
        _broadcastPlaybackState();

        // Normalize audio
        if (loudnessNormalizationEnabled && GetPlatform.isAndroid) {
          _normalizeVolume(streamInfo.audio!.loudnessDb);
        }

        try {
          await _player.seek(Duration.zero);
        } catch (_) {}
        unawaited(_startPlayback());
        _broadcastPlaybackState();
        break;

      case 'toggleSkipSilence':
        final enable = (extras!['enable'] as bool);
        await _player.setSkipSilenceEnabled(enable);
        break;

      case 'setSpeed':
        final double speed = (extras!['speed'] as num).toDouble();
        await _player.setSpeed(speed);
        break;

      case 'setPitch':
        final double pitch = (extras!['pitch'] as num).toDouble();
        await _setPitchIfSupported(pitch);
        break;

      case 'toggleLoudnessNormalization':
        loudnessNormalizationEnabled = (extras!['enable'] as bool);
        if (!loudnessNormalizationEnabled) {
          _player.setVolume(1.0);
          return;
        }

        if (loudnessNormalizationEnabled) {
          try {
            final currentSongId = (queue.value[currentIndex]).id;
            if (SqliteStore.box("SongsUrlCache").containsKey(currentSongId)) {
              final songJson =
                  SqliteStore.box("SongsUrlCache").get(currentSongId);
              _normalizeVolume((songJson)["highQualityAudio"]["loudnessDb"]);
              return;
            }

            if (SqliteStore.box("SongDownloads").containsKey(currentSongId)) {
              final streamInfo = (SqliteStore.box("SongDownloads")
                  .get(currentSongId))["streamInfo"];

              _normalizeVolume(
                  streamInfo == null ? 0 : streamInfo[1]["loudnessDb"]);
            }
          } catch (e) {
            printERROR(e);
          }
        }
        break;

      case 'shuffleQueue':
        final currentQueue = queue.value;
        final currentItem = currentQueue[currentIndex];
        currentQueue.remove(currentItem);
        currentQueue.shuffle();
        currentQueue.insert(0, currentItem);
        queue.add(currentQueue);
        mediaItem.add(currentItem);
        currentIndex = 0;
        break;

      case 'reorderQueue':
        final result = reorderQueue<MediaItem>(
          items: queue.value,
          oldIndex: extras!['oldIndex'] as int,
          newIndex: extras['newIndex'] as int,
          currentIndex: currentIndex,
        );
        currentIndex = result.currentIndex;
        queue.add(result.items);
        mediaItem.add(result.items[currentIndex]);
        break;

      case 'addPlayNextItem':
        final song = extras!['mediaItem'] as MediaItem;
        final currentQueue = queue.value;
        currentQueue.insert(currentIndex + 1, song);
        queue.add(currentQueue);
        if (shuffleModeEnabled) {
          shuffledQueue.insert(currentShuffleIndex + 1, song.id);
        }
        break;

      case 'openEqualizer':
        await EqualizerService.openEqualizer(_player.androidAudioSessionId ?? 0);
        break;

      case 'saveSession':
        await saveSessionData();
        break;

      case 'setVolume':
        _player.setVolume(extras!['value'] / 100);
        break;

      case 'shuffleCmd':
        final songIndex = extras!['index'];
        _shuffleCmd(songIndex);
        break;

      case 'upadateMediaItemInAudioService':
        //added to update media item from player controller
        final songIndex = extras!['index'];
        currentIndex = songIndex;
        mediaItem.add(queue.value[currentIndex]);
        break;

      case 'toggleQueueLoopMode':
        queueLoopModeEnabled = extras!['enable'];
        break;

      case 'clearQueue':
        customAction("reorderQueue", {'oldIndex': currentIndex, 'newIndex': 0});
        final newQueue = queue.value;
        newQueue.removeRange(1, newQueue.length);
        queue.add(newQueue);
        if (shuffleModeEnabled) {
          shuffledQueue.clear();
          shuffledQueue.add(newQueue[0].id);
          currentShuffleIndex = 0;
        }
        break;
      default:
        break;
    }
  }

  Future<void> _setPitchIfSupported(
    double pitch, {
    bool isInitialValue = false,
  }) async {
    if (!_supportsPitchControl) {
      if (!isInitialValue) {
        printERROR("Pitch control is not supported on desktop media_kit.");
      }
      return;
    }

    try {
      await _player.setPitch(pitch);
    } catch (e) {
      printERROR("Failed to set pitch: $e");
    }
  }

  void _shuffleCmd(int index) {
    final queueIds = queue.value.toList().map((item) => item.id).toList();
    final currentSongId = (index >= 0 && index < queueIds.length) ? queueIds.removeAt(index) : null;
    queueIds.shuffle();
    if (currentSongId != null) queueIds.insert(0, currentSongId);
    shuffledQueue = queueIds;
    currentShuffleIndex = 0;
  }

  void _normalizeVolume(double currentLoudnessDb) {
    double loudnessDifference = -5 - currentLoudnessDb;

    // Converted loudness difference to a volume multiplier
    // We use a factor to convert dB difference to a linear scale
    // 10^(difference / 20) converts dB difference to a linear volume factor
    final volumeAdjustment = pow(10.0, loudnessDifference / 20.0);
    printINFO(
        "loudness:$currentLoudnessDb Normalized volume: $volumeAdjustment");
    _player.setVolume(volumeAdjustment.toDouble().clamp(0, 1.0));
  }

  Future<void> saveSessionData() async {
    if (Get.find<SettingsScreenController>().restorePlaybackSession.isFalse) {
      return;
    }
    final currQueue = queue.value;
    if (currQueue.isNotEmpty) {
      final queueData =
          currQueue.map((e) => MediaItemBuilder.toJson(e)).toList();
      final currIndex = currentIndex ?? 0;
      final position = _player.position.inMilliseconds;
      final prevSessionData = await SqliteStore.openBox("prevSessionData");
      await prevSessionData.clear();
      await prevSessionData.putAll(
          {"queue": queueData, "position": position, "index": currIndex});
      await prevSessionData.close();
      printINFO("Saved session data");
    }
  }

  /// Android Auto
  @override
  Future<List<MediaItem>> getChildren(String parentMediaId,
      [Map<String, dynamic>? options]) async {
    return _mediaLibrary.getByRootId(parentMediaId);
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    return Stream.fromFuture(
            _mediaLibrary.getByRootId(parentMediaId).then((items) => items))
        .map((_) => <String, dynamic>{})
        .shareValue();
  }

  // only for Android Auto
  @override
  Future<void> playFromMediaId(String mediaId,
      [Map<String, dynamic>? extras]) async {
    customEvent.add({
      'eventType': 'playFromMediaId',
      'songId': mediaId,
      'libraryId': extras!['libraryId'],
    });
  }

  @override
  Future<void> onTaskRemoved() async {
    final stopForegroundService =
        Get.find<SettingsScreenController>().stopPlyabackOnSwipeAway.value;
    if (stopForegroundService) {
      await Get.find<HomeScreenController>().cachedHomeScreenData();
      await saveSessionData();
      await stop();
    }
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

// Work around used [useNewInstanceOfExplode = false] to Fix Connection closed before full header was received issue
  Future<HMStreamingData> checkNGetUrl(
    String songId, {
    MediaItem? providerTrack,
    bool generateNewUrl = false,
    bool offlineReplacementUrl = false,
  }) async {
    return PlaybackSourceResolver(cacheDirPath: _cacheDir).resolveStreamData(
      songId,
      providerTrack: providerTrack,
      generateNewUrl: generateNewUrl,
      offlineReplacementUrl: offlineReplacementUrl,
    );
  }

  Future<_ResolvedSongPlayback> _resolveSongPlayback(
    MediaItem song, {
    bool generateNewUrl = false,
    bool forceCatalogRecovery = false,
  }) async {
    try {
      HMStreamingData? streamInfo;
      if (!forceCatalogRecovery) {
        streamInfo = await checkNGetUrl(
          song.id,
          providerTrack: song,
          generateNewUrl: generateNewUrl,
        );
        if (streamInfo.playable) {
          return _ResolvedSongPlayback(song: song, streamInfo: streamInfo);
        }
        if (!generateNewUrl) {
          printINFO(
            'Song ${song.id} failed with cached/initial URL; retrying with fresh URL generation',
          );
          final freshStreamInfo = await checkNGetUrl(
            song.id,
            providerTrack: song,
            generateNewUrl: true,
          );
          if (freshStreamInfo.playable) {
            return _ResolvedSongPlayback(song: song, streamInfo: freshStreamInfo);
          }
          streamInfo = freshStreamInfo;
        }
        printINFO(
          'Song ${song.id} is not playable (${streamInfo.statusMSG}); '
          'searching for a replacement with a new ID',
        );
      }

      final recoveredSong = await _recoverSong(song);
      if (recoveredSong == null) {
        printINFO(
          'No replacement found for ${song.id} ("${song.title}"); '
          'giving up recovery',
        );
        return _ResolvedSongPlayback(
          song: song,
          streamInfo: streamInfo ??
              HMStreamingData(
                playable: false,
                statusMSG: 'Song is unavailable',
              ),
        );
      }

      printINFO(
        'Found potential replacement for ${song.id}: '
        '${recoveredSong.id} ("${recoveredSong.title}"); '
        'verifying playability',
      );

      final recoveredStreamInfo = await checkNGetUrl(
        recoveredSong.id,
        providerTrack: recoveredSong,
        generateNewUrl: true,
      );
      if (!recoveredStreamInfo.playable) {
        printINFO(
          'Replacement ${recoveredSong.id} is also not playable '
          '(${recoveredStreamInfo.statusMSG}); giving up',
        );
        return _ResolvedSongPlayback(
          song: song,
          streamInfo: streamInfo ?? recoveredStreamInfo,
        );
      }

      await Get.find<CatalogRecoveryService>().persistRecoveredSong(
        oldSong: song,
        recoveredSong: recoveredSong,
      );
      await _replaceSongInQueue(song.id, recoveredSong);
      printINFO(
        'Successfully recovered song: ${song.id} -> ${recoveredSong.id} '
        '("${recoveredSong.title}")',
      );
      return _ResolvedSongPlayback(
        song: recoveredSong,
        streamInfo: recoveredStreamInfo,
      );
    } catch (e) {
      printERROR("Error resolving song playback for ${song.id}: $e");
      return _ResolvedSongPlayback(
        song: song,
        streamInfo: HMStreamingData(
          playable: false,
          statusMSG: "networkError",
        ),
      );
    }
  }

  Future<MediaItem?> _recoverSong(MediaItem song) async {
    return Get.find<CatalogRecoveryService>().findSimilarSong(
      title: song.title,
      artistName: song.artist,
      albumName: song.album,
      duration: song.duration,
      excludeIds: {song.id},
    );
  }

  Future<void> _replaceSongInQueue(
      String oldSongId, MediaItem recoveredSong) async {
    final updatedQueue = queue.value
        .map((item) => item.id == oldSongId ? recoveredSong : item)
        .toList();
    queue.add(updatedQueue);
    if (mediaItem.value?.id == oldSongId) {
      mediaItem.add(recoveredSong);
    }
  }
}

class UrlError extends Error {
  String message() => 'Unable to fetch url';
}

class _ResolvedSongPlayback {
  _ResolvedSongPlayback({
    required this.song,
    required this.streamInfo,
  });

  final MediaItem song;
  final HMStreamingData streamInfo;
}

// for Android Auto
class MediaLibrary {
  static const albumsRootId = 'albums';
  static const songsRootId = 'songs';
  static const favoritesRootId = "LIBFAV";
  static const playlistsRootId = 'playlists';

  Future<List<MediaItem>> getByRootId(String id) async {
    switch (id) {
      case AudioService.browsableRootId:
        return Future.value(getRoot());
      case songsRootId:
        return getLibSongs("SongDownloads");
      case favoritesRootId:
        return getLibSongs("LIBFAV");
      case albumsRootId:
        return getAlbums();
      case playlistsRootId:
        return getPlaylists();
      case AudioService.recentRootId:
        return getLibSongs("LIBRP");
      default:
        return getLibSongs(id);
    }
  }

  List<MediaItem> getRoot() {
    return [
      MediaItem(
        id: songsRootId,
        title: S.current.songs,
        playable: false,
      ),
      MediaItem(
        id: favoritesRootId,
        title: S.current.favorites,
        playable: false,
      ),
      MediaItem(
        id: albumsRootId,
        title: S.current.albums,
        playable: false,
      ),
      MediaItem(
        id: playlistsRootId,
        title: S.current.playlists,
        playable: false,
      ),
    ];
  }

  Future<List<MediaItem>> getAlbums() async {
    final box = await SqliteStore.openBox("LibraryAlbums");
    final albums =
        box.values.map((item) => Album.fromJson(item).toMediaItem()).toList();
    await box.close();
    return albums;
  }

  Future<List<MediaItem>> getPlaylists() async {
    final box = await SqliteStore.openBox("LibraryPlaylists");
    final playlists = box.values
        .map((item) => Playlist.fromJson(item))
        .where((playlist) => !LibraryPlaylistsController.reservedCollectionIds
            .contains(playlist.playlistId))
        .map((playlist) => playlist.toMediaItem())
        .toList();
    await box.close();
    return playlists;
  }

  Future<List<MediaItem>> getLibSongs(String libId) async {
    SqliteBox<dynamic> box;
    final boxName = sanitizeBoxName(libId);
    try {
      box = await SqliteStore.openBox(boxName);
    } catch (e) {
      box = await SqliteStore.openBox(boxName);
    }
    final songs = box.values.toList().map((e) {
      final song = MediaItemBuilder.fromJson(e);
      return MediaItem(
        id: song.id,
        title: song.title,
        artist: song.artist,
        artUri: song.artUri,
        extras: {"libraryId": libId},
        playable: true,
      );
    }).toList();

    if (!libId.contains("SongDownloads")) {
      await box.close();
    }

    if (libId == "LIBRP") {
      return songs.reversed.toList();
    }

    return songs;
  }
}
