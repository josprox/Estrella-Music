import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/ui/screens/Friends/friends_management_screen.dart';
import 'package:estrella_music/ui/profiles/profile_switcher.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';

import 'package:estrella_music/utils/localization/lang_mapping.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:estrella_music/ui/widgets/common_dialog_widget.dart';
import 'package:estrella_music/ui/widgets/cust_switch.dart';
import 'package:estrella_music/ui/widgets/backup_dialog.dart';
import 'package:estrella_music/ui/widgets/cloud_backup_dialog.dart';
import 'package:estrella_music/ui/widgets/cloud_sync_status_dialog.dart';
import 'package:estrella_music/ui/widgets/legacy_music_migration_dialog.dart';
import 'package:estrella_music/ui/widgets/restore_dialog.dart';
import 'package:estrella_music/ui/widgets/snackbar.dart';

import '/ui/utils/theme_controller.dart';
import 'components/custom_expansion_tile.dart';
import 'settings_screen_controller.dart';
import 'package:estrella_music/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.isBottomNavActive = false});
  final bool isBottomNavActive;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SettingsScreenController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final topPad = isBottomNavActive
        ? statusBarHeight
        : (context.isLandscape ? 50.0 : 90.0);

    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    // New settings cards are now separated into sub-screens to improve aesthetics and structure.

    // Footer
    final footer = Obx(() => Column(
          children: [
            Container(
              width: isWide ? 400 : double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: cs.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/icons/icon.png',
                        width: 36, height: 36),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estrella Music',
                          style: tt.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      Text(ctrl.currentVersion.value,
                          style: tt.bodySmall
                              ?.copyWith(color: cs.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${ctrl.currentVersion.value} • ${S.current.developedBy}",
              style: tt.labelSmall
                  ?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 4),
            Text(
              S.current.copyrightNotice,
              style: tt.labelSmall
                  ?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.4)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 120),
          ],
        ));

    final viewBody = SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: topPad)),

          // â”€â”€ Header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Row(
                children: [
                  if (!isBottomNavActive) ...[
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.settings_rounded,
                        color: cs.onPrimaryContainer, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Text(S.current.settings,
                      style: tt.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),

          // â”€â”€ Update banner â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SliverToBoxAdapter(
            child: Obx(() => ctrl.isNewVersionAvailable.value
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                    child: Card(
                      color: cs.primaryContainer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        onTap: () => launchUrl(
                            Uri.parse(
                                'https://github.com/josprox/Estrella-Music/releases/latest'),
                            mode: LaunchMode.externalApplication),
                        leading: Icon(Icons.download_rounded,
                            color: cs.onPrimaryContainer),
                        title: Text(S.current.newVersionAvailable,
                            style: TextStyle(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w600)),
                        subtitle: Text(S.current.goToDownloadPage,
                            style: TextStyle(
                                color: cs.onPrimaryContainer
                                    .withValues(alpha: 0.7))),
                        trailing: Icon(Icons.open_in_new_rounded,
                            color: cs.onPrimaryContainer),
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
          ),

          // Sections
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  color: cs.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(S.current.personalisation),
                        subtitle: Text(S.current.settings_appearance_desc),
                        leading: Icon(Icons.palette_rounded, color: cs.primary),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(
                            () => const SettingsAppearanceScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        title: Text(S.current.content),
                        subtitle: Text(S.current.settings_content_desc),
                        leading:
                            Icon(Icons.music_video_rounded, color: cs.primary),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(() => const SettingsContentScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        title: Text(S.current.musicAndPlayback),
                        subtitle: Text(S.current.settings_playback_desc),
                        leading:
                            Icon(Icons.music_note_rounded, color: cs.primary),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(
                            () => const SettingsPlaybackScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        title: Text(S.current.settings_downloads_desc),
                        subtitle: Text(S.current.settings_downloads_sub),
                        leading:
                            Icon(Icons.download_rounded, color: cs.primary),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(
                            () => const SettingsDownloadsScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        title: Text(S.current.settings_account_desc),
                        subtitle: Text(S.current.settings_account_sub),
                        leading:
                            Icon(Icons.cloud_sync_rounded, color: cs.primary),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(() => const SettingsAccountScreen(),
                            transition: Transition.rightToLeft),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        title: Text(S.current.settings_about_desc),
                        subtitle: Text(S.current.settings_about_sub),
                        leading: Icon(Icons.info_rounded, color: cs.primary),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(() => const SettingsAboutScreen(),
                            transition: Transition.rightToLeft),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),

          // â”€â”€ Footer â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: footer,
            ),
          )
        ],
      ),
    );

    return isBottomNavActive
        ? viewBody
        : Scaffold(
            backgroundColor: cs.surface,
            body: viewBody,
          );
  }
}

