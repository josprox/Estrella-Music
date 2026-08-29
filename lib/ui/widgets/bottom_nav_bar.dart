import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<HomeScreenController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Obx(
      () => _M3ExpressiveNavBar(
        currentIndex: ctrl.tabIndex.toInt(),
        onTap: ctrl.onBottonBarTabSelected,
        colorScheme: colorScheme,
      ),
    );
  }
}

class _M3ExpressiveNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final ColorScheme colorScheme;

  const _M3ExpressiveNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    // Build icon for each tab â€” show filled when selected, outlined otherwise
    Widget buildIcon(IconData filled, IconData outlined, int index) {
      final isSelected = currentIndex == index;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          isSelected ? filled : outlined,
          key: ValueKey(isSelected),
        ),
      );
    }

    final tabs = [
      GButton(
        icon: Icons.home_rounded,
        leading: buildIcon(Icons.home_rounded, Icons.home_outlined, 0),
      ),
      GButton(
        icon: Icons.audiotrack_rounded,
        leading:
            buildIcon(Icons.audiotrack_rounded, Icons.audiotrack_outlined, 1),
      ),
      GButton(
        icon: Icons.search_rounded,
        leading: buildIcon(Icons.search_rounded, Icons.search_outlined, 2),
      ),
      GButton(
        icon: Icons.album_rounded,
        leading: buildIcon(Icons.album_rounded, Icons.album_outlined, 3),
      ),
      GButton(
        icon: Icons.people_alt_rounded,
        leading: buildIcon(
            Icons.people_alt_rounded, Icons.people_outline_rounded, 4),
      ),
      GButton(
        icon: Icons.queue_music_rounded,
        leading:
            buildIcon(Icons.queue_music_rounded, Icons.queue_music_outlined, 5),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.35),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
          child: GNav(
            // â”€â”€ Colors â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            color: colorScheme.onSurfaceVariant,
            activeColor: colorScheme.onSecondaryContainer,
            tabBackgroundColor: colorScheme.secondaryContainer,
            hoverColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
            rippleColor: colorScheme.secondaryContainer.withValues(alpha: 0.3),

            // â”€â”€ Layout â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            gap: 4,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            // â”€â”€ Animation â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubicEmphasized,

            // â”€â”€ Typography â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            textStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
              color: colorScheme.onSecondaryContainer,
            ),

            // â”€â”€ Tabs â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            tabs: tabs,
            selectedIndex: currentIndex,
            onTabChange: onTap,
          ),
        ),
      ),
    );
  }
}
