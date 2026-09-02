import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:audio_service/audio_service.dart';
import 'package:estrella_music/services/music/music_recognition_service.dart';
import 'package:estrella_music/music_provider/music_catalog_service.dart';
import 'package:estrella_music/ui/player/player_controller.dart';
import 'package:estrella_music/ui/widgets/loader.dart';
import 'package:estrella_music/ui/navigator.dart';
import 'package:estrella_music/generated/l10n.dart';

class MusicRecognitionBottomSheet extends StatefulWidget {
  const MusicRecognitionBottomSheet({super.key});

  @override
  State<MusicRecognitionBottomSheet> createState() =>
      _MusicRecognitionBottomSheetState();
}

class _MusicRecognitionBottomSheetState
    extends State<MusicRecognitionBottomSheet> {
  final MusicRecognitionService _recognitionService = MusicRecognitionService();
  final MusicCatalogService _musicServices = Get.find<MusicCatalogService>();
  final PlayerController _playerController = Get.find<PlayerController>();

  RecognitionState _state = RecognitionState.idle;
  RecognitionResult? _result;
  String _errorMessage = '';
  bool _isPlayingLoader = false;

  @override
  void initState() {
    super.initState();
    // Auto-start recognition when sheet is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startRecognition();
    });
  }

  @override
  void dispose() {
    _recognitionService.stopRecording();
    super.dispose();
  }

  Future<void> _startRecognition() async {
    setState(() {
      _state = RecognitionState.idle;
      _result = null;
      _errorMessage = '';
      _isPlayingLoader = false;
    });

    final res = await _recognitionService.recognizeMusic(
      onStateChanged: (state) {
        if (mounted) {
          setState(() {
            _state = state;
          });
        }
      },
      onError: (msg) {
        if (mounted) {
          setState(() {
            _errorMessage = msg;
            _state = RecognitionState.error;
          });
        }
      },
    );

    if (mounted && res != null) {
      setState(() {
        _result = res;
      });
    }
  }

  Future<void> _playRecognizedTrack() async {
    if (_result == null) return;
    setState(() {
      _isPlayingLoader = true;
    });

    try {
      // 1. Search catalog for matching track
      final query = "${_result!.title} ${_result!.artist}";
      final searchRes =
          await _musicServices.search(query, filter: "songs", limit: 3);
      final List<dynamic>? songs = searchRes['Songs'];

      if (songs != null && songs.isNotEmpty) {
        final MediaItem matchItem = songs.first as MediaItem;
        // 2. Play using playerController
        await _playerController.pushSongToQueue(matchItem);
        if (mounted) {
          Navigator.pop(context); // Close bottom sheet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${S.current.playingRecognizedTrack} ${matchItem.title} - ${matchItem.artist}'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
      } else {
        // Fallback: search without filter
        final generalSearchRes = await _musicServices.search(query, limit: 3);
        final List<dynamic>? generalSongs = generalSearchRes['Songs'];
        if (generalSongs != null && generalSongs.isNotEmpty) {
          final MediaItem matchItem = generalSongs.first as MediaItem;
          await _playerController.pushSongToQueue(matchItem);
          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '${S.current.playingRecognizedTrack} ${matchItem.title} - ${matchItem.artist}'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
          }
        } else {
          throw Exception(
              "No se encontró el tema en los servidores de reproducción.");
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.current.errorPlayingTrack} $e'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPlayingLoader = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
      child: Obx(() {
        final double playerHeight =
            _playerController.playerPanelMinHeight.value;
        final double extraBottomPadding = playerHeight > 0
            ? (playerHeight > Get.mediaQuery.padding.bottom
                ? playerHeight - Get.mediaQuery.padding.bottom
                : playerHeight)
            : 0.0;

        return Container(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: 24.0 + extraBottomPadding,
          ),
          decoration: BoxDecoration(
            color: brightness == Brightness.dark
                ? Colors.black.withValues(alpha: 0.65)
                : Colors.white.withValues(alpha: 0.75),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            border: Border.all(
              color: brightness == Brightness.dark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.05),
              width: 1.0,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bottom sheet drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildContent(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContent() {
    switch (_state) {
      case RecognitionState.idle:
      case RecognitionState.listening:
        return _buildListeningState();
      case RecognitionState.processing:
        return _buildProcessingState();
      case RecognitionState.success:
        return _buildSuccessState();
      case RecognitionState.noMatch:
        return _buildNoMatchState();
      case RecognitionState.error:
        return _buildErrorState();
    }
  }

  Widget _buildListeningState() {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          S.current.musicRecognition,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          S.current.listeningToEnvironment,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 200,
          height: 200,
          child: RipplesAnimation(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _recognitionService.stopRecording();
                  Navigator.pop(context);
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.music_note_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          S.current.micInstruction,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProcessingState() {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          S.current.processingAudio,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 40),
        const SizedBox(
          width: 120,
          height: 120,
          child: Center(
            child: LoadingIndicator(),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          S.current.shazamSearching,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSuccessState() {
    if (_result == null) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final hasCover =
        _result!.coverArtHqUrl != null || _result!.coverArtUrl != null;
    final coverUrl = _result!.coverArtHqUrl ?? _result!.coverArtUrl ?? '';

    return Column(
      children: [
        Text(
          S.current.songFound,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent.shade700,
          ),
        ),
        const SizedBox(height: 16),
        // Album art with rich glow
        Center(
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.25),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: hasCover
                  ? CachedNetworkImage(
                      imageUrl: coverUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.08),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.08),
                        child: Icon(Icons.music_note,
                            size: 50, color: theme.colorScheme.primary),
                      ),
                    )
                  : Container(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.08),
                      child: Icon(Icons.music_note,
                          size: 50, color: theme.colorScheme.primary),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _result!.title,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _result!.artist,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        if (_result!.album != null && _result!.album!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _result!.album!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ],
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _isPlayingLoader ? null : _playRecognizedTrack,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: _isPlayingLoader
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.play_arrow_rounded),
                label: Text(S.current.playNow),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // search in library
                  Get.toNamed(
                    ScreenNavigationSetup.searchResultScreen,
                    id: ScreenNavigationSetup.id,
                    arguments: "${_result!.title} ${_result!.artist}",
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: BorderSide(
                      color: theme.colorScheme.outline.withValues(alpha: 0.4)),
                ),
                icon: const Icon(Icons.search_rounded),
                label: Text(S.current.searchInLibrary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNoMatchState() {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        Icon(
          Icons.sentiment_dissatisfied_rounded,
          size: 72,
          color: theme.colorScheme.error.withValues(alpha: 0.7),
        ),
        const SizedBox(height: 16),
        Text(
          S.current.noMatchesFound,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          S.current.noMatchInstruction,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _startRecognition,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.replay_rounded),
                label: Text(S.current.retry),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.current.cancel),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    final theme = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        Icon(
          Icons.error_outline_rounded,
          size: 72,
          color: theme.colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          S.current.errorOccurred,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: theme.colorScheme.error,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: _startRecognition,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.replay_rounded),
                label: Text(S.current.retry),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.current.close),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RipplesAnimation extends StatefulWidget {
  final Widget child;
  const RipplesAnimation({super.key, required this.child});

  @override
  State<RipplesAnimation> createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<RipplesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RipplePainter(_controller, color),
          child: widget.child,
        );
      },
    );
  }
}

class RipplePainter extends CustomPainter {
  final Animation<double> _animation;
  final Color color;
  RipplePainter(this._animation, this.color) : super(repaint: _animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Paint paint = Paint()
      ..color = color.withValues(alpha: opacity * 0.25)
      ..style = PaintingStyle.fill;

    final double radius = rect.width / 2 * (value / 4.0);
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  bool shouldRepaint(RipplePainter oldDelegate) => true;
}
