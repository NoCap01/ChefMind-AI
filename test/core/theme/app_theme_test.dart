import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/core/theme/app_theme.dart';
import 'package:chefmind_ai/core/theme/app_colors.dart';
import 'package:chefmind_ai/core/theme/design_tokens.dart';

void main() {
  group('AppTheme', () {
    group('Light Theme', () {
      late ThemeData lightTheme;

      setUpAll(() {
        lightTheme = AppTheme.lightTheme;
      });

      test('should use Material 3', () {
        expect(lightTheme.useMaterial3, isTrue);
      });

      test('should have correct color scheme', () {
        expect(lightTheme.colorScheme, equals(AppColors.lightColorScheme));
        expect(lightTheme.colorScheme.brightness, equals(Brightness.light));
      });

      test('should have consistent primary colors', () {
        expect(lightTheme.colorScheme.primary, equals(AppColors.primary));
        expect(lightTheme.colorScheme.onPrimary, equals(AppColors.onPrimary));
        expect(lightTheme.colorScheme.primaryContainer, equals(AppColors.primaryContainer));
      });

      test('should have proper button styling', () {
        final elevatedButtonStyle = lightTheme.elevatedButtonTheme.style!;
        final backgroundColor = elevatedButtonStyle.backgroundColor!.resolve({});
        final foregroundColor = elevatedButtonStyle.foregroundColor!.resolve({});
        
        expect(backgroundColor, equals(lightTheme.colorScheme.primary));
        expect(foregroundColor, equals(lightTheme.colorScheme.onPrimary));
      });

      test('should have accessible contrast ratios', () {
        // Test primary color contrast
        final primaryLuminance = lightTheme.colorScheme.primary.computeLuminance();
        final onPrimaryLuminance = lightTheme.colorScheme.onPrimary.computeLuminance();
        final contrastRatio = _calculateContrastRatio(primaryLuminance, onPrimaryLuminance);
        
        // WCAG AA requires at least 4.5:1 for normal text
        expect(contrastRatio, greaterThan(4.5));
      });

      test('should have proper elevation values', () {
        expect(lightTheme.cardTheme.elevation, equals(DesignTokens.elevationSm));
        expect(lightTheme.appBarTheme.elevation, equals(DesignTokens.elevationNone));
      });

      test('should have consistent border radius', () {
        final cardShape = lightTheme.cardTheme.shape as RoundedRectangleBorder;
        final buttonShape = lightTheme.elevatedButtonTheme.style!.shape!.resolve({}) as RoundedRectangleBorder;
        
        expect(cardShape.borderRadius, equals(DesignTokens.radiusExtraLarge));
        expect(buttonShape.borderRadius, equals(DesignTokens.radiusLarge));
      });
    });

    group('Dark Theme', () {
      late ThemeData darkTheme;

      setUpAll(() {
        darkTheme = AppTheme.darkTheme;
      });

      test('should use Material 3', () {
        expect(darkTheme.useMaterial3, isTrue);
      });

      test('should have correct color scheme', () {
        expect(darkTheme.colorScheme, equals(AppColors.darkColorScheme));
        expect(darkTheme.colorScheme.brightness, equals(Brightness.dark));
      });

      test('should have accessible contrast ratios', () {
        // Test primary color contrast in dark theme
        final primaryLuminance = darkTheme.colorScheme.primary.computeLuminance();
        final onPrimaryLuminance = darkTheme.colorScheme.onPrimary.computeLuminance();
        final contrastRatio = _calculateContrastRatio(primaryLuminance, onPrimaryLuminance);
        
        expect(contrastRatio, greaterThan(4.5));
      });

      test('should have proper system overlay style', () {
        expect(darkTheme.appBarTheme.systemOverlayStyle, equals(SystemUiOverlayStyle.light));
      });
    });

    group('Theme Utilities', () {
      testWidgets('should detect dark theme correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            home: Builder(
              builder: (context) {
                expect(AppTheme.isDark(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('should provide responsive padding', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final padding = AppTheme.getResponsivePadding(context);
                expect(padding, isA<EdgeInsets>());
                return const SizedBox();
              },
            ),
          ),
        );
      });

      test('should return correct theme for brightness', () {
        final lightTheme = AppTheme.getTheme(Brightness.light);
        final darkTheme = AppTheme.getTheme(Brightness.dark);
        
        expect(lightTheme.brightness, equals(Brightness.light));
        expect(darkTheme.brightness, equals(Brightness.dark));
      });
    });

    group('Component Themes', () {
      test('should have consistent input decoration theme', () {
        final lightInputTheme = AppTheme.lightTheme.inputDecorationTheme;
        final darkInputTheme = AppTheme.darkTheme.inputDecorationTheme;
        
        expect(lightInputTheme.filled, isTrue);
        expect(darkInputTheme.filled, isTrue);
        expect(lightInputTheme.contentPadding, equals(DesignTokens.inputPadding));
        expect(darkInputTheme.contentPadding, equals(DesignTokens.inputPadding));
      });

      test('should have proper chip theme configuration', () {
        final chipTheme = AppTheme.lightTheme.chipTheme;
        final shape = chipTheme.shape as RoundedRectangleBorder;
        
        expect(shape.borderRadius, equals(BorderRadius.circular(DesignTokens.radiusFull)));
        expect(chipTheme.padding, equals(const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        )));
      });

      test('should have consistent navigation bar theme', () {
        final navBarTheme = AppTheme.lightTheme.navigationBarTheme;
        
        expect(navBarTheme.elevation, equals(DesignTokens.elevationSm));
        expect(navBarTheme.height, equals(DesignTokens.bottomNavHeight));
      });

      test('should have proper dialog theme', () {
        final dialogTheme = AppTheme.lightTheme.dialogTheme;
        final shape = dialogTheme.shape as RoundedRectangleBorder;
        
        expect(dialogTheme.elevation, equals(DesignTokens.elevation3xl));
        expect(shape.borderRadius, equals(DesignTokens.radiusRounded));
      });
    });

    group('Accessibility Compliance', () {
      test('should meet minimum touch target size', () {
        final buttonTheme = AppTheme.lightTheme.elevatedButtonTheme.style!;
        final minimumSize = buttonTheme.minimumSize!.resolve({});
        
        // Material Design recommends minimum 48dp touch targets
        expect(minimumSize!.height, greaterThanOrEqualTo(48.0));
      });

      test('should have sufficient color contrast for text', () {
        final colorScheme = AppTheme.lightTheme.colorScheme;
        
        // Test surface and onSurface contrast
        final surfaceLuminance = colorScheme.surface.computeLuminance();
        final onSurfaceLuminance = colorScheme.onSurface.computeLuminance();
        final contrastRatio = _calculateContrastRatio(surfaceLuminance, onSurfaceLuminance);
        
        expect(contrastRatio, greaterThan(4.5));
      });

      test('should have proper focus indicators', () {
        final inputTheme = AppTheme.lightTheme.inputDecorationTheme;
        final focusedBorder = inputTheme.focusedBorder as OutlineInputBorder;
        
        expect(focusedBorder.borderSide.width, equals(2.0));
        expect(focusedBorder.borderSide.color, equals(AppTheme.lightTheme.colorScheme.primary));
      });
    });

    group('Design Token Integration', () {
      test('should use design tokens for spacing', () {
        final cardTheme = AppTheme.lightTheme.cardTheme;
        expect(cardTheme.margin, equals(const EdgeInsets.all(DesignTokens.spacingSm)));
      });

      test('should use design tokens for elevation', () {
        final cardElevation = AppTheme.lightTheme.cardTheme.elevation;
        final fabElevation = AppTheme.lightTheme.floatingActionButtonTheme.elevation;
        
        expect(cardElevation, equals(DesignTokens.elevationSm));
        expect(fabElevation, equals(DesignTokens.elevationMd));
      });

      test('should use design tokens for border radius', () {
        final cardShape = AppTheme.lightTheme.cardTheme.shape as RoundedRectangleBorder;
        final buttonShape = AppTheme.lightTheme.elevatedButtonTheme.style!.shape!.resolve({}) as RoundedRectangleBorder;
        
        expect(cardShape.borderRadius, equals(DesignTokens.radiusExtraLarge));
        expect(buttonShape.borderRadius, equals(DesignTokens.radiusLarge));
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