class ThemeSelectorDialog extends StatelessWidget {
  const ThemeSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsScreenController>();
    return CommonDialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.themeMode,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            radioWidget(
              label: S.current.dynamic,
              controller: settingsController,
              value: ThemeType.dynamic,
            ),
            radioWidget(
              label: S.current.systemDefault,
              controller: settingsController,
              value: ThemeType.system,
            ),
            radioWidget(
              label: S.current.dark,
              controller: settingsController,
              value: ThemeType.dark,
            ),
            radioWidget(
              label: S.current.light,
              controller: settingsController,
              value: ThemeType.light,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.current.cancel),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DiscoverContentSelectorDialog extends StatelessWidget {
  const DiscoverContentSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsScreenController>();
    return CommonDialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.setDiscoverContent,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            radioWidget(
                label: S.current.quickpicks,
                controller: settingsController,
                value: "QP"),
            radioWidget(
                label: S.current.topmusicvideos,
                controller: settingsController,
                value: "TMV"),
            radioWidget(
                label: S.current.trending,
                controller: settingsController,
                value: "TR"),
            radioWidget(
                label: S.current.basedOnLast,
                controller: settingsController,
                value: "BOLI"),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.current.cancel),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget radioWidget(
    {required String label,
    required SettingsScreenController controller,
    required value}) {
  final context = Get.context!;
  final cs = Theme.of(context).colorScheme;
  final isTheme = value.runtimeType == ThemeType;
  return Obx(() {
    final groupValue = isTheme
        ? controller.themeModetype.value
        : controller.discoverContentType.value;
    final isSelected = groupValue == value;
    void onChanged(dynamic newValue) {
      if (isTheme) {
        controller.onThemeChange(newValue);
      } else {
        controller.onContentChange(newValue);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: isSelected
            ? cs.primaryContainer.withValues(alpha: 0.4)
            : Colors.transparent,
        visualDensity: const VisualDensity(vertical: -2),
        onTap: () {
          if (isTheme) {
            controller.onThemeChange(value);
          } else {
            controller.onContentChange(value);
            Navigator.of(Get.context!).pop();
          }
        },
        leading: RadioGroup<dynamic>(
          groupValue: groupValue,
          onChanged: onChanged,
          child: Radio<dynamic>(
            value: value,
            activeColor: cs.primary,
          ),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? cs.onPrimaryContainer : cs.onSurface,
          ),
        ),
      ),
    );
  });
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Sub-secciones de Configuración
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class SettingsAppearanceScreen extends StatelessWidget {
  const SettingsAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SettingsScreenController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(S.current.personalisation),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsTile(
            title: S.current.language,
            subtitle: S.current.languageDes,
            leadingIcon: Icons.translate_rounded,
            trailing: Obx(() => DropdownButton(
                  menuMaxHeight: Get.height - 250,
                  dropdownColor: cs.surfaceContainerHigh,
                  underline: const SizedBox.shrink(),
                  style: tt.titleSmall,
                  value: ctrl.currentAppLanguageCode.value,
                  items: langMap.entries
                      .map((l) =>
                          DropdownMenuItem(value: l.key, child: Text(l.value)))
                      .whereType<DropdownMenuItem<String>>()
                      .toList(),
                  selectedItemBuilder: (ctx) => langMap.entries
                      .map<Widget>((e) => Container(
                            alignment: Alignment.centerRight,
                            constraints: const BoxConstraints(minWidth: 50),
                            child: Text(e.value),
                          ))
                      .toList(),
                  onChanged: ctrl.setAppLanguage,
                )),
          ),
          SettingsTile(
            title: S.current.themeMode,
            subtitle: S.current.setDiscoverContent,
            leadingIcon: Icons.dark_mode_rounded,
            onTap: () => showDialog(
                context: context, builder: (_) => const ThemeSelectorDialog()),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          SettingsTile(
            title: S.current.disableTransitionAnimation,
            subtitle: S.current.disableTransitionAnimationDes,
            leadingIcon: Icons.animation_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.isTransitionAnimationDisabled.isTrue,
                onChanged: ctrl.disableTransitionAnimation)),
          ),
          SettingsTile(
            title: S.current.enableSlidableAction,
            subtitle: S.current.enableSlidableActionDes,
            leadingIcon: Icons.swipe_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.slidableActionEnabled.isTrue,
                onChanged: ctrl.toggleSlidableAction)),
          ),
        ],
      ),
    );
  }
}

