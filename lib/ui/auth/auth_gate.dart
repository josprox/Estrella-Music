import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../services/auth_service.dart';
import '../../services/update_service.dart';
import '../../services/user_data_bootstrap_service.dart';
import '../home.dart';
import '../screens/Update/update_screen.dart';
import 'account_bootstrap_screen.dart';
import 'cloud_migration_screen.dart';
import 'cloud_mode_choice_screen.dart';
import 'music_auth_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
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

    if (!hasUpdate) {
      Get.find<AuthService>().restoreSession();
      
      final prefs = Hive.box('AppPrefs');
      final modeChoiceCompleted =
          prefs.get('emusicModeChoiceCompleted', defaultValue: false) == true;
      if (!modeChoiceCompleted) {
        final bootstrapService = Get.find<UserDataBootstrapService>();
        final hasData = await bootstrapService.hasMeaningfulLocalData();
        if (!hasData) {
          await prefs.put('emusicModeChoiceCompleted', true);
          await prefs.put('emusicDataMode', 'local');
          await prefs.put('emusicCloudRequested', false);
        }
      }
    }
  }

  Future<void> _keepLocalMode() async {
    final prefs = Hive.box('AppPrefs');
    await prefs.put('emusicDataMode', 'local');
    await prefs.put('emusicModeChoiceCompleted', true);
    await prefs.put('emusicCloudRequested', false);
    await prefs.put('hasPendingSync', false);
    if (mounted) setState(() {});
  }

  Future<void> _chooseCloudMode() async {
    final prefs = Hive.box('AppPrefs');
    await prefs.put('emusicModeChoiceCompleted', true);
    await prefs.put('emusicCloudRequested', true);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final bootstrapService = Get.find<UserDataBootstrapService>();
    return Obx(() {
      final prefs = Hive.box('AppPrefs');
      final modeChoiceCompleted =
          prefs.get('emusicModeChoiceCompleted', defaultValue: false) == true;
      final cloudRequested =
          prefs.get('emusicCloudRequested', defaultValue: false) == true;
      final dataMode =
          prefs.get('emusicDataMode', defaultValue: 'local').toString();

      if (isUpdateChecked.isFalse) {
        return const AccountBootstrapScreen(
          title: 'Estrella Music',
          message: 'Buscando actualizaciones...',
        );
      }

      if (updateRequired.isTrue) {
        return const UpdateScreen();
      }

      if (!modeChoiceCompleted) {
        return CloudModeChoiceScreen(
          onKeepLocal: _keepLocalMode,
          onChooseCloud: _chooseCloudMode,
        );
      }

      if (authService.isLoadingSession.isTrue) {
        return const AccountBootstrapScreen(
          title: 'Validando tu sesion',
          message: 'Un momento, estamos preparando Estrella Music.',
        );
      }

      if (authService.isAuthenticated.isFalse) {
        if (!cloudRequested && dataMode == 'local') {
          return const Home();
        }
        bootstrapService.resetRuntimeState();
        return const MusicAuthScreen();
      }

      if (cloudRequested && dataMode != 'cloud') {
        return const CloudMigrationScreen();
      }

      if (bootstrapService.needsBootstrapForCurrentUser) {
        Future.microtask(bootstrapService.prepareForAuthenticatedUser);
      }

      if (bootstrapService.isPreparing.isTrue) {
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
