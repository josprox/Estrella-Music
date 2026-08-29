import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/utils/helpers/ionicons.dart';
import 'package:harmonymusic/ui/widgets/custom_marquee.dart';

import '/ui/theme/app_spacing.dart';
import '/ui/widgets/glass_morphism.dart';
import '/ui/player/components/animated_play_button.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';

class PlayerControlWidget extends StatelessWidget {
  const PlayerControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController ctrl = Get.find<PlayerController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // â”€â”€ Song info + favourite â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    colors: [Colors.white, Colors.white, Colors.transparent],
                    stops: [0, 0.80, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Marquee(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(seconds: 10),
                          id: '${ctrl.currentSong.value}_title',
                          child: Text(
                            ctrl.currentSong.value?.title ?? 'NA',
                            style: tt.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Marquee(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(seconds: 10),
                          id: '${ctrl.currentSong.value}_subtitle',
                          child: Text(
                            ctrl.currentSong.value?.artist ?? 'NA',
                            style: tt.titleSmall?.copyWith(
                              color: Colors.white60,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            // Favourite button with glass circle
            Obx(() => GlassIconButton(
                  icon: ctrl.isCurrentSongFav.isTrue
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: ctrl.isCurrentSongFav.isTrue
                      ? cs.primary
                      : Colors.white60,
                  size: 40,
                  iconSize: 20,
                  onPressed: ctrl.toggleFavourite,
                )),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),

        // â”€â”€ Progress bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        GetX<PlayerController>(
          builder: (c) => ProgressBar(
            thumbRadius: 7,
            barHeight: 4,
            thumbGlowRadius: 18,
            baseBarColor: Colors.white.withValues(alpha: 0.15),
            bufferedBarColor: cs.primary.withValues(alpha: 0.3),
            progressBarColor: cs.primary,
            thumbColor: Colors.white,
            timeLabelTextStyle: tt.bodySmall?.copyWith(
              color: Colors.white60,
              fontSize: 12,
            ),
            progress: c.progressBarStatus.value.current,
            total: c.progressBarStatus.value.total,
            buffered: c.progressBarStatus.value.buffered,
            onSeek: c.seek,
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // â”€â”€ Transport controls â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Shuffle
            Obx(() => _iconBtn(
                  icon: Ionicons.shuffle,
                  color: ctrl.isShuffleModeEnabled.value
                      ? cs.primary
                      : Colors.white30,
                  onTap: ctrl.toggleShuffleMode,
                )),

            // Previous
            _iconBtn(
              icon: Icons.skip_previous_rounded,
              color: Colors.white,
              size: AppSpacing.iconXl,
              onTap: ctrl.prev,
            ),

            // Play / Pause â€” large glowing button
            const GlassPlayButton(
              size: 72,
              child: AnimatedPlayButton(
                key: Key('playButton'),
                iconSize: 34,
              ),
            ),

            // Next
            Obx(() {
              final isLast = ctrl.currentQueue.isEmpty ||
                  (!(ctrl.isShuffleModeEnabled.isTrue ||
                          ctrl.isQueueLoopModeEnabled.isTrue) &&
                      ctrl.currentQueue.last.id == ctrl.currentSong.value?.id);
              return _iconBtn(
                icon: Icons.skip_next_rounded,
                color: isLast ? Colors.white24 : Colors.white,
                size: AppSpacing.iconXl,
                onTap: isLast ? null : ctrl.next,
              );
            }),

            // Loop
            Obx(() => _iconBtn(
                  icon: Icons.all_inclusive_rounded,
                  color: ctrl.isLoopModeEnabled.value
                      ? cs.primary
                      : Colors.white30,
                  onTap: ctrl.toggleLoopMode,
                )),
          ],
        ),
      ],
    );
  }

  Widget _iconBtn({
    required IconData icon,
    required Color color,
    double size = AppSpacing.iconLg,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      splashColor: Colors.white.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