class SettingsContentScreen extends StatelessWidget {
  const SettingsContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SettingsScreenController>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final startupOptions = <int, String>{
      0: S.current.home,
      1: S.current.songs,
      3: S.current.albums,
      4: S.current.artists,
      5: S.current.playlists,
    };

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(S.current.content),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsTile(
            title: S.current.startupScreen,
            subtitle: S.current.startupScreenDescription,
            leadingIcon: Icons.start_rounded,
            trailing: Obx(() => SizedBox(
                  width: 132,
                  child: DropdownButton<int>(
                    isExpanded: true,
                    dropdownColor: cs.surfaceContainerHigh,
                    underline: const SizedBox.shrink(),
                    value: ctrl.startupTabIndex.value,
                    selectedItemBuilder: (context) => startupOptions.values
                        .map((label) => Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: tt.bodyMedium?.copyWith(
                                  color: cs.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ))
                        .toList(),
                    items: startupOptions.entries
                        .map((option) => DropdownMenuItem<int>(
                              value: option.key,
                              child: Text(
                                option.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: ctrl.setStartupTab,
                  ),
                )),
          ),
          SettingsTile(
            title: S.current.setDiscoverContent,
            leadingIcon: Icons.explore_rounded,
            subtitle: null,
            onTap: () => showDialog(
                context: context,
                builder: (_) => const DiscoverContentSelectorDialog()),
            trailing: Obx(() => Text(
                  ctrl.discoverContentType.value == "QP"
                      ? S.current.quickpicks
                      : ctrl.discoverContentType.value == "TMV"
                          ? S.current.topmusicvideos
                          : ctrl.discoverContentType.value == "TR"
                              ? S.current.trending
                              : S.current.basedOnLast,
                  style: tt.bodySmall?.copyWith(
                      color: cs.primary, fontWeight: FontWeight.bold),
                )),
          ),
          SettingsTile(
            title: S.current.homeContentCount,
            subtitle: S.current.homeContentCountDes,
            leadingIcon: Icons.grid_view_rounded,
            trailing: Obx(() => DropdownButton(
                  dropdownColor: cs.surfaceContainerHigh,
                  underline: const SizedBox.shrink(),
                  value: ctrl.noOfHomeScreenContent.value,
                  items: [3, 5, 7, 9, 11]
                      .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
                      .toList(),
                  onChanged: ctrl.setContentNumber,
                )),
          ),
          SettingsTile(
            title: S.current.cacheHomeScreenData,
            subtitle: S.current.cacheHomeScreenDataDes,
            leadingIcon: Icons.cached_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.cacheHomeScreenData.value,
                onChanged: ctrl.toggleCacheHomeScreenData)),
          ),
          SettingsTile(
            title: S.current.clearImgCache,
            subtitle: S.current.clearImgCacheDes,
            leadingIcon: Icons.image_not_supported_rounded,
            isThreeLine: true,
            onTap: () => ctrl.clearImagesCache().then((_) =>
                ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
                    Get.context!, S.current.clearImgCacheAlert,
                    size: SanckBarSize.BIG))),
          ),
        ],
      ),
    );
  }
}

