import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/core/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    group('Color Scheme Generation', () {
      test('should generate valid light color scheme', () {
        final colorScheme = AppColors.lightColorScheme;
        
        expect(colorScheme.brightness, equals(Brightness.light));
        expect(colorScheme.primary, equals(AppColors.primary));
        expect(colorScheme.onPrimary, equals(AppColors.onPrimary));
        expect(colorScheme.secondary, equals(AppColors.secondary));
        expect(colorScheme.error, equals(AppColors.error));
      });

      test('should generate valid dark color scheme', () {
        final colorScheme = AppColors.darkColorScheme;
        
        expect(colorScheme.brightness, equals(Brightness.dark));
        expect(colorScheme.error, isA<Color>());
        expect(colorScheme.surface, isA<Color>());
        expect(colorScheme.onSurface, isA<Color>());
      });
    });

    group('Primary Color Palette', () {
      test('should have consistent primary colors', () {
        expect(AppColors.primary, equals(const Color(0xFFFF6B35)));
        expect(AppColors.primaryContainer, equals(const Color(0xFFFFDBD0)));
        expect(AppColors.onPrimary, equals(const Color(0xFFFFFFFF)));
        expect(AppColors.onPrimaryContainer, equals(const Color(0xFF3A0A00)));
      });

      test('should have accessible contrast ratios for primary colors', () {
        final primaryLuminance = AppColors.primary.computeLuminance();
        final onPrimaryLuminance = AppColors.onPrimary.computeLuminance();
        final contrastRatio = _calculateContrastRatio(primaryLuminance, onPrimaryLuminance);
        
        // Should meet WCAG AA standard (4.5:1)
        expect(contrastRatio, greaterThan(4.5));
      });
    });

    group('Secondary Color Palette', () {
      test('should have consistent secondary colors', () {
        expect(AppColors.secondary, equals(const Color(0xFF26A69A)));
        expect(AppColors.secondaryContainer, equals(const Color(0xFFB2DFDB)));
        expect(AppColors.onSecondary, equals(const Color(0xFFFFFFFF)));
        expect(AppColors.onSecondaryContainer, equals(const Color(0xFF002019)));
      });

      test('should have accessible contrast ratios for secondary colors', () {
        final secondaryLuminance = AppColors.secondary.computeLuminance();
        final onSecondaryLuminance = AppColors.onSecondary.computeLuminance();
        final contrastRatio = _calculateContrastRatio(secondaryLuminance, onSecondaryLuminance);
        
        expect(contrastRatio, greaterThan(4.5));
      });
    });

    group('Tertiary Color Palette', () {
      test('should have consistent tertiary colors', () {
        expect(AppColors.tertiary, equals(const Color(0xFFFFC107)));
        expect(AppColors.tertiaryContainer, equals(const Color(0xFFFFF8E1)));
        expect(AppColors.onTertiary, equals(const Color(0xFF000000)));
        expect(AppColors.onTertiaryContainer, equals(const Color(0xFF1F1B00)));
      });
    });

    group('Error Color Palette', () {
      test('should have consistent error colors', () {
        expect(AppColors.error, equals(const Color(0xFFBA1A1A)));
        expect(AppColors.errorContainer, equals(const Color(0xFFFFDAD6)));
        expect(AppColors.onError, equals(const Color(0xFFFFFFFF)));
        expect(AppColors.onErrorContainer, equals(const Color(0xFF410002)));
      });

      test('should have accessible contrast ratios for error colors', () {
        final errorLuminance = AppColors.error.computeLuminance();
        final onErrorLuminance = AppColors.onError.computeLuminance();
        final contrastRatio = _calculateContrastRatio(errorLuminance, onErrorLuminance);
        
        expect(contrastRatio, greaterThan(4.5));
      });
    });

    group('Neutral Colors - Light Theme', () {
      test('should have appropriate light theme neutral colors', () {
        expect(AppColors.surfaceLight, equals(const Color(0xFFFFFBFE)));
        expect(AppColors.onSurfaceLight, equals(const Color(0xFF201A17)));
        expect(AppColors.outlineLight, equals(const Color(0xFF85736C)));
      });

      test('should have accessible contrast for light theme text', () {
        final surfaceLuminance = AppColors.surfaceLight.computeLuminance();
        final onSurfaceLuminance = AppColors.onSurfaceLight.computeLuminance();
        final contrastRatio = _calculateContrastRatio(surfaceLuminance, onSurfaceLuminance);
        
        expect(contrastRatio, greaterThan(4.5));
      });
    });

    group('Neutral Colors - Dark Theme', () {
      test('should have appropriate dark theme neutral colors', () {
        expect(AppColors.surfaceDark, equals(const Color(0xFF181210)));
        expect(AppColors.onSurfaceDark, equals(const Color(0xFFF0E0DB)));
        expect(AppColors.outlineDark, equals(const Color(0xFFA08D84)));
      });

      test('should have accessible contrast for dark theme text', () {
        final surfaceLuminance = AppColors.surfaceDark.computeLuminance();
        final onSurfaceLuminance = AppColors.onSurfaceDark.computeLuminance();
        final contrastRatio = _calculateContrastRatio(surfaceLuminance, onSurfaceLuminance);
        
        expect(contrastRatio, greaterThan(4.5));
      });
    });

    group('Cooking-Specific Semantic Colors', () {
      test('should have appropriate cooking colors', () {
        expect(AppColors.successGreen, equals(const Color(0xFF4CAF50)));
        expect(AppColors.warningAmber, equals(const Color(0xFFFFC107)));
        expect(AppColors.infoBlue, equals(const Color(0xFF2196F3)));
        expect(AppColors.freshGreen, equals(const Color(0xFF8BC34A)));
        expect(AppColors.spiceRed, equals(const Color(0xFFE53935)));
        expect(AppColors.herbGreen, equals(const Color(0xFF689F38)));
        expect(AppColors.grainBrown, equals(const Color(0xFF8D6E63)));
      });
    });

    group('Difficulty Level Colors', () {
      test('should have distinct difficulty colors', () {
        expect(AppColors.difficultyEasy, equals(const Color(0xFF4CAF50)));
        expect(AppColors.difficultyMedium, equals(const Color(0xFFFFC107)));
        expect(AppColors.difficultyHard, equals(const Color(0xFFFF5722)));
      });

      test('should return correct difficulty color for string input', () {
        expect(AppColors.getDifficultyColor('easy'), equals(AppColors.difficultyEasy));
        expect(AppColors.getDifficultyColor('Easy'), equals(AppColors.difficultyEasy));
        expect(AppColors.getDifficultyColor('EASY'), equals(AppColors.difficultyEasy));
        
        expect(AppColors.getDifficultyColor('medium'), equals(AppColors.difficultyMedium));
        expect(AppColors.getDifficultyColor('Medium'), equals(AppColors.difficultyMedium));
        
        expect(AppColors.getDifficultyColor('hard'), equals(AppColors.difficultyHard));
        expect(AppColors.getDifficultyColor('Hard'), equals(AppColors.difficultyHard));
        
        // Should default to medium for unknown values
        expect(AppColors.getDifficultyColor('unknown'), equals(AppColors.difficultyMedium));
        expect(AppColors.getDifficultyColor(''), equals(AppColors.difficultyMedium));
      });
    });

    group('Status Colors', () {
      test('should have appropriate status colors', () {
        expect(AppColors.statusActive, equals(const Color(0xFF4CAF50)));
        expect(AppColors.statusInactive, equals(const Color(0xFF9E9E9E)));
        expect(AppColors.statusPending, equals(const Color(0xFFFFC107)));
        expect(AppColors.statusExpired, equals(const Color(0xFFE53935)));
      });

      test('should return correct status color for string input', () {
        expect(AppColors.getStatusColor('active'), equals(AppColors.statusActive));
        expect(AppColors.getStatusColor('fresh'), equals(AppColors.statusActive));
        expect(AppColors.getStatusColor('available'), equals(AppColors.statusActive));
        
        expect(AppColors.getStatusColor('inactive'), equals(AppColors.statusInactive));
        expect(AppColors.getStatusColor('unavailable'), equals(AppColors.statusInactive));
        
        expect(AppColors.getStatusColor('pending'), equals(AppColors.statusPending));
        expect(AppColors.getStatusColor('cooking'), equals(AppColors.statusPending));
        
        expect(AppColors.getStatusColor('expired'), equals(AppColors.statusExpired));
        expect(AppColors.getStatusColor('spoiled'), equals(AppColors.statusExpired));
        
        // Should default to inactive for unknown values
        expect(AppColors.getStatusColor('unknown'), equals(AppColors.statusInactive));
        expect(AppColors.getStatusColor(''), equals(AppColors.statusInactive));
      });
    });

    group('Rating Colors', () {
      test('should have appropriate rating colors', () {
        expect(AppColors.ratingGold, equals(const Color(0xFFFFD700)));
        expect(AppColors.ratingEmpty, equals(const Color(0xFFE0E0E0)));
      });

      test('should have sufficient contrast for rating visibility', () {
        final goldLuminance = AppColors.ratingGold.computeLuminance();
        final emptyLuminance = AppColors.ratingEmpty.computeLuminance();
        final contrastRatio = _calculateContrastRatio(goldLuminance, emptyLuminance);
        
        // Should have noticeable difference
        expect(contrastRatio, greaterThan(1.5));
      });
    });

    group('Color Scheme Consistency', () {
      test('light and dark schemes should have same structure', () {
        final lightScheme = AppColors.lightColorScheme;
        final darkScheme = AppColors.darkColorScheme;
        
        // Both should have all required colors
        expect(lightScheme.primary, isA<Color>());
        expect(darkScheme.primary, isA<Color>());
        
        expect(lightScheme.secondary, isA<Color>());
        expect(darkScheme.secondary, isA<Color>());
        
        expect(lightScheme.error, isA<Color>());
        expect(darkScheme.error, isA<Color>());
        
        expect(lightScheme.surface, isA<Color>());
        expect(darkScheme.surface, isA<Color>());
      });

      test('should maintain color relationships across themes', () {
        final lightScheme = AppColors.lightColorScheme;
        final darkScheme = AppColors.darkColorScheme;
        
        // Primary colors should maintain their hue relationship
        expect(lightScheme.primary.red, greaterThan(lightScheme.primary.blue));
        expect(darkScheme.primary.red, greaterThan(darkScheme.primary.blue));
      });
    });
  });
}

/// Calculate contrast ratio between two luminance values
double _calculateContrastRatio(double luminance1, double luminance2) {
  final lighter = luminance1 > luminance2 ? luminance1 : luminance2;
  final darker = luminance1 > luminance2 ? luminance2 : luminance1;
  return (lighter + 0.05) / (darker + 0.05);
}