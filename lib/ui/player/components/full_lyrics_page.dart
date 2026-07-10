import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';
import '/ui/utils/theme_controller.dart';
import 'lyrics_widget.dart';
import 'package:harmonymusic/ui/widgets/lyrics_search_dialog.dart';

class AnimatedAlbumArt extends StatefulWidget {
  final ImageProvider? artImageProvider;
  final bool isPlaying;
  const AnimatedAlbumArt({super.key, this.artImageProvider, required this.isPlaying});

  @override
  State<AnimatedAlbumArt> createState() => _AnimatedAlbumArtState();
}

class _AnimatedAlbumArtState extends State<AnimatedAlbumArt> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.04).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.04, end: 1.0).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedAlbumArt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = widget.isPlaying ? _scaleAnimation.value : 1.0;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: widget.isPlaying ? 0.35 : 0.15),
                  blurRadius: widget.isPlaying ? 35 : 20,
                  spreadRadius: widget.isPlaying ? 6 : 2,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: widget.artImageProvider != null
                  ? Image(image: widget.artImageProvider!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.grey[900],
                      child: const Icon(Icons.music_note_rounded, size: 100, color: Colors.white54),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class FullLyricsPage extends StatelessWidget {
  const FullLyricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PlayerController>();
    final themeCtrl = Get.find<ThemeController>();
    final mediaQuery = MediaQuery.of(context);
    final isWide = mediaQuery.size.width > 720;

    return Obx(() {
      final currentSong = ctrl.currentSong.value;
      final artUri = currentSong?.artUri;
      final isPlaying = ctrl.buttonState.value == PlayButtonState.playing;
      final totalSecs = ctrl.progressBarStatus.value.total.inSeconds;
      final currentSecs = ctrl.progressBarStatus.value.current.inSeconds;
      final progress = totalSecs > 0 ? currentSecs / totalSecs : 0.0;

      ImageProvider? artImageProvider;
      if (artUri != null) {
        artImageProvider = artUri.isScheme('file')
            ? FileImage(File(artUri.toFilePath()))
            : CachedNetworkImageProvider(artUri.toString()) as ImageProvider;
      }

      final primaryThemeColor = themeCtrl.primaryColor.value;

      return Scaffold(
        body: Stack(
          children: [
            // 1. Dynamic Organic Blurred Background
            Positioned.fill(
              child: Container(
                color: Colors.black,
              ),
            ),
            if (artImageProvider != null)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: artImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.60),
                    ),
                  ),
                ),
              )
            else
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryThemeColor.withValues(alpha: 0.3),
                        Colors.black87,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),

            // Subtle color overlay matching current primary color for extra depth
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryThemeColor.withValues(alpha: 0.15),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.4),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Main Content Layout
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Glassmorphic Navigation Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          color: Colors.white.withValues(alpha: 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const LyricsSearchDialog(),
                                  );
                                },
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                                  foregroundColor: Colors.white,
                                  hoverColor: Colors.white24,
                                ),
                                icon: const Icon(Icons.search_rounded, size: 22),
                              ),
                              if (!isWide)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Column(
                                      children: [
                                        Text(
                                          currentSong?.title ?? '',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          currentSong?.artist ?? '',
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                const Spacer(),
                              IconButton(
                                onPressed: () => Get.back(),
                                style: IconButton.styleFrom(
                                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                                  foregroundColor: Colors.white,
                                  hoverColor: Colors.white24,
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 26),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Responsive body
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: isWide
                          ? _buildWideLayout(context, ctrl, currentSong, artImageProvider, isPlaying, progress, primaryThemeColor)
                          : _buildMobileLayout(context, ctrl, currentSong, artImageProvider, isPlaying, progress),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // Tablet & Desktop Split Layout
  Widget _buildWideLayout(
    BuildContext context,
    PlayerController ctrl,
    dynamic currentSong,
    ImageProvider? artImageProvider,
    bool isPlaying,
    double progress,
    Color accentColor,
  ) {
    return Row(
      children: [
        // Left column - Player details
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedAlbumArt(
                artImageProvider: artImageProvider,
                isPlaying: isPlaying,
              ),
              const SizedBox(height: 32),
              
              Text(
                currentSong?.title ?? '',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currentSong?.artist ?? '',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 36),

              // Player control card
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
                    ),
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: accentColor,
                            inactiveTrackColor: Colors.white.withValues(alpha: 0.15),
                            thumbColor: Colors.white,
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                          ),
                          child: Slider(
                            value: progress,
                            onChanged: (val) {
                              final newPosition = Duration(seconds: (val * totalSecs(ctrl)).toInt());
                              ctrl.seek(newPosition);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(ctrl.progressBarStatus.value.current),
                                style: const TextStyle(color: Colors.white60, fontSize: 12),
                              ),
                              Text(
                                _formatDuration(ctrl.progressBarStatus.value.total),
                                style: const TextStyle(color: Colors.white60, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => ctrl.prev(),
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.skip_previous_rounded, size: 36),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () => ctrl.playPause(),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.all(16),
                                shadowColor: Colors.black26,
                                elevation: 8,
                              ),
                              icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 36),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () => ctrl.next(),
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.skip_next_rounded, size: 36),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 40),
        
        // Right column - Interactive Lyrics
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                const LyricsWidget(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  isFull: true,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: _buildLyricsPreferenceBar(ctrl),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Mobile layout
  Widget _buildMobileLayout(
    BuildContext context,
    PlayerController ctrl,
    dynamic currentSong,
    ImageProvider? artImageProvider,
    bool isPlaying,
    double progress,
  ) {
    return Column(
      children: [
        // Mini player glass panel
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: artImageProvider != null
                          ? Image(image: artImageProvider, fit: BoxFit.cover)
                          : Container(
                              color: Colors.grey[900],
                              child: const Icon(Icons.music_note_rounded, color: Colors.white54),
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong?.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          currentSong?.artist ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => ctrl.playPause(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 22),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Lyrics view with options bar stacked over it
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                const LyricsWidget(
                  padding: EdgeInsets.only(top: 24, bottom: 64, left: 16, right: 16),
                  isFull: true,
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: _buildLyricsPreferenceBar(ctrl),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Preferences configuration bar (Zoom, Alignment)
  Widget _buildLyricsPreferenceBar(PlayerController ctrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (ctrl.lyricsTextScale.value > 0.7) {
                    ctrl.lyricsTextScale.value -= 0.1;
                  }
                },
                tooltip: "Reducir tamaño",
                icon: const Icon(Icons.text_fields_rounded, size: 14, color: Colors.white70),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(28, 28),
                ),
              ),
              Obx(() => Text(
                    "${(ctrl.lyricsTextScale.value * 100).toInt()}%",
                    style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                  )),
              IconButton(
                onPressed: () {
                  if (ctrl.lyricsTextScale.value < 1.5) {
                    ctrl.lyricsTextScale.value += 0.1;
                  }
                },
                tooltip: "Aumentar tamaño",
                icon: const Icon(Icons.text_fields_rounded, size: 20, color: Colors.white70),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(28, 28),
                ),
              ),
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  color: Colors.white24,
                  width: 12,
                  thickness: 1,
                ),
              ),
              Obx(() {
                final isLeft = ctrl.lyricsAlignment.value == LyricAlign.LEFT;
                return IconButton(
                  onPressed: () {
                    ctrl.lyricsAlignment.value = isLeft ? LyricAlign.CENTER : LyricAlign.LEFT;
                  },
                  tooltip: isLeft ? "Centrar" : "Alinear izquierda",
                  icon: Icon(
                    isLeft ? Icons.format_align_left_rounded : Icons.format_align_center_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(28, 28),
                  ),
                );
              }),
              const SizedBox(
                height: 16,
                child: VerticalDivider(
                  color: Colors.white24,
                  width: 12,
                  thickness: 1,
                ),
              ),
              Obx(() {
                final themeCtrl = Get.find<ThemeController>();
                final isTranslationLoading = ctrl.isTranslationLoading.value;
                final isTranslationEnabled = ctrl.isTranslationEnabled.value;
                return IconButton(
                  onPressed: isTranslationLoading ? null : () => ctrl.toggleTranslation(),
                  tooltip: "Traducir",
                  icon: isTranslationLoading
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.translate_rounded,
                          size: 16,
                          color: isTranslationEnabled ? themeCtrl.primaryColor.value : Colors.white70,
                        ),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(28, 28),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  int totalSecs(PlayerController ctrl) {
    final secs = ctrl.progressBarStatus.value.total.inSeconds;
    return secs > 0 ? secs : 1;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return "$minutes:${twoDigits(seconds)}";
  }
}