class SettingsPlaybackScreen extends StatelessWidget {
  const SettingsPlaybackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SettingsScreenController>();
    final cs = Theme.of(context).colorScheme;
    final isDesktop = GetPlatform.isDesktop;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(S.current.musicAndPlayback),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsTile(
            title: S.current.streamingQuality,
            subtitle: S.current.streamingQualityDes,
            leadingIcon: Icons.high_quality_rounded,
            trailing: Obx(() => DropdownButton(
                  dropdownColor: cs.surfaceContainerHigh,
                  underline: const SizedBox.shrink(),
                  value: ctrl.streamingQuality.value,
                  items: [
                    DropdownMenuItem(
                        value: AudioQuality.low, child: Text(S.current.low)),
                    DropdownMenuItem(
                        value: AudioQuality.high, child: Text(S.current.high)),
                  ],
                  onChanged: ctrl.setStreamingQuality,
                )),
          ),
          if (GetPlatform.isAndroid)
            SettingsTile(
              title: S.current.loudnessNormalization,
              subtitle: S.current.loudnessNormalizationDes,
              leadingIcon: Icons.equalizer_rounded,
              trailing: Obx(() => CustSwitch(
                  value: ctrl.loudnessNormalizationEnabled.value,
                  onChanged: ctrl.toggleLoudnessNormalization)),
            ),
          if (!isDesktop)
            SettingsTile(
              title: S.current.cacheSongs,
              subtitle: S.current.cacheSongsDes,
              leadingIcon: Icons.save_alt_rounded,
              trailing: Obx(() => CustSwitch(
                  value: ctrl.cacheSongs.value,
                  onChanged: ctrl.toggleCachingSongsValue)),
            ),
          if (!isDesktop)
            SettingsTile(
              title: S.current.skipSilence,
              subtitle: S.current.skipSilenceDes,
              leadingIcon: Icons.fast_forward_rounded,
              trailing: Obx(() => CustSwitch(
                  value: ctrl.skipSilenceEnabled.value,
                  onChanged: ctrl.toggleSkipSilence)),
            ),
          if (isDesktop)
            SettingsTile(
              title: S.current.backgroundPlay,
              subtitle: S.current.backgroundPlayDes,
              leadingIcon: Icons.play_circle_outline_rounded,
              trailing: Obx(() => CustSwitch(
                  value: ctrl.backgroundPlayEnabled.value,
                  onChanged: ctrl.toggleBackgroundPlay)),
            ),
          SettingsTile(
            title: S.current.keepScreenOnWhilePlaying,
            subtitle: S.current.keepScreenOnWhilePlayingDes,
            leadingIcon: Icons.screen_lock_rotation_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.keepScreenAwake.value,
                onChanged: ctrl.toggleKeepScreenAwake)),
          ),
          SettingsTile(
            title: S.current.restoreLastPlaybackSession,
            subtitle: S.current.restoreLastPlaybackSessionDes,
            leadingIcon: Icons.restore_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.restorePlaybackSession.value,
                onChanged: ctrl.toggleRestorePlaybackSession)),
          ),
          SettingsTile(
            title: S.current.autoOpenPlayer,
            subtitle: S.current.autoOpenPlayerDes,
            leadingIcon: Icons.open_in_full_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.autoOpenPlayer.value,
                onChanged: ctrl.toggleAutoOpenPlayer)),
          ),
          if (!isDesktop)
            SettingsTile(
              title: S.current.stopMusicOnTaskClear,
              subtitle: S.current.stopMusicOnTaskClearDes,
              leadingIcon: Icons.stop_circle_outlined,
              trailing: Obx(() => CustSwitch(
                  value: ctrl.stopPlyabackOnSwipeAway.value,
                  onChanged: ctrl.toggleStopPlyabackOnSwipeAway)),
            ),
          if (GetPlatform.isAndroid)
            Obx(() => SettingsTile(
                  title: S.current.ignoreBatOpt,
                  leadingIcon: Icons.battery_saver_rounded,
                  isThreeLine: true,
                  onTap: ctrl.isIgnoringBatteryOptimizations.isFalse
                      ? ctrl.enableIgnoringBatteryOptimizations
                      : null,
                  trailing: CustSwitch(
                    value: ctrl.isIgnoringBatteryOptimizations.value,
                    onChanged: ctrl.isIgnoringBatteryOptimizations.isFalse
                        ? (_) => ctrl.enableIgnoringBatteryOptimizations()
                        : null,
                  ),
                  subtitle:
                      "${S.current.status}: ${ctrl.isIgnoringBatteryOptimizations.isTrue ? S.current.enabled : S.current.disabled}\n${S.current.ignoreBatOptDes}",
                )),
        ],
      ),
    );
  }
}

class SettingsDownloadsScreen extends StatelessWidget {
  const SettingsDownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SettingsScreenController>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(S.current.settings_downloads_desc),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsTile(
            title: S.current.autoDownFavSong,
            subtitle: S.current.autoDownFavSongDes,
            leadingIcon: Icons.favorite_rounded,
            trailing: Obx(() => CustSwitch(
                value: ctrl.autoDownloadFavoriteSongEnabled.value,
                onChanged: ctrl.toggleAutoDownloadFavoriteSong)),
          ),
          SettingsTile(
            title: S.current.downloadingFormat,
            subtitle: S.current.downloadingFormatDes,
            leadingIcon: Icons.audio_file_rounded,
            trailing: Obx(() => DropdownButton(
                  dropdownColor: cs.surfaceContainerHigh,
                  underline: const SizedBox.shrink(),
                  value: ctrl.downloadingFormat.value,
                  items: const [
                    DropdownMenuItem(value: "opus", child: Text("Opus/Ogg")),
                    DropdownMenuItem(value: "m4a", child: Text("M4a")),
                  ],
                  onChanged: ctrl.changeDownloadingFormat,
                )),
          ),
        ],
      ),
    );
  }
}

