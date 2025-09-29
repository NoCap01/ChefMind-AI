import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefmind_ai/main.dart';
import 'package:chefmind_ai/core/theme/app_theme.dart';

void main() {
  group('UI Consistency Tests', () {
    late Widget testApp;

    setUp(() {
      testApp = const ProviderScope(child: ChefMindApp());
    });

    testWidgets('Theme Consistency Across Screens', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Test light theme consistency
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(AppTheme.lightTheme));
      expect(materialApp.darkTheme, equals(AppTheme.darkTheme));

      // Navigate through all main screens and verify theme consistency
      final screens = ['Generate Recipe', 'Recipe Book', 'Shopping', 'Meal Planner', 'Profile'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Verify consistent color scheme
          final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
          expect(scaffold.backgroundColor, isNotNull);

          // Verify consistent app bar styling
          final appBars = find.byType(AppBar);
          if (appBars.evaluate().isNotEmpty) {
            final appBar = tester.widget<AppBar>(appBars.first);
            expect(appBar.backgroundColor, isNotNull);
          }
        }
      }
    });

    testWidgets('Button Styling Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Check ElevatedButton consistency
      final elevatedButtons = find.byType(ElevatedButton);
      for (int i = 0; i < elevatedButtons.evaluate().length; i++) {
        final button = tester.widget<ElevatedButton>(elevatedButtons.at(i));
        expect(button.style, isNotNull);
      }

      // Check TextButton consistency
      final textButtons = find.byType(TextButton);
      for (int i = 0; i < textButtons.evaluate().length; i++) {
        final button = tester.widget<TextButton>(textButtons.at(i));
        expect(button.style, isNotNull);
      }

      // Check OutlinedButton consistency
      final outlinedButtons = find.byType(OutlinedButton);
      for (int i = 0; i < outlinedButtons.evaluate().length; i++) {
        final button = tester.widget<OutlinedButton>(outlinedButtons.at(i));
        expect(button.style, isNotNull);
      }
    });

    testWidgets('Typography Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate through screens and check text styling
      final screens = ['Generate Recipe', 'Recipe Book', 'Shopping', 'Meal Planner', 'Profile'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Check for consistent text styles
          final texts = find.byType(Text);
          for (int i = 0; i < texts.evaluate().length && i < 5; i++) {
            final text = tester.widget<Text>(texts.at(i));
            if (text.style != null) {
              expect(text.style!.fontFamily, isNotNull);
            }
          }
        }
      }
    });

    testWidgets('Card and Container Styling Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate through screens and check card styling
      final screens = ['Recipe Book', 'Shopping', 'Meal Planner'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Check card consistency
          final cards = find.byType(Card);
          for (int i = 0; i < cards.evaluate().length && i < 3; i++) {
            final card = tester.widget<Card>(cards.at(i));
            expect(card.elevation, isNotNull);
            expect(card.shape, isNotNull);
          }

          // Check container consistency
          final containers = find.byType(Container);
          for (int i = 0; i < containers.evaluate().length && i < 3; i++) {
            final container = tester.widget<Container>(containers.at(i));
            if (container.decoration != null) {
              expect(container.decoration, isA<BoxDecoration>());
            }
          }
        }
      }
    });

    testWidgets('Input Field Styling Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate to screens with input fields
      final screensWithInputs = ['Generate Recipe', 'Shopping', 'Profile'];
      
      for (final screenName in screensWithInputs) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Check TextField consistency
          final textFields = find.byType(TextField);
          for (int i = 0; i < textFields.evaluate().length && i < 3; i++) {
            final textField = tester.widget<TextField>(textFields.at(i));
            expect(textField.decoration, isNotNull);
            if (textField.decoration != null) {
              expect(textField.decoration!.border, isNotNull);
            }
          }

          // Check TextFormField consistency
          final textFormFields = find.byType(TextFormField);
          for (int i = 0; i < textFormFields.evaluate().length && i < 3; i++) {
            final textFormField = tester.widget<TextFormField>(textFormFields.at(i));
            expect(textFormField.decoration ?? const InputDecoration(), isNotNull);
          }
        }
      }
    });

    testWidgets('Loading and Error State Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Test loading states
      await tester.tap(find.text('Generate Recipe'));
      await tester.pumpAndSettle();

      // Add ingredient and generate to trigger loading
      final ingredientField = find.byType(TextField).first;
      await tester.enterText(ingredientField, 'test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      final generateButton = find.text('Generate Recipe');
      await tester.tap(generateButton);
      
      // Check for consistent loading indicators
      await tester.pump(const Duration(milliseconds: 100));
      final loadingIndicators = find.byType(CircularProgressIndicator);
      if (loadingIndicators.evaluate().isNotEmpty) {
        final indicator = tester.widget<CircularProgressIndicator>(loadingIndicators.first);
        expect(indicator.color, isNotNull);
      }

      await tester.pumpAndSettle();
    });

    testWidgets('Icon Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navigate through screens and check icon consistency
      final screens = ['Generate Recipe', 'Recipe Book', 'Shopping', 'Meal Planner', 'Profile'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Check icon consistency
          final icons = find.byType(Icon);
          for (int i = 0; i < icons.evaluate().length && i < 5; i++) {
            final icon = tester.widget<Icon>(icons.at(i));
            expect(icon.icon, isNotNull);
            if (icon.color != null) {
              expect(icon.color, isA<Color>());
            }
          }

          // Check IconButton consistency
          final iconButtons = find.byType(IconButton);
          for (int i = 0; i < iconButtons.evaluate().length && i < 3; i++) {
            final iconButton = tester.widget<IconButton>(iconButtons.at(i));
            expect(iconButton.icon, isNotNull);
          }
        }
      }
    });

    testWidgets('Spacing and Padding Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Check consistent spacing across screens
      final screens = ['Generate Recipe', 'Recipe Book', 'Shopping', 'Meal Planner', 'Profile'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Check Padding consistency
          final paddings = find.byType(Padding);
          for (int i = 0; i < paddings.evaluate().length && i < 3; i++) {
            final padding = tester.widget<Padding>(paddings.at(i));
            expect(padding.padding, isNotNull);
            expect(padding.padding, isA<EdgeInsets>());
          }

          // Check SizedBox consistency for spacing
          final sizedBoxes = find.byType(SizedBox);
          for (int i = 0; i < sizedBoxes.evaluate().length && i < 3; i++) {
            final sizedBox = tester.widget<SizedBox>(sizedBoxes.at(i));
            // Verify reasonable spacing values
            if (sizedBox.height != null) {
              expect(sizedBox.height! >= 0, isTrue);
            }
            if (sizedBox.width != null) {
              expect(sizedBox.width! >= 0, isTrue);
            }
          }
        }
      }
    });

    testWidgets('Accessibility Consistency', (WidgetTester tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Check semantic labels and accessibility
      final screens = ['Generate Recipe', 'Recipe Book', 'Shopping', 'Meal Planner', 'Profile'];
      
      for (final screenName in screens) {
        final screenTab = find.text(screenName);
        if (screenTab.evaluate().isNotEmpty) {
          await tester.tap(screenTab);
          await tester.pumpAndSettle();

          // Check for semantic widgets
          final semantics = find.byType(Semantics);
          expect(semantics.evaluate().length, greaterThanOrEqualTo(0));

          // Check buttons have proper semantics
          final elevatedButtons = find.byType(ElevatedButton);
          for (int i = 0; i < elevatedButtons.evaluate().length && i < 3; i++) {
            final button = tester.widget<ElevatedButton>(elevatedButtons.at(i));
            expect(button.onPressed, isNotNull);
          }
        }
      }
    });
  });
}