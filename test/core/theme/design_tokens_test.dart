import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/core/theme/design_tokens.dart';

void main() {
  group('DesignTokens', () {
    group('Spacing Tokens', () {
      test('should have consistent spacing scale', () {
        expect(DesignTokens.spacing2xs, equals(2.0));
        expect(DesignTokens.spacingXs, equals(4.0));
        expect(DesignTokens.spacingSm, equals(8.0));
        expect(DesignTokens.spacingMd, equals(12.0));
        expect(DesignTokens.spacingLg, equals(16.0));
        expect(DesignTokens.spacingXl, equals(20.0));
        expect(DesignTokens.spacing2xl, equals(24.0));
        expect(DesignTokens.spacing3xl, equals(32.0));
        expect(DesignTokens.spacing4xl, equals(40.0));
        expect(DesignTokens.spacing5xl, equals(48.0));
        expect(DesignTokens.spacing6xl, equals(64.0));
      });

      test('should have logical spacing progression', () {
        expect(DesignTokens.spacingXs, greaterThan(DesignTokens.spacing2xs));
        expect(DesignTokens.spacingSm, greaterThan(DesignTokens.spacingXs));
        expect(DesignTokens.spacingMd, greaterThan(DesignTokens.spacingSm));
        expect(DesignTokens.spacingLg, greaterThan(DesignTokens.spacingMd));
      });
    });

    group('Border Radius Tokens', () {
      test('should have consistent radius scale', () {
        expect(DesignTokens.radiusXs, equals(4.0));
        expect(DesignTokens.radiusSm, equals(6.0));
        expect(DesignTokens.radiusMd, equals(8.0));
        expect(DesignTokens.radiusLg, equals(12.0));
        expect(DesignTokens.radiusXl, equals(16.0));
        expect(DesignTokens.radius2xl, equals(20.0));
        expect(DesignTokens.radius3xl, equals(24.0));
        expect(DesignTokens.radiusFull, equals(9999.0));
      });

      test('should provide border radius presets', () {
        expect(DesignTokens.radiusSmall, equals(BorderRadius.circular(DesignTokens.radiusSm)));
        expect(DesignTokens.radiusMedium, equals(BorderRadius.circular(DesignTokens.radiusMd)));
        expect(DesignTokens.radiusLarge, equals(BorderRadius.circular(DesignTokens.radiusLg)));
        expect(DesignTokens.radiusExtraLarge, equals(BorderRadius.circular(DesignTokens.radiusXl)));
        expect(DesignTokens.radiusRounded, equals(BorderRadius.circular(DesignTokens.radius2xl)));
      });
    });

    group('Elevation Tokens', () {
      test('should have consistent elevation scale', () {
        expect(DesignTokens.elevationNone, equals(0.0));
        expect(DesignTokens.elevationXs, equals(1.0));
        expect(DesignTokens.elevationSm, equals(2.0));
        expect(DesignTokens.elevationMd, equals(4.0));
        expect(DesignTokens.elevationLg, equals(6.0));
        expect(DesignTokens.elevationXl, equals(8.0));
        expect(DesignTokens.elevation2xl, equals(12.0));
        expect(DesignTokens.elevation3xl, equals(16.0));
      });

      test('should have logical elevation progression', () {
        expect(DesignTokens.elevationXs, greaterThan(DesignTokens.elevationNone));
        expect(DesignTokens.elevationSm, greaterThan(DesignTokens.elevationXs));
        expect(DesignTokens.elevationMd, greaterThan(DesignTokens.elevationSm));
      });
    });

    group('Icon Size Tokens', () {
      test('should have consistent icon sizes', () {
        expect(DesignTokens.iconXs, equals(12.0));
        expect(DesignTokens.iconSm, equals(16.0));
        expect(DesignTokens.iconMd, equals(20.0));
        expect(DesignTokens.iconLg, equals(24.0));
        expect(DesignTokens.iconXl, equals(32.0));
        expect(DesignTokens.icon2xl, equals(40.0));
        expect(DesignTokens.icon3xl, equals(48.0));
      });

      test('should meet accessibility requirements for touch targets', () {
        // Icons used as touch targets should be at least 24dp
        expect(DesignTokens.iconLg, greaterThanOrEqualTo(24.0));
        expect(DesignTokens.iconXl, greaterThanOrEqualTo(24.0));
      });
    });

    group('Animation Tokens', () {
      test('should have appropriate animation durations', () {
        expect(DesignTokens.animationFast, equals(const Duration(milliseconds: 150)));
        expect(DesignTokens.animationNormal, equals(const Duration(milliseconds: 300)));
        expect(DesignTokens.animationSlow, equals(const Duration(milliseconds: 500)));
      });

      test('should have logical duration progression', () {
        expect(DesignTokens.animationNormal.inMilliseconds, 
               greaterThan(DesignTokens.animationFast.inMilliseconds));
        expect(DesignTokens.animationSlow.inMilliseconds, 
               greaterThan(DesignTokens.animationNormal.inMilliseconds));
      });

      test('should provide appropriate animation curves', () {
        expect(DesignTokens.curveEaseIn, equals(Curves.easeIn));
        expect(DesignTokens.curveEaseOut, equals(Curves.easeOut));
        expect(DesignTokens.curveEaseInOut, equals(Curves.easeInOut));
        expect(DesignTokens.curveElastic, equals(Curves.elasticOut));
        expect(DesignTokens.curveBounce, equals(Curves.bounceOut));
      });
    });

    group('Opacity Tokens', () {
      test('should have consistent opacity values', () {
        expect(DesignTokens.opacityDisabled, equals(0.38));
        expect(DesignTokens.opacityMedium, equals(0.60));
        expect(DesignTokens.opacityHigh, equals(0.87));
        expect(DesignTokens.opacityFull, equals(1.0));
      });

      test('should follow Material Design opacity guidelines', () {
        // Material Design disabled state opacity
        expect(DesignTokens.opacityDisabled, equals(0.38));
        // Material Design secondary text opacity
        expect(DesignTokens.opacityMedium, equals(0.60));
        // Material Design primary text opacity
        expect(DesignTokens.opacityHigh, equals(0.87));
      });
    });

    group('Component Tokens', () {
      test('should have appropriate button dimensions', () {
        expect(DesignTokens.buttonHeight, equals(48.0));
        expect(DesignTokens.buttonHeightSmall, equals(36.0));
        expect(DesignTokens.buttonHeightLarge, equals(56.0));
        
        // Should meet minimum touch target size (48dp)
        expect(DesignTokens.buttonHeight, greaterThanOrEqualTo(48.0));
      });

      test('should have appropriate card dimensions', () {
        expect(DesignTokens.cardMinHeight, equals(120.0));
        expect(DesignTokens.recipeCardHeight, equals(280.0));
        expect(DesignTokens.recipeCardWidth, equals(200.0));
      });

      test('should have appropriate input dimensions', () {
        expect(DesignTokens.inputHeight, equals(48.0));
        expect(DesignTokens.inputHeightLarge, equals(56.0));
        
        // Should meet minimum touch target size
        expect(DesignTokens.inputHeight, greaterThanOrEqualTo(48.0));
      });

      test('should have cooking-specific dimensions', () {
        expect(DesignTokens.timerSize, equals(120.0));
        expect(DesignTokens.ingredientChipHeight, equals(32.0));
        expect(DesignTokens.difficultyIndicatorSize, equals(16.0));
        expect(DesignTokens.ratingStarSize, equals(20.0));
      });
    });

    group('Layout Tokens', () {
      test('should have responsive breakpoints', () {
        expect(DesignTokens.breakpointMobile, equals(480.0));
        expect(DesignTokens.breakpointTablet, equals(768.0));
        expect(DesignTokens.breakpointDesktop, equals(1024.0));
      });

      test('should have logical breakpoint progression', () {
        expect(DesignTokens.breakpointTablet, greaterThan(DesignTokens.breakpointMobile));
        expect(DesignTokens.breakpointDesktop, greaterThan(DesignTokens.breakpointTablet));
      });

      test('should have consistent spacing values', () {
        expect(DesignTokens.gridSpacing, equals(16.0));
        expect(DesignTokens.listItemSpacing, equals(8.0));
        expect(DesignTokens.sectionSpacing, equals(24.0));
      });
    });

    group('Padding Presets', () {
      test('should provide consistent padding presets', () {
        expect(DesignTokens.screenPadding, equals(const EdgeInsets.all(DesignTokens.spacingLg)));
        expect(DesignTokens.cardPadding, equals(const EdgeInsets.all(DesignTokens.spacingLg)));
        expect(DesignTokens.buttonPadding, equals(const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacing2xl,
          vertical: DesignTokens.spacingMd,
        )));
        expect(DesignTokens.inputPadding, equals(const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingMd,
        )));
      });
    });

    group('Shadow Presets', () {
      test('should provide shadow presets', () {
        expect(DesignTokens.shadowSmall, isA<List<BoxShadow>>());
        expect(DesignTokens.shadowMedium, isA<List<BoxShadow>>());
        expect(DesignTokens.shadowLarge, isA<List<BoxShadow>>());
      });

      test('should have appropriate shadow properties', () {
        final smallShadow = DesignTokens.shadowSmall.first;
        final mediumShadow = DesignTokens.shadowMedium.first;
        final largeShadow = DesignTokens.shadowLarge.first;

        // Blur radius should increase with shadow size
        expect(mediumShadow.blurRadius, greaterThan(smallShadow.blurRadius));
        expect(largeShadow.blurRadius, greaterThan(mediumShadow.blurRadius));

        // Offset should increase with shadow size
        expect(mediumShadow.offset.dy, greaterThan(smallShadow.offset.dy));
        expect(largeShadow.offset.dy, greaterThan(mediumShadow.offset.dy));
      });
    });

    group('Gradient Presets', () {
      test('should provide cooking-themed gradients', () {
        expect(DesignTokens.primaryGradient, isA<LinearGradient>());
        expect(DesignTokens.secondaryGradient, isA<LinearGradient>());
        expect(DesignTokens.warmGradient, isA<LinearGradient>());
      });

      test('should have appropriate gradient properties', () {
        expect(DesignTokens.primaryGradient.colors.length, equals(2));
        expect(DesignTokens.secondaryGradient.colors.length, equals(2));
        expect(DesignTokens.warmGradient.colors.length, equals(2));
      });
    });
  });
}