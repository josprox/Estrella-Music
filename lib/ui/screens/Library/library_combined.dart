import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:estrella_music/ui/widgets/create_playlist_dialog.dart';
import 'library.dart';
import 'package:estrella_music/generated/l10n.dart';

class CombinedLibrary extends StatelessWidget {
  const CombinedLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final tabCon = Get.put(CombinedLibraryController());
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            // toolbarHeight cero â€” toda la UI va en flexibleSpace
            toolbarHeight: 0,
            expandedHeight: topPadding + 112,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // â”€â”€ Fila tÃ­tulo + acciones â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.library_music_rounded,
                                color: cs.onPrimaryContainer, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Text(
                              S.current.library,
                              style: tt.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          // BotÃ³n crear playlist
                          FilledButton.tonalIcon(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (_) =>
                                  const CreateNRenamePlaylistPopup(),
                            ),
                            icon: const Icon(Icons.add_rounded, size: 18),
                            label: Text(S.current.playlists),
                            style: FilledButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                color: cs.surface,
                child: TabBar(
                  controller: tabCon.tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  indicator: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  labelColor: cs.onSecondaryContainer,
                  unselectedLabelColor: cs.onSurfaceVariant,
                  labelStyle:
                      tt.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: [
                    Tab(text: S.current.songs),
                    Tab(text: S.current.playlists),
                    Tab(text: S.current.albums),
                    Tab(text: S.current.artists),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: tabCon.tabController,
          children: const [
            SongsLibraryWidget(isBottomNavActive: true),
            PlaylistNAlbumLibraryWidget(
                isAlbumContent: false, isBottomNavActive: true),
            PlaylistNAlbumLibraryWidget(isBottomNavActive: true),
            LibraryArtistWidget(isBottomNavActive: true),
          ],
        ),
      ),
    );
  }
}

class CombinedLibraryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
