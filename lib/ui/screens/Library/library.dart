import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/widgets/modification_list.dart';
import 'package:harmonymusic/models/playlist.dart';
import 'package:harmonymusic/ui/widgets/piped_sync_widget.dart';
import 'library_controller.dart';
import 'package:harmonymusic/ui/widgets/content_list_widget_item.dart';
import 'package:harmonymusic/ui/widgets/list_widget.dart';
import 'package:harmonymusic/ui/widgets/sort_widget.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/generated/l10n.dart';

class SongsLibraryWidget extends StatelessWidget {
  const SongsLibraryWidget({super.key, this.isBottomNavActive = false});
  final bool isBottomNavActive;

  Widget _buildExpressiveTitle(BuildContext context, String title) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 16, right: 16),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = context.isLandscape ? 30.0 : 70.0;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: isBottomNavActive ? 18.0 : topPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildExpressiveTitle(context, S.current.libSongs),
          GetX<LibrarySongsController>(builder: (controller) {
            final filters = <({
              LibrarySongCollection collection,
              IconData icon,
              String label,
            })>[
              (
                collection: LibrarySongCollection.favorites,
                icon: Icons.favorite_rounded,
                label: S.current.favorites,
              ),
              (
                collection: LibrarySongCollection.downloads,
                icon: Icons.download_done_rounded,
                label: S.current.downloads,
              ),
              (
                collection: LibrarySongCollection.recent,
                icon: Icons.history_rounded,
                label: S.current.recentlyPlayed,
              ),
              if (controller.hasMigratedLibrary.isTrue)
                (
                  collection: LibrarySongCollection.migrated,
                  icon: Icons.move_to_inbox_rounded,
                  label: S.current.migratedLibrary,
                ),
            ];

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: filters
                    .map((filter) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            avatar: Icon(filter.icon, size: 18),
                            label: Text(filter.label),
                            selected: controller.selectedCollection.value ==
                                filter.collection,
                            showCheckmark: false,
                            selectedColor: colorScheme.secondaryContainer,
                            labelStyle: TextStyle(
                              color: controller.selectedCollection.value ==
                                      filter.collection
                                  ? colorScheme.onSecondaryContainer
                                  : colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                            onSelected:
                                controller.additionalOperationMode.value ==
                                        OperationMode.none
                                    ? (_) => controller
                                        .selectCollection(filter.collection)
                                    : null,
                          ),
                        ))
                    .toList(),
              ),
            );
          }),
          Obx(() {
            final libSongsController = Get.find<LibrarySongsController>();
            return Container(
              margin: const EdgeInsets.only(bottom: 12.0, top: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.08),
                ),
              ),
              child: SortWidget(
                tag: "LibSongSort",
                screenController: libSongsController,
                itemCountTitle: "${libSongsController.librarySongsList.length}",
                itemIcon: Icons.music_note,
                titleLeftPadding: 9,
                requiredSortTypes: buildSortTypeSet(true, true),
                isSearchFeatureRequired: true,
                isSongDeletetioFeatureRequired:
                    libSongsController.selectedCollection.value ==
                        LibrarySongCollection.downloads,
                onSort: (type, ascending) {
                  libSongsController.onSort(type, ascending);
                },
                onSearch: libSongsController.onSearch,
                onSearchClose: libSongsController.onSearchClose,
                onSearchStart: libSongsController.onSearchStart,
                startAdditionalOperation:
                    libSongsController.startAdditionalOperation,
                selectAll: libSongsController.selectAll,
                performAdditionalOperation:
                    libSongsController.performAdditionalOperation,
                cancelAdditionalOperation:
                    libSongsController.cancelAdditionalOperation,
              ),
            );
          }),
          GetX<LibrarySongsController>(builder: (controller) {
            return controller.librarySongsList.isNotEmpty
                ? (controller.additionalOperationMode.value ==
                        OperationMode.none
                    ? ListWidget(
                        controller.librarySongsList,
                        "library Songs",
                        true,
                        isPlaylistOrAlbum: true,
                        playlist: Playlist(
                            title: S.current.libSongs,
                            playlistId: controller.selectedCollectionBoxId,
                            thumbnailUrl: "",
                            isCloudPlaylist: false),
                      )
                    : ModificationList(
                        mode: controller.additionalOperationMode.value,
                        screenController: controller,
                      ))
                : Expanded(
                    child: Center(
                        child: Text(
                      controller.selectedCollection.value ==
                              LibrarySongCollection.downloads
                          ? S.current.noOfflineSong
                          : S.current.noSongsInCollection,
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                  );
          })
        ],
      ),
    );
  }
}

