import 'package:flutter/material.dart';

class HoverCardWrapper extends StatefulWidget {
  final Widget child;
  final bool isCircle;
  final double borderRadius;
  final VoidCallback? onPlayTap;

  const HoverCardWrapper({
    super.key,
    required this.child,
    this.isCircle = false,
    this.borderRadius = 12.0,
    this.onPlayTap,
  });

  @override
  State<HoverCardWrapper> createState() => _HoverCardWrapperState();
}

class _HoverCardWrapperState extends State<HoverCardWrapper>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: widget.isCircle
                ? null
                : BorderRadius.circular(widget.borderRadius),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: primaryColor.withValues(alpha: 0.35),
                      blurRadius: 16,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: widget.isCircle
                    ? BorderRadius.circular(999)
                    : BorderRadius.circular(widget.borderRadius),
                child: widget.child,
              ),
              // Hover overlay + play button
              if (widget.onPlayTap != null)
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: _isHovered ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: widget.isCircle
                            ? BoxShape.circle
                            : BoxShape.rectangle,
                        borderRadius: widget.isCircle
                            ? null
                            : BorderRadius.circular(widget.borderRadius),
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                      child: Center(
                        child: AnimatedScale(
                          scale: _isHovered ? 1.0 : 0.8,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutBack,
                          child: GestureDetector(
                            onTap: widget.onPlayTap,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
