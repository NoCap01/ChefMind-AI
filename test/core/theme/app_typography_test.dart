import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/core/theme/app_typography.dart';

void main() {
  group('AppTypography', () {
    group('Text Theme Structure', () {
      test('should provide complete Material 3 text theme', () {
        final textTheme = AppTypography.textTheme;
        
        // Display styles
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.displayMedium, isNotNull);
        expect(textTheme.displaySmall, isNotNull);
        
        // Headline styles
        expect(textTheme.headlineLarge, isNotNull);
        expect(textTheme.headlineMedium, isNotNull);
        expect(textTheme.headlineSmall, isNotNull);
        
        // Title styles
        expect(textTheme.titleLarge, isNotNull);
        expect(textTheme.titleMedium, isNotNull);
        expect(textTheme.titleSmall, isNotNull);
        
        // Body styles
        expect(textTheme.bodyLarge, isNotNull);
        expect(textTheme.bodyMedium, isNotNull);
        expect(textTheme.bodySmall, isNotNull);
        
        // Label styles
        expect(textTheme.labelLarge, isNotNull);
        expect(textTheme.labelMedium, isNotNull);
        expect(textTheme.labelSmall, isNotNull);
      });

      test('should use correct font families', () {
        final textTheme = AppTypography.textTheme;
        
        // Display and headline styles should use Poppins
        expect(textTheme.displayLarge!.fontFamily, contains('Poppins'));
        expect(textTheme.headlineLarge!.fontFamily, contains('Poppins'));
        expect(textTheme.titleLarge!.fontFamily, contains('Poppins'));
        
        // Body and label styles should use Inter
        expect(textTheme.bodyLarge!.fontFamily, contains('Inter'));
        expect(textTheme.labelLarge!.fontFamily, contains('Inter'));
      });
    });

    group('Font Size Hierarchy', () {
      test('should have logical font size progression for display styles', () {
        final textTheme = AppTypography.textTheme;
        
        expect(textTheme.displayLarge!.fontSize!, greaterThan(textTheme.displayMedium!.fontSize!));
        expect(textTheme.displayMedium!.fontSize!, greaterThan(textTheme.displaySmall!.fontSize!));
      });

      test('should have logical font size progression for headline styles', () {
        final textTheme = AppTypography.textTheme;
        
        expect(textTheme.headlineLarge!.fontSize!, greaterThan(textTheme.headlineMedium!.fontSize!));
        expect(textTheme.headlineMedium!.fontSize!, greaterThan(textTheme.headlineSmall!.fontSize!));
      });

      test('should have logical font size progression for title styles', () {
        final textTheme = AppTypography.textTheme;
        
        expect(textTheme.titleLarge!.fontSize!, greaterThan(textTheme.titleMedium!.fontSize!));
        expect(textTheme.titleMedium!.fontSize!, greaterThan(textTheme.titleSmall!.fontSize!));
      });

      test('should have logical font size progression for body styles', () {
        final textTheme = AppTypography.textTheme;
        
        expect(textTheme.bodyLarge!.fontSize!, greaterThan(textTheme.bodyMedium!.fontSize!));
        expect(textTheme.bodyMedium!.fontSize!, greaterThan(textTheme.bodySmall!.fontSize!));
      });
    });

    group('Font Weight Consistency', () {
      test('should use appropriate font weights for hierarchy', () {
        final textTheme = AppTypography.textTheme;
        
        // Display styles should be regular weight
        expect(textTheme.displayLarge!.fontWeight, equals(FontWeight.w400));
        expect(textTheme.displayMedium!.fontWeight, equals(FontWeight.w400));
        expect(textTheme.displaySmall!.fontWeight, equals(FontWeight.w400));
        
        // Headlines should be semi-bold
        expect(textTheme.headlineLarge!.fontWeight, equals(FontWeight.w600));
        expect(textTheme.headlineMedium!.fontWeight, equals(FontWeight.w600));
        expect(textTheme.headlineSmall!.fontWeight, equals(FontWeight.w600));
        
        // Body text should be regular
        expect(textTheme.bodyLarge!.fontWeight, equals(FontWeight.w400));
        expect(textTheme.bodyMedium!.fontWeight, equals(FontWeight.w400));
        expect(textTheme.bodySmall!.fontWeight, equals(FontWeight.w400));
      });
    });

    group('Line Height and Letter Spacing', () {
      test('should have appropriate line heights for readability', () {
        final textTheme = AppTypography.textTheme;
        
        // Body text should have comfortable line height (1.4-1.6)
        expect(textTheme.bodyLarge!.height!, greaterThanOrEqualTo(1.4));
        expect(textTheme.bodyLarge!.height!, lessThanOrEqualTo(1.6));
        
        expect(textTheme.bodyMedium!.height!, greaterThanOrEqualTo(1.4));
        expect(textTheme.bodyMedium!.height!, lessThanOrEqualTo(1.6));
      });

      test('should have appropriate letter spacing', () {
        final textTheme = AppTypography.textTheme;
        
        // Large text should have tighter letter spacing
        expect(textTheme.displayLarge!.letterSpacing!, lessThan(0));
        
        // Small text should have looser letter spacing
        expect(textTheme.labelMedium!.letterSpacing!, greaterThan(0));
        expect(textTheme.labelSmall!.letterSpacing!, greaterThan(0));
      });
    });

    group('Custom Text Styles', () {
      test('should provide recipe-specific text styles', () {
        expect(AppTypography.recipeTitle, isNotNull);
        expect(AppTypography.recipeSubtitle, isNotNull);
        expect(AppTypography.ingredientText, isNotNull);
        expect(AppTypography.instructionText, isNotNull);
        
        // Recipe title should be prominent
        expect(AppTypography.recipeTitle.fontSize!, greaterThan(16));
        expect(AppTypography.recipeTitle.fontWeight, equals(FontWeight.w600));
      });

      test('should provide UI component text styles', () {
        expect(AppTypography.buttonText, isNotNull);
        expect(AppTypography.buttonTextLarge, isNotNull);
        expect(AppTypography.appBarTitle, isNotNull);
        expect(AppTypography.tabLabel, isNotNull);
        
        // Button text should be medium weight
        expect(AppTypography.buttonText.fontWeight, equals(FontWeight.w600));
        expect(AppTypography.buttonTextLarge.fontWeight, equals(FontWeight.w600));
      });

      test('should provide nutrition and cooking text styles', () {
        expect(AppTypography.timerText, isNotNull);
        expect(AppTypography.nutritionLabel, isNotNull);
        expect(AppTypography.nutritionValue, isNotNull);
        expect(AppTypography.chipText, isNotNull);
        
        // Timer text should be large and bold
        expect(AppTypography.timerText.fontSize!, greaterThan(20));
        expect(AppTypography.timerText.fontWeight, equals(FontWeight.w600));
      });

      test('should provide utility text styles', () {
        expect(AppTypography.cardTitle, isNotNull);
        expect(AppTypography.cardSubtitle, isNotNull);
        expect(AppTypography.errorText, isNotNull);
        expect(AppTypography.hintText, isNotNull);
        expect(AppTypography.captionText, isNotNull);
      });
    });

    group('Responsive Text Styles', () {
      testWidgets('should provide responsive title styles', (tester) async {
        // Test mobile size
        await tester.binding.setSurfaceSize(const Size(400, 800));
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final style = AppTypography.getResponsiveTitle(context);
                expect(style.fontSize, lessThan(28)); // Should be smaller on mobile
                return const SizedBox();
              },
            ),
          ),
        );

        // Test tablet size
        await tester.binding.setSurfaceSize(const Size(800, 600));
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final style = AppTypography.getResponsiveTitle(context);
                expect(style.fontSize, greaterThan(24)); // Should be larger on tablet
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('should provide responsive body styles', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final style = AppTypography.getResponsiveBody(context);
                expect(style, isNotNull);
                expect(style.fontSize, greaterThan(12));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });

    group('Text Style Modifiers', () {
      test('should modify text style color', () {
        final baseStyle = AppTypography.textTheme.bodyLarge!;
        final modifiedStyle = AppTypography.withColor(baseStyle, Colors.red);
        
        expect(modifiedStyle.color, equals(Colors.red));
        expect(modifiedStyle.fontSize, equals(baseStyle.fontSize));
        expect(modifiedStyle.fontWeight, equals(baseStyle.fontWeight));
      });

      test('should modify text style opacity', () {
        final baseStyle = AppTypography.textTheme.bodyLarge!.copyWith(color: Colors.black);
        final modifiedStyle = AppTypography.withOpacity(baseStyle, 0.5);
        
        expect(modifiedStyle.color!.opacity, equals(0.5));
        expect(modifiedStyle.fontSize, equals(baseStyle.fontSize));
      });

      test('should modify text style weight', () {
        final baseStyle = AppTypography.textTheme.bodyLarge!;
        final modifiedStyle = AppTypography.withWeight(baseStyle, FontWeight.bold);
        
        expect(modifiedStyle.fontWeight, equals(FontWeight.bold));
        expect(modifiedStyle.fontSize, equals(baseStyle.fontSize));
      });

      test('should modify text style size', () {
        final baseStyle = AppTypography.textTheme.bodyLarge!;
        final modifiedStyle = AppTypography.withSize(baseStyle, 20.0);
        
        expect(modifiedStyle.fontSize, equals(20.0));
        expect(modifiedStyle.fontWeight, equals(baseStyle.fontWeight));
      });
    });

    group('Accessibility Compliance', () {
      test('should have minimum font sizes for readability', () {
        final textTheme = AppTypography.textTheme;
        
        // Body text should be at least 14sp for accessibility
        expect(textTheme.bodyMedium!.fontSize!, greaterThanOrEqualTo(14.0));
        expect(textTheme.bodyLarge!.fontSize!, greaterThanOrEqualTo(14.0));
        
        // Labels should be at least 12sp
        expect(textTheme.labelMedium!.fontSize!, greaterThanOrEqualTo(12.0));
        expect(textTheme.labelLarge!.fontSize!, greaterThanOrEqualTo(12.0));
      });

      test('should have appropriate line heights for readability', () {
        final textTheme = AppTypography.textTheme;
        
        // Line height should be at least 1.2 for readability
        expect(textTheme.bodyLarge!.height!, greaterThanOrEqualTo(1.2));
        expect(textTheme.bodyMedium!.height!, greaterThanOrEqualTo(1.2));
        expect(textTheme.headlineLarge!.height!, greaterThanOrEqualTo(1.2));
      });
    });

    group('Cooking-Specific Typography', () {
      test('should have appropriate styles for cooking content', () {
        // Ingredient text should be readable
        expect(AppTypography.ingredientText.fontSize!, greaterThanOrEqualTo(14.0));
        expect(AppTypography.ingredientText.height!, greaterThanOrEqualTo(1.4));
        
        // Instruction text should be comfortable to read
        expect(AppTypography.instructionText.fontSize!, greaterThanOrEqualTo(16.0));
        expect(AppTypography.instructionText.height!, greaterThanOrEqualTo(1.5));
        
        // Timer text should be highly visible
        expect(AppTypography.timerText.fontSize!, greaterThan(20.0));
        expect(AppTypography.timerText.fontWeight, equals(FontWeight.w600));
      });

      test('should have appropriate nutrition text styles', () {
        // Nutrition labels should be small but readable
        expect(AppTypography.nutritionLabel.fontSize!, greaterThanOrEqualTo(12.0));
        expect(AppTypography.nutritionLabel.fontWeight, equals(FontWeight.w500));
        
        // Nutrition values should be prominent
        expect(AppTypography.nutritionValue.fontSize!, greaterThan(AppTypography.nutritionLabel.fontSize!));
        expect(AppTypography.nutritionValue.fontWeight, equals(FontWeight.w600));
      });
    });
  });
}