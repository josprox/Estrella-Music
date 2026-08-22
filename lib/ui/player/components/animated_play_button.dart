import 'package:material_ui/material_ui.dart';
import 'package:get/get.dart';
import 'package:harmonymusic/ui/player/player_controller.dart';

import 'package:harmonymusic/ui/widgets/loader.dart';

/// Animates between play and pause icons.
/// [iconColor] controls the icon color (default black for use on white button).
class AnimatedPlayButton extends StatefulWidget {
  final double iconSize;
  final Color iconColor;

  const AnimatedPlayButton({
    super.key,
    this.iconSize = 40.0,
    this.iconColor = Colors.black,
  });

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<PlayerController>(builder: (controller) {
      final buttonState = controller.buttonState.value;
      final isPlaying = buttonState == PlayButtonState.playing;
      final isLoading = buttonState == PlayButtonState.loading;

      if (isPlaying) {
        _controller.forward();
      } else if (!isLoading) {
        _controller.reverse();
      }

      return IconButton(
        iconSize: widget.iconSize,
        padding: EdgeInsets.zero,
        onPressed: () {
          isPlaying ? controller.pause() : controller.play();
        },
        icon: isLoading
            ? LoadingIndicator(
                dimension: widget.iconSize * 0.55,
              )
            : AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _controller,
                color: widget.iconColor,
              ),
      );
    });
  }
}
