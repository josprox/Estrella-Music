import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/models/playling_from.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/ui/navigator.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/widgets/add_to_playlist.dart';
import 'package:harmonymusic/ui/widgets/loader.dart';
import 'package:harmonymusic/ui/widgets/shared_song_action_sheet.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/ui/widgets/songinfo_bottom_sheet.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

class AppLinksController extends GetxController with ProcessLink {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  Timer? _retryTimer;
  Uri? _pendingLink;
  bool _isHandlingLink = false;
  String? _lastHandledLink;
  DateTime? _lastHandledAt;

  @override
  void onInit() {
    super.onInit();
    unawaited(initDeepLinks());
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Subscribe first so a warm link cannot arrive between the initial-link
    // lookup and stream registration.
    _linkSubscription = _appLinks.uriLinkStream.listen(
      _queueLink,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint("App link stream error: $error");
      },
    );

    final appLink = await _appLinks.getInitialAppLink();
    if (appLink != null) {
      _queueLink(appLink);
    }
  }

  void _queueLink(Uri uri) {
    final link = uri.toString();
    final wasJustHandled = _lastHandledLink == link &&
        _lastHandledAt != null &&
        DateTime.now().difference(_lastHandledAt!) < const Duration(seconds: 2);
    if (wasJustHandled || _pendingLink?.toString() == link) return;

    _pendingLink = uri;
    debugPrint("App link queued: $uri");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_processPendingLink());
    });
  }

  Future<void> _processPendingLink() async {
    if (_isHandlingLink || _pendingLink == null) return;

    if (!_isNavigationReady) {
      _retryTimer?.cancel();
      _retryTimer = Timer(
        const Duration(seconds: 1),
        () => unawaited(_processPendingLink()),
      );
      return;
    }

    final uri = _pendingLink!;
    _pendingLink = null;
    _isHandlingLink = true;
    try {
      debugPrint("Handling app link: $uri");
      await filterLinks(uri);
      _lastHandledLink = uri.toString();
      _lastHandledAt = DateTime.now();
    } catch (error, stackTrace) {
      debugPrint("Unable to handle app link $uri: $error");
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isHandlingLink = false;
      if (_pendingLink != null) {
        unawaited(_processPendingLink());
      }
    }
  }

  bool get _isNavigationReady {
    return Get.context != null &&
        Get.isRegistered<PlayerController>() &&
        Get.nestedKey(ScreenNavigationSetup.id)?.currentState != null;
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _linkSubscription?.cancel();
    super.dispose();
  }
}

