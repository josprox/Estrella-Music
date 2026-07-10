import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '/ui/screens/Search/search_screen_controller.dart';
import 'package:harmonymusic/ui/screens/Search/search_screen.dart';
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


// _GlassFab removed — replaced by standard FloatingActionButton above

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
                                _buildNewsCard(context),
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

                        return CustomScrollView(
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
                                  const SizedBox.shrink(),
                                  IconButton(
                                    icon: const Icon(Icons.settings_outlined,
                                        size: 30),
                                    onPressed: () {
                                      Get.to(
                                        () => const SettingsScreen(isBottomNavActive: false),
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

  Widget _buildNewsCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A00E0).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showNewsDetailsDialog(context),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.campaign_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "¡Estrella Music ha evolucionado!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Sincronización 100% con Joss Red, playlists con amigos y mucho más. Toca para ver lo nuevo.",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white70,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNewsDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0F1B26),
        title: const Row(
          children: [
            Icon(Icons.campaign_rounded, color: Color(0xFFFF9F1C)),
            SizedBox(width: 10),
            Text("Novedades de Estrella Music", style: TextStyle(color: Colors.white)),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNewsItem(
                Icons.cloud_done_rounded,
                "Integración Total con Joss Red",
                "Tus playlists y favoritos ahora se guardan y sincronizan en la nube automáticamente con tu cuenta principal de Joss Red.",
              ),
              const SizedBox(height: 12),
              _buildNewsItem(
                Icons.people_alt_rounded,
                "Playlists Colaborativas",
                "¡Crea listas de reproducción con tus amigos! Al crear una playlist, selecciona la casilla de Colaborativa y elige a tus amigos para que editen juntos.",
              ),
              const SizedBox(height: 12),
              _buildNewsItem(
                Icons.sync_rounded,
                "Sincronización Transparente",
                "Ya no necesitas dar clics a botones de sincronización manual; el nuevo motor se encarga de subir y bajar cambios automáticamente.",
              ),
              const Divider(color: Colors.white24, height: 24),
              const Text(
                "Gestión de Amigos y Cuenta:",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 8),
              const Text(
                "Para añadir amigos, aceptar solicitudes o gestionar tu perfil de seguridad, por favor utiliza Joss Red en sus plataformas oficiales:",
                style: TextStyle(color: Colors.white70, fontSize: 12.5, height: 1.4),
              ),
              const SizedBox(height: 14),
              _buildLinkButton(
                "Joss Red App (Play Store)",
                "https://play.google.com/store/apps/details?id=com.josprox.jossestrada",
              ),
              const SizedBox(height: 8),
              _buildLinkButton(
                "Joss Red Web",
                "https://app.joss.red/",
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Entendido", style: TextStyle(color: Color(0xFFFF9F1C), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF2EC4B6), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.5),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(color: Colors.white70, fontSize: 12.5, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkButton(String label, String url) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.open_in_new_rounded, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E2E3C),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
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
