import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:material_ui/material_ui.dart';

class AnimatedAuthBackground extends StatefulWidget {
  const AnimatedAuthBackground({super.key});

  @override
  State<AnimatedAuthBackground> createState() => _AnimatedAuthBackgroundState();
}

class _AnimatedAuthBackgroundState extends State<AnimatedAuthBackground> {
  final Random _random = Random();
  Timer? _timer;

  late double _top1;
  late double _left1;
  late double _top2;
  late double _left2;
  late double _top3;
  late double _left3;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _seed();
      _timer = Timer.periodic(const Duration(seconds: 5), (_) => _move());
    });
  }

  void _seed() {
    final size = MediaQuery.of(context).size;
    setState(() {
      _top1 = -160;
      _left1 = -140;
      _top2 = size.height * 0.45;
      _left2 = size.width * 0.75;
      _top3 = size.height * 0.7;
      _left3 = -120;
      _initialized = true;
    });
    Future.delayed(const Duration(milliseconds: 300), _move);
  }

  void _move() {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    setState(() {
      _top1 = _random.nextDouble() * (size.height + 220) - 180;
      _left1 = _random.nextDouble() * (size.width + 220) - 180;
      _top2 = _random.nextDouble() * (size.height + 260) - 160;
      _left2 = _random.nextDouble() * (size.width + 260) - 160;
      _top3 = _random.nextDouble() * (size.height + 180) - 120;
      _left3 = _random.nextDouble() * (size.width + 180) - 120;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF07121C),
            Color(0xFF102534),
            Color(0xFF173A36),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          if (_initialized)
            AnimatedPositioned(
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              top: _top1,
              left: _left1,
              child: const _Blob(
                color: Color(0xFFFF9F1C),
                size: 260,
              ),
            ),
          if (_initialized)
            AnimatedPositioned(
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              top: _top2,
              left: _left2,
              child: const _Blob(
                color: Color(0xFF2EC4B6),
                size: 320,
              ),
            ),
          if (_initialized)
            AnimatedPositioned(
              duration: const Duration(seconds: 4),
              curve: Curves.easeInOut,
              top: _top3,
              left: _left3,
              child: const _Blob(
                color: Color(0xFFE71D36),
                size: 240,
              ),
            ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
            child: Container(
              color: Colors.black.withValues(alpha: 0.14),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
