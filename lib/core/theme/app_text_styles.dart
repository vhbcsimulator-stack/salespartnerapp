import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App typography matching the VHBC design tokens
class AppTextStyles {
  AppTextStyles._();

  // Plus Jakarta Sans Styles
  static TextStyle labelSm = GoogleFonts.plusJakartaSans(
    fontSize: 10,
    height: 14 / 10,
    letterSpacing: 0.6,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle labelMd = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.36,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle labelLg = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    height: 18 / 14,
    letterSpacing: 0.14,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static TextStyle bodySm = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle bodyMd = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static TextStyle bodyLg = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static TextStyle titleMd = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    height: 22 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static TextStyle headlineSm = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryContainer,
  );

  static TextStyle priceDisplay = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    height: 30 / 24,
    letterSpacing: -0.48,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryContainer,
  );

  // Newsreader Serif Styles
  static TextStyle headlineMd = GoogleFonts.newsreader(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static TextStyle headlineLg = GoogleFonts.newsreader(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );

  static TextStyle headlineXl = GoogleFonts.newsreader(
    fontSize: 36,
    height: 44 / 36,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
  );
}
