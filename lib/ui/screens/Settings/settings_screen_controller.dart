import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/services/system/permission_service.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:estrella_music/utils/helpers/update_check_flag_file.dart';
import 'package:estrella_music/utils/helpers/helper.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/music_provider/models/playback_source.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/ui/screens/Home/home_screen_controller.dart';
import '/ui/utils/theme_controller.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:estrella_music/generated/l10n.dart';

class SettingsScreenController extends GetxController {
  String _supportDir = "";
  final cacheSongs = false.obs;
  final setBox = SqliteStore.box("AppPrefs");
  final themeModetype = ThemeType.dynamic.obs;
  final skipSilenceEnabled = false.obs;
  final loudnessNormalizationEnabled = false.obs;
  final noOfHomeScreenContent = 3.obs;
  final startupTabIndex = 0.obs;
  final streamingQuality = AudioQuality.high.obs;
  final slidableActionEnabled = true.obs;
  final isIgnoringBatteryOptimizations = false.obs;
  final autoOpenPlayer = false.obs;
  final discoverContentType = "QP".obs;
  final isNewVersionAvailable = false.obs;
  final stopPlyabackOnSwipeAway = false.obs;
  final currentAppLanguageCode = "en".obs;
  final downloadLocationPath = "".obs;
  final exportLocationPath = "".obs;
  final downloadingFormat = "".obs;
  final autoDownloadFavoriteSongEnabled = false.obs;
  final isTransitionAnimationDisabled = false.obs;
  final isBottomNavBarEnabled = true.obs;
  final backgroundPlayEnabled = true.obs;
  final keepScreenAwake = false.obs;
  final restorePlaybackSession = false.obs;
  final cacheHomeScreenData = true.obs;
  final playbackSpeed = 1.0.obs;
  final playbackPitch = 1.0.obs;
  final currentVersion = "".obs;

  @override
  void onInit() {
    _setInitValue();
    _fetchVersion();
    if (updateCheckFlag) _checkNewVersion();
    _createInAppSongDownDir();
    super.onInit();
  }

  Future<void> _fetchVersion() async {
    try {
      final pInfo = await PackageInfo.fromPlatform();
      currentVersion.value = "V${pInfo.version}";
    } catch (_) {
      currentVersion.value = "V1.0.0";
    }
  }

  get currentVision => currentVersion.value;
  get isCurrentPathsupportDownDir =>
      "$_supportDir/Music" == downloadLocationPath.toString();
  String get supportDirPath => _supportDir;
  bool get supportsPlaybackPitch => !GetPlatform.isDesktop;

  _checkNewVersion() {
    newVersionCheck(currentVersion.value)
        .then((value) => isNewVersionAvailable.value = value);
  }

  Future<String> _createInAppSongDownDir() async {
    _supportDir = (await getApplicationSupportDirectory()).path;
    final directory = Directory("$_supportDir/Music/");
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return "$_supportDir/Music";
  }

