import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:estrella_music/services/sync/sync_service.dart';
import 'package:estrella_music/ui/screens/Settings/settings_screen_controller.dart';
import 'package:estrella_music/ui/widgets/custom_marquee.dart';
import 'package:estrella_music/utils/helpers/music_share_manager.dart';

import '/models/playling_from.dart';
import '/models/playlist.dart';
import '/models/thumbnail.dart';
import '/ui/widgets/playlist_album_scroll_behaviour.dart';
import 'package:estrella_music/services/download/downloader.dart';
import 'package:estrella_music/ui/navigator.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/ui/widgets/create_playlist_dialog.dart';
import 'package:estrella_music/ui/widgets/loader.dart';
import 'package:estrella_music/ui/widgets/playlist_export_dialog.dart';
import 'package:estrella_music/ui/widgets/snackbar.dart';
import 'package:estrella_music/ui/widgets/song_list_tile.dart';
import 'package:estrella_music/ui/widgets/songinfo_bottom_sheet.dart';
import 'package:estrella_music/ui/widgets/sort_widget.dart';
import 'package:estrella_music/ui/screens/Playlist/playlist_screen_controller.dart';
import 'package:estrella_music/generated/l10n.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tag = key.hashCode.toString();
    final playlistController =
        (Get.isRegistered<PlaylistScreenController>(tag: tag))
            ? Get.find<PlaylistScreenController>(tag: tag)
            : Get.put(PlaylistScreenController(), tag: tag);
    final size = MediaQuery.of(context).size;
    final playerController = Get.find<PlayerController>();
    final landscape = size.width > size.height;
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          final scrollOffset = scrollInfo.metrics.pixels;

          if (landscape) {
            playlistController.scrollOffset.value = 0;
          } else {
            playlistController.scrollOffset.value = scrollOffset;
          }
          if (scrollOffset > 270 || (landscape && scrollOffset > 215)) {
            playlistController.appBarTitleVisible.value = true;
          } else {
            playlistController.appBarTitleVisible.value = false;
          }
          return true;
        },
        child: Stack(
          children: [
            Obx(
              () => playlistController.isContentFetched.isTrue
                  ? Positioned(
                      top: 0,
                      right: landscape ? 0 : null,
                      child: DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).canvasColor,
                              spreadRadius: 200,
                              blurRadius: 100,
                              offset: Offset(-size.height, 0),
                            ),
                            BoxShadow(
                              color: Theme.of(context).canvasColor,
                              spreadRadius: 200,
                              blurRadius: 100,
                              offset: Offset(
                                  0, landscape ? size.height : size.width + 80),
                            )
                          ],
                        ),
                        child: _buildPlaylistCoverImage(
                          context,
                          playlist: playlistController.playlist.value,
                          songList: playlistController.songList,
                          landscape: landscape,
                          size: size,
                        ),
                      ))
                  : SizedBox(
                      height: size.width,
                      width: size.width,
                    ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: 10,
                      right: 10),
                  height: 80,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: IconButton(
                              tooltip: S.current.back,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back_ios)),
                        ),
                        Expanded(
                          child: Obx(
                            () => Marquee(
                              delay: const Duration(milliseconds: 300),
                              duration: const Duration(seconds: 5),
                              id: "${playlistController.playlist.value.title.hashCode.toString()}_appbar",
                              child: Text(
                                playlistController.appBarTitleVisible.isTrue
                                    ? playlistController.playlist.value.title
                                    : "",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ),
                        if (playlistController.isDefaultPlaylist.isFalse)
                          SizedBox(
                            width: 50,
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10.0)),
                                    ),
                                    context: Get.find<PlayerController>()
                                        .homeScaffoldkey
                                        .currentState!
                                        .context,
                                    barrierColor:
                                        Colors.transparent.withAlpha(100),
                                    builder: (context) {
                                      final isCloud = playlistController
                                          .playlist.value.isCloudPlaylist;
                                      return SizedBox(
                                        height: isCloud ? 200 : 140,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.edit),
                                              title: Text(
                                                  S.current.renamePlaylist),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CreateNRenamePlaylistPopup(
                                                          renamePlaylist: true,
                                                          playlist:
                                                              playlistController
                                                                  .playlist
                                                                  .value),
                                                );
                                              },
                                            ),
                                            if (isCloud)
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.people),
                                                title: Text(S.current
                                                    .manageCollaborators),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  _showCollaboratorsDialog(
                                                      context,
                                                      playlistController
                                                          .playlist.value);
                                                },
                                              ),
                                            ListTile(
                                              leading: const Icon(Icons.delete),
                                              title: Text(
                                                  S.current.removePlaylist),
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                playlistController
                                                    .addNremoveFromLibrary(
                                                        playlistController
                                                            .playlist.value,
                                                        add: false)
                                                    .then((value) {
                                                  Get.nestedKey(
                                                          ScreenNavigationSetup
                                                              .id)!
                                                      .currentState!
                                                      .pop();
                                                  ScaffoldMessenger.of(
                                                          Get.context!)
                                                      .showSnackBar(snackbar(
                                                          Get.context!,
                                                          value
                                                              ? S.current
                                                                  .playlistRemovedAlert
                                                              : S.current
                                                                  .operationFailed,
                                                          size: SanckBarSize
                                                              .MEDIUM));
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.more_vert)),
                          )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 800,
                      ),
                      child: Obx(() {
                        Widget buildItem(BuildContext context, int index) {
                          if (index == 0) {
                            return Padding(
                              key: const ValueKey('header_0'),
                              padding: const EdgeInsets.only(left: 15.0),
                              child: SizedBox(
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      // Bookmark button
                                      Obx(() => (playlistController.playlist
                                                  .value.isPipedPlaylist ||
                                              !playlistController.playlist.value
                                                  .isCloudPlaylist)
                                          ? const SizedBox.shrink()
                                          : IconButton(
                                              tooltip: playlistController
                                                      .isAddedToLibrary.isFalse
                                                  ? S.current.addToLibrary
                                                  : S.current.removeFromLibrary,
                                              splashRadius: 10,
                                              onPressed: () {
                                                final add = playlistController
                                                    .isAddedToLibrary.isFalse;
                                                playlistController
                                                    .addNremoveFromLibrary(
                                                        playlistController
                                                            .playlist.value,
                                                        add: add)
                                                    .then((value) {
                                                  if (!context.mounted) {
                                                    return;
                                                  }

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackbar(
                                                          context,
                                                          value
                                                              ? add
                                                                  ? S.current
                                                                      .playlistBookmarkAddAlert
                                                                  : S.current
                                                                      .playlistBookmarkRemoveAlert
                                                              : S.current
                                                                  .operationFailed,
                                                          size: SanckBarSize
                                                              .MEDIUM));
                                                });
                                              },
                                              icon: Icon(playlistController
                                                      .isAddedToLibrary.isFalse
                                                  ? Icons.bookmark_add
                                                  : Icons.bookmark_added))),
                                      // Play button
                                      IconButton(
                                          tooltip: S.current.play,
                                          onPressed: () {
                                            playerController.playPlayListSong(
                                                List<MediaItem>.from(
                                                    playlistController
                                                        .songList),
                                                0,
                                                playfrom: PlaylingFrom(
                                                    name: playlistController
                                                        .playlist.value.title,
                                                    type: PlaylingFromType
                                                        .PLAYLIST));
                                          },
                                          icon: Icon(
                                            Icons.play_circle,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .color,
                                          )),
                                      // Enqueue button
                                      IconButton(
                                          tooltip: S.current.enqueueSongs,
                                          onPressed: () {
                                            Get.find<PlayerController>()
                                                .enqueueSongList(
                                                    playlistController.songList
                                                        .toList())
                                                .whenComplete(() {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackbar(
                                                        context,
                                                        S.current
                                                            .songEnqueueAlert,
                                                        size: SanckBarSize
                                                            .MEDIUM));
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.merge,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .color,
                                          )),

                                      // Shuffle button
                                      IconButton(
                                          tooltip: S.current.shuffle,
                                          onPressed: () {
                                            final songsToplay =
                                                List<MediaItem>.from(
                                                    playlistController
                                                        .songList);
                                            songsToplay.shuffle();
                                            songsToplay.shuffle();
                                            playerController.playPlayListSong(
                                                songsToplay, 0,
                                                playfrom: PlaylingFrom(
                                                    name: playlistController
                                                        .playlist.value.title,
                                                    type: PlaylingFromType
                                                        .PLAYLIST));
                                          },
                                          icon: Icon(
                                            Icons.shuffle,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .color,
                                          )),
                                      // Download button
                                      GetX<Downloader>(builder: (controller) {
                                        final id = playlistController
                                            .playlist.value.playlistId;
                                        return IconButton(
                                          tooltip: S.current.downloadPlaylist,
                                          onPressed: () {
                                            if (playlistController
                                                .isDownloaded.isTrue) {
                                              return;
                                            }
                                            controller.downloadPlaylist(
                                                id,
                                                playlistController.songList
                                                    .toList());
                                          },
                                          icon: playlistController
                                                  .isDownloaded.isTrue
                                              ? const Icon(Icons.download_done)
                                              : controller.playlistQueue
                                                          .containsKey(id) &&
                                                      controller
                                                              .currentPlaylistId
                                                              .toString() ==
                                                          id
                                                  ? Stack(
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                                "${controller.playlistDownloadingProgress.value}/${playlistController.songList.length}",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                        const Center(
                                                            child:
                                                                LoadingIndicator(
                                                          dimension: 30,
                                                        ))
                                                      ],
                                                    )
                                                  : controller.playlistQueue
                                                          .containsKey(id)
                                                      ? const Stack(
                                                          children: [
                                                            Center(
                                                                child: Icon(
                                                              Icons
                                                                  .hourglass_bottom,
                                                              size: 20,
                                                            )),
                                                            Center(
                                                                child:
                                                                    LoadingIndicator(
                                                              dimension: 30,
                                                            ))
                                                          ],
                                                        )
                                                      : const Icon(
                                                          Icons.download),
                                        );
                                      }),

                                      if (playlistController
                                          .playlist.value.isCloudPlaylist)
                                        IconButton(
                                          tooltip: S.current.sharePlaylist,
                                          visualDensity: const VisualDensity(
                                            vertical: -3,
                                          ),
                                          splashRadius: 10,
                                          onPressed: () {
                                            final content = playlistController
                                                .playlist.value;
                                            if (content.isPipedPlaylist) {
                                              MusicShareManager.sharePlaylist(
                                                  content.playlistId);
                                            } else {
                                              final isPlaylistIdPrefixAvlbl =
                                                  content.playlistId
                                                          .substring(0, 2) ==
                                                      "VL";
                                              final id = isPlaylistIdPrefixAvlbl
                                                  ? content.playlistId
                                                      .substring(2)
                                                  : content.playlistId;
                                              MusicShareManager.sharePlaylist(
                                                  id);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.share,
                                            size: 20,
                                          ),
                                        ),
                                      // Export button - opens export dialog
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (dialogContext) =>
                                                PlaylistExportDialog(
                                              controller: playlistController,
                                              parentContext: context,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.file_upload),
                                        tooltip: S.current.exportPlaylist,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (index == 1) {
                            final title =
                                playlistController.playlist.value.title;
                            final description =
                                playlistController.playlist.value.description;

                            return AnimatedBuilder(
                              key: const ValueKey('header_1'),
                              animation: playlistController.animationController,
                              builder: (context, child) {
                                return SizedBox(
                                  height:
                                      playlistController.heightAnimation.value,
                                  child: Transform.scale(
                                    scale:
                                        playlistController.scaleAnimation.value,
                                    child: child,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, bottom: 10, right: 30),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Marquee(
                                        delay:
                                            const Duration(milliseconds: 300),
                                        duration: const Duration(seconds: 5),
                                        id: title.hashCode.toString(),
                                        child: Text(
                                          title.length > 50
                                              ? title.substring(0, 50)
                                              : title,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 30),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Marquee(
                                          delay:
                                              const Duration(milliseconds: 300),
                                          duration: const Duration(seconds: 5),
                                          id: description.hashCode.toString(),
                                          child: Text(
                                            description ?? S.current.playlist,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (index == 2) {
                            if (playlistController.isArranging.isTrue) {
                              return Padding(
                                key: const ValueKey('header_2_arranging'),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.reArrangePlaylist,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        playlistController.isArranging.value =
                                            false;
                                      },
                                      icon: const Icon(Icons.check),
                                      label: Text(S.current.done),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return SizedBox(
                                key: const ValueKey('header_2_sort'),
                                height: playlistController.isSearchingOn.isTrue
                                    ? 60
                                    : 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 10),
                                  child: Obx(
                                    () => SortWidget(
                                      tag: playlistController
                                          .playlist.value.playlistId,
                                      screenController: playlistController,
                                      isSearchFeatureRequired: true,
                                      isPlaylistRearrageFeatureRequired:
                                          !playlistController.playlist.value
                                                  .isCloudPlaylist &&
                                              playlistController.playlist.value
                                                      .playlistId !=
                                                  "LIBRP" &&
                                              playlistController.playlist.value
                                                      .playlistId !=
                                                  "SongDownloads" &&
                                              playlistController.playlist.value
                                                      .playlistId !=
                                                  "SongsCache",
                                      isSongDeletetioFeatureRequired:
                                          !playlistController
                                              .playlist.value.isCloudPlaylist,
                                      itemCountTitle:
                                          "${playlistController.songList.length}",
                                      itemIcon: Icons.music_note,
                                      titleLeftPadding: 9,
                                      requiredSortTypes:
                                          buildSortTypeSet(false, true),
                                      onSort: playlistController.onSort,
                                      onSearch: playlistController.onSearch,
                                      onSearchClose:
                                          playlistController.onSearchClose,
                                      onSearchStart:
                                          playlistController.onSearchStart,
                                      startAdditionalOperation:
                                          playlistController
                                              .startAdditionalOperation,
                                      selectAll: playlistController.selectAll,
                                      performAdditionalOperation:
                                          playlistController
                                              .performAdditionalOperation,
                                      cancelAdditionalOperation:
                                          playlistController
                                              .cancelAdditionalOperation,
                                    ),
                                  ),
                                ));
                          } else if (playlistController
                                  .isContentFetched.isFalse ||
                              playlistController.songList.isEmpty) {
                            return SizedBox(
                              key: const ValueKey('header_3_empty'),
                              height: 300,
                              child: Center(
                                child:
                                    playlistController.isContentFetched.isFalse
                                        ? const LoadingIndicator()
                                        : Text(
                                            S.current.emptyPlaylist,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                              ),
                            );
                          }

                          final song = playlistController.songList[index - 3];
                          final child = Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 5),
                            child: SongListTile(
                              onTap: () {
                                playerController.playPlayListSong(
                                    List<MediaItem>.from(
                                        playlistController.songList),
                                    index - 3,
                                    playfrom: PlaylingFrom(
                                        name: playlistController
                                            .playlist.value.title,
                                        type: PlaylingFromType.PLAYLIST));
                              },
                              song: song,
                              isPlaylistOrAlbum: true,
                              playlist: playlistController.playlist.value,
                            ),
                          );

                          if (playlistController.isArranging.isTrue) {
                            return KeyedSubtree(
                              key: ValueKey('${song.id}_$index'),
                              child: Row(
                                children: [
                                  ReorderableDragStartListener(
                                    index: index,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      child: Icon(Icons.drag_handle,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                  ),
                                  Expanded(child: child),
                                ],
                              ),
                            );
                          }
                          return KeyedSubtree(
                              key: ValueKey('${song.id}_$index'), child: child);
                        }

                        final padding = EdgeInsets.only(
                          top: playlistController.isSearchingOn.isTrue
                              ? 0
                              : landscape
                                  ? 150
                                  : 200,
                          bottom: 200,
                        );
                        final itemCount = playlistController.songList.isEmpty ||
                                playlistController.isContentFetched.isFalse
                            ? 4
                            : playlistController.songList.length + 3;

                        return ScrollConfiguration(
                          behavior: PlaylistAlbumScrollBehaviour(),
                          child: playlistController.isArranging.isTrue
                              ? ReorderableListView.builder(
                                  padding: padding,
                                  itemCount: itemCount,
                                  buildDefaultDragHandles: false,
                                  // ignore: deprecated_member_use
                                  onReorder: (oldIndex, newIndex) {
                                    if (oldIndex < 3 || newIndex < 3) return;
                                    playlistController.reorderList(
                                        oldIndex - 3, newIndex - 3);
                                  },
                                  itemBuilder: buildItem,
                                )
                              : ListView.builder(
                                  addRepaintBoundaries: false,
                                  padding: padding,
                                  itemCount: itemCount,
                                  itemBuilder: buildItem,
                                ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future openBottomSheet(BuildContext context, MediaItem song) {
    return showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => SongInfoBottomSheet(song),
    ).whenComplete(() => Get.delete<SongInfoController>());
  }

  void _showCollaboratorsDialog(BuildContext context, Playlist playlist) {
    final syncService = Get.find<SyncService>();
    final selectedFriends = List<dynamic>.from(playlist.collaborators);
    final friendsFuture = syncService.fetchFriends();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F1B26),
        title: Row(
          children: [
            const Icon(Icons.people_alt_rounded, color: Color(0xFFFF9F1C)),
            const SizedBox(width: 10),
            Text(S.current.playlistCollaboratorsTitle,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.collaboratorsInstruction,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 12.5, height: 1.4),
                ),
                const SizedBox(height: 14),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: friendsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasError ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          S.current.noJossRedFriends,
                          style: const TextStyle(
                              fontSize: 12.5, color: Colors.white54),
                        ),
                      );
                    }
                    final friends = snapshot.data!;
                    final double containerHeight =
                        (friends.length * 50.0).clamp(50.0, 180.0);
                    return Container(
                      height: containerHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var friend in friends) ...[
                              (() {
                                final friendId =
                                    friend['id'] ?? friend['username'];
                                final friendName = friend['name'] ??
                                    friend['username'] ??
                                    S.current.friendFallback;
                                final isChecked = selectedFriends.any((c) =>
                                    (c is Map ? c['id'] : c) == friendId);
                                return CheckboxListTile(
                                  dense: true,
                                  title: Text(friendName.toString(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  value: isChecked,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (selected) {
                                    setState(() {
                                      if (selected == true) {
                                        selectedFriends.add({
                                          'id': friend['id'],
                                          'username': friend['username'],
                                          'first_name':
                                              friend['first_name'] ?? '',
                                          'last_name':
                                              friend['last_name'] ?? '',
                                        });
                                      } else {
                                        selectedFriends.removeWhere((c) =>
                                            (c is Map ? c['id'] : c) ==
                                            friendId);
                                      }
                                    });
                                  },
                                );
                              }()),
                            ]
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.cancel,
                style: const TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () async {
              playlist.collaborators = selectedFriends;
              playlist.isCollaborative = selectedFriends.isNotEmpty;
              playlist.description = playlist.isCollaborative
                  ? S.current.collaborativePlaylistDescription
                  : S.current.libraryPlaylistDescription;

              final box = await SqliteStore.openBox("LibraryPlaylists");
              await box.put(playlist.playlistId, playlist.toJson());
              await box.close();

              await syncService.pushCollaborative(playlist);

              if (context.mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  snackbar(context, S.current.collaboratorsUpdated,
                      size: SanckBarSize.MEDIUM),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9F1C),
              foregroundColor: Colors.black,
            ),
            child: Text(S.current.save,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistCoverImage(
    BuildContext context, {
    required Playlist playlist,
    required List<MediaItem> songList,
    required bool landscape,
    required Size size,
  }) {
    var rawUrl = playlist.thumbnailUrl;
    if (rawUrl.isEmpty && songList.isNotEmpty) {
      rawUrl = songList.first.artUri?.toString() ?? '';
    }

    final isFile = rawUrl.startsWith('file://') || rawUrl.startsWith('/');
    if (isFile) {
      String filePath = rawUrl;
      if (rawUrl.startsWith('file://')) {
        try {
          filePath = Uri.parse(rawUrl).toFilePath();
        } catch (_) {
          filePath = rawUrl.replaceFirst(RegExp(r'^file://+'), '/');
        }
      }
      final file = File(filePath);
      if (file.existsSync()) {
        return Image.file(
          file,
          fit: landscape ? BoxFit.fitHeight : BoxFit.cover,
          width: landscape ? null : size.width,
          height: landscape ? size.height : size.width,
          errorBuilder: (_, __, ___) => Container(
            width: landscape ? null : size.width,
            height: landscape ? size.height : size.width,
            color: Theme.of(context).canvasColor,
          ),
        );
      }
    }

    final supportDir = Get.isRegistered<SettingsScreenController>()
        ? Get.find<SettingsScreenController>().supportDirPath
        : '';
    if (supportDir.isNotEmpty) {
      if (playlist.playlistId.isNotEmpty) {
        final plThumb =
            File('$supportDir/thumbnails/${playlist.playlistId}.png');
        if (plThumb.existsSync()) {
          return Image.file(
            plThumb,
            fit: landscape ? BoxFit.fitHeight : BoxFit.cover,
            width: landscape ? null : size.width,
            height: landscape ? size.height : size.width,
            errorBuilder: (_, __, ___) => Container(
              width: landscape ? null : size.width,
              height: landscape ? size.height : size.width,
              color: Theme.of(context).canvasColor,
            ),
          );
        }
      }
      if (songList.isNotEmpty) {
        final firstSongThumb =
            File('$supportDir/thumbnails/${songList.first.id}.png');
        if (firstSongThumb.existsSync()) {
          return Image.file(
            firstSongThumb,
            fit: landscape ? BoxFit.fitHeight : BoxFit.cover,
            width: landscape ? null : size.width,
            height: landscape ? size.height : size.width,
            errorBuilder: (_, __, ___) => Container(
              width: landscape ? null : size.width,
              height: landscape ? size.height : size.width,
              color: Theme.of(context).canvasColor,
            ),
          );
        }
      }
    }

    if (rawUrl.isEmpty ||
        rawUrl.startsWith('data:') ||
        rawUrl.startsWith('file:')) {
      return Container(
        width: landscape ? null : size.width,
        height: landscape ? size.height : size.width,
        color: Theme.of(context).canvasColor,
      );
    }

    return CachedNetworkImage(
      imageUrl: Thumbnail(rawUrl).extraHigh,
      fit: landscape ? BoxFit.fitHeight : BoxFit.cover,
      width: landscape ? null : size.width,
      height: landscape ? size.height : size.width,
      errorWidget: (_, __, ___) => Container(
        width: landscape ? null : size.width,
        height: landscape ? size.height : size.width,
        color: Theme.of(context).canvasColor,
      ),
    );
  }
}
