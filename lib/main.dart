import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:harmonymusic/ui/widgets/liquid_bottom_navigation_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terminate_restart/terminate_restart.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import '/services/app_backup_service.dart';
import '/services/auth_service.dart';
import '/services/catalog_recovery_service.dart';
import '/services/cloud_backup_service.dart';
import '/services/legacy_music_migration_service.dart';
import '/services/notification_service.dart';
import '/services/sync_service.dart';
import '/services/colistening_service.dart';
import '/services/user_data_bootstrap_service.dart';
import '/ui/screens/Search/search_screen_controller.dart';
import '/services/downloader.dart';
import '/services/piped_service.dart';
import 'utils/app_link_controller.dart';
import '/services/audio_handler.dart';
import '/services/music_service.dart';
import '/ui/player/player_controller.dart';
import 'ui/screens/Settings/settings_screen_controller.dart';
import 'ui/auth/auth_gate.dart';
import '/ui/utils/theme_controller.dart';
import 'ui/screens/Home/home_screen_controller.dart';
import 'ui/screens/Library/library_controller.dart';
import 'utils/system_tray.dart';
import 'utils/update_check_flag_file.dart';

import 'package:workmanager/workmanager.dart';
import 'services/background_backup_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {}
  await NotificationService.initOneSignal();
  await initHive();
  final appPrefs = await Hive.openBox('AppPrefs');

  // Initialize Background Backup (Android/iOS only — workmanager has no desktop implementation)
  if (GetPlatform.isAndroid || GetPlatform.isIOS) {
    Workmanager().initialize(
      callbackDispatcher,
    );
    Workmanager().registerPeriodicTask(
      "periodic-backup-task",
      "backupTask",
      frequency: const Duration(hours: 4),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }

  final appLang = appPrefs.get('currentAppLanguageCode') ??
      Get.deviceLocale?.languageCode ??
      "en";
  await S.load(Locale(appLang));
  _setAppInitPrefs();
  startApplicationServices();
  Get.put<AudioHandler>(await initAudioService(), permanent: true);
  WidgetsBinding.instance.addObserver(LifecycleHandler());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  TerminateRestart.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (!GetPlatform.isDesktop) Get.put(AppLinksController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return GetMaterialApp(
        title: 'Estrella Music',
        home: const AuthGate(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: (Hive.box("AppPrefs").get('currentAppLanguageCode') == null ||
                Hive.box("AppPrefs").get('autoLanguage', defaultValue: true))
            ? Get.deviceLocale
            : Locale(Hive.box("AppPrefs").get('currentAppLanguageCode')),
        navigatorObservers: [LiquidRouteObserver.instance],
        builder: (context, child) {
          return DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) {
              final controller = Get.find<ThemeController>();

              // Determine which dynamic scheme to use
              final dynamicScheme =
                  (MediaQuery.of(context).platformBrightness == Brightness.dark)
                      ? darkDynamic
                      : lightDynamic;

              // Update the controller with dynamic colors if available
              // This ensures the initial theme is correct
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (dynamicScheme != null) {
                  controller.changeThemeModeType(
                      Hive.box("AppPrefs").get("themeModeType"),
                      dynamicColors: dynamicScheme);
                }
              });

              final mQuery = MediaQuery.of(context);
              final scale = mQuery.textScaler
                  .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.1);

              return Stack(
                children: [
                  GetX<ThemeController>(
                    builder: (controller) => MediaQuery(
                      data: mQuery.copyWith(textScaler: scale),
                      child: AnimatedTheme(
                          duration: const Duration(milliseconds: 700),
                          data: controller.themedata.value!,
                          child: child!),
                    ),
                  ),
                  GestureDetector(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.transparent,
                        height: mQuery.padding.bottom,
                        width: mQuery.size.width,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        });
  }
}

Future<void> startApplicationServices() async {
  Get.put(AuthService(), permanent: true);
  Get.put(SyncService(), permanent: true);
  Get.put(ColisteningService(), permanent: true);
  Get.put(AppBackupService(), permanent: true);
  Get.put(CatalogRecoveryService(), permanent: true);
  Get.put(CloudBackupService(), permanent: true);
  Get.put(LegacyMusicMigrationService(), permanent: true);
  Get.put(UserDataBootstrapService(), permanent: true);
  Get.lazyPut(() => PipedServices(), fenix: true);
  Get.lazyPut(() => MusicServices(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);
  Get.lazyPut(() => PlayerController(), fenix: true);
  Get.lazyPut(() => HomeScreenController(), fenix: true);
  Get.lazyPut(() => LibrarySongsController(), fenix: true);
  Get.lazyPut(() => LibraryPlaylistsController(), fenix: true);
  Get.lazyPut(() => LibraryAlbumsController(), fenix: true);
  Get.lazyPut(() => LibraryArtistsController(), fenix: true);
  Get.lazyPut(() => SettingsScreenController(), fenix: true);
  Get.lazyPut(() => Downloader(), fenix: true);
  if (GetPlatform.isDesktop) {
    Get.lazyPut(() => SearchScreenController(), fenix: true);
    Get.put(DesktopSystemTray());
  }
}

initHive() async {
  String applicationDataDirectoryPath;
  if (GetPlatform.isDesktop) {
    applicationDataDirectoryPath =
        "${(await getApplicationSupportDirectory()).path}/db";
  } else {
    applicationDataDirectoryPath =
        (await getApplicationDocumentsDirectory()).path;
  }
  await Hive.initFlutter(applicationDataDirectoryPath);
  await Hive.openBox("SongsCache");
  await Hive.openBox("SongDownloads");
  await Hive.openBox('SongsUrlCache');
  await Hive.openBox("AppPrefs");

  // Open common library boxes at startup to prevent "Box not found" errors
  await Hive.openBox("LIBFAV");
  await Hive.openBox("LIBRP");
  await Hive.openBox("LibraryArtists");
  await Hive.openBox("LibraryAlbums");
  await Hive.openBox("LibraryPlaylists");
  await Hive.openBox("homeScreenData");
}

void _setAppInitPrefs() {
  final appPrefs = Hive.box("AppPrefs");
  if (appPrefs.isEmpty) {
    appPrefs.putAll({
      'themeModeType': 0,
      "cacheSongs": false,
      "skipSilenceEnabled": false,
      'streamingQuality': 1,
      'themePrimaryColor': 4278199603,
      'discoverContentType': "QP",
      'newVersionVisibility': updateCheckFlag,
      "cacheHomeScreenData": true,
      "restrorePlaybackSession": true,
      "autoLanguage": true,
      "app_first_run_timestamp": DateTime.now().toIso8601String(),
      "emusicDataMode": "local",
      "hasPendingSync": false,
    });
  } else {
    appPrefs.put("emusicDataMode",
        appPrefs.get("emusicDataMode", defaultValue: "local"));
    appPrefs.put(
        "hasPendingSync", appPrefs.get("hasPendingSync", defaultValue: false));
  }
}

class LifecycleHandler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    } else if (state == AppLifecycleState.detached) {
      await Get.find<AudioHandler>().customAction("saveSession");
    }
  }
}
