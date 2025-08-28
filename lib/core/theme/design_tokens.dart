import 'package:flutter/material.dart';

/// Design tokens for consistent spacing, sizing, and styling across the app
class DesignTokens {
  DesignTokens._();

  // Spacing tokens
  static const double spacing2xs = 2.0;
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 12.0;
  static const double spacingLg = 16.0;
  static const double spacingXl = 20.0;
  static const double spacing2xl = 24.0;
  static const double spacing3xl = 32.0;
  static const double spacing4xl = 40.0;
  static const double spacing5xl = 48.0;
  static const double spacing6xl = 64.0;

  // Border radius tokens
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 20.0;
  static const double radius3xl = 24.0;
  static const double radiusFull = 9999.0;

  // Elevation tokens
  static const double elevationNone = 0.0;
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 6.0;
  static const double elevationXl = 8.0;
  static const double elevation2xl = 12.0;
  static const double elevation3xl = 16.0;

  // Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 20.0;
  static const double iconLg = 24.0;
  static const double iconXl = 32.0;
  static const double icon2xl = 40.0;
  static const double icon3xl = 48.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Animation curves
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveElastic = Curves.elasticOut;
  static const Curve curveBounce = Curves.bounceOut;

  // Opacity tokens
  static const double opacityDisabled = 0.38;
  static const double opacityMedium = 0.60;
  static const double opacityHigh = 0.87;
  static const double opacityFull = 1.0;

  // Layout breakpoints
  static const double breakpointMobile = 480.0;
  static const double breakpointTablet = 768.0;
  static const double breakpointDesktop = 1024.0;

  // Component specific tokens
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;
  
  static const double cardMinHeight = 120.0;
  static const double recipeCardHeight = 280.0;
  static const double recipeCardWidth = 200.0;
  
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 80.0;
  
  static const double inputHeight = 48.0;
  static const double inputHeightLarge = 56.0;

  // Cooking-specific design tokens
  static const double timerSize = 120.0;
  static const double ingredientChipHeight = 32.0;
  static const double difficultyIndicatorSize = 16.0;
  static const double ratingStarSize = 20.0;
  
  // Grid and list spacing
  static const double gridSpacing = 16.0;
  static const double listItemSpacing = 8.0;
  static const double sectionSpacing = 24.0;

  // Safe area and padding
  static const EdgeInsets screenPadding = EdgeInsets.all(spacingLg);
  static const EdgeInsets cardPadding = EdgeInsets.all(spacingLg);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: spacing2xl,
    vertical: spacingMd,
  );
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: spacingLg,
    vertical: spacingMd,
  );

  // Border radius presets
  static BorderRadius get radiusSmall => BorderRadius.circular(radiusSm);
  static BorderRadius get radiusMedium => BorderRadius.circular(radiusMd);
  static BorderRadius get radiusLarge => BorderRadius.circular(radiusLg);
  static BorderRadius get radiusExtraLarge => BorderRadius.circular(radiusXl);
  static BorderRadius get radiusRounded => BorderRadius.circular(radius2xl);

  // Shadow presets
  static List<BoxShadow> get shadowSmall => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowLarge => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ];

  // Gradient presets for cooking theme
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF8A50)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF26A69A), Color(0xFF4DB6AC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}