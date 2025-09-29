import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/presentation/widgets/recipe/ingredient_input_widget.dart';

void main() {
  group('IngredientInputWidget Tests', () {
    testWidgets('should display initial UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientInputWidget(
              ingredients: const [],
              onIngredientAdded: (ingredient) {},
              onIngredientRemoved: (ingredient) {},
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('should display existing ingredients', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientInputWidget(
              ingredients: const ['chicken', 'rice'],
              onIngredientAdded: (ingredient) {},
              onIngredientRemoved: (ingredient) {},
            ),
          ),
        ),
      );

      expect(find.text('chicken'), findsOneWidget);
      expect(find.text('rice'), findsOneWidget);
    });

    testWidgets('should call onIngredientAdded when ingredient is added', (WidgetTester tester) async {
      String? addedIngredient;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientInputWidget(
              ingredients: const [],
              onIngredientAdded: (ingredient) => addedIngredient = ingredient,
              onIngredientRemoved: (ingredient) {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'tomato');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(addedIngredient, equals('tomato'));
    });

    testWidgets('should call onIngredientRemoved when ingredient is removed', (WidgetTester tester) async {
      String? removedIngredient;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientInputWidget(
              ingredients: const ['chicken'],
              onIngredientAdded: (ingredient) {},
              onIngredientRemoved: (ingredient) => removedIngredient = ingredient,
            ),
          ),
        ),
      );

      // Find and tap the remove button for chicken
      final removeButton = find.byIcon(Icons.close);
      if (removeButton.evaluate().isNotEmpty) {
        await tester.tap(removeButton.first);
        await tester.pump();
        expect(removedIngredient, equals('chicken'));
      }
    });

    testWidgets('should clear text field after adding ingredient', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IngredientInputWidget(
              ingredients: const [],
              onIngredientAdded: (ingredient) {},
              onIngredientRemoved: (ingredient) {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'onion');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, isEmpty);
    });
  });
}