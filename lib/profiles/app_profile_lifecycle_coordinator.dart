import 'package:audio_service/audio_service.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/ui/profiles/profile_switcher.dart';

import 'music_profile.dart';
import 'profile_manager.dart';

class AppProfileLifecycleCoordinator implements ProfileLifecycleCoordinator {
  @override
  Future<Map<String, dynamic>> deactivate(MusicProfile profile) async {
    if (!Get.isRegistered<AudioHandler>()) return const {};
    final handler = Get.find<AudioHandler>();
    await handler.customAction('saveSession');
    await handler.stop();
    await handler.updateQueue(const []);
    return {'savedAt': DateTime.now().toUtc().toIso8601String()};
  }

  @override
  Future<void> activate(
    MusicProfile profile,
    Map<String, dynamic> savedState,
  ) async {
    if (Get.isRegistered<PlayerController>()) {
      await Get.find<PlayerController>().restoreProfilePlaybackState();
    }
    await ProfileSwitcher.refreshActiveContext();
  }
}
