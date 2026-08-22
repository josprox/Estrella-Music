import 'package:audio_service/audio_service.dart';

import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/utils/helpers/ionicons.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:harmonymusic/services/download/downloader.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/services/social/piped_service.dart';
import '/ui/widgets/sleep_timer_bottom_sheet.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import '/ui/widgets/add_to_playlist.dart';
import '/ui/widgets/snackbar.dart';
import 'package:harmonymusic/models/media_item_builder.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/navigator.dart';
import 'song_download_btn.dart';
import 'image_widget.dart';
import 'song_info_dialog.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/utils/helpers/youtube_share_manager.dart';

class SongInfoBottomSheet extends StatelessWidget {
  const SongInfoBottomSheet(this.song,
      {super.key,
      this.playlist,
      this.calledFromPlayer = false,
      this.calledFromQueue = false});
  final MediaItem song;
  final Playlist? playlist;
  final bool calledFromPlayer;
  final bool calledFromQueue;

  @override
  Widget build(BuildContext context) {
    final songInfoController =
        Get.put(SongInfoController(song, calledFromPlayer));
    final playerController = Get.find<PlayerController>();
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: Padding(
        padding: EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: const EdgeInsets.only(
                    left: 15, top: 7, right: 10, bottom: 0),
                leading: ImageWidget(
                  song: song,
                  size: 50,
                ),
                title: Text(
                  song.title,
                  maxLines: 1,
                ),
                subtitle: Text(song.artist!),
                trailing: SizedBox(
                  width: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calledFromPlayer
                          ? IconButton(
                              onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => SongInfoDialog(
                                      song: song,
                                    ),
                                  ),
                              icon: Icon(
                                Icons.info,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ))
                          : IconButton(
                              onPressed: songInfoController.toggleFav,
                              icon: Obx(() => Icon(
                                    songInfoController.isCurrentSongFav.isFalse
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                  ))),
                      SongDownloadButton(
                        song_: song,
                        isDownloadingDoneCallback:
                            songInfoController.setDownloadStatus,
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                visualDensity: const VisualDensity(vertical: -1),
                leading: const Icon(Icons.sensors),
                title: Text(S.current.startRadio),
                onTap: () {
                  Navigator.of(context).pop();
                  playerController.startRadio(song);
                },
              ),
              (calledFromPlayer || calledFromQueue)
                  ? const SizedBox.shrink()
                  : ListTile(
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: const Icon(Icons.playlist_play),
                      title: Text(S.current.playNext),
                      onTap: () {
                        Navigator.of(context).pop();
                        playerController.playNext(song);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar(
                            context, "${S.current.playnextMsg} ${song.title}",
                            size: SanckBarSize.BIG));
                      },
                    ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -1),
                leading: const Icon(Icons.playlist_add),
                title: Text(S.current.addToPlaylist),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) => AddToPlaylist([song]),
                  ).whenComplete(() => Get.delete<AddToPlaylistController>());
                },
              ),
              (calledFromPlayer || calledFromQueue)
                  ? const SizedBox.shrink()
                  : ListTile(
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: const Icon(Icons.merge),
                      title: Text(S.current.enqueueSong),
                      onTap: () {
                        playerController.enqueueSong(song).whenComplete(() {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(snackbar(
                              context, S.current.songEnqueueAlert,
                              size: SanckBarSize.MEDIUM));
                        });
                        Navigator.of(context).pop();
                      },
                    ),
              song.extras!['album'] != null
                  ? ListTile(
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: const Icon(Icons.album),
                      title: Text(S.current.goToAlbum),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (calledFromPlayer) {
                          playerController.playerPanelController.close();
                        }
                        if (calledFromQueue) {
                          playerController.playerPanelController.close();
                        }
                        Get.toNamed(ScreenNavigationSetup.albumScreen,
                            id: ScreenNavigationSetup.id,
                            arguments: (null, song.extras!['album']['id']));
                      },
                    )
                  : const SizedBox.shrink(),
              ...artistWidgetList(song, context),
              (playlist != null &&
                          !playlist!.isCloudPlaylist &&
                          !(playlist!.playlistId == "LIBRP")) ||
                      (playlist != null && playlist!.isPipedPlaylist)
                  ? ListTile(
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: const Icon(Icons.delete),
                      title: playlist!.title == "Library Songs"
                          ? Text(S.current.removeFromLib)
                          : Text(S.current.removeFromPlaylist),
                      onTap: () {
                        Navigator.of(context).pop();
                        songInfoController
                            .removeSongFromPlaylist(song, playlist!)
                            .whenComplete(() =>
                                ScaffoldMessenger.of(Get.context!).showSnackBar(
                                    snackbar(Get.context!,
                                        "Removed from ${playlist!.title}",
                                        size: SanckBarSize.MEDIUM)));
                      },
                    )
                  : const SizedBox.shrink(),
              (calledFromQueue)
                  ? ListTile(
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: const Icon(Icons.delete),
                      title: Text(S.current.removeFromQueue),
                      onTap: () {
                        Navigator.of(context).pop();
                        if (playerController.currentSong.value!.id == song.id) {
                          ScaffoldMessenger.of(context).showSnackBar(snackbar(
                              context, S.current.songRemovedfromQueueCurrSong,
                              size: SanckBarSize.BIG));
                        } else {
                          playerController.removeFromQueue(song);
                          ScaffoldMessenger.of(context).showSnackBar(snackbar(
                              context, S.current.songRemovedfromQueue,
                              size: SanckBarSize.MEDIUM));
                        }
                      })
                  : const SizedBox.shrink(),
              Obx(
                () => (songInfoController.isDownloaded.isTrue &&
                        (playlist?.playlistId != "SongDownloads" &&
                            playlist?.playlistId != "SongsCache"))
                    ? ListTile(
                        contentPadding: const EdgeInsets.only(left: 15),
                        visualDensity: const VisualDensity(vertical: -1),
                        leading: const Icon(Icons.delete),
                        title: Text(S.current.deleteDownloadData),
                        onTap: () {
                          Navigator.of(context).pop();
                          final box = SqliteStore.box("SongDownloads");
                          Get.find<LibrarySongsController>()
                              .removeSong(song, true,
                                  url: box.get(song.id)['url'])
                              .then((value) async {
                            box.delete(song.id).then((value) {
                              if (playlist != null) {
                                Get.find<PlaylistScreenController>(
                                        tag: Key(playlist!.playlistId)
                                            .hashCode
                                            .toString())
                                    .checkDownloadStatus();
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbar(context,
                                        S.current.deleteDownloadedDataAlert,
                                        size: SanckBarSize.BIG));
                              }
                            });
                          });
                        },
                      )
                    : const SizedBox.shrink(),
              ),
              ListTile(
                leading: const Icon(Icons.open_with),
                title: Text(S.current.openIn),
                trailing: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        splashRadius: 10,
                        onPressed: () {
                          launchUrl(Uri.parse(
                              YoutubeShareManager.getSongUrl(song.id)));
                        },
                        icon: const Icon(Ionicons.logoYoutube),
                      ),
                      IconButton(
                        splashRadius: 10,
                        onPressed: () {
                          launchUrl(Uri.parse(
                              YoutubeShareManager.getMusicSongUrl(song.id)));
                        },
                        icon: const Icon(Ionicons.playCircle),
                      )
                    ],
                  ),
                ),
              ),
              if (calledFromPlayer)
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 15),
                  visualDensity: const VisualDensity(vertical: -1),
                  leading: const Icon(Icons.timer),
                  title: Text(S.current.sleepTimer),
                  onTap: () {
                    Navigator.of(context).pop();
                    showModalBottomSheet(
                      constraints: const BoxConstraints(maxWidth: 500),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                      ),
                      isScrollControlled: true,
                      context: playerController
                          .homeScaffoldkey.currentState!.context,
                      builder: (context) => const SleepTimerBottomSheet(),
                    );
                  },
                ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 15),
                visualDensity: const VisualDensity(vertical: -1),
                leading: const Icon(Icons.share),
                title: Text(S.current.shareSong),
                onTap: () => YoutubeShareManager.shareSong(song.id,
                    title: song.title, artist: song.artist),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> artistWidgetList(MediaItem song, BuildContext context) {
    final artistList = [];
    final artists = song.extras!['artists'];
    if (artists != null) {
      for (dynamic each in artists) {
        if (each.containsKey("id") && each['id'] != null) artistList.add(each);
      }
    }
    return artistList.isNotEmpty
        ? artistList
            .map((e) => ListTile(
                  onTap: () async {
                    Navigator.of(context).pop();
                    if (calledFromPlayer) {
                      Get.find<PlayerController>()
                          .playerPanelController
                          .close();
                    }
                    if (calledFromQueue) {
                      final playerController = Get.find<PlayerController>();
                      playerController.playerPanelController.close();
                    }
                    await Get.toNamed(ScreenNavigationSetup.artistScreen,
                        id: ScreenNavigationSetup.id,
                        preventDuplicates: true,
                        arguments: [true, e['id']]);
                  },
                  tileColor: Colors.transparent,
                  leading: const Icon(Icons.person),
                  title: Text("${S.current.viewArtist} (${e['name']})"),
                ))
            .toList()
        : [const SizedBox.shrink()];
  }
}