class PlaylistNAlbumLibraryWidget extends StatelessWidget {
  const PlaylistNAlbumLibraryWidget(
      {super.key, this.isAlbumContent = true, this.isBottomNavActive = false});
  final bool isAlbumContent;
  final bool isBottomNavActive;

  Widget _buildExpressiveTitle(BuildContext context, String title) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 16, right: 16),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final libralbumCntrller = Get.find<LibraryAlbumsController>();
    final librplstCntrller = Get.find<LibraryPlaylistsController>();
    final settingscrnController = Get.find<SettingsScreenController>();

    const double itemHeight = 180;
    const double itemWidth = 130;
    final topPadding = context.isLandscape ? 30.0 : 70.0;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: isBottomNavActive ? 18.0 : topPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              _buildExpressiveTitle(
                context,
                isAlbumContent ? S.current.libAlbums : S.current.libPlaylists,
              ),
              if (!(settingscrnController.isBottomNavBarEnabled.isTrue ||
                  isAlbumContent ||
                  settingscrnController.isLinkedWithPiped.isFalse))
                const Positioned(
                  right: 0,
                  child: PipedSyncWidget(
                    padding: EdgeInsets.zero,
                  ),
                )
            ],
          ),
          if (isAlbumContent)
            Obx(() {
              final filters = [
                (
                  collection: LibraryAlbumCollection.tastes,
                  icon: Icons.auto_awesome_rounded,
                  label: S.current.albumsByTaste,
                ),
                (
                  collection: LibraryAlbumCollection.saved,
                  icon: Icons.bookmark_rounded,
                  label: S.current.savedAlbums,
                ),
                (
                  collection: LibraryAlbumCollection.recommended,
                  icon: Icons.recommend_rounded,
                  label: S.current.recommendedAlbums,
                ),
              ];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: filters
                      .map((filter) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              avatar: Icon(filter.icon, size: 18),
                              label: Text(filter.label),
                              selected:
                                  libralbumCntrller.selectedCollection.value ==
                                      filter.collection,
                              showCheckmark: false,
                              selectedColor: colorScheme.secondaryContainer,
                              labelStyle: TextStyle(
                                color: libralbumCntrller
                                            .selectedCollection.value ==
                                        filter.collection
                                    ? colorScheme.onSecondaryContainer
                                    : colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) => libralbumCntrller
                                  .selectCollection(filter.collection),
                            ),
                          ))
                      .toList(),
                ),
              );
            }),
          Obx(
            () => Container(
              margin: const EdgeInsets.only(bottom: 12.0, top: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.08),
                ),
              ),
              child: isAlbumContent
                  ? SortWidget(
                      tag: "LibAlbumSort",
                      screenController: libralbumCntrller,
                      isAdditionalOperationRequired: false,
                      isSearchFeatureRequired: true,
                      itemCountTitle:
                          "${libralbumCntrller.libraryAlbums.length} ${S.current.items}",
                      requiredSortTypes: buildSortTypeSet(true),
                      onSort: (type, ascending) {
                        libralbumCntrller.onSort(type, ascending);
                      },
                      onSearch: libralbumCntrller.onSearch,
                      onSearchClose: libralbumCntrller.onSearchClose,
                      onSearchStart: libralbumCntrller.onSearchStart,
                    )
                  : SortWidget(
                      tag: "LibPlaylistSort",
                      screenController: librplstCntrller,
                      isAdditionalOperationRequired: false,
                      isSearchFeatureRequired: true,
                      itemCountTitle:
                          "${librplstCntrller.libraryPlaylists.length} ${S.current.items}",
                      requiredSortTypes: buildSortTypeSet(),
                      onSort: (type, ascending) {
                        librplstCntrller.onSort(type, ascending);
                      },
                      onSearch: librplstCntrller.onSearch,
                      onSearchClose: librplstCntrller.onSearchClose,
                      onSearchStart: librplstCntrller.onSearchStart,
                      isImportFeatureRequired: true,
                    ),
            ),
          ),
          Expanded(
            child: Obx(
              () => (isAlbumContent &&
                      libralbumCntrller.isLoadingRecommended.isTrue)
                  ? const Center(child: CircularProgressIndicator())
                  : (isAlbumContent
                          ? libralbumCntrller.libraryAlbums.isNotEmpty
                          : librplstCntrller.libraryPlaylists.isNotEmpty)
                      ? LayoutBuilder(builder: (context, constraints) {
                          final availableWidth = constraints.maxWidth > 300 &&
                                  constraints.maxWidth < 394
                              ? 310.0
                              : constraints.maxWidth;
                          final isMobile = availableWidth < 600;
                          final int columns = isMobile
                              ? 3
                              : (availableWidth / itemWidth).floor();

                          final currentItemWidth = isMobile
                              ? (availableWidth / columns) - 4
                              : itemWidth;
                          final currentItemHeight = isMobile
                              ? (currentItemWidth * (itemHeight / itemWidth))
                              : itemHeight;
                          final currentImageSize =
                              isMobile ? (currentItemWidth - 10) : 120.0;

                          return SizedBox(
                            width: availableWidth,
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  childAspectRatio:
                                      (currentItemWidth / currentItemHeight),
                                ),
                                controller:
                                    ScrollController(keepScrollOffset: false),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding:
                                    const EdgeInsets.only(bottom: 200, top: 10),
                                itemCount: isAlbumContent
                                    ? libralbumCntrller.libraryAlbums.length
                                    : librplstCntrller.libraryPlaylists.length,
                                itemBuilder: (context, index) => Center(
                                      child: ContentListItem(
                                        content: isAlbumContent
                                            ? libralbumCntrller
                                                .libraryAlbums[index]
                                            : librplstCntrller
                                                .libraryPlaylists[index],
                                        isLibraryItem: true,
                                        width:
                                            isMobile ? currentItemWidth : null,
                                        height:
                                            isMobile ? currentItemHeight : null,
                                        imageSize:
                                            isMobile ? currentImageSize : null,
                                      ),
                                    )),
                          );
                        })
                      : Center(
                          child: Text(
                          S.current.noBookmarks,
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
            ),
          )
        ],
      ),
    );
  }
}

