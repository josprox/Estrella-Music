import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NebulaBackground extends StatelessWidget {
  final RxString seedString;

  const NebulaBackground({super.key, required this.seedString});

  List<Color> _getReactiveGradientColors(BuildContext context, String seed) {
    final theme = Theme.of(context);
    if (seed.isEmpty) {
      // Elegant default colors matching the active theme's colorScheme!
      return [
        theme.colorScheme.primary,
        theme.colorScheme.secondary,
      ];
    }

    final int hash = seed.hashCode;
    double hue = (hash % 360).abs().toDouble();
    if (hue > 60 && hue < 170) hue = (hash % 2 == 0) ? 180 : 40;

    final color1 = HSLColor.fromAHSL(1.0, hue, 0.65, 0.35).toColor();
    final color2 =
        HSLColor.fromAHSL(1.0, (hue + 40) % 360, 0.65, 0.30).toColor();
    return [color1, color2];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final colors = _getReactiveGradientColors(context, seedString.value);
      return AnimatedContainer(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        height: double
            .infinity, // Occupies full screen height to eliminate dividing lines
        child: CustomPaint(
          painter: NebulaPainter(
            color1: colors[0].withValues(alpha: 0.12),
            color2: colors[1].withValues(alpha: 0.12),
          ),
        ),
      );
    });
  }
}

class NebulaPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  NebulaPainter({required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.5, -0.6),
        radius: 1.6,
        colors: [color1, Colors.transparent],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final paint2 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.5, -0.6),
        radius: 1.6,
        colors: [color2, Colors.transparent],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint2);
  }

  @override
  bool shouldRepaint(covariant NebulaPainter oldDelegate) =>
      oldDelegate.color1 != color1 || oldDelegate.color2 != color2;
}
