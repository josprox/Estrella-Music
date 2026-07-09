import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'custom_marquee.dart';

import 'image_widget.dart';
import 'snackbar.dart';
import 'songinfo_bottom_sheet.dart';
import 'package:harmonymusic/generated/l10n.dart';

class UpNextQueue extends StatefulWidget {
  const UpNextQueue(
      {super.key,
      this.onReorderEnd,
      this.onReorderStart,
      this.isQueueInSlidePanel = true});
  final void Function(int)? onReorderStart;
  final void Function(int)? onReorderEnd;
  final bool isQueueInSlidePanel;

  @override
  State<UpNextQueue> createState() => _UpNextQueueState();
}

class _UpNextQueueState extends State<UpNextQueue> {
  late PlayerController _playerController;
  StreamSubscription? _indexSubscription;
  bool _userIsScrolling = false;

  @override
  void initState() {
    super.initState();
    _playerController = Get.find<PlayerController>();
    
    // Auto-scroll only when the song index changes
    _indexSubscription = _playerController.currentSongIndex.listen((index) {
      _scrollToActiveIndex(index);
    });

    // Auto-scroll on initial build (once)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveIndex(_playerController.currentSongIndex.value);
    });
  }

  @override
  void dispose() {
    _indexSubscription?.cancel();
    super.dispose();
  }

  void _scrollToActiveIndex(int index) {
    if (!widget.isQueueInSlidePanel) return;
    if (_userIsScrolling) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = _playerController.scrollController;
      if (controller.hasClients) {
        final double targetOffset = index * 72.0;
        final double maxScroll = controller.position.maxScrollExtent;
        final double offset = targetOffset.clamp(0.0, maxScroll);
        controller.animateTo(
          offset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && _playerController.scrollController.hasClients && !_userIsScrolling) {
            final ctrl = _playerController.scrollController;
            final double targetOffset = index * 72.0;
            final double maxScroll = ctrl.position.maxScrollExtent;
            final double offset = targetOffset.clamp(0.0, maxScroll);
            ctrl.animateTo(
              offset,
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: No auto-scroll here — it only triggers via the index subscription above
    return Container(
      color: widget.isQueueInSlidePanel
          ? Theme.of(context).bottomSheetTheme.backgroundColor
          : Colors.transparent,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _userIsScrolling = true;
          } else if (notification is ScrollEndNotification) {
            // Give a short grace period before re-enabling auto-scroll
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) _userIsScrolling = false;
            });
          }
          return false;
        },
        child: Obx(() {
          return ReorderableListView.builder(
            footer: SizedBox(height: Get.mediaQuery.padding.bottom),
            scrollController:
                widget.isQueueInSlidePanel ? _playerController.scrollController : null,
            // ignore: deprecated_member_use
            onReorder: (int oldIndex, int newIndex) {
              if (_playerController.isShuffleModeEnabled.isTrue) {
                ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
                    Get.context!, S.current.queuerearrangingDeniedMsg,
                    size: SanckBarSize.BIG));
                return;
              }
              _playerController.onReorder(oldIndex, newIndex);
            },
            onReorderStart: widget.onReorderStart,
            onReorderEnd: widget.onReorderEnd,
            itemCount: _playerController.currentQueue.length,
            padding: EdgeInsets.only(
                top: widget.isQueueInSlidePanel ? 55 : 0,
                bottom: widget.isQueueInSlidePanel ? 80 : 0),
            physics: const AlwaysScrollableScrollPhysics(),

          itemBuilder: (context, index) {
            final homeScaffoldContext =
                _playerController.homeScaffoldkey.currentContext!;
            return Material(
              key: Key('$index'),
              child: Obx(
                () => Dismissible(
                  key: Key(_playerController.currentQueue[index].id),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (direction) async =>
                      _playerController.currentSongIndex.value != index,
                  onDismissed: (direction) {
                    _playerController
                        .removeFromQueue(_playerController.currentQueue[index]);
                  },
                  child: ListTile(
                    onTap: () {
                      _playerController.seekByIndex(index);
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        constraints: const BoxConstraints(maxWidth: 500),
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10.0)),
                        ),

                        isScrollControlled: true,
                        context: _playerController
                            .homeScaffoldkey.currentState!.context,

                        builder: (context) => SongInfoBottomSheet(
                          _playerController.currentQueue[index],
                          calledFromQueue: true,
                        ),
                      ).whenComplete(() => Get.delete<SongInfoController>());
                    },
                    contentPadding: EdgeInsets.only(
                        top: 0,
                        left: GetPlatform.isAndroid ? 30 : 0,
                        right: 25),
                    tileColor: _playerController.currentSongIndex.value == index
                        ? Theme.of(homeScaffoldContext).colorScheme.secondary
                        : Theme.of(homeScaffoldContext)
                            .bottomSheetTheme
                            .backgroundColor,
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (GetPlatform.isDesktop)
                          IconButton(
                              onPressed: () {
                                if (_playerController.currentSongIndex.value ==
                                    index) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackbar(
                                          context,
                                          S.current
                                              .songRemovedfromQueueCurrSong,
                                          size: SanckBarSize.BIG));
                                } else {
                                  _playerController.removeFromQueue(
                                      _playerController.currentQueue[index]);
                                }
                              },
                              icon: const Icon(Icons.close)),
                        ImageWidget(
                          size: 50,
                          song: _playerController.currentQueue[index],
                        ),
                      ],
                    ),
                    title: Marquee(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(seconds: 5),
                      id: "queue${_playerController.currentQueue[index].title.hashCode}",
                      child: Text(
                        _playerController.currentQueue[index].title,
                        maxLines: 1,
                        style:
                            Theme.of(homeScaffoldContext).textTheme.titleMedium,
                      ),
                    ),
                    subtitle: Text(
                      "${_playerController.currentQueue[index].artist}",
                      maxLines: 1,
                      style: _playerController.currentSongIndex.value == index
                          ? Theme.of(homeScaffoldContext)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  color: Theme.of(homeScaffoldContext)
                                      .textTheme
                                      .titleMedium!
                                      .color!
                                      .withValues(alpha: 0.35))
                          : Theme.of(homeScaffoldContext).textTheme.titleSmall,
                    ),
                    trailing: ReorderableDragStartListener(
                      enabled: !GetPlatform.isDesktop,
                      index: index,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: (GetPlatform.isDesktop) ? 20 : 5, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (!GetPlatform.isDesktop)
                              const Icon(
                                Icons.drag_handle,
                              ),
                            _playerController.currentSongIndex.value == index
                                ? const Icon(
                                    Icons.equalizer,
                                    color: Colors.white,
                                  )
                                : Text(
                                    _playerController.currentQueue[index]
                                            .extras!['length'] ??
                                        "",
                                    style: Theme.of(homeScaffoldContext)
                                        .textTheme
                                        .titleSmall,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      ),  // NotificationListener
    );
  }
}