class LibraryArtistWidget extends StatelessWidget {
  const LibraryArtistWidget({super.key, this.isBottomNavActive = false});
  final bool isBottomNavActive;

  Widget _buildExpressiveTitle(BuildContext context, String title) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 16, right: 16),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1.0,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cntrller = Get.find<LibraryArtistsController>();
    final topPadding = context.isLandscape ? 30.0 : 70.0;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: isBottomNavActive ? 18.0 : topPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildExpressiveTitle(context, S.current.libArtists),
          Obx(() {
            final filters = [
              (
                collection: LibraryArtistCollection.tastes,
                icon: Icons.auto_awesome_rounded,
                label: S.current.artistsByTaste,
              ),
              (
                collection: LibraryArtistCollection.followed,
                icon: Icons.favorite_rounded,
                label: S.current.followedArtists,
              ),
              (
                collection: LibraryArtistCollection.recommended,
                icon: Icons.recommend_rounded,
                label: S.current.recommendedArtists,
              ),
            ];
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: filters
                    .map((filter) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            avatar: Icon(filter.icon, size: 18),
                            label: Text(filter.label),
                            selected: cntrller.selectedCollection.value ==
                                filter.collection,
                            showCheckmark: false,
                            selectedColor: colorScheme.secondaryContainer,
                            labelStyle: TextStyle(
                              color: cntrller.selectedCollection.value ==
                                      filter.collection
                                  ? colorScheme.onSecondaryContainer
                                  : colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                            onSelected: (_) =>
                                cntrller.selectCollection(filter.collection),
                          ),
                        ))
                    .toList(),
              ),
            );
          }),
          Obx(
            () => Container(
              margin: const EdgeInsets.only(bottom: 12.0, top: 4.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.08),
                ),
              ),
              child: SortWidget(
                tag: "LibArtistSort",
                screenController: cntrller,
                isAdditionalOperationRequired: false,
                isSearchFeatureRequired: true,
                itemIcon: Icons.people_outline,
                itemCountTitle:
                    "${cntrller.libraryArtists.length} ${S.current.items}",
                onSort: (type, ascending) {
                  cntrller.onSort(type, ascending);
                },
                onSearch: cntrller.onSearch,
                onSearchClose: cntrller.onSearchClose,
                onSearchStart: cntrller.onSearchStart,
              ),
            ),
          ),
          Obx(() {
            if (cntrller.isLoadingRecommended.isTrue &&
                cntrller.selectedCollection.value ==
                    LibraryArtistCollection.recommended) {
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return cntrller.libraryArtists.isNotEmpty
                ? ListWidget(cntrller.libraryArtists, "Library Artists", true)
                : Expanded(
                    child: Center(
                      child: Text(
                        S.current.noBookmarks,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
