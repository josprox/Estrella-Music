import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estrella_music/ui/player/player_controller.dart';
import '/ui/widgets/image_widget.dart';
import 'animated_play_button.dart';
import '/ui/screens/Settings/settings_screen_controller.dart';
import '/ui/screens/Home/home_screen_controller.dart';
import '/ui/widgets/custom_marquee.dart';

/// Material 3 Expressive mini-player.
/// Modern floating card-style anchored docked bar with top-rounded corners,
/// circular filled action buttons, and drag handles.
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PlayerController>();

    return Obx(() {
      final song = ctrl.currentSong.value;
      if (song == null || !ctrl.isPlayerpanelTopVisible.value) {
        return const SizedBox.shrink();
      }
      return _MiniPlayerContent(song: song, ctrl: ctrl);
    });
  }
}

class _MiniPlayerContent extends StatelessWidget {
  final dynamic song;
  final PlayerController ctrl;

  const _MiniPlayerContent({required this.song, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 800;

    return Obx(() {
      final isBottomNavBarEnabled =
          Get.find<SettingsScreenController>().isBottomNavBarEnabled.isTrue;
      bool isHomeOnTop = false;
      if (Get.isRegistered<HomeScreenController>()) {
        isHomeOnTop = Get.find<HomeScreenController>().isHomeSreenOnTop.isTrue;
      }
      final isBottomNavBarVisible =
          isBottomNavBarEnabled && isHomeOnTop && ctrl.isPanelGTHOpened.isFalse;

      final bottomPadding =
          isBottomNavBarVisible ? 0.0 : MediaQuery.of(context).padding.bottom;

      if (isWideScreen) {
        // Floating premium capsule bar for desktop widescreen
        return Container(
          width: screenWidth,
          height: 105.0,
          padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 16, top: 8),
          color: Colors.transparent, // outer space transparent to float
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ctrl.playerPanelController.open,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.35),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Progress bar (Top edge of floating card, rounded)
                  Positioned(
                    top: 0,
                    left: 24,
                    right: 24,
                    height: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.5),
                      child: GetX<PlayerController>(
                        builder: (c) {
                          final total =
                              c.progressBarStatus.value.total.inMilliseconds;
                          final current =
                              c.progressBarStatus.value.current.inMilliseconds;
                          final pct = total > 0
                              ? (current / total).clamp(0.0, 1.0)
                              : 0.0;
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ColoredBox(
                                color: colorScheme.outlineVariant
                                    .withValues(alpha: 0.2),
                              ),
                              FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: pct,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(1.5),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    child: Row(
                      children: [
                        // Album Art
                        Hero(
                          tag: 'mini_art_${song.id}',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: colorScheme.outlineVariant
                                    .withValues(alpha: 0.35),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: ImageWidget(size: 52, song: song),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Title + Artist info
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Marquee(
                                id: song.id.toString(),
                                child: Text(
                                  song.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: colorScheme.onSurface,
                                    fontSize: 16,
                                    letterSpacing: -0.1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                song.artist ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Actions
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Previous button
                            IconButton(
                              onPressed: ctrl.prev,
                              icon: Icon(
                                Icons.skip_previous_rounded,
                                color: colorScheme.onSurface,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 4),
                            // Play button
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.primaryContainer,
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.primary
                                        .withValues(alpha: 0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: AnimatedPlayButton(
                                  iconSize: 30,
                                  iconColor: colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            // Next button
                            IconButton(
                              onPressed: ctrl.next,
                              icon: Icon(
                                Icons.skip_next_rounded,
                                color: colorScheme.onSurface,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Favorite
                            Obx(
                              () => IconButton(
                                onPressed: ctrl.toggleFavourite,
                                icon: Icon(
                                  ctrl.isCurrentSongFav.isTrue
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: ctrl.isCurrentSongFav.isTrue
                                      ? colorScheme.error
                                      : colorScheme.onSurfaceVariant,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      // Default Mobile Layout
      const playerHeight = 74.0;
      final totalHeight = playerHeight + bottomPadding;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: ctrl.playerPanelController.open,
        onHorizontalDragEnd: (details) {
          if ((details.primaryVelocity ?? 0) < 0) ctrl.next();
          if ((details.primaryVelocity ?? 0) > 0) ctrl.prev();
        },
        child: Container(
          width: screenWidth,
          height: totalHeight,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                offset: const Offset(0, -4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Drag Handle (Top center indicator)
                Positioned(
                  top: 5,
                  left: (screenWidth - 36) / 2,
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color:
                          colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Progress bar (Top edge of card)
                Positioned(
                  top: 0,
                  left: 16,
                  right: 16,
                  height: 2.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.25),
                    child: GetX<PlayerController>(
                      builder: (c) {
                        final total =
                            c.progressBarStatus.value.total.inMilliseconds;
                        final current =
                            c.progressBarStatus.value.current.inMilliseconds;
                        final pct =
                            total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            ColoredBox(
                              color: colorScheme.outlineVariant
                                  .withValues(alpha: 0.2),
                            ),
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: pct,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: BorderRadius.circular(1.25),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Main Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      // Album Art with double outline & drop shadow
                      Hero(
                        tag: 'mini_art_${song.id}',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: colorScheme.outlineVariant
                                  .withValues(alpha: 0.35),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: ImageWidget(size: 46, song: song),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Title + Artist info
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Marquee(
                              id: song.id.toString(),
                              child: Text(
                                song.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colorScheme.onSurface,
                                  fontSize: 14.5,
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              song.artist ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.8),
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Elegant Action Row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                            () => IconButton(
                              onPressed: ctrl.toggleFavourite,
                              icon: Icon(
                                ctrl.isCurrentSongFav.isTrue
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: ctrl.isCurrentSongFav.isTrue
                                    ? colorScheme.error
                                    : colorScheme.onSurfaceVariant,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),

                          // Circular action backdrop for Play Button
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme.primaryContainer,
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.15),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: AnimatedPlayButton(
                                iconSize: 26,
                                iconColor: colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),

                          const SizedBox(width: 6),
                          IconButton(
                            onPressed: ctrl.next,
                            icon: Icon(
                              Icons.skip_next_rounded,
                              color: colorScheme.onSurface,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
