import 'package:flutter/material.dart';

class ScrollToHideWidget extends StatelessWidget {
  const ScrollToHideWidget(
      {super.key, required this.isVisible, required this.child});
  final Widget child;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedAlign(
        alignment: Alignment.topCenter,
        heightFactor: isVisible ? 1.0 : 0.0,
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );
  }
}
