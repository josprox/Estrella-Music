import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/widgets/custom_marquee.dart';
import 'package:harmonymusic/utils/helpers/youtube_share_manager.dart';

import '/models/playling_from.dart';
import '/models/thumbnail.dart';
import '/ui/widgets/playlist_album_scroll_behaviour.dart';
import 'package:harmonymusic/services/download/downloader.dart';
import 'package:harmonymusic/ui/navigator.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/widgets/create_playlist_dialog.dart';
import 'package:harmonymusic/ui/widgets/loader.dart';
import 'package:harmonymusic/ui/widgets/playlist_export_dialog.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/ui/widgets/song_list_tile.dart';
import 'package:harmonymusic/ui/widgets/songinfo_bottom_sheet.dart';
import 'package:harmonymusic/ui/widgets/sort_widget.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'playlist_screen_controller.dart';
import 'package:harmonymusic/generated/l10n.dart';

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
                                  0,
                                  landscape
                                      ? size.height
                                      : size.width + 80),
                            )
                          ],
                        ),
                        child: CachedNetworkImage(
                          imageUrl: Thumbnail(playlistController
                                  .playlist.value.thumbnailUrl)
                              .extraHigh,
                          fit: landscape ? BoxFit.fitHeight : BoxFit.cover,
                          width: landscape ? null : size.width,
                          height: landscape ? size.height : size.width,
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
                        if (!playlistController
                                .playlist.value.isCloudPlaylist &&
                            playlistController.isDefaultPlaylist.isFalse)
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
                                    builder: (context) => SizedBox(
                                      height: 140,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.edit),
                                            title: Text(S.current.renamePlaylist),
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
                                          ListTile(
                                            leading: const Icon(Icons.delete),
                                            title: Text(S.current.removePlaylist),
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
                                                            ? S.current.playlistRemovedAlert
                                                            : S.current.operationFailed,
                                                        size: SanckBarSize
                                                            .MEDIUM));
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
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
                                                  !playlistController.playlist
                                                      .value.isCloudPlaylist)
                                              ? const SizedBox.shrink()
                                              : IconButton(
                                                  tooltip: playlistController
                                                          .isAddedToLibrary
                                                          .isFalse
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
                                      
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(snackbar(
                                                              context,
                                                              value
                                                                  ? add
                                                                      ? S.current.playlistBookmarkAddAlert
                                                                      : S.current.playlistBookmarkRemoveAlert
                                                                  : S.current.operationFailed,
                                                              size: SanckBarSize
                                                                  .MEDIUM));
                                                    });
                                                  },
                                                  icon: Icon(playlistController
                                                          .isAddedToLibrary
                                                          .isFalse
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
                                                        playlistController
                                                            .songList
                                                            .toList())
                                                    .whenComplete(() {
                                                  if (context.mounted) {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(snackbar(
                                                            context,
                                                            S.current.songEnqueueAlert,
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
                                                  ? const Icon(
                                                      Icons.download_done)
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
                                              .isAddedToLibrary.isTrue)
                                            IconButton(
                                                tooltip:
                                                    S.current.syncPlaylistSongs,
                                                onPressed: () {
                                                  playlistController
                                                      .syncPlaylistSongs();
                                                },
                                                icon:
                                                    const Icon(Icons.cloud_sync)),
                                          if (playlistController
                                              .playlist.value.isPipedPlaylist)
                                            IconButton(
                                                tooltip:
                                                    S.current.blacklistPipedPlaylist,
                                                icon: const Icon(
                                                  Icons.block,
                                                  size: 20,
                                                ),
                                                splashRadius: 10,
                                                onPressed: () {
                                                  Get.nestedKey(
                                                          ScreenNavigationSetup
                                                              .id)!
                                                      .currentState!
                                                      .pop();
                                                  Get.find<
                                                          LibraryPlaylistsController>()
                                                      .blacklistPipedPlaylist(
                                                          playlistController
                                                              .playlist.value);
                                                  ScaffoldMessenger.of(
                                                          Get.context!)
                                                      .showSnackBar(snackbar(
                                                          Get.context!,
                                                          S.current.playlistBlacklistAlert,
                                                          size: SanckBarSize
                                                              .MEDIUM));
                                                }),
                                          if (playlistController
                                              .playlist.value.isCloudPlaylist)
                                            IconButton(
                                              tooltip:
                                                  S.current.sharePlaylist,
                                              visualDensity: const VisualDensity(
                                                vertical: -3,
                                              ),
                                              splashRadius: 10,
                                              onPressed: () {
                                                final content = playlistController
                                                    .playlist.value;
                                                if (content.isPipedPlaylist) {
                                                  YoutubeShareManager.sharePlaylist(content.playlistId);
                                                } else {
                                                  final isPlaylistIdPrefixAvlbl =
                                                      content.playlistId
                                                              .substring(0, 2) ==
                                                          "VL";
                                                  final id = isPlaylistIdPrefixAvlbl
                                                      ? content.playlistId.substring(2)
                                                      : content.playlistId;
                                                  YoutubeShareManager.sharePlaylist(id);
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
                                final description = playlistController
                                    .playlist.value.description;

                                return AnimatedBuilder(
                                  key: const ValueKey('header_1'),
                                  animation:
                                      playlistController.animationController,
                                  builder: (context, child) {
                                    return SizedBox(
                                      height: playlistController
                                          .heightAnimation.value,
                                      child: Transform.scale(
                                        scale: playlistController
                                            .scaleAnimation.value,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, bottom: 10, right: 30),
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
                                            delay: const Duration(
                                                milliseconds: 300),
                                            duration:
                                                const Duration(seconds: 5),
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
                                );
                              } else if (index == 2) {
                                if (playlistController.isArranging.isTrue) {
                                  return Padding(
                                    key: const ValueKey('header_2_arranging'),
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          S.current.reArrangePlaylist,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            playlistController.isArranging.value = false;
                                          },
                                          icon: const Icon(Icons.check),
                                          label: const Text("Listo"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context).colorScheme.secondary,
                                            foregroundColor: Theme.of(context).colorScheme.onSecondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return SizedBox(
                                    key: const ValueKey('header_2_sort'),
                                    height:
                                        playlistController.isSearchingOn.isTrue
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
                                          isPlaylistRearrageFeatureRequired: !playlistController
                                                  .playlist
                                                  .value
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
                                              !playlistController.playlist.value
                                                  .isCloudPlaylist,
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
                                          selectAll:
                                              playlistController.selectAll,
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
                                    child: playlistController
                                            .isContentFetched.isFalse
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
                                          padding: const EdgeInsets.only(left: 10, right: 5),
                                          child: Icon(Icons.drag_handle, color: Theme.of(context).colorScheme.secondary),
                                        ),
                                      ),
                                      Expanded(child: child),
                                    ],
                                  ),
                                );
                              }
                              return KeyedSubtree(key: ValueKey('${song.id}_$index'), child: child);
                            }

                            final padding = EdgeInsets.only(
                              top: playlistController.isSearchingOn.isTrue ? 0 : landscape ? 150 : 200,
                              bottom: 200,
                            );
                            final itemCount = playlistController.songList.isEmpty || playlistController.isContentFetched.isFalse ? 4 : playlistController.songList.length + 3;

                            return ScrollConfiguration(
                              behavior: PlaylistAlbumScrollBehaviour(),
                              child: playlistController.isArranging.isTrue ?
                                ReorderableListView.builder(
                                  padding: padding,
                                  itemCount: itemCount,
                                  buildDefaultDragHandles: false,
                                  // ignore: deprecated_member_use
                                  onReorder: (oldIndex, newIndex) {
                                    if (oldIndex < 3 || newIndex < 3) return;
                                    playlistController.reorderList(oldIndex - 3, newIndex - 3);
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
}
