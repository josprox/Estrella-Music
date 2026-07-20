import 'package:audio_service/audio_service.dart' show MediaItem;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'custom_marquee.dart';

import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import '/ui/theme/app_spacing.dart';
import 'add_to_playlist.dart';
import 'image_widget.dart';
import 'snackbar.dart';
import 'songinfo_bottom_sheet.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'song_status_badges.dart';

class SongListTile extends StatelessWidget with RemoveSongFromPlaylistMixin {
  const SongListTile(
      {super.key,
      this.onTap,
      required this.song,
      this.playlist,
      this.isPlaylistOrAlbum = false,
      this.thumbReplacementWithIndex = false,
      this.index});
  final Playlist? playlist;
  final MediaItem song;
  final VoidCallback? onTap;
  final bool isPlaylistOrAlbum;
  final bool thumbReplacementWithIndex;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Listener(
      onPointerDown: (PointerDownEvent event) {
        if (event.buttons == kSecondaryMouseButton) {
          _openInfoSheet(context, playerController, null);
        }
      },
      child: Slidable(
        enabled:
            Get.find<SettingsScreenController>().slidableActionEnabled.isTrue,
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (_) => showDialog(
              context: context,
              builder: (_) => AddToPlaylist([song]),
            ).whenComplete(() => Get.delete<AddToPlaylistController>()),
            backgroundColor: cs.primaryContainer,
            foregroundColor: cs.onPrimaryContainer,
            icon: Icons.playlist_add_rounded,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          if (playlist != null && !playlist!.isCloudPlaylist)
            SlidableAction(
              onPressed: (_) => removeSongFromPlaylist(song, playlist!),
              backgroundColor: cs.errorContainer,
              foregroundColor: cs.onErrorContainer,
              icon: Icons.delete_outline_rounded,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
        ]),
        endActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (_) {
              playerController.enqueueSong(song).whenComplete(() {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(snackbar(
                    context, S.current.songEnqueueAlert,
                    size: SanckBarSize.MEDIUM));
              });
            },
            backgroundColor: cs.secondaryContainer,
            foregroundColor: cs.onSecondaryContainer,
            icon: Icons.merge_rounded,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          SlidableAction(
            onPressed: (_) {
              playerController.playNext(song);
              ScaffoldMessenger.of(context).showSnackBar(snackbar(
                  context, '${S.current.playnextMsg} ${song.title}',
                  size: SanckBarSize.BIG));
            },
            backgroundColor: cs.tertiaryContainer,
            foregroundColor: cs.onTertiaryContainer,
            icon: Icons.next_plan_outlined,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ]),
        child: Obx(
          () {
            final isPlaying = playerController.currentSong.value?.id == song.id;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                color: isPlaying
                    ? cs.primary.withValues(alpha: 0.10)
                    : Colors.transparent,
              ),
              child: ListTile(
                onTap: onTap,
                onLongPress: () =>
                    _openInfoSheet(context, playerController, playlist),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                contentPadding: const EdgeInsets.only(
                    top: 0, left: AppSpacing.md, right: AppSpacing.xl),
                leading: thumbReplacementWithIndex
                    ? SizedBox(
                        width: 28,
                        height: 55,
                        child: Center(
                          child: Text(
                            '$index.',
                            style: tt.titleSmall?.copyWith(
                                color: isPlaying ? cs.primary : null),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                          boxShadow: isPlaying
                              ? [
                                  BoxShadow(
                                    color: cs.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                              : null,
                        ),
                        child: SongStatusBadges(
                          songId: song.id,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusSm),
                            child: ImageWidget(size: 52, song: song),
                          ),
                        ),
                      ),
                title: Marquee(
                  delay: const Duration(milliseconds: 300),
                  duration: const Duration(seconds: 5),
                  id: song.title.hashCode.toString(),
                  child: Text(
                    song.title.length > 50
                        ? song.title.substring(0, 50)
                        : song.title,
                    maxLines: 1,
                    style: tt.titleMedium?.copyWith(
                      color: isPlaying ? cs.primary : null,
                      fontWeight: isPlaying ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                subtitle: Text(
                  '${song.artist}',
                  maxLines: 1,
                  style: tt.bodySmall,
                ),
                trailing: SizedBox(
                  width: Get.size.width > 800 ? 80 : 42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isPlaylistOrAlbum && isPlaying)
                            Icon(
                              Icons.equalizer_rounded,
                              size: AppSpacing.iconSm,
                              color: cs.primary,
                            ),
                          Text(
                            song.extras!['length'] ?? '',
                            style: tt.bodySmall,
                          ),
                        ],
                      ),
                      if (GetPlatform.isDesktop)
                        IconButton(
                          splashRadius: 20,
                          onPressed: () => _openInfoSheet(
                              context, playerController, playlist),
                          icon: const Icon(Icons.more_vert_rounded, size: 18),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openInfoSheet(BuildContext context, PlayerController playerController,
      Playlist? playlist) {
    showModalBottomSheet(
      constraints: const BoxConstraints(maxWidth: 500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),

      isScrollControlled: true,
      context: playerController.homeScaffoldkey.currentState!.context,

      builder: (_) => SongInfoBottomSheet(song, playlist: playlist),
    ).whenComplete(() => Get.delete<SongInfoController>());
  }
}