class SettingsAccountScreen extends StatelessWidget {
  const SettingsAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SettingsScreenController>();
    final auth = Get.find<AuthService>();
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(S.current.settings_account_desc),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Obx(() => ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: CircleAvatar(
                  backgroundColor: cs.primaryContainer,
                  child: Text(
                      auth.displayName.isNotEmpty
                          ? auth.displayName[0].toUpperCase()
                          : '?',
                      style: TextStyle(
                          color: cs.onPrimaryContainer,
                          fontWeight: FontWeight.bold)),
                ),
                title: Text(auth.displayName,
                    style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                subtitle: Text(auth.emailLabel,
                    style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
                trailing: FilledButton.tonal(
                  onPressed: ctrl.logoutUser,
                  child: Text(S.current.settings_logout,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: cs.error,
                side: BorderSide(color: cs.error.withValues(alpha: 0.5)),
              ),
              icon: const Icon(Icons.delete_forever_rounded),
              label: const Text('Eliminar cuenta'),
              onPressed: () => showDialog<void>(
                context: context,
                builder: (dialogCtx) => AlertDialog(
                  title: const Text('Eliminar cuenta'),
                  content: const Text(
                    'La eliminación definitiva de tu cuenta y datos personales se gestiona de forma segura a través del portal de tu perfil en Joss Red.\n\n¿Deseas abrir tu perfil en joss.red para solicitar la baja?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogCtx).pop(),
                      child: const Text('Cancelar'),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: cs.error),
                      onPressed: () async {
                        Navigator.of(dialogCtx).pop();
                        final uri = Uri.parse('https://joss.red/profile');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: const Text('Continuar a joss.red'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ProfileSwitcher(),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          SettingsTile(
            title: S.current.settings_cloud_backup,
            subtitle: S.current.settings_cloud_backup_desc,
            leadingIcon: Icons.cloud_sync_rounded,
            onTap: () => showDialog(
                    context: context, builder: (_) => const CloudBackupDialog())
                .whenComplete(() => Get.delete<CloudBackupDialogController>()),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          SettingsTile(
            title: S.current.settings_local_cloud_title,
            subtitle: S.current.settings_local_cloud_desc,
            leadingIcon: Icons.cloud_queue_rounded,
            onTap: () => showDialog(
                context: context,
                builder: (_) => const CloudSyncStatusDialog()),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          SettingsTile(
            title: S.current.settings_my_friends,
            subtitle: S.current.settings_my_friends_desc,
            leadingIcon: Icons.people_outline_rounded,
            onTap: () => Get.to(() => const FriendsManagementScreen()),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          SettingsTile(
            title: S.current.settings_migration_title,
            subtitle: S.current.settings_migration_desc,
            leadingIcon: Icons.move_to_inbox_rounded,
            onTap: () => showDialog(
                    context: context,
                    builder: (_) => const LegacyMusicMigrationDialog())
                .whenComplete(
                    () => Get.delete<LegacyMusicMigrationDialogController>()),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          SettingsTile(
            title: S.current.backupAppData,
            subtitle: S.current.backupSettingsAndPlaylistsDes,
            leadingIcon: Icons.backup_rounded,
            isThreeLine: true,
            onTap: () => showDialog(
                    context: context, builder: (_) => const BackupDialog())
                .whenComplete(() => Get.delete<BackupDialogController>()),
          ),
          SettingsTile(
            title: S.current.restoreAppData,
            subtitle: S.current.restoreSettingsAndPlaylistsDes,
            leadingIcon: Icons.settings_backup_restore_rounded,
            isThreeLine: true,
            onTap: () => showDialog(
                    context: context, builder: (_) => const RestoreDialog())
                .whenComplete(() => Get.delete<RestoreDialogController>()),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          SettingsTile(
            title: S.current.resetToDefault,
            subtitle: S.current.resetToDefaultDes,
            leadingIcon: Icons.restart_alt_rounded,
            onTap: () => ctrl.resetAppSettingsToDefault().then((_) =>
                ScaffoldMessenger.of(Get.context!).showSnackBar(snackbar(
                    Get.context!, S.current.resetToDefaultMsg,
                    size: SanckBarSize.BIG,
                    duration: const Duration(seconds: 2)))),
          ),
        ],
      ),
    );
  }
}

class SettingsAboutScreen extends StatelessWidget {
  const SettingsAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings_about_desc),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SettingsTile(
            title: S.current.github,
            subtitle: S.current.githubDes,
            leadingIcon: Icons.code_rounded,
            isThreeLine: true,
            onTap: () => launchUrl(
                Uri.parse('https://github.com/josprox/Estrella-Music'),
                mode: LaunchMode.externalApplication),
            trailing: const Icon(Icons.open_in_new_rounded),
          ),
        ],
      ),
    );
  }
}
