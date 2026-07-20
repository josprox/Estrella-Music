import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';

import 'package:harmonymusic/ui/widgets/loader.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import 'package:harmonymusic/generated/l10n.dart';

class LyricsWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool isFull;
  const LyricsWidget({super.key, required this.padding, this.isFull = false});

  @override
  Widget build(BuildContext context) {
    final playerController = Get.find<PlayerController>();
    return Obx(() {
      if (playerController.isLyricsLoading.isTrue) {
        return const Center(child: LoadingIndicator());
      }

      final synced = playerController.lyrics['synced'].toString();
      final plain = playerController.lyrics["plainLyrics"].toString();
      final hasSynced = synced.isNotEmpty && synced != 'null' && synced != '""';
      final hasPlain = plain.isNotEmpty && plain != 'NA' && plain != 'null';
      final mode = playerController.lyricsMode.toInt();

      // Accessing reactive variables to ensure Obx rebuilds when they change
      final currentScale = playerController.lyricsTextScale.value;
      final currentAlign = playerController.lyricsAlignment.value;
      final showTranslation = playerController.isTranslationEnabled.value;
      final tSynced = playerController.translatedLyrics["synced"].toString();
      final tPlain = playerController.translatedLyrics["plainLyrics"].toString();

      // Determine what to show based on availability and preferred mode
      bool showSynced = false;
      if (mode == 0) {
        showSynced = hasSynced;
      } else {
        showSynced = !hasPlain && hasSynced;
      }

      Widget content;

      if (showSynced) {
        var model = LyricsModelBuilder.create().bindLyricToMain(synced);
        if (showTranslation && tSynced.isNotEmpty) {
          model = model.bindLyricToExt(tSynced);
        }
        
        content = IgnorePointer(
          ignoring: !isFull,
          child: LyricsReader(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            lyricUi: playerController.lyricUi,
            position: playerController
                .progressBarStatus.value.current.inMilliseconds,
            model: model.getModel(),
            emptyBuilder: () => _buildNoLyrics(context, playerController),
          ),
        );
      } else if (hasPlain || (mode == 1 && !hasSynced)) {
        String displayedText = hasPlain ? plain : S.current.lyricsNotAvailable;
        if (showTranslation && tPlain.isNotEmpty && tPlain != "null" && tPlain != "NA") {
          final originalLines = plain.split('\n');
          final translatedLines = tPlain.split('\n');
          final List<String> combined = [];
          for (int i = 0; i < originalLines.length; i++) {
            combined.add(originalLines[i].trim());
            if (i < translatedLines.length && translatedLines[i].trim().isNotEmpty) {
              combined.add("(${translatedLines[i].trim()})");
            }
            combined.add(""); // Empty line for stanza spacing
          }
          displayedText = combined.join('\n');
        }

        content = Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: padding,
            child: TextSelectionTheme(
              data: Theme.of(context).textSelectionTheme,
              child: SelectableText(
                displayedText,
                textAlign: currentAlign == LyricAlign.LEFT ? TextAlign.left : TextAlign.center,
                style: playerController.isDesktopLyricsDialogOpen
                    ? Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: (Theme.of(context).textTheme.titleMedium!.fontSize ?? 16) * currentScale,
                        )
                    : TextStyle(
                        color: Colors.white,
                        fontSize: 18 * currentScale,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
              ),
            ),
          ),
        );
      } else {
        content = _buildNoLyrics(context, playerController);
      }

      // Elegant top/bottom fade edge blending
      return ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: [0.0, 0.08, 0.92, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: content,
      );
    });
  }

  Widget _buildNoLyrics(BuildContext context, PlayerController ctrl) {
    final currentScale = ctrl.lyricsTextScale.value;
    return Center(
      child: Text(
        S.current.lyricsNotAvailable,
        textAlign: TextAlign.center,
        style: ctrl.isDesktopLyricsDialogOpen
            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: (Theme.of(context).textTheme.titleMedium!.fontSize ?? 16) * currentScale,
                )
            : TextStyle(
                color: Colors.white70,
                fontSize: 18 * currentScale,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