  Future<void> _setInitValue() async {
    final isDesktop = GetPlatform.isDesktop;
    final appLang = setBox.get('currentAppLanguageCode') ??
        Get.deviceLocale?.languageCode ??
        "en";
    currentAppLanguageCode.value = appLang == "zh_Hant"
        ? "zh-TW"
        : appLang == "zh_Hans"
            ? "zh-CN"
            : appLang;
    isBottomNavBarEnabled.value = isDesktop ? false : true;
    noOfHomeScreenContent.value = setBox.get("noOfHomeScreenContent") ?? 3;
    final savedStartupTab = setBox.get('startupTabIndex');
    final parsedStartupTab = savedStartupTab is int
        ? savedStartupTab
        : int.tryParse('$savedStartupTab');
    startupTabIndex.value =
        HomeScreenController.supportedStartupTabs.contains(parsedStartupTab)
            ? parsedStartupTab!
            : 0;
    isTransitionAnimationDisabled.value =
        setBox.get("isTransitionAnimationDisabled") ?? false;
    cacheSongs.value = setBox.get('cacheSongs') ?? false;
    themeModetype.value = ThemeType.dynamic;
    skipSilenceEnabled.value =
        isDesktop ? false : (setBox.get("skipSilenceEnabled") ?? false);
    loudnessNormalizationEnabled.value = isDesktop
        ? false
        : (setBox.get("loudnessNormalizationEnabled") ?? false);
    autoOpenPlayer.value = (setBox.get("autoOpenPlayer") ?? true);
    restorePlaybackSession.value =
        setBox.get("restrorePlaybackSession") ?? false;
    cacheHomeScreenData.value = setBox.get("cacheHomeScreenData") ?? true;
    streamingQuality.value =
        AudioQuality.values[setBox.get('streamingQuality')];
    backgroundPlayEnabled.value = setBox.get("backgroundPlayEnabled") ?? true;
    keepScreenAwake.value =
        setBox.get("keepScreenAwake") ?? GetPlatform.isDesktop ? true : false;
    final downloadPath =
        setBox.get('downloadLocationPath') ?? await _createInAppSongDownDir();
    downloadLocationPath.value =
        (isDesktop && downloadPath.contains("emulated"))
            ? await _createInAppSongDownDir()
            : downloadPath;

    exportLocationPath.value =
        setBox.get("exportLocationPath") ?? "/storage/emulated/0/Music";
    // Opus/Ogg is the default for new profiles. Existing explicit selections
    // are respected, so users who deliberately chose M4A are not migrated.
    downloadingFormat.value = setBox.get('downloadingFormat') ?? "opus";
    discoverContentType.value = setBox.get('discoverContentType') ?? "QP";
    slidableActionEnabled.value = setBox.get('slidableActionEnabled') ?? true;
    stopPlyabackOnSwipeAway.value =
        setBox.get('stopPlyabackOnSwipeAway') ?? false;
    if (GetPlatform.isAndroid) {
      isIgnoringBatteryOptimizations.value =
          (await Permission.ignoreBatteryOptimizations.isGranted);
    }
    autoDownloadFavoriteSongEnabled.value =
        setBox.get("autoDownloadFavoriteSongEnabled") ?? false;
    playbackSpeed.value =
        ((setBox.get("playbackSpeed") ?? 1.0) as num).toDouble();
    playbackPitch.value =
        ((setBox.get("playbackPitch") ?? 1.0) as num).toDouble();
  }

  Future<void> setAppLanguage(String? val) async {
    if (val == null) return;
    S.load(Locale(val));
    Get.updateLocale(Locale(val));
    await Get.find<MusicCatalogService>().setContentLanguage(val);
    Get.find<HomeScreenController>().loadContentFromNetwork(silent: true);
    currentAppLanguageCode.value = val;
    setBox.put('currentAppLanguageCode', val);
  }

  void setContentNumber(int? no) {
    noOfHomeScreenContent.value = no!;
    setBox.put("noOfHomeScreenContent", no);
  }

  void setStartupTab(int? index) {
    if (index == null ||
        !HomeScreenController.supportedStartupTabs.contains(index)) {
      return;
    }
    startupTabIndex.value = index;
    setBox.put('startupTabIndex', index);
  }

  void setStreamingQuality(dynamic val) {
    setBox.put("streamingQuality", AudioQuality.values.indexOf(val));
    streamingQuality.value = val;
  }

  void toggleSlidableAction(bool val) {
    setBox.put("slidableActionEnabled", val);
    slidableActionEnabled.value = val;
  }

  void changeDownloadingFormat(String? val) {
    setBox.put("downloadingFormat", val);
    downloadingFormat.value = val!;
  }

  Future<void> setExportedLocation() async {
    if (!await PermissionService.getExtStoragePermission()) {
      return;
    }

    final String? pickedFolderPath = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Select export file folder");
    if (pickedFolderPath == '/' || pickedFolderPath == null) {
      return;
    }

    setBox.put("exportLocationPath", pickedFolderPath);
    exportLocationPath.value = pickedFolderPath;
  }

  Future<void> setDownloadLocation() async {
    if (!await PermissionService.getExtStoragePermission()) {
      return;
    }

    final String? pickedFolderPath = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Select downloads folder");
    if (pickedFolderPath == '/' || pickedFolderPath == null) {
      return;
    }

    setBox.put("downloadLocationPath", pickedFolderPath);
    downloadLocationPath.value = pickedFolderPath;
  }

  void disableTransitionAnimation(bool val) {
    setBox.put('isTransitionAnimationDisabled', val);
    isTransitionAnimationDisabled.value = val;
  }

