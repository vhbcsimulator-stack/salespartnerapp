import 'package:flutter/material.dart';

/// App color palette matching the VHBC design system specification
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF00271B);
  static const Color primaryContainer = Color(0xFF0F3E2E);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF7BA994);
  static const Color primaryFixed = Color(0xFFBDEDD6);
  static const Color primaryFixedDim = Color(0xFFA2D1BA);

  // Secondary (Gold / Bronze)
  static const Color secondary = Color(0xFF77591C);
  static const Color secondaryContainer = Color(0xFFFED48A);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF785A1D);
  static const Color secondaryFixed = Color(0xFFFFDEA7);
  static const Color secondaryFixedDim = Color(0xFFE9C179);
  static const Color onSecondaryFixed = Color(0xFF271900);

  // Tertiary (Deep Blue-Grey)
  static const Color tertiary = Color(0xFF172233);
  static const Color tertiaryContainer = Color(0xFF2C374A);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFF95A0B7);
  static const Color tertiaryFixedDim = Color(0xFFBCC7DE);

  // Surface & Background
  static const Color background = Color(0xFFF7F9FB);
  static const Color surface = Color(0xFFF7F9FB);
  static const Color surfaceBright = Color(0xFFF7F9FB);
  static const Color surfaceDim = Color(0xFFD8DADC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F4F6);
  static const Color surfaceContainer = Color(0xFFECEEF0);
  static const Color surfaceContainerHigh = Color(0xFFE6E8EA);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E5);

  // Text & Content
  static const Color onSurface = Color(0xFF191C1E);
  static const Color onSurfaceVariant = Color(0xFF414944);
  static const Color outline = Color(0xFF717974);
  static const Color outlineVariant = Color(0xFFC0C8C2);
  static const Color surfaceTint = Color(0xFF3B6755);

  // Error & Status
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF93000A);
}
