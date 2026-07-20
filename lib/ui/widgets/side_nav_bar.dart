import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/screens/Home/home_screen_controller.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen.dart';
import 'package:harmonymusic/ui/navigator.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/ui/screens/Settings/settings_screen_controller.dart';

/// Material 3 Expressive side navigation rail — no glass blur, solid surface.
class SideNavBar extends StatefulWidget {
  const SideNavBar({super.key});

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobileOrTabScreen = size.width < 600;
    final homeScreenController = Get.find<HomeScreenController>();
    final settingsScreenController = Get.find<SettingsScreenController>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool isExpanded = _isHovered && !isMobileOrTabScreen;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubicEmphasized,
        width: isExpanded ? 240.0 : 80.0,
        height: size.height,
        child: Material(
          color: colorScheme.surface,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────────
                _buildHeader(isExpanded, colorScheme, settingsScreenController),
                const SizedBox(height: 8),

                // ── Nav Items ───────────────────────────────────────────────
                Expanded(
                  child: Obx(
                    () => ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _SideBarNavItem(
                          icon: Icons.home_outlined,
                          activeIcon: Icons.home_rounded,
                          label: S.current.home,
                          isSelected:
                              homeScreenController.tabIndex.value == 0,
                          isExpanded: isExpanded,
                          onTap: () =>
                              homeScreenController.onSideBarTabSelected(0),
                        ),
                        const SizedBox(height: 4),
                        _SideBarNavItem(
                          icon: Icons.audiotrack_outlined,
                          activeIcon: Icons.audiotrack_rounded,
                          label: S.current.songs,
                          isSelected:
                              homeScreenController.tabIndex.value == 1,
                          isExpanded: isExpanded,
                          onTap: () =>
                              homeScreenController.onSideBarTabSelected(1),
                        ),
                        const SizedBox(height: 4),
                        _SideBarNavItem(
                          icon: Icons.search_outlined,
                          activeIcon: Icons.search_rounded,
                          label: S.current.search,
                          isSelected:
                              homeScreenController.tabIndex.value == 2,
                          isExpanded: isExpanded,
                          onTap: () =>
                              homeScreenController.onSideBarTabSelected(2),
                        ),
                        const SizedBox(height: 4),
                        _SideBarNavItem(
                          icon: Icons.album_outlined,
                          activeIcon: Icons.album_rounded,
                          label: S.current.albums,
                          isSelected:
                              homeScreenController.tabIndex.value == 3,
                          isExpanded: isExpanded,
                          onTap: () =>
                              homeScreenController.onSideBarTabSelected(3),
                        ),
                        const SizedBox(height: 4),
                        _SideBarNavItem(
                          icon: Icons.people_outline,
                          activeIcon: Icons.people_rounded,
                          label: S.current.artists,
                          isSelected:
                              homeScreenController.tabIndex.value == 4,
                          isExpanded: isExpanded,
                          onTap: () =>
                              homeScreenController.onSideBarTabSelected(4),
                        ),
                        const SizedBox(height: 4),
                        _SideBarNavItem(
                          icon: Icons.library_music_outlined,
                          activeIcon: Icons.library_music_rounded,
                          label: S.current.playlists,
                          isSelected:
                              homeScreenController.tabIndex.value == 5,
                          isExpanded: isExpanded,
                          onTap: () =>
                              homeScreenController.onSideBarTabSelected(5),
                        ),
                        const SizedBox(height: 4),
                        _SideBarNavItem(
                          icon: Icons.settings_outlined,
                          activeIcon: Icons.settings_rounded,
                          label: S.current.settings,
                          isSelected: false,
                          isExpanded: isExpanded,
                          onTap: () {
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
                ),

                // ── Profile section ──────────────────────────────────────────
                _buildProfileSection(isExpanded, colorScheme),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isExpanded, ColorScheme colorScheme, SettingsScreenController settingsScreenController) {
    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(
        horizontal: isExpanded ? 20 : 16,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: SizedBox(
          width: isExpanded ? 200 : 48,
          child: Row(
            mainAxisAlignment:
                isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.music_note_rounded,
                  color: colorScheme.onPrimaryContainer,
                  size: 22,
                ),
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estrella Music',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Obx(() => Text(
                            settingsScreenController.currentVersion.value.isNotEmpty
                                ? settingsScreenController.currentVersion.value
                                : 'V2.3.6',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(bool isExpanded, ColorScheme colorScheme) {
    final authService = Get.find<AuthService>();
    return Obx(() {
      final isLoggedIn = authService.isAuthenticated.value;
      final name = authService.displayName;
      final email = authService.emailLabel;
      final initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colorScheme.outlineVariant.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            Get.to(
              () => const SettingsScreen(isBottomNavActive: false),
              id: ScreenNavigationSetup.id,
              transition: Transition.rightToLeft,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            child: Row(
              mainAxisAlignment:
                  isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                // Avatar circle
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isLoggedIn
                        ? colorScheme.primaryContainer
                        : colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: TextStyle(
                        color: isLoggedIn
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (isExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _SideBarNavItem extends StatefulWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const _SideBarNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<_SideBarNavItem> createState() => _SideBarNavItemState();
}

class _SideBarNavItemState extends State<_SideBarNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bg = widget.isSelected
        ? colorScheme.secondaryContainer
        : _isHovered
            ? colorScheme.secondaryContainer.withValues(alpha: 0.4)
            : Colors.transparent;

    final iconColor = widget.isSelected
        ? colorScheme.onSecondaryContainer
        : _isHovered
            ? colorScheme.onSecondaryContainer.withValues(alpha: 0.8)
            : colorScheme.onSurfaceVariant;

    final textColor = widget.isSelected
        ? colorScheme.onSecondaryContainer
        : _isHovered
            ? colorScheme.onSurface
            : colorScheme.onSurfaceVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: bg,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.isExpanded ? 16 : 0,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.isSelected)
                Positioned(
                  left: widget.isExpanded ? 4 : 4,
                  top: 14,
                  bottom: 14,
                  width: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: widget.isExpanded
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (widget.isExpanded) const SizedBox(width: 8),
                  AnimatedScale(
                    scale: widget.isSelected ? 1.1 : (_isHovered ? 1.05 : 1.0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    child: Icon(
                      widget.isSelected ? widget.activeIcon : widget.icon,
                      color: iconColor,
                      size: 24,
                    ),
                  ),
                  if (widget.isExpanded) ...[
                    const SizedBox(width: 14),
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: textColor,
                          fontWeight: widget.isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                        child: Text(
                          widget.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
