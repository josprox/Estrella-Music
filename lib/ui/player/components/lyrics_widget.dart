import 'package:flutter/material.dart';
import 'package:flutter_lyric/flutter_lyric.dart';
import 'package:get/get.dart';

import 'package:estrella_music/ui/widgets/loader.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/generated/l10n.dart';

class LyricsWidget extends StatefulWidget {
  final EdgeInsetsGeometry padding;
  final bool isFull;
  const LyricsWidget({super.key, required this.padding, this.isFull = false});

  @override
  State<LyricsWidget> createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget> {
  final LyricController _lyricController = LyricController();
  String? _lastSynced;
  String? _lastTranslation;

  @override
  void dispose() {
    _lyricController.dispose();
    super.dispose();
  }

  void _syncLyrics(String synced, String? translation) {
    if (_lastSynced != synced || _lastTranslation != translation) {
      _lastSynced = synced;
      _lastTranslation = translation;
      _lyricController.loadLyric(synced, translationLyric: translation);
    }
  }

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

      final currentScale = playerController.lyricsTextScale.value;
      final currentAlign = playerController.lyricsAlignment.value;
      final colorScheme = Theme.of(context).colorScheme;
      final showTranslation = playerController.isTranslationEnabled.value;
      final tSynced = playerController.translatedLyrics["synced"].toString();
      final tPlain =
          playerController.translatedLyrics["plainLyrics"].toString();

      bool showSynced = false;
      if (mode == 0) {
        showSynced = hasSynced;
      } else {
        showSynced = !hasPlain && hasSynced;
      }

      Widget content;

      if (showSynced) {
        _syncLyrics(synced, (showTranslation && tSynced.isNotEmpty) ? tSynced : null);
        _lyricController.setProgress(playerController.progressBarStatus.value.current);

        final align = currentAlign == LyricAlign.left ? TextAlign.left : TextAlign.center;
        final crossAlign = currentAlign == LyricAlign.left ? CrossAxisAlignment.start : CrossAxisAlignment.center;

        final lyricStyle = LyricStyles.default1.copyWith(
          textStyle: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.42),
            fontSize: 18 * currentScale,
            fontWeight: FontWeight.w600,
          ),
          activeStyle: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 24 * currentScale,
            fontWeight: FontWeight.w900,
          ),
          translationStyle: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 14 * currentScale,
            fontWeight: FontWeight.w500,
          ),
          translationActiveColor: colorScheme.onSurface.withValues(alpha: 0.8),
          textAlign: align,
          contentAlignment: crossAlign,
          lineGap: 24 * currentScale,
          selectedColor: colorScheme.onSurface,
          selectedTranslationColor: colorScheme.onSurface.withValues(alpha: 0.8),
        );

        content = IgnorePointer(
          ignoring: !widget.isFull,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LyricView(
              controller: _lyricController,
              style: lyricStyle,
            ),
          ),
        );
      } else if (hasPlain || (mode == 1 && !hasSynced)) {
        Widget childWidget;
        if (showTranslation &&
            tPlain.isNotEmpty &&
            tPlain != "null" &&
            tPlain != "NA") {
          final originalLines = plain.split('\n');
          final translatedLines = tPlain.split('\n');
          final List<InlineSpan> spans = [];

          for (int i = 0; i < originalLines.length; i++) {
            final orig = originalLines[i].trim();
            if (orig.isNotEmpty) {
              spans.add(TextSpan(
                text: "$orig\n",
                style: playerController.isDesktopLyricsDialogOpen
                    ? Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: (Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize ??
                                  16) *
                              currentScale,
                          fontWeight: FontWeight.w700,
                        )
                    : TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 18 * currentScale,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
              ));
            }
            if (i < translatedLines.length &&
                translatedLines[i].trim().isNotEmpty) {
              spans.add(TextSpan(
                text: "(${translatedLines[i].trim()})\n",
                style: playerController.isDesktopLyricsDialogOpen
                    ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.65),
                          fontSize: (Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .fontSize ??
                                  14) *
                              currentScale,
                          fontWeight: FontWeight.w500,
                        )
                    : TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: 0.65),
                        fontSize: 15 * currentScale,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
              ));
            }
            spans.add(const TextSpan(text: "\n"));
          }

          childWidget = SelectableText.rich(
            TextSpan(children: spans),
            textAlign: currentAlign == LyricAlign.left
                ? TextAlign.left
                : TextAlign.center,
          );
        } else {
          String displayedText =
              hasPlain ? plain : S.current.lyricsNotAvailable;
          childWidget = SelectableText(
            displayedText,
            textAlign: currentAlign == LyricAlign.left
                ? TextAlign.left
                : TextAlign.center,
            style: playerController.isDesktopLyricsDialogOpen
                ? Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize:
                          (Theme.of(context).textTheme.titleMedium!.fontSize ??
                                  16) *
                              currentScale,
                    )
                : TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 18 * currentScale,
                    fontWeight: FontWeight.w700,
                    height: 1.6,
                  ),
          );
        }

        content = Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: widget.padding,
            child: TextSelectionTheme(
              data: Theme.of(context).textSelectionTheme,
              child: childWidget,
            ),
          ),
        );
      } else {
        content = _buildNoLyrics(context, playerController);
      }

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
                  fontSize:
                      (Theme.of(context).textTheme.titleMedium!.fontSize ??
                              16) *
                          currentScale,
                )
            : TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 18 * currentScale,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
