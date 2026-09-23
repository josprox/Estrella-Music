import 'dart:async';
import 'package:audio_service/audio_service.dart' show MediaItem;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/models/thumbnail.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';

import 'package:estrella_music/base_class/playlist_album_screen_con_base.dart';
import 'package:estrella_music/mixins/additional_opeartion_mixin.dart';
import '../../../models/album.dart' show Album;
import 'package:estrella_music/models/media_item_builder.dart';
import 'package:estrella_music/models/playlist.dart';
import 'package:estrella_music/services/auth/catalog_recovery_service.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/music_provider/music_provider.dart';
import 'package:estrella_music/services/sync/sync_service.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';
import 'package:estrella_music/ui/screens/Library/library_controller.dart';

///PlaylistScreenController handles playlist screen
///
///Playlist title,image,songs
class PlaylistScreenController extends PlaylistAlbumScreenControllerBase
    with AdditionalOpeartionMixin, GetSingleTickerProviderStateMixin {
  final MusicCatalogService _musicServices = Get.find<MusicCatalogService>();
  final CatalogRecoveryService _catalogRecoveryService =
      Get.find<CatalogRecoveryService>();
  final playlist = Playlist(
    title: "",
    playlistId: "",
    thumbnailUrl: Playlist.thumbPlaceholderUrl,
  ).obs;
  final isDefaultPlaylist = false.obs;
  final isArranging = false.obs;

  StreamSubscription? _playlistSub;
  StreamSubscription? _songsSub;

  // Title animation

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heightAnimation;

  AnimationController get animationController => _animationController;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get heightAnimation => _heightAnimation;
  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(animationController);

    _heightAnimation = Tween<double>(begin: 10.0, end: 75.0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.easeOutBack));

    final args = Get.arguments as List;
    final Playlist? playlist = args[0];
    final playlistId = args[1];
    fetchPlaylistDetails(playlist, playlistId);
    Future.delayed(const Duration(milliseconds: 200),
        () => Get.find<HomeScreenController>().whenHomeScreenOnTop());
  }

  ///Fetches playlist details from the service
  @override
  void fetchPlaylistDetails(Playlist? playlist_, String playlistId) async {
    final isIdOnly = playlist_ == null;
    final isPipedPlaylist = playlist_?.isPipedPlaylist ?? false;
    bool wasInLibrary = false;
    isDefaultPlaylist.value = (playlistId == "SongDownloads" ||
        playlistId == "SongsCache" ||
        playlistId == "LIBRP" ||
        playlistId == "LIBFAV");

    _watchPlaylistChanges(playlistId);

    if (!isIdOnly && !playlist_.isCloudPlaylist) {
      playlist.value = playlist_;
      _animationController.forward();
      fetchSongsfromDatabase(playlistId);
      isContentFetched.value = true;

      Future.delayed(
          const Duration(seconds: 1), () => _updatePlaylistThumbSongBased());

      return;
    }

    if (!isIdOnly) {
      playlist.value = playlist_;
      _animationController.forward();
    }

    try {
      // Check if the playlist is offline
      wasInLibrary = await checkIfAddedToLibrary(playlistId);
      if (wasInLibrary) {
        final songsBox = await SqliteStore.openBox(sanitizeBoxName(playlistId));
        if (songsBox.values.isEmpty) {
          await _fetchSongOnline(
            playlistId,
            isIdOnly,
            isPipedPlaylist,
            persistRecovery: true,
          );
          await updateSongsIntoDb();
        } else {
          // If the playlist is offline, fetch the songs from the local database
          // Playlist details are already fetched in _checkIfAddedToLibrary method
          fetchSongsfromDatabase(playlistId);
        }
      } else {
        await _fetchSongOnline(
          playlistId,
          isIdOnly,
          isPipedPlaylist,
          persistRecovery: false,
        );
      }
    } catch (e) {
      // Handle any errors that occur during the fetch
      printERROR("Error fetching playlist details: $e");
    } finally {
      isContentFetched.value = true;
    }
  }

  Future<void> _fetchSongOnline(
    String id,
    bool isIdOnly,
    bool isPipedPlaylist, {
    required bool persistRecovery,
  }) async {
    isContentFetched.value = false;

    if (isPipedPlaylist) {
      songList.clear();
      isContentFetched.value = true;
      return;
    }

    try {
      final content =
          await _musicServices.getPlaylistOrAlbumSongs(playlistId: id);

      if (isIdOnly) {
        content['playlistId'] = id;
        playlist.value = Playlist.fromJson(content);
        _animationController.forward();
      }
      songList.value = List<MediaItem>.from(content['tracks']);
      checkDownloadStatus();
    } on MusicProviderException catch (error) {
      printERROR("Error fetching playlist details: $error");
      final recoveredPlaylist =
          await _catalogRecoveryService.findSimilarPlaylist(
        title: _playlistTitleHint(),
        description: playlist.value.description,
      );
      if (recoveredPlaylist != null && recoveredPlaylist.playlistId != id) {
        final content = await _musicServices.getPlaylistOrAlbumSongs(
          playlistId: recoveredPlaylist.playlistId,
        );
        content['playlistId'] = recoveredPlaylist.playlistId;
        playlist.value = Playlist.fromJson(content);
        _animationController.forward();
        songList.value = List<MediaItem>.from(content['tracks']);
        if (persistRecovery) {
          await _catalogRecoveryService.persistRecoveredPlaylist(
            oldPlaylistId: id,
            playlist: playlist.value,
            tracks: songList.toList(),
          );
        }
        checkDownloadStatus();
      }
    } finally {
      isContentFetched.value = true;
    }
  }

  String _playlistTitleHint() {
    return playlist.value.title.trim();
  }

  @override
  void syncPlaylistSongs() {
    _fetchSongOnline(
      playlist.value.playlistId,
      false,
      false,
      persistRecovery: isAddedToLibrary.isTrue,
    ).then((value) {
      updateSongsIntoDb();
      isContentFetched.value = true;
    });
  }

  @override
  Future<bool> checkIfAddedToLibrary(String id) async {
    final box = await SqliteStore.openBox("LibraryPlaylists");
    isAddedToLibrary.value = box.containsKey(id);
    if (isAddedToLibrary.value) playlist.value = Playlist.fromJson(box.get(id));
    await box.close();
    return isAddedToLibrary.value;
  }

  @override
  Future<bool> addNremoveFromLibrary(dynamic content, {bool add = true}) async {
    try {
      final box = await SqliteStore.openBox("LibraryPlaylists");
      final id = content.playlistId;
      if (add) {
        box.put(id, content.toJson());
        updateSongsIntoDb();
      } else {
        box.delete(id);
        final songsBox = await SqliteStore.openBox(sanitizeBoxName(id));
        songsBox.deleteFromDisk();
      }
      isAddedToLibrary.value = add;
      //Update frontend
      Get.find<LibraryPlaylistsController>().refreshLib();
      Get.find<SyncService>().triggerPush();
      if (!content.isCloudPlaylist && !add) {
        final plstbox =
            await SqliteStore.openBox(sanitizeBoxName(content.playlistId));
        plstbox.deleteFromDisk();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> updateSongsIntoDb() async {
    final songsBox =
        await SqliteStore.openBox(sanitizeBoxName(playlist.value.playlistId));
    await songsBox.clear();
    final songListCopy = songList.toList();
    for (int i = 0; i < songListCopy.length; i++) {
      await songsBox.put(i, MediaItemBuilder.toJson(songListCopy[i]));
    }
    if (playlist.value.playlistId != "SongDownloads") await songsBox.close();

    // Update the playlist thumbnail based on the first song's thumbnail
    _updatePlaylistThumbSongBased();
    await Get.find<SyncService>()
        .recordPlaylistChange(playlist.value.playlistId);
  }

  @override
  Future<void> deleteMultipleSongs(List<MediaItem> songs) async {
    final id = playlist.value.playlistId;
    final isoffline = id == "SongsCache" || id == "SongDownloads";
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final box_ = await SqliteStore.openBox(sanitizeBoxName(id));
      for (MediaItem element in songs) {
        final index = box_.values
            .toList()
            .indexWhere((ele) => ele['videoId'] == element.id);
        await box_.deleteAt(index);

        if (isoffline) {
          await Get.find<LibrarySongsController>()
              .removeSong(element, id == "SongDownloads");
        }

        songList.removeWhere((song) => song.id == element.id);
        if (!isoffline) {
          await syncService.recordPlaylistTrackChange(
            id,
            element.id,
            deleted: true,
            track: MediaItemBuilder.toJson(element),
          );
        }
      }
      if (!isoffline) {
        await box_.close();
      }
    });

    // Update the playlist thumbnail based on the first song's thumbnail
    _updatePlaylistThumbSongBased();
  }

  void addNRemoveItemsinList(MediaItem? item,
      {required String action, int? index}) {
    if (action == 'add') {
      if (tempListContainer.isNotEmpty) {
        index != null
            ? tempListContainer.insert(index, item!)
            : tempListContainer.add(item!);
        return;
      }
      index != null ? songList.insert(index, item!) : songList.add(item!);
    } else {
      if (tempListContainer.isNotEmpty) {
        index != null
            ? tempListContainer.removeAt(index)
            : tempListContainer.remove(item);
      }
      index != null ? songList.removeAt(index) : songList.remove(item);
    }

    // update the playlist thumbnail based on the first song's thumbnail
    _updatePlaylistThumbSongBased();
  }

  void reorderList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = songList.removeAt(oldIndex);
    songList.insert(newIndex, item);
    updateSongsIntoDb();
    unawaited(Get.find<SyncService>().recordPlaylistChange(
      playlist.value.playlistId,
    ));
  }

  @override
  void fetchAlbumDetails(
      Album? album_, String albumId) {} // Not used in this class

  /// This function updates the local playlist thumbnail based on the first song's thumbnail
  void _updatePlaylistThumbSongBased() {
    final currentPlaylist = playlist.value;

    if (isDefaultPlaylist.isTrue || currentPlaylist.isCloudPlaylist) {
      return;
    }

    Playlist updatedplaylist;
    if (songList.isNotEmpty) {
      updatedplaylist =
          currentPlaylist.copyWith(thumbnailUrl: songList[0].artUri.toString());
    } else {
      updatedplaylist =
          currentPlaylist.copyWith(thumbnailUrl: Playlist.thumbPlaceholderUrl);
    }

    // Check if the thumbnail URL is the same as the current one
    // If it is, no need to update the playlist
    if (Thumbnail(currentPlaylist.thumbnailUrl).extraHigh ==
        Thumbnail(updatedplaylist.thumbnailUrl).extraHigh) {
      return;
    }

    // Update the playlist thumbnail URL
    playlist.value = updatedplaylist;
    Get.find<LibraryPlaylistsController>()
        .updatePlaylistIntoDb(updatedplaylist);
  }

  @override
  void onClose() {
    _playlistSub?.cancel();
    _songsSub?.cancel();
    tempListContainer.clear();
    _animationController.dispose();
    Get.find<HomeScreenController>().whenHomeScreenOnTop();
    super.onClose();
  }

  void _watchPlaylistChanges(String playlistId) async {
    _playlistSub?.cancel();
    _songsSub?.cancel();

    try {
      final plBox = SqliteStore.isBoxOpen("LibraryPlaylists")
          ? SqliteStore.box("LibraryPlaylists")
          : await SqliteStore.openBox("LibraryPlaylists");
      _playlistSub = plBox.watch(key: playlistId).listen((event) {
        final data = event.value;
        if (data != null) {
          playlist.value = Playlist.fromJson(Map<String, dynamic>.from(data));
        }
      });
    } catch (_) {}

    try {
      final boxName = sanitizeBoxName(playlistId);
      final songsBox = SqliteStore.isBoxOpen(boxName)
          ? SqliteStore.box(boxName)
          : await SqliteStore.openBox(boxName);
      _songsSub = songsBox.watch().listen((event) {
        fetchSongsfromDatabase(playlistId);
      });
    } catch (_) {}
  }
}
