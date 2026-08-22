import 'package:flutter/material.dart';

/// Centralized color tokens for the Material 3 Expressive design system.
/// All UI files must reference these tokens — never hardcode colors.
abstract class AppColors {
  // ─── Brand seed ────────────────────────────────────────────────────────────
  /// Default seed used when no dynamic color or song palette is active.
  static const Color seed = Color(0xFF6750A4); // M3 baseline purple-violet

  // ─── Gradients (accent use only — e.g. logo, onboarding) ─────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6750A4), Color(0xFF9E56D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Alias kept for compatibility with files referencing primaryGradientDark.
  static const LinearGradient primaryGradientDark = primaryGradient;

  // ─── Legacy gradient start/end (kept for glass_morphism.dart compat) ──────
  static const Color accentGradientStart = Color(0xFF6750A4);
  static const Color accentGradientEnd = Color(0xFF9E56D4);

  // ─── Legacy text tokens (kept for app_typography.dart compat) ─────────────
  /// Use colorScheme.onSurface in new code instead.
  static const Color textPrimaryDark = Color(0xFFF0F0FF);
  static const Color textSecondaryDark = Color(0xFFB0B0D0);
  static const Color textTertiaryDark = Color(0xFF6A6A9A);
  static const Color textPrimaryLight = Color(0xFF1C1B1F); // M3 dark on surface
  static const Color textSecondaryLight = Color(0xFF49454F); // M3 on surface variant

  // ─── Semantic ─────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF386A20); // M3 green tone
  static const Color warning = Color(0xFF7A5900); // M3 amber tone
  static const Color error = Color(0xFFBA1A1A);   // M3 red tone
}
