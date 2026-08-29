import 'dart:ui';
import 'package:flutter/material.dart';
import '/ui/theme/app_colors.dart';
import '/ui/theme/app_spacing.dart';

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// GlassMorphism â€” base frosted-glass container
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

/// Wraps [child] in a BackdropFilter + translucent container to mimic
/// liquid glass. Customize blur sigma, opacity, border radius and border color.
class GlassMorphism extends StatelessWidget {
  const GlassMorphism({
    super.key,
    required this.child,
    this.blurX = 20.0,
    this.blurY = 20.0,
    this.borderRadius = AppSpacing.radiusMd,
    this.surfaceOpacity = 0.12,
    this.borderOpacity = 0.25,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.isDark = true,
  });

  final Widget child;
  final double blurX;
  final double blurY;
  final double borderRadius;
  final double surfaceOpacity;
  final double borderOpacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final base = isDark ? Colors.white : Colors.black;
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: base.withValues(alpha: surfaceOpacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: base.withValues(alpha: borderOpacity),
                width: 1.0,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// GlassCard
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = AppSpacing.radiusMd,
    this.padding = const EdgeInsets.all(14.0),
    this.margin,
    this.width,
    this.height,
    this.blurSigma = 18.0,
    this.onTap,
    this.shadowColor,
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double blurSigma;
  final VoidCallback? onTap;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withValues(alpha: 0.08),
          highlightColor: Colors.white.withValues(alpha: 0.04),
          child: GlassMorphism(
            blurX: blurSigma,
            blurY: blurSigma,
            borderRadius: borderRadius,
            padding: padding,
            isDark: isDark,
            child: child,
          ),
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// GlassButton â€” pill / rounded frosted button
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    this.label,
    this.icon,
    required this.onPressed,
    this.borderRadius = 100.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.gradient,
    this.textStyle,
    this.iconColor,
    this.height,
    this.width,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final LinearGradient? gradient;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = gradient ?? AppColors.primaryGradientDark;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: effectiveGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGradientStart.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withValues(alpha: 0.15),
          highlightColor: Colors.white.withValues(alpha: 0.08),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon,
                      size: AppSpacing.iconMd,
                      color: iconColor ?? Colors.white),
                  if (label != null) const SizedBox(width: AppSpacing.sm),
                ],
                if (label != null)
                  Text(
                    label!,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// GlassIconButton â€” circular frosted icon button
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44.0,
    this.iconSize = 22.0,
    this.iconColor,
    this.blurSigma = 14.0,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final double blurSigma;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor =
        iconColor ?? (isDark ? Colors.white : Colors.black87);
    Widget button = ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Material(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            splashColor: Colors.white.withValues(alpha: 0.12),
            child: SizedBox(
              width: size,
              height: size,
              child: Icon(icon, size: iconSize, color: effectiveColor),
            ),
          ),
        ),
      ),
    );
    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// GlassPlayButton â€” large glowing play/pause button for the full player
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class GlassPlayButton extends StatelessWidget {
  const GlassPlayButton({
    super.key,
    required this.child,
    this.size = 72.0,
  });

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Colors.white, Color(0xFFE8E8FF)],
          radius: 0.85,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGradientStart.withValues(alpha: 0.55),
            blurRadius: 32,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: AppColors.accentGradientEnd.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// GlassDivider â€” subtle section separator
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class GlassDivider extends StatelessWidget {
  const GlassDivider({super.key, this.margin});
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0),
            Colors.white.withValues(alpha: 0.15),
            Colors.white.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}
