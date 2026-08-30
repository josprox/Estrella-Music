import 'package:audio_service/audio_service.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'package:estrella_music/ui/widgets/liquid_bottom_navigation_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:estrella_music/services/backup/app_backup_service.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/services/auth/catalog_recovery_service.dart';
import 'package:estrella_music/services/backup/cloud_backup_service.dart';
import 'package:estrella_music/services/sync/legacy_music_migration_service.dart';
import 'package:estrella_music/services/system/notification_service.dart';
import 'package:estrella_music/services/sync/pending_sync_queue_service.dart';
import 'package:estrella_music/services/sync/music_sqlite_service.dart';
import 'package:estrella_music/services/sync/sync_service.dart';
import 'package:estrella_music/services/sync/cloud_sync_manager.dart';
import 'package:estrella_music/services/social/colistening_service.dart';
import 'package:estrella_music/services/auth/user_data_bootstrap_service.dart';
import '/ui/screens/Search/search_screen_controller.dart';
import 'package:estrella_music/services/download/downloader.dart';
import 'package:estrella_music/services/background/background_execution_service.dart';
import 'package:estrella_music/utils/desktop/app_link_controller.dart';
import 'package:estrella_music/services/music/audio_handler.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/music_provider/music_provider_manager.dart';
import 'package:estrella_music/music_provider/providers/emusic_provider.dart';
import 'package:estrella_music/music_provider/providers/local_music_provider.dart';
import 'package:estrella_music/profiles/app_profile_lifecycle_coordinator.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/profiles/profile_persistence.dart';
import 'package:estrella_music/profiles/profile_storage_namespace.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'ui/screens/Settings/settings_screen_controller.dart';
import 'ui/auth/auth_gate.dart';
import 'ui/permissions/permission_consent_gate.dart';
import '/ui/utils/theme_controller.dart';
import 'ui/screens/Home/home_screen_controller.dart';
import 'ui/screens/Library/library_controller.dart';
import 'package:estrella_music/utils/desktop/system_tray.dart';
import 'package:estrella_music/utils/helpers/update_check_flag_file.dart';

import 'package:workmanager/workmanager.dart';
import 'package:estrella_music/services/backup/background_backup_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {}
  await initLocalStorage();
  final authService = Get.put(AuthService(), permanent: true);
  // Provider restoration happens only after the global Joss Red session has
  // been restored, otherwise a saved eMusic profile would fail on every boot.
  await authService.restoreSession();
  final providerManager = MusicProviderManager(
    localProviderId: LocalMusicProvider.providerId,
  );
  providerManager.register(const ProviderRegistration(
    id: LocalMusicProvider.providerId,
    displayName: 'Local',
    factory: LocalMusicProvider.new,
    trust: ProviderTrust.local,
  ));
  providerManager.register(ProviderRegistration(
    id: EMusicProvider.providerId,
    displayName: 'eMusic',
    factory: () => EMusicProvider(
      baseUrl: () => dotenv.env['EMUSICWEB'] ?? authService.baseUrl ?? '',
      tokenLoader: authService.getAccessToken,
      playbackContextLoader: _loadEMusicPlaybackContext,
    ),
    trust: ProviderTrust.jossRedAuthorized,
  ));
  Get.put(providerManager, permanent: true);
  final profileManager = ProfileManager(
    providerManager: providerManager,
    persistence: SqliteProfilePersistence(),
    lifecycle: AppProfileLifecycleCoordinator(),
  );
  Get.put(profileManager, permanent: true);
  await profileManager.initialize();
  Get.put(
    MusicCatalogService(
      providerManager: providerManager,
      profileManager: profileManager,
    ),
    permanent: true,
  );
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

Future<EMusicPlaybackContext> _loadEMusicPlaybackContext() async {
  final prefs = SqliteStore.box('AppPrefs');
  final visitorEntry = prefs.get('visitorId');
  final visitorData = visitorEntry is Map
      ? visitorEntry['id']?.toString()
      : visitorEntry?.toString();
  String? firstString(List<String> keys) {
    for (final key in keys) {
      final value = prefs.get(key)?.toString().trim();
      if (value != null && value.isNotEmpty && value != 'null') return value;
    }
    return null;
  }

  return EMusicPlaybackContext(
    clientIp: firstString(const ['clientIp', 'clientIP', 'streamClientIp']),
    visitorData: visitorData,
    poToken: firstString(const ['poToken', 'po_token', 'streamPoToken']),
  );
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
    if (!kIsWeb && !Get.isRegistered<AppLinksController>()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!Get.isRegistered<AppLinksController>()) {
          Get.put(AppLinksController(), permanent: true);
        }
      });
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return GetMaterialApp(
        title: 'Estrella Music',
        home: const PermissionConsentGate(child: AuthGate()),
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
  Get.put(musicDatabase, permanent: true);
  Get.put(PendingSyncQueueService(), permanent: true);
  Get.put(SyncService(), permanent: true);
  Get.put(CloudSyncManager(), permanent: true);
  Get.put(ColisteningService(), permanent: true);
  Get.put(AppBackupService(), permanent: true);
  Get.put(CatalogRecoveryService(), permanent: true);
  Get.put(CloudBackupService(), permanent: true);
  Get.put(LegacyMusicMigrationService(), permanent: true);
  Get.put(UserDataBootstrapService(), permanent: true);
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
  SqliteStore.boxNameResolver = ProfileStorageNamespace.resolve;
  SqliteStore.boxBackendResolver = ProfileStorageNamespace.backendFor;
  for (final globalBox in const [
    'AppPrefs',
    'MusicProfiles',
    'MusicProfileState',
  ]) {
    await SqliteStore.copySqliteBoxToHive(
      sourcePhysicalName: globalBox,
      targetPhysicalName: globalBox,
    );
    await SqliteStore.openBox(globalBox);
  }
}

void _setAppInitPrefs() {
  final appPrefs = SqliteStore.box("AppPrefs");
  final defaults = <String, dynamic>{
    'themeModeType': 0,
    'cacheSongs': false,
    'skipSilenceEnabled': false,
    'streamingQuality': 1,
    'themePrimaryColor': 4278199603,
    'discoverContentType': 'QP',
    'startupTabIndex': 0,
    'newVersionVisibility': updateCheckFlag,
    'cacheHomeScreenData': true,
    'restrorePlaybackSession': true,
    'autoLanguage': true,
    'app_first_run_timestamp': DateTime.now().toIso8601String(),
    'hasPendingSync': false,
    'linkedDeviceId': '',
  };
  for (final entry in defaults.entries) {
    if (!appPrefs.containsKey(entry.key)) {
      appPrefs.put(entry.key, entry.value);
    }
  }
}

class LifecycleHandler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      unawaited(NotificationService.syncMessagesOnResume());
      NotificationService.resumeDesktopPolling();
      if (Get.isRegistered<SyncService>()) {
        unawaited(Get.find<SyncService>().pullRemoteChanges());
      }
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      NotificationService.pauseDesktopPolling();
    } else if (state == AppLifecycleState.detached) {
      await Get.find<AudioHandler>().customAction("saveSession");
    }
  }
}
