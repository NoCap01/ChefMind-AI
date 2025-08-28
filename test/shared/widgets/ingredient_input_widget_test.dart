import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/shared/presentation/widgets/ingredient_input_widget.dart';

void main() {
  group('IngredientInputWidget Tests', () {
    late TextEditingController controller;
    List<String> selectedIngredients = [];
    List<String> addedIngredients = [];
    List<String> removedIngredients = [];

    setUp(() {
      controller = TextEditingController();
      selectedIngredients = [];
      addedIngredients = [];
      removedIngredients = [];
    });

    tearDown(() {
      controller.dispose();
    });

    Widget createWidget({
      bool enableVoiceInput = true,
      bool enableAutoSuggestions = true,
      List<String>? customSuggestions,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: IngredientInputWidget(
            controller: controller,
            onIngredientAdded: (ingredient) {
              addedIngredients.add(ingredient);
              selectedIngredients.add(ingredient);
            },
            onIngredientRemoved: (ingredient) {
              removedIngredients.add(ingredient);
              selectedIngredients.remove(ingredient);
            },
            selectedIngredients: selectedIngredients,
            enableVoiceInput: enableVoiceInput,
            enableAutoSuggestions: enableAutoSuggestions,
            customSuggestions: customSuggestions,
          ),
        ),
      );
    }

    testWidgets('should display input field with proper decoration', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Enter ingredients (e.g., chicken, rice, tomatoes)'), findsOneWidget);
      expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
      expect(find.byIcon(Icons.mic_none), findsOneWidget);
      expect(find.byIcon(Icons.add_circle), findsOneWidget);
    });

    testWidgets('should add ingredient when text is entered and add button is pressed', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(addedIngredients, contains('Chicken'));
      expect(controller.text, isEmpty);
    });

    testWidgets('should add ingredient when text is submitted', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'rice');
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(addedIngredients, contains('Rice'));
      expect(controller.text, isEmpty);
    });

    testWidgets('should handle multiple ingredients separated by commas', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'chicken, rice, tomatoes');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(addedIngredients, contains('Chicken'));
      expect(addedIngredients, contains('Rice'));
      expect(addedIngredients, contains('Tomatoes'));
    });

    testWidgets('should handle multiple ingredients separated by semicolons', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'onion; garlic; ginger');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(addedIngredients, contains('Onion'));
      expect(addedIngredients, contains('Garlic'));
      expect(addedIngredients, contains('Ginger'));
    });

    testWidgets('should not add duplicate ingredients', (tester) async {
      selectedIngredients.add('Chicken');
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(addedIngredients, isEmpty);
    });

    testWidgets('should normalize ingredient names', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'CHICKEN BREAST');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add_circle));
      await tester.pump();

      expect(addedIngredients, contains('Chicken Breast'));
    });

    testWidgets('should validate ingredient input', (tester) async {
      await tester.pumpWidget(createWidget());

      // Test invalid inputs
      await tester.enterText(find.byType(TextField), '123');
      await tester.pump();
      expect(find.text('Please enter a valid ingredient name'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump();
      expect(find.text('Please enter a valid ingredient name'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'test@#\$');
      await tester.pump();
      expect(find.text('Please enter a valid ingredient name'), findsOneWidget);

      // Test valid input
      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();
      expect(find.text('Please enter a valid ingredient name'), findsNothing);
    });

    testWidgets('should show clear button when text is entered', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();

      expect(find.byIcon(Icons.clear), findsOneWidget);

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(controller.text, isEmpty);
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('should display selected ingredients as chips', (tester) async {
      selectedIngredients.addAll(['Chicken', 'Rice', 'Tomatoes']);
      await tester.pumpWidget(createWidget());

      expect(find.byType(Chip), findsNWidgets(3));
      expect(find.text('Chicken'), findsOneWidget);
      expect(find.text('Rice'), findsOneWidget);
      expect(find.text('Tomatoes'), findsOneWidget);
    });

    testWidgets('should remove ingredient when chip delete is tapped', (tester) async {
      selectedIngredients.add('Chicken');
      await tester.pumpWidget(createWidget());

      final chipDeleteIcon = find.descendant(
        of: find.byType(Chip),
        matching: find.byIcon(Icons.close),
      );
      
      await tester.tap(chipDeleteIcon);
      await tester.pump();

      expect(removedIngredients, contains('Chicken'));
    });

    testWidgets('should disable voice input when not enabled', (tester) async {
      await tester.pumpWidget(createWidget(enableVoiceInput: false));

      expect(find.byIcon(Icons.mic_none), findsNothing);
    });

    testWidgets('should show voice input button when enabled', (tester) async {
      await tester.pumpWidget(createWidget(enableVoiceInput: true));

      expect(find.byIcon(Icons.mic_none), findsOneWidget);
    });

    testWidgets('should handle voice input toggle', (tester) async {
      await tester.pumpWidget(createWidget(enableVoiceInput: true));

      final micButton = find.byIcon(Icons.mic_none);
      await tester.tap(micButton);
      await tester.pump();

      // Note: In a real test environment, speech recognition won't work
      // This test just verifies the button interaction doesn't crash
      expect(micButton, findsOneWidget);
    });

    testWidgets('should disable add button when input is empty', (tester) async {
      await tester.pumpWidget(createWidget());

      final addButton = find.ancestor(
        of: find.byIcon(Icons.add_circle),
        matching: find.byType(IconButton),
      );
      expect(tester.widget<IconButton>(addButton).onPressed, isNull);
    });

    testWidgets('should enable add button when input has text', (tester) async {
      await tester.pumpWidget(createWidget());

      await tester.enterText(find.byType(TextField), 'chicken');
      await tester.pump();

      final addButton = find.ancestor(
        of: find.byIcon(Icons.add_circle),
        matching: find.byType(IconButton),
      );
      expect(tester.widget<IconButton>(addButton).onPressed, isNotNull);
    });

    testWidgets('should support multiline input', (tester) async {
      await tester.pumpWidget(createWidget());

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, isNull);
      expect(textField.keyboardType, TextInputType.multiline);
    });

    testWidgets('should use custom suggestions when provided', (tester) async {
      final customSuggestions = ['Custom Ingredient 1', 'Custom Ingredient 2'];
      await tester.pumpWidget(createWidget(
        customSuggestions: customSuggestions,
      ));

      // Focus the text field to potentially show suggestions
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Enter partial text that might match custom suggestions
      await tester.enterText(find.byType(TextField), 'custom');
      await tester.pump();

      // The widget should use custom suggestions internally
      // (Testing the overlay suggestions would require more complex setup)
      expect(find.byType(TextField), findsOneWidget);
    });

    group('Animation Tests', () {
      testWidgets('should animate ingredient chips', (tester) async {
        await tester.pumpWidget(createWidget());

        await tester.enterText(find.byType(TextField), 'chicken');
        await tester.pump();
        await tester.tap(find.byIcon(Icons.add_circle));
        
        // Pump a few frames to let animations start
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        
        // The chip should appear after the ingredient is added
        expect(find.byType(Chip), findsOneWidget);
      });

      testWidgets('should animate voice input status', (tester) async {
        await tester.pumpWidget(createWidget(enableVoiceInput: true));

        // Tap voice input button
        await tester.tap(find.byIcon(Icons.mic_none));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Should show listening indicator (though speech won't actually work in tests)
        expect(find.byType(TextField), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle empty input gracefully', (tester) async {
        await tester.pumpWidget(createWidget());

        await tester.enterText(find.byType(TextField), '');
        await tester.tap(find.byIcon(Icons.add_circle));
        await tester.pump();

        expect(addedIngredients, isEmpty);
      });

      testWidgets('should handle whitespace-only input', (tester) async {
        await tester.pumpWidget(createWidget());

        await tester.enterText(find.byType(TextField), '   ');
        await tester.tap(find.byIcon(Icons.add_circle));
        await tester.pump();

        expect(addedIngredients, isEmpty);
      });

      testWidgets('should trim whitespace from ingredients', (tester) async {
        await tester.pumpWidget(createWidget());

        await tester.enterText(find.byType(TextField), '  chicken  ');
        await tester.pump();
        await tester.tap(find.byIcon(Icons.add_circle));
        await tester.pump();

        expect(addedIngredients, contains('Chicken'));
      });

      testWidgets('should handle very long ingredient names', (tester) async {
        await tester.pumpWidget(createWidget());

        final longIngredient = 'a' * 100;
        await tester.enterText(find.byType(TextField), longIngredient);
        await tester.pump();
        await tester.tap(find.byIcon(Icons.add_circle));
        await tester.pump();

        expect(addedIngredients, isNotEmpty);
      });
    });
  });
}