mixin ProcessLink {
  Future<void> filterLinks(Uri uri) async {
    final playerController = Get.find<PlayerController>();
    if (playerController.playerPanelController.isPanelOpen) {
      playerController.playerPanelController.close();
    }

    if (Get.isRegistered<SongInfoController>() && Get.context != null) {
      Navigator.of(Get.context!).pop();
    }

    final sharedItem = _emusicSharedItem(uri);
    if (sharedItem != null) {
      switch (sharedItem.type) {
        case "song":
          await openSharedSong(sharedItem.id);
          return;
        case "album":
          await openAlbum(sharedItem.id);
          return;
        case "playlist":
          await openPlaylist(sharedItem.id);
          return;
        case "artist":
          await openArtist(sharedItem.id);
          return;
      }
    }

    if (!_isYoutubeLink(uri)) {
      _showInvalidLinkMessage();
      return;
    }

    printINFO("pathsegmet: ${uri.pathSegments} params:${uri.queryParameters}");
    if (uri.pathSegments.isEmpty) {
      _showInvalidLinkMessage();
    } else if (uri.pathSegments[0] == "playlist" &&
        uri.queryParameters.containsKey("list")) {
      await openPlaylistOrAlbum(uri.queryParameters["list"]!);
    } else if (uri.pathSegments[0] == "shorts") {
      _showSongVideoMessage();
    } else if (uri.pathSegments[0] == "watch") {
      final songId = uri.queryParameters["v"];
      if (songId == null) {
        _showInvalidLinkMessage();
      } else {
        await playSong(songId);
      }
    } else if (uri.pathSegments[0] == "channel" &&
        uri.pathSegments.length > 1) {
      await openArtist(uri.pathSegments[1]);
    } else if (uri.host == "youtu.be") {
      await playSong(uri.pathSegments[0]);
    } else {
      _showInvalidLinkMessage();
    }
  }

  _SharedItem? _emusicSharedItem(Uri uri) {
    final isHttpsLink = uri.scheme == "https" &&
        uri.host == "emusic.joss.red" &&
        uri.pathSegments.length == 3 &&
        uri.pathSegments[0] == "share";
    final isCustomScheme = uri.scheme == "estrellamusic" &&
        uri.host == "share" &&
        uri.pathSegments.length == 2;

    if (!isHttpsLink && !isCustomScheme) return null;

    final type = isHttpsLink ? uri.pathSegments[1] : uri.pathSegments[0];
    const supportedTypes = {"song", "album", "playlist", "artist"};
    if (!supportedTypes.contains(type)) return null;

    return _SharedItem(type: type, id: uri.pathSegments.last);
  }

  bool _isYoutubeLink(Uri uri) {
    return {
      "youtube.com",
      "music.youtube.com",
      "youtu.be",
      "www.youtube.com",
      "m.youtube.com",
    }.contains(uri.host);
  }

  void _showInvalidLinkMessage() {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(snackbar(
      context,
      S.current.notaValidLink,
      size: SanckBarSize.MEDIUM,
    ));
  }

  void _showSongVideoMessage() {
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(snackbar(
      context,
      S.current.notaSongVideo,
      size: SanckBarSize.MEDIUM,
    ));
  }

  Future<void> openPlaylistOrAlbum(String browseId) async {
    if (browseId.contains("OLAK5uy")) {
      Get.toNamed(
        ScreenNavigationSetup.albumScreen,
        id: ScreenNavigationSetup.id,
        arguments: (null, browseId),
      );
    } else {
      Get.toNamed(
        ScreenNavigationSetup.playlistScreen,
        id: ScreenNavigationSetup.id,
        arguments: [null, browseId],
      );
    }
  }

  Future<void> openAlbum(String browseId) async {
    await Get.toNamed(
      ScreenNavigationSetup.albumScreen,
      id: ScreenNavigationSetup.id,
      arguments: (null, browseId),
    );
  }

  Future<void> openPlaylist(String browseId) async {
    await Get.toNamed(
      ScreenNavigationSetup.playlistScreen,
      id: ScreenNavigationSetup.id,
      arguments: [null, browseId],
    );
  }

  Future<void> openArtist(String channelId) async {
    await Get.toNamed(
      ScreenNavigationSetup.artistScreen,
      id: ScreenNavigationSetup.id,
      arguments: [true, channelId],
    );
  }

  Future<void> playSong(String songId) async {
    final songs = await _loadSong(songId);
    if (songs == null) return;
    Get.find<PlayerController>().playPlayListSong(
      songs,
      0,
      playfrom: PlaylingFrom(type: PlaylingFromType.SELECTION),
    );
  }

  Future<void> openSharedSong(String songId) async {
    final songs = await _loadSong(songId);
    if (songs == null || songs.isEmpty || Get.context == null) return;

    final song = songs.first;
    final action = await showModalBottomSheet<SharedSongAction>(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SharedSongActionSheet(song: song),
    );

    switch (action) {
      case SharedSongAction.play:
        Get.find<PlayerController>().playPlayListSong(
          songs,
          0,
          playfrom: PlaylingFrom(type: PlaylingFromType.SELECTION),
        );
        return;
      case SharedSongAction.enqueue:
        await Get.find<PlayerController>().enqueueSong(song);
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
            Get.context!,
            S.current.songEnqueueAlert,
            size: SanckBarSize.MEDIUM,
          ));
        }
        return;
      case SharedSongAction.addToPlaylist:
        if (Get.context == null) return;
        await showDialog<void>(
          context: Get.context!,
          builder: (_) => AddToPlaylist([song]),
        );
        if (Get.isRegistered<AddToPlaylistController>()) {
          Get.delete<AddToPlaylistController>();
        }
        return;
      case null:
        return;
    }
  }

  Future<List<MediaItem>?> _loadSong(String songId) async {
    final context = Get.context;
    if (context == null) return null;

    showDialog<void>(
      context: context,
      builder: (_) => const Center(
        child: LoadingIndicator(strokeWidth: 5),
      ),
      barrierDismissible: false,
    );

    try {
      final result = await Get.find<MusicServices>().getSongWithId(songId);
      if (Get.context != null && Navigator.of(Get.context!).canPop()) {
        Navigator.of(Get.context!).pop();
      }
      if (result[0]) {
        return List<MediaItem>.from(result[1]);
      }
      _showSongVideoMessage();
      return null;
    } catch (_) {
      if (Get.context != null && Navigator.of(Get.context!).canPop()) {
        Navigator.of(Get.context!).pop();
      }
      _showSongVideoMessage();
      return null;
    }
  }
}

class _SharedItem {
  const _SharedItem({required this.type, required this.id});

  final String type;
  final String id;
}
