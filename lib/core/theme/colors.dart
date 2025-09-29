import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryOrange = Color(0xFFFF9800);
  static const Color primaryRed = Color(0xFFF44336);

  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF2196F3);

  // Neutral colors
  static const Color neutral50 = Color(0xFFFAFAFA);
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFEEEEEE);
  static const Color neutral300 = Color(0xFFE0E0E0);
  static const Color neutral400 = Color(0xFFBDBDBD);
  static const Color neutral500 = Color(0xFF9E9E9E);
  static const Color neutral600 = Color(0xFF757575);
  static const Color neutral700 = Color(0xFF616161);
  static const Color neutral800 = Color(0xFF424242);
  static const Color neutral900 = Color(0xFF212121);

  // Light theme color scheme
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: primaryGreen,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFE8F5E8),
    onPrimaryContainer: Color(0xFF1B5E20),

    secondary: primaryOrange,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFFFE0B2),
    onSecondaryContainer: Color(0xFFE65100),

    tertiary: Color(0xFF6366F1),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFEEF2FF),
    onTertiaryContainer: Color(0xFF312E81),

    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFEBEE),
    onErrorContainer: Color(0xFFB71C1C),

    surface: Colors.white,
    onSurface: neutral900,
    surfaceContainerHighest: neutral100,
    onSurfaceVariant: neutral700,

    outline: neutral300,
    outlineVariant: neutral200,

    inverseSurface: neutral800,
    onInverseSurface: neutral100,
    inversePrimary: Color(0xFF81C784),

    shadow: Colors.black12,
    scrim: Colors.black45,
    surfaceTint: primaryGreen,
  );

  // Dark theme color scheme
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: Color(0xFF81C784),
    onPrimary: Color(0xFF1B5E20),
    primaryContainer: Color(0xFF2E7D32),
    onPrimaryContainer: Color(0xFFC8E6C9),

    secondary: Color(0xFFFFB74D),
    onSecondary: Color(0xFFE65100),
    secondaryContainer: Color(0xFFF57C00),
    onSecondaryContainer: Color(0xFFFFE0B2),

    tertiary: Color(0xFF818CF8),
    onTertiary: Color(0xFF312E81),
    tertiaryContainer: Color(0xFF4338CA),
    onTertiaryContainer: Color(0xFFEEF2FF),

    error: Color(0xFFEF5350),
    onError: Color(0xFFB71C1C),
    errorContainer: Color(0xFFD32F2F),
    onErrorContainer: Color(0xFFFFEBEE),

    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE0E0E0),
    surfaceContainerHighest: Color(0xFF424242),
    onSurfaceVariant: Color(0xFFBDBDBD),

    outline: Color(0xFF757575),
    outlineVariant: Color(0xFF616161),

    inverseSurface: Color(0xFFE0E0E0),
    onInverseSurface: Color(0xFF1E1E1E),
    inversePrimary: primaryGreen,

    shadow: Colors.black26,
    scrim: Colors.black54,
    surfaceTint: Color(0xFF81C784),
  );
}
