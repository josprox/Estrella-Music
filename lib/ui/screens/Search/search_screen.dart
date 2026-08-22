import 'dart:ui';
import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';

import '/ui/navigator.dart';
import '/ui/screens/Settings/settings_screen_controller.dart';
import 'package:harmonymusic/ui/widgets/nebula_background.dart';
import 'components/search_item.dart';
import 'components/music_recognition_bottom_sheet.dart';
import 'search_screen_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchScreenController = Get.put(SearchScreenController());
    final settingsScreenController = Get.find<SettingsScreenController>();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Stack(
          children: [
            NebulaBackground(seedString: searchScreenController.searchText),
            SafeArea(
              bottom: false,
              child: Row(
                children: [
                  if (settingsScreenController.isBottomNavBarEnabled.isFalse)
                    Container(
                      width: 60,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: context.isLandscape ? 10.0 : 20.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Theme.of(context).textTheme.titleMedium!.color,
                              ),
                              onPressed: () {
                                Get.nestedKey(ScreenNavigationSetup.id)!
                                    .currentState!
                                    .pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        _ExpressiveTitleSliver(controller: searchScreenController),
                        _SearchBarSliver(controller: searchScreenController),
                        _ExpressiveGridCategoriesSliver(controller: searchScreenController),
                        _RecentSearchesHeaderSliver(controller: searchScreenController),
                        _RecentSearchesSliver(controller: searchScreenController),
                        _SearchResultsSliver(controller: searchScreenController),
                        const SliverPadding(padding: EdgeInsets.only(bottom: 220)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpressiveTitleSliver extends StatelessWidget {
  final SearchScreenController controller;
  const _ExpressiveTitleSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.searchText.value.isNotEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0, bottom: 8.0),
          child: Text(
            S.current.search,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      );
    });
  }
}

class _SearchBarSliver extends StatelessWidget {
  final SearchScreenController controller;

  const _SearchBarSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SearchBarDelegate(controller: controller),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final SearchScreenController controller;

  const _SearchBarDelegate({required this.controller});

  @override
  double get minExtent => 76;
  @override
  double get maxExtent => 76;

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) => false;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withValues(alpha: 0.18)
                  : Colors.white.withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.06),
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 18),
                Icon(
                  Icons.search_rounded,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.65),
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller.textInputController,
                    focusNode: controller.focusNode,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textInputAction: TextInputAction.search,
                    onChanged: controller.onChanged,
                    onSubmitted: (val) {
                      if (val.contains("https://")) {
                        controller.filterLinks(Uri.parse(val));
                        controller.reset();
                        return;
                      }
                      Get.toNamed(ScreenNavigationSetup.searchResultScreen,
                          id: ScreenNavigationSetup.id, arguments: val);
                      controller.addToHistryQueryList(val);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14),
                      hintText: S.current.searchDes,
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.4),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Obx(() => controller.searchText.value.isNotEmpty
                    ? IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          Icons.close_rounded,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6),
                          size: 20,
                        ),
                        onPressed: controller.reset,
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              Icons.mic_rounded,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.7),
                              size: 22,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,

                                builder: (context) =>
                                    const MusicRecognitionBottomSheet(),
                              );
                            },
                          ),
                          const SizedBox(width: 4),
                        ],
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpressiveGridCategoriesSliver extends StatelessWidget {
  final SearchScreenController controller;

  const _ExpressiveGridCategoriesSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 1200 ? 5 : (width > 800 ? 3 : 2);
    final childAspectRatio = width > 800 ? 1.8 : 1.6;

    return Obx(() {
      if (controller.searchText.value.isNotEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: childAspectRatio,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final category = controller.categories[index];
              return _CategoryCard(
                category: category,
                onTap: () {
                  Get.toNamed(ScreenNavigationSetup.searchResultScreen,
                      id: ScreenNavigationSetup.id, arguments: category.name);
                  controller.addToHistryQueryList(category.name);
                },
              );
            },
            childCount: controller.categories.length,
          ),
        ),
      );
    });
  }
}

class _CategoryCard extends StatefulWidget {
  final SearchCategory category;
  final VoidCallback onTap;

  const _CategoryCard({required this.category, required this.onTap});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.04 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.category.color.withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: widget.onTap,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  Image.network(
                    widget.category.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: widget.category.color.withValues(alpha: 0.2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: widget.category.color.withValues(alpha: 0.25),
                      );
                    },
                  ),
                  // Gradient Overlay matching Category color
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          widget.category.color.withValues(alpha: _isHovered ? 0.90 : 0.80),
                          widget.category.color.withValues(alpha: _isHovered ? 0.35 : 0.20),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.category.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentSearchesHeaderSliver extends StatelessWidget {
  final SearchScreenController controller;

  const _RecentSearchesHeaderSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.searchText.value.isNotEmpty || controller.historyQuerylist.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 8.0),
          child: Text(
            S.current.recentSearches,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  letterSpacing: -0.2,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
          ),
        ),
      );
    });
  }
}

class _RecentSearchesSliver extends StatelessWidget {
  final SearchScreenController controller;

  const _RecentSearchesSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.searchText.value.isNotEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      final list = controller.historyQuerylist;
      if (list.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final query = list[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Material(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.04),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(ScreenNavigationSetup.searchResultScreen,
                            id: ScreenNavigationSetup.id, arguments: query);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.history_rounded,
                                size: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                query,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.9),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: Icon(
                                Icons.close_rounded,
                                size: 18,
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                              ),
                              onPressed: () => controller.removeQueryFromHistory(query),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    });
  }
}

class _SearchResultsSliver extends StatelessWidget {
  final SearchScreenController controller;

  const _SearchResultsSliver({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.searchText.value.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      if (controller.urlPasted.isTrue) {
        return SliverToBoxAdapter(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
              child: InkWell(
                onTap: () {
                  controller.filterLinks(Uri.parse(controller.textInputController.text));
                  controller.reset();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Text(
                    S.current.urlSearchDes,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }

      final combinedList = <Map<String, dynamic>>[];
      
      for (var query in controller.filteredHistory) {
        combinedList.add({'query': query, 'isHistory': true});
      }
      
      for (var query in controller.apiSuggestions) {
        combinedList.add({'query': query, 'isHistory': false});
      }

      if (combinedList.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = combinedList[index];
              return SearchItem(
                queryString: item['query'],
                isHistoryString: item['isHistory'],
              );
            },
            childCount: combinedList.length,
          ),
        ),
      );
    });
  }
}
