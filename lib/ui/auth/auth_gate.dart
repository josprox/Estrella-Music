import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estrella_music/services/auth/auth_service.dart';
import 'package:estrella_music/services/auth/authentication_access_policy.dart';
import 'package:estrella_music/services/system/update_service.dart';
import 'package:estrella_music/services/auth/user_data_bootstrap_service.dart';
import 'package:estrella_music/profiles/profile_manager.dart';
import 'package:estrella_music/ui/home.dart';
import 'package:estrella_music/ui/screens/Update/update_screen.dart';
import 'package:estrella_music/services/storage/sqlite_store.dart';
import 'account_bootstrap_screen.dart';
import 'music_auth_screen.dart';
import 'welcome_profile_setup_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  static const _accessPolicy = AuthenticationAccessPolicy();
  final isUpdateChecked = false.obs;
  final updateRequired = false.obs;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final hasUpdate = await UpdateService.checkForUpdate();
    updateRequired.value = hasUpdate;
    isUpdateChecked.value = true;

    if (!hasUpdate && !Get.find<AuthService>().isAuthenticated.value) {
      await Get.find<AuthService>().restoreSession();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final bootstrapService = Get.find<UserDataBootstrapService>();
    return Obx(() {
      if (isUpdateChecked.isFalse) {
        return const AccountBootstrapScreen(
          title: 'Estrella Music',
          message: 'Buscando actualizaciones...',
        );
      }

      if (updateRequired.isTrue) {
        return const UpdateScreen();
      }

      if (authService.isLoadingSession.isTrue) {
        return const AccountBootstrapScreen(
          title: 'Validando tu sesion',
          message: 'Un momento, estamos preparando Estrella Music.',
        );
      }

      if (!_accessPolicy.canEnterApplication(
        isAuthenticated: authService.isAuthenticated.value,
      )) {
        bootstrapService.resetRuntimeState();
        return const MusicAuthScreen();
      }

      final isWelcomeCompleted = SqliteStore.box('AppPrefs')
              .get('welcomeProfileOnboardingCompleted', defaultValue: false)
          as bool;

      if (!isWelcomeCompleted) {
        return const WelcomeProfileSetupScreen();
      }

      final profileManager = Get.find<ProfileManager>();
      if (profileManager.activeProfileMaySync &&
          bootstrapService.needsBootstrapForCurrentUser) {
        Future.microtask(bootstrapService.prepareForAuthenticatedUser);
      }

      if (profileManager.activeProfileMaySync &&
          bootstrapService.isPreparing.isTrue) {
        return AccountBootstrapScreen(
          title: 'Sincronizando tu cuenta',
          message: bootstrapService.statusMessage.value,
          details: bootstrapService.lastError.value.isEmpty
              ? 'Estamos dejando lista tu cuenta para que entres con todos tus datos desde el primer momento.'
              : bootstrapService.lastError.value,
          willReplaceLocalData: bootstrapService.willReplaceLocalData.value,
        );
      }

      if (authService.isAuthenticated.isTrue) {
        return const Home();
      }

      return const MusicAuthScreen();
    });
  }
}
