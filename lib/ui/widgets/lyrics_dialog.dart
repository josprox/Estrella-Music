import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/ui/player/components/lyrics_switch.dart';
import '/ui/player/components/lyrics_widget.dart';
import '/ui/widgets/common_dialog_widget.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';

class LyricsDialog extends StatelessWidget {
  const LyricsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();

    return CommonDialog(
      maxWidth: 750,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0, top: 20, left: 20, right: 20),
            child: Row(
              children: [
                const Expanded(child: LyricsSwitch()),
                const SizedBox(width: 12),
                Obx(() {
                  final isTranslating =
                      playerController.isTranslationLoading.value;
                  final isEnabled = playerController.isTranslationEnabled.value;
                  return IconButton(
                    tooltip: 'Traducir',
                    icon: isTranslating
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            Icons.translate_rounded,
                            color: isEnabled
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                    onPressed: () => playerController.toggleTranslation(),
                  );
                }),
              ],
            ),
          ),
          const Expanded(
            child: LyricsWidget(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20)),
          ),
        ],
      ),
    );
  }
}