  Future<void> clearImagesCache() async {
    final tempImgDirPath =
        "${(await getApplicationCacheDirectory()).path}/libCachedImageData";
    final tempImgDir = Directory(tempImgDirPath);
    try {
      if (await tempImgDir.exists()) {
        await tempImgDir.delete(recursive: true);
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  void resetDownloadLocation() {
    final defaultPath = "$_supportDir/Music";
    setBox.put("downloadLocationPath", defaultPath);
    downloadLocationPath.value = defaultPath;
  }

  void onThemeChange(dynamic val) {}

  void onContentChange(dynamic value) {
    setBox.put('discoverContentType', value);
    discoverContentType.value = value;
    Get.find<HomeScreenController>().changeDiscoverContent(value);
  }

  void toggleCachingSongsValue(bool value) {
    setBox.put("cacheSongs", value);
    cacheSongs.value = value;
  }

  void toggleSkipSilence(bool val) {
    Get.find<PlayerController>().toggleSkipSilence(val);
    setBox.put('skipSilenceEnabled', val);
    skipSilenceEnabled.value = val;
  }

  void toggleLoudnessNormalization(bool val) {
    Get.find<PlayerController>().toggleLoudnessNormalization(val);
    setBox.put("loudnessNormalizationEnabled", val);
    loudnessNormalizationEnabled.value = val;
  }

  void toggleRestorePlaybackSession(bool val) {
    setBox.put("restrorePlaybackSession", val);
    restorePlaybackSession.value = val;
  }

  Future<void> toggleCacheHomeScreenData(bool val) async {
    setBox.put("cacheHomeScreenData", val);
    cacheHomeScreenData.value = val;
    if (!val) {
      SqliteStore.openBox("homeScreenData").then((box) async {
        await box.clear();
        await box.close();
      });
    } else {
      await SqliteStore.openBox("homeScreenData");
      Get.find<HomeScreenController>().cachedHomeScreenData(updateAll: true);
    }
  }

  void toggleAutoDownloadFavoriteSong(bool val) {
    setBox.put("autoDownloadFavoriteSongEnabled", val);
    autoDownloadFavoriteSongEnabled.value = val;
  }

  void toggleBackgroundPlay(bool val) {
    setBox.put('backgroundPlayEnabled', val);
    backgroundPlayEnabled.value = val;
  }

  void toggleKeepScreenAwake(bool val) {
    setBox.put('keepScreenAwake', val);
    keepScreenAwake.value = val;
    try {
      if (val) {
        // enable wakelock immediately if music is playing
        if (Get.find<PlayerController>().buttonState.value ==
            PlayButtonState.playing) {
          WakelockPlus.enable();
        }
      } else {
        WakelockPlus.disable();
      }
    } catch (e) {
      // ignore if player/controller not available
    }
  }

  Future<void> enableIgnoringBatteryOptimizations() async {
    await Permission.ignoreBatteryOptimizations.request();
    isIgnoringBatteryOptimizations.value =
        await Permission.ignoreBatteryOptimizations.isGranted;
  }

  void toggleAutoOpenPlayer(bool val) {
    setBox.put('autoOpenPlayer', val);
    autoOpenPlayer.value = val;
  }

  Future<void> resetAppSettingsToDefault() async {
    await setBox.clear();
  }

  void toggleStopPlyabackOnSwipeAway(bool val) {
    setBox.put('stopPlyabackOnSwipeAway', val);
    stopPlyabackOnSwipeAway.value = val;
  }

  void setPlaybackSpeed(double val) {
    playbackSpeed.value = val;
    setBox.put('playbackSpeed', val);
    try {
      Get.find<AudioHandler>().customAction('setSpeed', {'speed': val});
    } catch (_) {}
  }

  void setPlaybackPitch(double val) {
    if (!supportsPlaybackPitch) return;

    playbackPitch.value = val;
    setBox.put('playbackPitch', val);
    try {
      Get.find<AudioHandler>().customAction('setPitch', {'pitch': val});
    } catch (_) {}
  }

  Future<void> closeAllDatabases() async {
    await SqliteStore.close();
  }

  Future<String> get dbDir async {
    if (GetPlatform.isDesktop) {
      return "$supportDirPath/db";
    } else {
      return (await getApplicationDocumentsDirectory()).path;
    }
  }

  Future<void> logoutUser() async {
    try {
      await Get.find<AudioHandler>().stop();
    } catch (_) {}
    await Get.find<AuthService>().logout();
  }
}
