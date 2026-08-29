import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '/ui/player/components/standard_player.dart';
import 'package:harmonymusic/utils/helpers/helper.dart';
import 'package:harmonymusic/ui/widgets/snackbar.dart';
import 'package:harmonymusic/ui/widgets/up_next_queue.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/widgets/sliding_up_panel.dart';
import 'package:harmonymusic/generated/l10n.dart';

/// Player screen
/// Contains the player ui
///
/// Player ui can be standard player or gesture player
class Player extends StatelessWidget {
  final ScrollController? mainScrollController;
  const Player({super.key, this.mainScrollController});

  @override
  Widget build(BuildContext context) {
    printINFO("player");
    final size = MediaQuery.of(context).size;
    final PlayerController playerController = Get.find<PlayerController>();
    return Scaffold(
      /// SlidingUpPanel is used to create a panel that can slide up and down
      /// It is used to show the current queue panel in mobile
      body: Obx(() {
        final isQueuePanelOpened = playerController.isQueuePanelOpened.value;
        return SlidingUpPanel(
          boxShadow: const [],
          minHeight: 0,
          maxHeight: GetPlatform.isDesktop ? size.height : size.height * 0.85,
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          backdropEnabled: !GetPlatform.isDesktop,
          backdropOpacity: 0.24,
          isDraggable: !GetPlatform.isDesktop && isQueuePanelOpened,
          onPanelSlide: (position) {
            if (position > 0.05) {
              playerController.isQueuePanelOpened.value = true;
            } else {
              playerController.isQueuePanelOpened.value = false;
            }
          },
          controller: GetPlatform.isDesktop
              ? null
              : playerController.queuePanelController,
          onPanelOpened: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final controller = playerController.scrollController;
              if (!controller.hasClients) return;
              final position = controller.position;
              final target = 100.0 +
                  (playerController.currentSongIndex.value * 64.0) -
                  (position.viewportDimension / 2) +
                  32.0;
              controller.jumpTo(target.clamp(0.0, position.maxScrollExtent));
            });
          },
          collapsed: null,

          /// Panel for queue
          panelBuilder: (ScrollController sc, onReorderStart, onReorderEnd) {
            playerController.scrollController = sc;
            return Stack(
              children: [
                /// Stack first child
                /// UpNextQueue widget contains list of songs in queue
                UpNextQueue(
                  onReorderEnd: onReorderEnd,
                  onReorderStart: onReorderStart,
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(28)),
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withAlpha(32),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    S.current.upNext,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: playerController
                                      .queuePanelController.close,
                                  tooltip: S.current.back,
                                  icon: const Icon(Icons.close_rounded),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Queue controls stay available without competing with the list.
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    color: Theme.of(context).colorScheme.surface,
                    elevation: 4,
                    shadowColor: Theme.of(context)
                        .colorScheme
                        .shadow
                        .withValues(alpha: 0.12),
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 10, 16, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(
                                () => Text(
                                  "${playerController.currentQueue.length} ${S.current.songs}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            Obx(
                              () => IconButton.filledTonal(
                                onPressed: playerController.toggleQueueLoopMode,
                                tooltip: S.current.queueLoop,
                                style: IconButton.styleFrom(
                                  backgroundColor: playerController
                                          .isQueueLoopModeEnabled.isTrue
                                      ? Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .surfaceContainerHighest,
                                  foregroundColor: playerController
                                          .isQueueLoopModeEnabled.isTrue
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                ),
                                icon: const Icon(Icons.repeat_rounded),
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton.filledTonal(
                              onPressed: () {
                                if (playerController
                                    .isShuffleModeEnabled.isTrue) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackbar(context,
                                          S.current.queueShufflingDeniedMsg,
                                          size: SanckBarSize.BIG));
                                  return;
                                }
                                playerController.shuffleQueue();
                              },
                              tooltip: S.current.shuffleQueue,
                              icon: const Icon(Icons.shuffle_rounded),
                            ),
                            const SizedBox(width: 8),
                            IconButton.filledTonal(
                              onPressed: playerController.clearQueue,
                              style: IconButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                foregroundColor: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer,
                              ),
                              icon: const Icon(Icons.playlist_remove_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },

          /// show player ui based on selected player ui in settings
          /// Gesture player is only applicable for mobile
          body: StandardPlayer(mainScrollController: mainScrollController),
        );
      }),
    );
  }
}
