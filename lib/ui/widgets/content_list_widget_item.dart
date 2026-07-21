import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audio_service/audio_service.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';

import 'package:harmonymusic/ui/navigator.dart';
import 'image_widget.dart';
import 'playlist_cover_widget.dart';
import 'hover_card_wrapper.dart';
import 'package:harmonymusic/models/playling_from.dart';
import 'package:harmonymusic/models/media_item_builder.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/models/playlist.dart';

import 'package:harmonymusic/ui/theme/app_spacing.dart';
import 'common_dialog_widget.dart';
import 'custom_button.dart';

class ContentListItem extends StatelessWidget {
  final double? width;
  final double? height;
  final double? imageSize;
  const ContentListItem(
      {super.key,
      required this.content,
      this.isLibraryItem = false,
      this.width,
      this.height,
      this.imageSize});
// ignore: unused_element
  // const ContentListItem.old(
  // {super.key, required this.content, this.isLibraryItem = false});

  ///content will be of Type class Album or Playlist
  final dynamic content;
  final bool isLibraryItem;

  @override
  Widget build(BuildContext context) {
    final finalWidth = width ?? 130.0;
    final finalHeight = height ?? 194.0;
    final finalImageSize = imageSize ?? 120.0;
    final isAlbum = content.runtimeType.toString() == "Album";
    
    final String subtitle;
    if (isLibraryItem) {
      if (isAlbum) {
        final artistName = (content.artists != null && content.artists!.isNotEmpty)
            ? content.artists![0]['name'] ?? ""
            : "";
        subtitle = artistName.isNotEmpty ? "Álbum • $artistName" : "Álbum";
      } else {
        final count = SqliteStore.isBoxOpen(content.playlistId)
            ? SqliteStore.box(content.playlistId).length
            : (content.songCount != null ? int.tryParse(content.songCount!.replaceAll(RegExp(r'\D'), '')) ?? 0 : 0);
        subtitle = count > 0 ? "Playlist • $count ${count == 1 ? 'canción' : 'canciones'}" : "Playlist";
      }
    } else {
      subtitle = isAlbum
          ? content.isPodcast
              ? "${content.artists[0]['name'] ?? ""}${content.episodeCount == null ? "" : " | ${content.episodeCount}"}"
              : "${content.artists[0]['name'] ?? ""} | ${content.year ?? ""}"
          : content.description ?? "";
    }

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (isAlbum) {
          Get.toNamed(ScreenNavigationSetup.albumScreen,
              id: ScreenNavigationSetup.id,
              arguments: (content, content.browseId));
          return;
        }
        Get.toNamed(ScreenNavigationSetup.playlistScreen,
            id: ScreenNavigationSetup.id,
            arguments: [content, content.playlistId]);
      },
      onLongPress: (isLibraryItem &&
              content is Playlist &&
              !LibraryPlaylistsController.reservedCollectionIds
                  .contains(content.playlistId))
          ? () {
              Get.dialog(
                CommonDialog(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.lg, horizontal: AppSpacing.xl),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.current.removePlaylist,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          "${S.current.delete} ${content.title}?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const CancelButton(),
                            ProceedButton(
                              buttonText: S.current.delete,
                              onPressed: () {
                                Get.find<LibraryPlaylistsController>()
                                    .deletePlaylist(content);
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          : null,
      child: Container(
        width: finalWidth,
        height: finalHeight,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HoverCardWrapper(
              borderRadius: 12.0,
              onPlayTap: (isAlbum || !(content.playlistId == 'LIBRP' || content.playlistId == 'SongsCache'))
                  ? () async {
                      final playerController = Get.find<PlayerController>();
                      final musicServices = Get.find<MusicServices>();
                      final scaffoldMessenger = ScaffoldMessenger.of(context);
                      try {
                        final id = isAlbum ? content.browseId : content.playlistId;

                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Cargando "${content.title}"...'),
                            duration: const Duration(milliseconds: 1500),
                          ),
                        );

                        if (id == 'LIBFAV' || id == 'SongDownloads') {
                          final box = await SqliteStore.openBox(sanitizeBoxName(id));
                          final tracks = box.values
                              .map<MediaItem?>((item) => MediaItemBuilder.fromJson(item))
                              .whereType<MediaItem>()
                              .toList();
                          if (tracks.isNotEmpty) {
                            playerController.playPlayListSong(
                              tracks,
                              0,
                              playfrom: PlaylingFrom(
                                name: content.title,
                                type: PlaylingFromType.PLAYLIST,
                              ),
                            );
                          }
                          return;
                        }

                        Map<String, dynamic> data;
                        if (isAlbum) {
                          final isPodcast = content.isPodcast == true || id.startsWith('MPSP');
                          data = isPodcast
                              ? await musicServices.podcast(id)
                              : await musicServices.getPlaylistOrAlbumSongs(albumId: id);
                        } else {
                          data = await musicServices.getPlaylistOrAlbumSongs(playlistId: id);
                        }
                        final tracks = List<MediaItem>.from(data['tracks'] ?? []);
                        if (tracks.isNotEmpty) {
                          playerController.playPlayListSong(
                            tracks,
                            0,
                            playfrom: PlaylingFrom(
                              name: content.title,
                              type: isAlbum ? PlaylingFromType.ALBUM : PlaylingFromType.PLAYLIST,
                            ),
                          );
                        } else {
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text('No se encontraron canciones en esta lista.'),
                            ),
                          );
                        }
                      } catch (e) {
                        printERROR("Failed to hover-play: $e");
                        scaffoldMessenger.showSnackBar(
                          const SnackBar(
                            content: Text('Error al cargar la música.'),
                          ),
                        );
                      }
                    }
                  : null,
              child: isAlbum
                  ? ImageWidget(
                      size: finalImageSize,
                      album: content,
                    )
                  : SizedBox.square(
                      dimension: finalImageSize,
                      child: Stack(
                        children: [
                          PlaylistCoverWidget(
                            size: finalImageSize,
                            playlist: content,
                          ),
                          if (content.isPipedPlaylist)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "P",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 14),
                                  )),
                                ),
                              ),
                            ),
                          if (!content.isCloudPlaylist)
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                  ),
                                  child: Center(
                                      child: Text(
                                    "L",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontSize: 14),
                                  )),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    maxLines: isLibraryItem ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(height: 1.25),
                  ),
                  if (subtitle.trim().isNotEmpty)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
