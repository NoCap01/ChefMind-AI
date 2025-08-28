import 'package:flutter/material.dart';

/// Material 3 color system for ChefMind AI
class AppColors {
  AppColors._();

  // Primary color palette - Cooking Orange
  static const Color primarySeed = Color(0xFFFF6B35);
  static const Color primary = Color(0xFFFF6B35);
  static const Color primaryContainer = Color(0xFFFFDBD0);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF3A0A00);

  // Secondary color palette - Fresh Teal
  static const Color secondary = Color(0xFF26A69A);
  static const Color secondaryContainer = Color(0xFFB2DFDB);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF002019);

  // Tertiary color palette - Warm Yellow
  static const Color tertiary = Color(0xFFFFC107);
  static const Color tertiaryContainer = Color(0xFFFFF8E1);
  static const Color onTertiary = Color(0xFF000000);
  static const Color onTertiaryContainer = Color(0xFF1F1B00);

  // Error color palette
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF410002);

  // Neutral color palette - Light theme
  static const Color surfaceLight = Color(0xFFFFFBFE);
  static const Color surfaceVariantLight = Color(0xFFF5EFEB);
  static const Color onSurfaceLight = Color(0xFF201A17);
  static const Color onSurfaceVariantLight = Color(0xFF52443D);
  static const Color outlineLight = Color(0xFF85736C);
  static const Color outlineVariantLight = Color(0xFFD8C2B8);
  static const Color shadowLight = Color(0xFF000000);
  static const Color scrimLight = Color(0xFF000000);
  static const Color inverseSurfaceLight = Color(0xFF362F2C);
  static const Color inverseOnSurfaceLight = Color(0xFFFBEEE9);
  static const Color inversePrimaryLight = Color(0xFFFFB59D);

  // Neutral color palette - Dark theme
  static const Color surfaceDark = Color(0xFF181210);
  static const Color surfaceVariantDark = Color(0xFF52443D);
  static const Color onSurfaceDark = Color(0xFFF0E0DB);
  static const Color onSurfaceVariantDark = Color(0xFFD8C2B8);
  static const Color outlineDark = Color(0xFFA08D84);
  static const Color outlineVariantDark = Color(0xFF52443D);
  static const Color shadowDark = Color(0xFF000000);
  static const Color scrimDark = Color(0xFF000000);
  static const Color inverseSurfaceDark = Color(0xFFF0E0DB);
  static const Color inverseOnSurfaceDark = Color(0xFF362F2C);
  static const Color inversePrimaryDark = Color(0xFFFF6B35);

  // Cooking-specific semantic colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningAmber = Color(0xFFFFC107);
  static const Color infoBlue = Color(0xFF2196F3);
  static const Color freshGreen = Color(0xFF8BC34A);
  static const Color spiceRed = Color(0xFFE53935);
  static const Color herbGreen = Color(0xFF689F38);
  static const Color grainBrown = Color(0xFF8D6E63);

  // Difficulty level colors
  static const Color difficultyEasy = Color(0xFF4CAF50);
  static const Color difficultyMedium = Color(0xFFFFC107);
  static const Color difficultyHard = Color(0xFFFF5722);

  // Rating colors
  static const Color ratingGold = Color(0xFFFFD700);
  static const Color ratingEmpty = Color(0xFFE0E0E0);

  // Status colors
  static const Color statusActive = Color(0xFF4CAF50);
  static const Color statusInactive = Color(0xFF9E9E9E);
  static const Color statusPending = Color(0xFFFFC107);
  static const Color statusExpired = Color(0xFFE53935);

  /// Light theme color scheme
  static ColorScheme get lightColorScheme => const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surfaceLight,
        onSurface: onSurfaceLight,
        surfaceContainerHighest: surfaceVariantLight,
        onSurfaceVariant: onSurfaceVariantLight,
        outline: outlineLight,
        outlineVariant: outlineVariantLight,
        shadow: shadowLight,
        scrim: scrimLight,
        inverseSurface: inverseSurfaceLight,
        onInverseSurface: inverseOnSurfaceLight,
        inversePrimary: inversePrimaryLight,
      );

  /// Dark theme color scheme
  static ColorScheme get darkColorScheme => const ColorScheme.dark(
        primary: Color(0xFFFFB59D),
        onPrimary: Color(0xFF5F1600),
        primaryContainer: Color(0xFF8A2C00),
        onPrimaryContainer: Color(0xFFFFDBD0),
        secondary: Color(0xFF4DB6AC),
        onSecondary: Color(0xFF00382E),
        secondaryContainer: Color(0xFF005048),
        onSecondaryContainer: Color(0xFFB2DFDB),
        tertiary: Color(0xFFE6C200),
        onTertiary: Color(0xFF3C2F00),
        tertiaryContainer: Color(0xFF564400),
        onTertiaryContainer: Color(0xFFFFF8E1),
        error: Color(0xFFFFB4AB),
        onError: Color(0xFF690005),
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        surface: surfaceDark,
        onSurface: onSurfaceDark,
        surfaceContainerHighest: surfaceVariantDark,
        onSurfaceVariant: onSurfaceVariantDark,
        outline: outlineDark,
        outlineVariant: outlineVariantDark,
        shadow: shadowDark,
        scrim: scrimDark,
        inverseSurface: inverseSurfaceDark,
        onInverseSurface: inverseOnSurfaceDark,
        inversePrimary: inversePrimaryDark,
      );

  /// Get color based on difficulty level
  static Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return difficultyEasy;
      case 'medium':
        return difficultyMedium;
      case 'hard':
        return difficultyHard;
      default:
        return difficultyMedium;
    }
  }

  /// Get status color
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'fresh':
      case 'available':
        return statusActive;
      case 'inactive':
      case 'unavailable':
        return statusInactive;
      case 'pending':
      case 'cooking':
        return statusPending;
      case 'expired':
      case 'spoiled':
        return statusExpired;
      default:
        return statusInactive;
    }
  }
}