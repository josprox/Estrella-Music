
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
          maxHeight: size.height,
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

              /// Stack second child
              /// This contains the bottom bar with queue loop, shuffle, clear queue buttons
              /// and number of songs in queue
              /// BackdropFilter is used to blur the background
              Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  elevation: 4,
                  shadowColor: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.15),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Song count
                          Obx(
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

                          // Queue loop
                          Obx(
                            () => FilledButton.tonal(
                              onPressed: playerController.toggleQueueLoopMode,
                              style: FilledButton.styleFrom(
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(S.current.queueLoop),
                            ),
                          ),

                          // Shuffle
                          FilledButton.tonal(
                            onPressed: () {
                              if (playerController.isShuffleModeEnabled.isTrue) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbar(context,
                                        S.current.queueShufflingDeniedMsg,
                                        size: SanckBarSize.BIG));
                                return;
                              }
                              playerController.shuffleQueue();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Icon(Icons.shuffle_rounded, size: 20),
                          ),

                          // Clear queue
                          FilledButton.tonal(
                            onPressed: playerController.clearQueue,
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .errorContainer,
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Icon(Icons.playlist_remove_rounded,
                                size: 20),
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
