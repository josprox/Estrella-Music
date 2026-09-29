import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// M3-compliant text theme using Inter via google_fonts.
abstract class AppTypography {
  static TextTheme get darkTextTheme {
    TextStyle font(TextStyle style) => GoogleFonts.inter(textStyle: style);
    return TextTheme(
      // Large display — hero headings
      displayLarge: font(const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        letterSpacing: -1.5,
        height: 1.1,
      )),
      displayMedium: font(const TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        letterSpacing: -1,
        height: 1.16,
      )),
      displaySmall: font(const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.5,
        height: 1.22,
      )),
      // Headlines — section titles
      headlineLarge: font(const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        letterSpacing: -0.25,
      )),
      headlineMedium: font(const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      )),
      headlineSmall: font(const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      )),
      // Titles — card/list titles
      titleLarge: font(const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        letterSpacing: 0.15,
      )),
      titleMedium: font(const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
        letterSpacing: 0.15,
      )),
      titleSmall: font(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryDark,
        letterSpacing: 0.1,
      )),
      // Body
      bodyLarge: font(const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
        letterSpacing: 0.5,
      )),
      bodyMedium: font(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
        letterSpacing: 0.25,
      )),
      bodySmall: font(const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiaryDark,
        letterSpacing: 0.4,
      )),
      // Labels
      labelLarge: font(const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
        letterSpacing: 0.1,
      )),
      labelMedium: font(const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryDark,
        letterSpacing: 0.5,
      )),
      labelSmall: font(const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiaryDark,
        letterSpacing: 0.5,
      )),
    );
  }

  static TextTheme get lightTextTheme {
    TextStyle font(TextStyle style) => GoogleFonts.inter(textStyle: style);
    return TextTheme(
      displayLarge: font(const TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryLight)),
      displaySmall: font(const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryLight)),
      headlineSmall: font(const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight)),
      titleLarge: font(const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryLight)),
      titleMedium: font(const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight)),
      titleSmall: font(const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondaryLight)),
      bodyMedium: font(const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryLight)),
      bodySmall: font(const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryLight)),
      labelLarge: font(const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryLight)),
      labelMedium: font(const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondaryLight)),
    );
  }
}
