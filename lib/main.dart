import 'package:audio_service/audio_service.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/services/storage/sqlite_store.dart';
import 'package:harmonymusic/ui/widgets/liquid_bottom_navigation_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:harmonymusic/services/backup/app_backup_service.dart';
import 'package:harmonymusic/services/auth/auth_service.dart';
import 'package:harmonymusic/services/auth/catalog_recovery_service.dart';
import 'package:harmonymusic/services/backup/cloud_backup_service.dart';
import 'package:harmonymusic/services/sync/cloud_migration_service.dart';
import 'package:harmonymusic/services/sync/legacy_music_migration_service.dart';
import 'package:harmonymusic/services/system/notification_service.dart';
import 'package:harmonymusic/services/system/fcm_notification_service.dart';
import 'package:harmonymusic/services/sync/pending_sync_queue_service.dart';
import 'package:harmonymusic/services/sync/music_sqlite_service.dart';
import 'package:harmonymusic/services/sync/sync_service.dart';
import 'package:harmonymusic/services/social/colistening_service.dart';
import 'package:harmonymusic/services/auth/user_data_bootstrap_service.dart';
import '/ui/screens/Search/search_screen_controller.dart';
import 'package:harmonymusic/services/download/downloader.dart';
import 'package:harmonymusic/services/background/background_execution_service.dart';
import 'package:harmonymusic/services/social/piped_service.dart';
import 'package:harmonymusic/utils/desktop/app_link_controller.dart';
import 'package:harmonymusic/services/music/audio_handler.dart';
import 'package:harmonymusic/services/music/music_service.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'ui/screens/Settings/settings_screen_controller.dart';
import 'ui/auth/auth_gate.dart';
import '/ui/utils/theme_controller.dart';
import 'ui/screens/Home/home_screen_controller.dart';
import 'ui/screens/Library/library_controller.dart';
import 'package:harmonymusic/utils/desktop/system_tray.dart';
import 'package:harmonymusic/utils/helpers/update_check_flag_file.dart';

import 'package:workmanager/workmanager.dart';
import 'package:harmonymusic/services/backup/background_backup_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {}
  if (GetPlatform.isAndroid || GetPlatform.isIOS) {
    await FcmNotificationService.initialize();
  }
  await initLocalStorage();
  final musicDatabase = MusicSqliteService();
  await musicDatabase.initialize();
  final appPrefs = await SqliteStore.openBox('AppPrefs');

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
  BackgroundExecutionService.initialize();
  _setAppInitPrefs();
  startApplicationServices(musicDatabase);
  Get.put<AudioHandler>(await initAudioService(), permanent: true);
  WidgetsBinding.instance.addObserver(LifecycleHandler());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
  unawaited(NotificationService.initInboxSync(
    mobile: GetPlatform.isAndroid || GetPlatform.isIOS,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService.onNotificationReceived = (title, message, type) {
        if (type != 'in_app') return;
        Get.dialog<void>(
          AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: Get.back,
                child: const Text('Entendido'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      };
    });
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
        locale: (SqliteStore.box("AppPrefs").get('currentAppLanguageCode') ==
                    null ||
                SqliteStore.box("AppPrefs")
                    .get('autoLanguage', defaultValue: true))
            ? Get.deviceLocale
            : Locale(SqliteStore.box("AppPrefs").get('currentAppLanguageCode')),
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
                      SqliteStore.box("AppPrefs").get("themeModeType"),
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

void startApplicationServices(MusicSqliteService musicDatabase) {
  Get.put(AuthService(), permanent: true);
  Get.put(musicDatabase, permanent: true);
  Get.put(PendingSyncQueueService(), permanent: true);
  Get.put(SyncService(), permanent: true);
  Get.put(ColisteningService(), permanent: true);
  Get.put(AppBackupService(), permanent: true);
  Get.put(CatalogRecoveryService(), permanent: true);
  Get.put(CloudBackupService(), permanent: true);
  Get.put(CloudMigrationService(), permanent: true);
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

Future<void> initLocalStorage() async {
  String applicationDataDirectoryPath;
  if (GetPlatform.isDesktop) {
    applicationDataDirectoryPath =
        "${(await getApplicationSupportDirectory()).path}/db";
  } else {
    applicationDataDirectoryPath =
        (await getApplicationDocumentsDirectory()).path;
  }
  await SqliteStore.initFlutter(applicationDataDirectoryPath);
  await SqliteStore.openBox("SongsCache");
  await SqliteStore.openBox("SongDownloads");
  await SqliteStore.openBox('SongsUrlCache');
  await SqliteStore.openBox("AppPrefs");

  // Pre-create the logical stores most controllers use during startup.
  await SqliteStore.openBox("LIBFAV");
  await SqliteStore.openBox("LIBRP");
  await SqliteStore.openBox("LibraryArtists");
  await SqliteStore.openBox("LibraryAlbums");
  await SqliteStore.openBox("LibraryPlaylists");
  await SqliteStore.openBox("homeScreenData");
  await SqliteStore.openBox(PendingSyncQueueService.boxName);
}

void _setAppInitPrefs() {
  final appPrefs = SqliteStore.box("AppPrefs");
  if (appPrefs.isEmpty) {
    appPrefs.putAll({
      'themeModeType': 0,
      "cacheSongs": false,
      "skipSilenceEnabled": false,
      'streamingQuality': 1,
      'themePrimaryColor': 4278199603,
      'discoverContentType': "QP",
      'startupTabIndex': 0,
      'newVersionVisibility': updateCheckFlag,
      "cacheHomeScreenData": true,
      "restrorePlaybackSession": true,
      "autoLanguage": true,
      "app_first_run_timestamp": DateTime.now().toIso8601String(),
      "emusicDataMode": "local",
      "hasPendingSync": false,
      "cloudMigrationStatus": "not_started",
      "linkedDeviceId": "",
      "emusicModeChoiceCompleted": false,
      "emusicCloudRequested": false,
    });
  } else {
    appPrefs.put("emusicDataMode",
        appPrefs.get("emusicDataMode", defaultValue: "local"));
    appPrefs.put(
        "hasPendingSync", appPrefs.get("hasPendingSync", defaultValue: false));
    appPrefs.put("cloudMigrationStatus",
        appPrefs.get("cloudMigrationStatus", defaultValue: "not_started"));
    appPrefs.put(
        "linkedDeviceId", appPrefs.get("linkedDeviceId", defaultValue: ""));
    appPrefs.put("emusicModeChoiceCompleted",
        appPrefs.get("emusicModeChoiceCompleted", defaultValue: false));
    appPrefs.put("emusicCloudRequested",
        appPrefs.get("emusicCloudRequested", defaultValue: false));
  }
}

class LifecycleHandler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      unawaited(NotificationService.syncMessages());
      if (GetPlatform.isAndroid || GetPlatform.isIOS) {
        unawaited(FcmNotificationService.registerCurrentToken());
      }
      if (Get.isRegistered<SyncService>()) {
        unawaited(Get.find<SyncService>().pullRemoteChanges());
      }
    } else if (state == AppLifecycleState.detached) {
      await Get.find<AudioHandler>().customAction("saveSession");
    }
  }
}
