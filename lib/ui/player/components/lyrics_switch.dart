import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/generated/l10n.dart';
import 'package:harmonymusic/ui/utils/theme_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:harmonymusic/ui/player/player_controller.dart';

class LyricsSwitch extends StatelessWidget {
  const LyricsSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find<PlayerController>();
    return Obx(
      () => playerController.showLyricsflag.value
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Theme.of(context).primaryColor.withLightness(0.4)],
                  [Theme.of(context).primaryColor.withLightness(0.4)]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Theme.of(context).colorScheme.secondary,
                inactiveFgColor: Colors.white,
                initialLabelIndex: playerController.lyricsMode.value,
                totalSwitches: 2,
                labels: [S.current.synced, S.current.plain],
                radiusStyle: true,
                onToggle: playerController.changeLyricsMode,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