class SongInfoController extends GetxController
    with RemoveSongFromPlaylistMixin {
  final isCurrentSongFav = false.obs;
  final MediaItem song;
  final bool calledFromPlayer;
  List artistList = [].obs;
  final isDownloaded = false.obs;
  SongInfoController(this.song, this.calledFromPlayer) {
    _setInitStatus(song);
  }
  _setInitStatus(MediaItem song) async {
    isDownloaded.value = SqliteStore.box("SongDownloads").containsKey(song.id);
    isCurrentSongFav.value =
        (await SqliteStore.openBox("LIBFAV")).containsKey(song.id);
    final artists = song.extras!['artists'];
    if (artists != null) {
      for (dynamic each in artists) {
        if (each.containsKey("id") && each['id'] != null) artistList.add(each);
      }
    }
  }

  void setDownloadStatus(bool isDownloaded_) {
    if (isDownloaded_) {
      Future.delayed(const Duration(milliseconds: 100),
          () => isDownloaded.value = isDownloaded_);
    }
  }

  Future<void> toggleFav() async {
    if (calledFromPlayer) {
      final cntrl = Get.find<PlayerController>();
      if (cntrl.currentSong.value == song) {
        await cntrl.toggleFavourite();
        isCurrentSongFav.value = cntrl.isCurrentSongFav.value;
        return;
      }
    }
    final wasFavorite = isCurrentSongFav.value;
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final track = MediaItemBuilder.toJson(song);
      await syncService.recordFavoriteChange(
        song.id,
        deleted: wasFavorite,
        track: track,
      );
      final box = await SqliteStore.openBox("LIBFAV");
      if (wasFavorite) {
        await box.delete(song.id);
      } else {
        await box.put(song.id, track);
      }
    });
    isCurrentSongFav.value = !wasFavorite;
    if (Get.find<SettingsScreenController>()
            .autoDownloadFavoriteSongEnabled
            .isTrue &&
        isCurrentSongFav.isTrue) {
      Get.find<Downloader>().download(song);
    }
  }
}

