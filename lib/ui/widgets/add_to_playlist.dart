import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:estrella_music/utils/helpers/helper.dart';

import 'package:estrella_music/services/sync/sync_service.dart';
import '/models/media_item_builder.dart';
import '/ui/widgets/create_playlist_dialog.dart';
import 'package:estrella_music/models/playlist.dart';
import 'common_dialog_widget.dart';
import 'snackbar.dart';
import 'package:estrella_music/generated/l10n.dart';

class AddToPlaylist extends StatelessWidget {
  const AddToPlaylist(this.songItems, {super.key});
  final List<MediaItem> songItems;

  @override
  Widget build(BuildContext context) {
    final addToPlaylistController = Get.put(AddToPlaylistController());
    return CommonDialog(
      child: Container(
        height: 380,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    S.current.addToPlaylist,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => CreateNRenamePlaylistPopup(
                          isCreateNadd: true, songItems: songItems),
                    );
                  },
                  icon: const Icon(Icons.playlist_add),
                  tooltip: S.current.CreateNewPlaylist,
                  style: IconButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.08),
                    padding: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (addToPlaylistController.playlists.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.playlist_play_rounded,
                          size: 48,
                          color: Theme.of(context)
                              .disabledColor
                              .withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          S.current.noLibPlaylist,
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: addToPlaylistController.playlists.length,
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final playlist = addToPlaylistController.playlists[index];
                    final isCloud = playlist.isCloudPlaylist;

                    return InkWell(
                      onTap: () {
                        addToPlaylistController
                            .addSongsToPlaylist(
                                songItems, playlist.playlistId, context)
                            .then((value) {
                          if (!context.mounted) return;
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(snackbar(
                                context, S.current.songAddedToPlaylistAlert,
                                size: SanckBarSize.MEDIUM));
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(snackbar(
                                context, S.current.songAlreadyExists,
                                size: SanckBarSize.MEDIUM));
                            Navigator.of(context).pop();
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .cardColor
                              .withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context)
                                .dividerColor
                                .withValues(alpha: 0.03),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  colors: isCloud
                                      ? [
                                          Colors.blue.shade600,
                                          Colors.indigo.shade400
                                        ]
                                      : [
                                          Colors.purple.shade600,
                                          Colors.pink.shade400
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: const Icon(
                                Icons.music_note_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playlist.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Icon(
                                        isCloud
                                            ? Icons.cloud_done_rounded
                                            : Icons.phone_android_rounded,
                                        size: 13,
                                        color: isCloud
                                            ? Colors.blue.shade400
                                            : Colors.green.shade400,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isCloud ? "Cloud" : "Local",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Theme.of(context)
                                  .disabledColor
                                  .withValues(alpha: 0.4),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToPlaylistController extends GetxController {
  final RxList<Playlist> playlists = RxList();
  final playlistType = "local".obs;
  final additionInProgress = false.obs;
  List<Playlist> localPlaylists = [];
  AddToPlaylistController() {
    _getAllPlaylist();
  }

  Future<void> _getAllPlaylist() async {
    final plstsBox = await SqliteStore.openBox("LibraryPlaylists");
    playlists.value =
        plstsBox.values.map((e) => Playlist.fromJson(e as Map)).toList();
    localPlaylists = playlists.toList();
  }

  void changePlaylistType(val) {
    playlistType.value = val;
    playlists.value = localPlaylists;
  }

  Future<bool> addSongsToPlaylist(
      List<MediaItem> songs, String playlistId, BuildContext context) async {
    additionInProgress.value = true;
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final plstBox = await SqliteStore.openBox(sanitizeBoxName(playlistId));
      final playlistSongIds = plstBox.values.map((item) => item['videoId']);
      for (MediaItem element in songs) {
        if (!playlistSongIds.contains(element.id)) {
          final track = MediaItemBuilder.toJson(element);
          final position = await plstBox.add(track);
          await syncService.recordPlaylistTrackChange(
            playlistId,
            element.id,
            deleted: false,
            track: track,
            position: position,
          );
        }
      }
    });
    additionInProgress.value = false;
    return true;
  }
}
