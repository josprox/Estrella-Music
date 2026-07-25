import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/models/media_item_builder.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/widgets/song_download_btn.dart';
import 'package:harmonymusic/ui/widgets/song_status_badges.dart';
import 'image_widget.dart';
import 'snackbar.dart';
import 'songinfo_bottom_sheet.dart';

class UpNextQueueModal extends StatefulWidget {
  const UpNextQueueModal({super.key});

  @override
  State<UpNextQueueModal> createState() => _UpNextQueueModalState();
}

class _UpNextQueueModalState extends State<UpNextQueueModal> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription? _indexSubscription;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final playerController = Get.find<PlayerController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveIndex(playerController.currentSongIndex.value);
    });

    _indexSubscription = playerController.currentSongIndex.listen((index) {
      _scrollToActiveIndex(index);
    });
  }

  void _scrollToActiveIndex(int index) {
    if (_scrollController.hasClients) {
      final double targetOffset = index * 64.0;
      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double offset = targetOffset.clamp(0.0, maxScroll);
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _scrollController.hasClients) {
          final double targetOffset = index * 64.0;
          final double maxScroll = _scrollController.position.maxScrollExtent;
          final double offset = targetOffset.clamp(0.0, maxScroll);
          _scrollController.jumpTo(offset);
        }
      });
    }
  }

  @override
  void dispose() {
    _indexSubscription?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleLike(MediaItem song) async {
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final box = await SqliteStore.openBox("LIBFAV");
      final wasFavorite = box.containsKey(song.id);
      final track = MediaItemBuilder.toJson(song);
      await syncService.recordFavoriteChange(
        song.id,
        deleted: wasFavorite,
        track: track,
      );
      if (wasFavorite) {
        await box.delete(song.id);
      } else {
        await box.put(song.id, track);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(32),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Title & Close Button
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
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: S.current.search,
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List of tracks
          Expanded(
            child: Obx(() {
              final allQueue = playerController.currentQueue;
              final indexedItems = <MapEntry<int, MediaItem>>[];
              for (int i = 0; i < allQueue.length; i++) {
                final song = allQueue[i];
                if (_searchQuery.isEmpty ||
                    song.title.toLowerCase().contains(_searchQuery) ||
                    (song.artist?.toLowerCase().contains(_searchQuery) ??
                        false)) {
                  indexedItems.add(MapEntry(i, song));
                }
              }

              if (indexedItems.isEmpty && _searchQuery.isNotEmpty) {
                return Center(
                  child: Text(
                    S.current.searchRes,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(138),
                    ),
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 24),
                itemCount: indexedItems.length,
                itemBuilder: (context, idx) {
                  final entry = indexedItems[idx];
                  final realIndex = entry.key;
                  final song = entry.value;

                  return Obx(() {
                    final isPlaying =
                        playerController.currentSongIndex.value == realIndex;

                    return InkWell(
                      onTap: () {
                        playerController.seekByIndex(realIndex);
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                          constraints: const BoxConstraints(maxWidth: 500),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (ctx) => SongInfoBottomSheet(
                            song,
                            calledFromQueue: true,
                          ),
                        ).whenComplete(
                            () => Get.delete<SongInfoController>());
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: isPlaying
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(25)
                              : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              child: isPlaying
                                  ? Icon(
                                      Icons.equalizer_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary,
                                      size: 18,
                                    )
                                  : Text(
                                      '${realIndex + 1}',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withAlpha(97),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                            const SizedBox(width: 12),
                            SongStatusBadges(
                              songId: song.id,
                              child: ImageWidget(
                                size: 48,
                                song: song,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    song.artist ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withAlpha(138),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Heart Like Icon
                            ValueListenableBuilder(
                              valueListenable:
                                  SqliteStore.box("LIBFAV").listenable(),
                              builder: (context, SqliteBox box, _) {
                                final isLiked = box.containsKey(song.id);
                                return IconButton(
                                  onPressed: () => _toggleLike(song),
                                  icon: Icon(
                                    isLiked
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: isLiked
                                        ? Colors.red
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withAlpha(97),
                                    size: 20,
                                  ),
                                );
                              },
                            ),
                            // Download Icon
                            SongDownloadButton(song_: song),
                            // Options Icon (three dots ⋮ matching Image 1)
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  constraints:
                                      const BoxConstraints(maxWidth: 500),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0)),
                                  ),
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (ctx) => SongInfoBottomSheet(
                                    song,
                                    calledFromQueue: true,
                                  ),
                                ).whenComplete(
                                    () => Get.delete<SongInfoController>());
                              },
                              icon: Icon(
                                Icons.more_vert_rounded,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withAlpha(97),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class UpNextQueue extends StatefulWidget {
  const UpNextQueue({
    super.key,
    this.onReorderEnd,
    this.onReorderStart,
    this.isQueueInSlidePanel = true,
  });
  final void Function(int)? onReorderStart;
  final void Function(int)? onReorderEnd;
  final bool isQueueInSlidePanel;

  @override
  State<UpNextQueue> createState() => _UpNextQueueState();
}

class _UpNextQueueState extends State<UpNextQueue> {
  late PlayerController _playerController;
  final ScrollController _localScrollController = ScrollController();
  StreamSubscription? _indexSubscription;
  bool _userIsScrolling = false;

  @override
  void initState() {
    super.initState();
    _playerController = Get.find<PlayerController>();

    _indexSubscription = _playerController.currentSongIndex.listen((index) {
      _scrollToActiveIndex(index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveIndex(_playerController.currentSongIndex.value);
    });
  }

  @override
  void dispose() {
    _indexSubscription?.cancel();
    _localScrollController.dispose();
    super.dispose();
  }

  void _scrollToActiveIndex(int index) {
    if (_userIsScrolling) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = widget.isQueueInSlidePanel
          ? _playerController.scrollController
          : _localScrollController;
      if (controller.hasClients) {
        final double targetOffset = index * 64.0;
        final double maxScroll = controller.position.maxScrollExtent;
        final double offset = targetOffset.clamp(0.0, maxScroll);
        controller.animateTo(
          offset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          final ctrl = widget.isQueueInSlidePanel
              ? _playerController.scrollController
              : _localScrollController;
          if (mounted && ctrl.hasClients && !_userIsScrolling) {
            final double targetOffset = index * 64.0;
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

  void _toggleLike(MediaItem song) async {
    final syncService = Get.find<SyncService>();
    await syncService.performLocalMutation(() async {
      final box = await SqliteStore.openBox("LIBFAV");
      final wasFavorite = box.containsKey(song.id);
      final track = MediaItemBuilder.toJson(song);
      await syncService.recordFavoriteChange(
        song.id,
        deleted: wasFavorite,
        track: track,
      );
      if (wasFavorite) {
        await box.delete(song.id);
      } else {
        await box.put(song.id, track);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.isQueueInSlidePanel
          ? Theme.of(context).colorScheme.surface
          : Colors.transparent,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _userIsScrolling = true;
          } else if (notification is ScrollEndNotification) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) _userIsScrolling = false;
            });
          }
          return false;
        },
        child: Obx(() {
          final queueList = _playerController.currentQueue;
          final topPadding = widget.isQueueInSlidePanel ? 100.0 : 0.0;
          final bottomPadding = widget.isQueueInSlidePanel ? 80.0 : 0.0;

          return ReorderableListView.builder(
            footer: SizedBox(height: Get.mediaQuery.padding.bottom),
            scrollController: widget.isQueueInSlidePanel
                ? _playerController.scrollController
                : _localScrollController,
            // ignore: deprecated_member_use
            onReorder: (int oldIndex, int newIndex) {
              if (_playerController.isShuffleModeEnabled.isTrue) {
                ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
                  Get.context!,
                  S.current.queuerearrangingDeniedMsg,
                  size: SanckBarSize.BIG,
                ));
                return;
              }
              _playerController.onReorder(oldIndex, newIndex);
            },
            onReorderStart: widget.onReorderStart,
            onReorderEnd: widget.onReorderEnd,
            itemCount: queueList.length,
            padding: EdgeInsets.only(
              top: topPadding,
              bottom: bottomPadding,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final song = queueList[index];
              return Material(
                key: Key('${song.id}_$index'),
                color: Colors.transparent,
                child: _buildQueueItemTile(context, index, song),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildQueueItemTile(
      BuildContext context, int realIndex, MediaItem song) {
    return Obx(() {
      final isPlaying =
          _playerController.currentSongIndex.value == realIndex;

      return Dismissible(
        key: Key("queue_dismiss_${song.id}_$realIndex"),
        direction: DismissDirection.horizontal,
        confirmDismiss: (direction) async =>
            _playerController.currentSongIndex.value != realIndex,
        onDismissed: (direction) {
          _playerController.removeFromQueue(song);
        },
        child: InkWell(
          onTap: () {
            _playerController.seekByIndex(realIndex);
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
                song,
                calledFromQueue: true,
              ),
            ).whenComplete(() => Get.delete<SongInfoController>());
          },
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isPlaying
                  ? Theme.of(context).colorScheme.primary.withAlpha(25)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: isPlaying
                      ? Icon(
                          Icons.equalizer_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 18,
                        )
                      : Text(
                          '${realIndex + 1}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(97),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                ),
                const SizedBox(width: 12),
                SongStatusBadges(
                  songId: song.id,
                  child: ImageWidget(
                    size: 48,
                    song: song,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        song.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        song.artist ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(138),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: SqliteStore.box("LIBFAV").listenable(),
                  builder: (context, SqliteBox box, _) {
                    final isLiked = box.containsKey(song.id);
                    return IconButton(
                      onPressed: () => _toggleLike(song),
                      icon: Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isLiked
                            ? Colors.red
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(97),
                        size: 20,
                      ),
                    );
                  },
                ),
                SongDownloadButton(song_: song),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      constraints: const BoxConstraints(maxWidth: 500),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10.0)),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => SongInfoBottomSheet(
                        song,
                        calledFromQueue: true,
                      ),
                    ).whenComplete(() => Get.delete<SongInfoController>());
                  },
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(97),
                    size: 20,
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
