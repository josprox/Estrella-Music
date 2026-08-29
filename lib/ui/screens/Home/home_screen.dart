import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/screens/Search/search_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Search/search_screen.dart';
import 'package:harmonymusic/ui/widgets/home_profile_card.dart';
import '/ui/widgets/animated_screen_transition.dart';

import 'package:harmonymusic/ui/widgets/side_nav_bar.dart';
import 'package:harmonymusic/ui/screens/Library/library.dart';

import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import '/ui/widgets/create_playlist_dialog.dart';
import 'package:harmonymusic/ui/navigator.dart';
import 'package:harmonymusic/ui/widgets/content_list_widget.dart';
import 'package:harmonymusic/ui/widgets/quickpickswidget.dart';
import 'package:harmonymusic/ui/widgets/shimmer_widgets/home_shimmer.dart';
import 'home_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen.dart';
import 'package:harmonymusic/ui/screens/Friends/friends_management_screen.dart';
import '/models/quick_picks.dart';

import '/ui/theme/app_spacing.dart';
import 'package:harmonymusic/ui/widgets/home_custom_sections.dart';
import 'package:harmonymusic/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find<PlayerController>();
    final HomeScreenController homeScreenController =
        Get.find<HomeScreenController>();
    final SettingsScreenController settingsScreenController =
        Get.find<SettingsScreenController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Obx(
        () => ((homeScreenController.tabIndex.value == 0 &&
                        !GetPlatform.isDesktop) ||
                    homeScreenController.tabIndex.value == 1) &&
                settingsScreenController.isBottomNavBarEnabled.isFalse
            ? Obx(
                () => Padding(
                  padding: EdgeInsets.only(
                    bottom: playerController.playerPanelMinHeight.value >
                            Get.mediaQuery.padding.bottom
                        ? playerController.playerPanelMinHeight.value -
                            Get.mediaQuery.padding.bottom
                        : playerController.playerPanelMinHeight.value,
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (homeScreenController.tabIndex.value == 1) {
                        showDialog(
                            context: context,
                            builder: (_) => const CreateNRenamePlaylistPopup());
                      } else {
                        Get.toNamed(ScreenNavigationSetup.searchScreen,
                            id: ScreenNavigationSetup.id);
                      }
                    },
                    child: Icon(
                      homeScreenController.tabIndex.value == 1
                          ? Icons.add_rounded
                          : Icons.search_rounded,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
      body: Obx(
        () => Row(
          children: [
            settingsScreenController.isBottomNavBarEnabled.isFalse
                ? const SideNavBar()
                : const SizedBox(width: 0),
            Expanded(
              child: Obx(() => AnimatedScreenTransition(
                    enabled: settingsScreenController
                        .isTransitionAnimationDisabled.isFalse,
                    resverse: homeScreenController.reverseAnimationtransiton,
                    horizontalTransition:
                        settingsScreenController.isBottomNavBarEnabled.isTrue,
                    child: Center(
                      key: ValueKey<int>(homeScreenController.tabIndex.value),
                      child: const Body(),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// _GlassFab removed â€” replaced by standard FloatingActionButton above

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenController = Get.find<HomeScreenController>();
    final settingsScreenController = Get.find<SettingsScreenController>();

    final leftPadding =
        settingsScreenController.isBottomNavBarEnabled.isTrue ? 20.0 : 8.0;

    if (homeScreenController.tabIndex.value == 0) {
      return Padding(
        padding: EdgeInsets.only(left: leftPadding),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                if (GetPlatform.isDesktop) {
                  final sscontroller = Get.find<SearchScreenController>();
                  if (sscontroller.focusNode.hasFocus) {
                    sscontroller.focusNode.unfocus();
                  }
                }
              },
              child: Obx(
                () => homeScreenController.networkError.isTrue
                    ? _NetworkError(
                        onRetry: homeScreenController.loadContentFromNetwork)
                    : Obx(() {
                        homeScreenController.disposeDetachedScrollControllers();

                        final items = homeScreenController
                                .isContentFetched.value
                            ? [
                                const HomeProfileCard(),
                                Obx(() {
                                  final sc = ScrollController();
                                  homeScreenController.contentScrollControllers
                                      .add(sc);
                                  return QuickPicksWidget(
                                      content:
                                          homeScreenController.quickPicks.value,
                                      scrollController: sc);
                                }),
                                Obx(() => homeScreenController
                                        .mostListened.isEmpty
                                    ? const SizedBox.shrink()
                                    : MostListenedWidget(
                                        content:
                                            homeScreenController.mostListened)),
                                Obx(() =>
                                    homeScreenController.randomMusic.value !=
                                            null
                                        ? QuickPicksWidget(
                                            content: homeScreenController
                                                .randomMusic.value!)
                                        : const SizedBox.shrink()),
                                Obx(() => homeScreenController
                                            .forgottenFavorites.value !=
                                        null
                                    ? QuickPicksWidget(
                                        content: homeScreenController
                                            .forgottenFavorites.value!)
                                    : const SizedBox.shrink()),
                                // ?? Daily Discover (Metrolist parity) ??
                                Obx(() =>
                                    homeScreenController.dailyDiscover.value !=
                                            null
                                        ? QuickPicksWidget(
                                            content: homeScreenController
                                                .dailyDiscover.value!)
                                        : const SizedBox.shrink()),
                                // ?? Keep Listening ??
                                Obx(() =>
                                    homeScreenController.keepListening.value !=
                                            null
                                        ? QuickPicksWidget(
                                            content: homeScreenController
                                                .keepListening.value!)
                                        : const SizedBox.shrink()),
                                // ?? Similar Recommendations ??
                                Obx(() => homeScreenController
                                            .similarRecommendations.value !=
                                        null
                                    ? QuickPicksWidget(
                                        content: homeScreenController
                                            .similarRecommendations.value!)
                                    : const SizedBox.shrink()),
                                // ?? Community Playlists ??
                                Obx(() => homeScreenController
                                            .communityPlaylists.value !=
                                        null
                                    ? QuickPicksWidget(
                                        content: homeScreenController
                                            .communityPlaylists.value!)
                                    : const SizedBox.shrink()),
                                ...getWidgetList(
                                    homeScreenController.middleContent,
                                    homeScreenController),
                                ...getWidgetList(
                                    homeScreenController.fixedContent,
                                    homeScreenController),
                              ]
                            : [const HomeShimmer()];

                        return RefreshIndicator(
                          onRefresh: () => homeScreenController.loadContent(),
                          child: CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            slivers: [
                              SliverAppBar(
                                floating: true,
                                surfaceTintColor:
                                    Theme.of(context).colorScheme.surface,
                                backgroundColor:
                                    Theme.of(context).colorScheme.surface,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current
                                          .home, // Can use exploreDiscover if available in localized strings
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.group_add_rounded,
                                          size: 30),
                                      tooltip: S.current.friends,
                                      onPressed: () {
                                        Get.to(
                                          () => const FriendsManagementScreen(),
                                          id: ScreenNavigationSetup.id,
                                          transition: Transition.rightToLeft,
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.settings_outlined,
                                          size: 30),
                                      onPressed: () {
                                        Get.to(
                                          () => const SettingsScreen(
                                              isBottomNavActive: false),
                                          id: ScreenNavigationSetup.id,
                                          transition: Transition.rightToLeft,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SliverPadding(
                                padding:
                                    const EdgeInsets.only(bottom: 200, top: 15),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (_, i) => items[i],
                                    childCount: items.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
              ),
            ),
          ],
        ),
      );
    } else if (homeScreenController.tabIndex.value == 1) {
      return settingsScreenController.isBottomNavBarEnabled.isTrue
          ? const SongsLibraryWidget(isBottomNavActive: true)
          : const SongsLibraryWidget();
    } else if (homeScreenController.tabIndex.value == 2) {
      return const SearchScreen();
    } else if (homeScreenController.tabIndex.value == 3) {
      return settingsScreenController.isBottomNavBarEnabled.isTrue
          ? const PlaylistNAlbumLibraryWidget(
              isAlbumContent: true, isBottomNavActive: true)
          : const PlaylistNAlbumLibraryWidget(isAlbumContent: true);
    } else if (homeScreenController.tabIndex.value == 4) {
      return settingsScreenController.isBottomNavBarEnabled.isTrue
          ? const LibraryArtistWidget(isBottomNavActive: true)
          : const LibraryArtistWidget();
    } else if (homeScreenController.tabIndex.value == 5) {
      return settingsScreenController.isBottomNavBarEnabled.isTrue
          ? const PlaylistNAlbumLibraryWidget(
              isAlbumContent: false, isBottomNavActive: true)
          : const PlaylistNAlbumLibraryWidget(isAlbumContent: false);
    } else {
      return Center(child: Text('${homeScreenController.tabIndex.value}'));
    }
  }

  List<Widget> getWidgetList(
      dynamic list, HomeScreenController homeScreenController) {
    return list
        .map((content) {
          final sc = ScrollController();
          homeScreenController.contentScrollControllers.add(sc);
          if (content.runtimeType == QuickPicks) {
            return QuickPicksWidget(content: content, scrollController: sc);
          }
          return ContentListWidget(content: content, scrollController: sc);
        })
        .whereType<Widget>()
        .toList();
  }
}

class _NetworkError extends StatelessWidget {
  final VoidCallback onRetry;
  const _NetworkError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 180,
      child: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(S.current.home, style: tt.headlineSmall),
        ),
        Expanded(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.wifi_off_rounded,
                  size: 64, color: cs.onSurface.withValues(alpha: 0.3)),
              const SizedBox(height: AppSpacing.lg),
              Text(S.current.networkError1,
                  style: tt.titleMedium
                      ?.copyWith(color: cs.onSurface.withValues(alpha: 0.6))),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(S.current.retry),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