mixin RemoveSongFromPlaylistMixin {
  Future<void> removeSongFromPlaylist(MediaItem item, Playlist playlist) async {
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final box = await SqliteStore.openBox(sanitizeBoxName(playlist.playlistId));
      //Library songs case
      if (playlist.playlistId == "SongsCache") {
        if (!box.containsKey(item.id)) {
          SqliteStore.box("SongDownloads").delete(item.id);
          Get.find<LibrarySongsController>().removeSong(item, true);
        } else {
          Get.find<LibrarySongsController>().removeSong(item, false);
          box.delete(item.id);
        }
      } else if (playlist.playlistId == "SongDownloads") {
        box.delete(item.id);
        Get.find<LibrarySongsController>().removeSong(item, true);
      } else if (!playlist.isPipedPlaylist) {
        //Other playlist song case
        final index =
            box.values.toList().indexWhere((ele) => ele['videoId'] == item.id);
        await box.deleteAt(index);
      }

      // this try catch block is to handle the case when song is removed from libsongs sections
      try {
        final plstCntroller = Get.find<PlaylistScreenController>(
            tag: Key(playlist.playlistId).hashCode.toString());
        if (playlist.isPipedPlaylist) {
          final res = await Get.find<PipedServices>()
              .getPlaylistSongs(playlist.playlistId);
          final songIndex = res.indexWhere((element) => element.id == item.id);
          if (songIndex != -1) {
            final res = await Get.find<PipedServices>()
                .removeFromPlaylist(playlist.playlistId, songIndex);
            if (res.code == 1) {
              plstCntroller.addNRemoveItemsinList(item, action: 'remove');
            }
          }
          return;
        }

        try {
          plstCntroller.addNRemoveItemsinList(item, action: 'remove');
          // ignore: empty_catches
        } catch (e) {}
      } catch (e) {
        printERROR(
            "Some Error in removeSongFromPlaylist (might irrelavant): $e");
      }

      if (playlist.playlistId == "SongDownloads" ||
          playlist.playlistId == "SongsCache") {
        return;
      }
      await syncService.recordPlaylistTrackChange(
        playlist.playlistId,
        item.id,
        deleted: true,
        track: MediaItemBuilder.toJson(item),
      );
      box.close();
    });
  }
}
