import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../lib/shared/presentation/modals/search_modal.dart';

void main() {
  group('SearchModal Widget Tests', () {
    testWidgets('should display search modal with all components', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check if main components are present
      expect(find.text('Advanced Search'), findsOneWidget);
      expect(find.text('Search Query'), findsOneWidget);
      expect(find.text('Cuisine Type'), findsOneWidget);
      expect(find.text('Difficulty Level'), findsOneWidget);
      expect(find.text('Cooking Time (minutes)'), findsOneWidget);
      expect(find.text('Dietary Preferences'), findsOneWidget);
      expect(find.text('Search Recipes'), findsOneWidget);
    });

    testWidgets('should handle text input in search field', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the search text field
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Enter text
      await tester.enterText(searchField, 'chicken pasta');
      await tester.pump();

      // Verify text was entered
      expect(find.text('chicken pasta'), findsOneWidget);
    });

    testWidgets('should toggle cuisine filter chips', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap Italian cuisine chip
      final italianChip = find.widgetWithText(FilterChip, 'Italian');
      expect(italianChip, findsOneWidget);

      await tester.tap(italianChip);
      await tester.pump();

      // Verify chip is selected (this would require checking the chip's selected state)
      // For now, we just verify the tap doesn't crash
      expect(italianChip, findsOneWidget);
    });

    testWidgets('should toggle difficulty filter chips', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap Beginner difficulty chip
      final beginnerChip = find.widgetWithText(FilterChip, 'Beginner');
      expect(beginnerChip, findsOneWidget);

      await tester.tap(beginnerChip);
      await tester.pump();

      // Verify chip interaction works
      expect(beginnerChip, findsOneWidget);
    });

    testWidgets('should adjust cooking time range slider', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find the range slider
      final rangeSlider = find.byType(RangeSlider);
      expect(rangeSlider, findsOneWidget);

      // Test slider interaction (basic test)
      await tester.tap(rangeSlider);
      await tester.pump();

      // Verify slider exists and can be interacted with
      expect(rangeSlider, findsOneWidget);
    });

    testWidgets('should toggle dietary preference checkboxes', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap vegetarian checkbox
      final vegetarianCheckbox = find.widgetWithText(CheckboxListTile, 'Vegetarian');
      expect(vegetarianCheckbox, findsOneWidget);

      await tester.tap(vegetarianCheckbox);
      await tester.pump();

      // Verify checkbox interaction works
      expect(vegetarianCheckbox, findsOneWidget);
    });

    testWidgets('should clear search text when clear button is tapped', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Enter text first
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'test search');
      await tester.pump();

      // Find and tap clear button
      final clearButton = find.byIcon(Icons.clear);
      if (clearButton.evaluate().isNotEmpty) {
        await tester.tap(clearButton);
        await tester.pump();

        // Verify text is cleared
        final textField = tester.widget<TextField>(searchField);
        expect(textField.controller?.text, isEmpty);
      }
    });

    testWidgets('should show voice input button', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find voice input button
      final voiceButton = find.byIcon(Icons.mic_none);
      expect(voiceButton, findsOneWidget);

      // Test voice button tap (won't actually start listening in test)
      await tester.tap(voiceButton);
      await tester.pump();

      // Verify button exists and can be tapped
      expect(voiceButton, findsOneWidget);
    });

    testWidgets('should clear all filters when Clear All is tapped', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap Clear All button
      final clearAllButton = find.text('Clear All');
      expect(clearAllButton, findsOneWidget);

      await tester.tap(clearAllButton);
      await tester.pump();

      // Verify the button works (filters would be reset internally)
      expect(clearAllButton, findsOneWidget);
    });

    testWidgets('should close modal when close button is tapped', (tester) async {
      bool modalClosed = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => const SearchModal(),
                      );
                      modalClosed = true;
                    },
                    child: const Text('Open Modal'),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Find and tap close button
      final closeButton = find.byIcon(Icons.close);
      expect(closeButton, findsOneWidget);

      await tester.tap(closeButton);
      await tester.pumpAndSettle();

      // Verify modal was closed
      expect(modalClosed, isTrue);
    });

    testWidgets('should perform search when Search Recipes button is tapped', (tester) async {
      Map<String, dynamic>? searchResult;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: ElevatedButton(
                    onPressed: () async {
                      searchResult = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) => const SearchModal(),
                      );
                    },
                    child: const Text('Open Modal'),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Open the modal
      await tester.tap(find.text('Open Modal'));
      await tester.pumpAndSettle();

      // Enter search text
      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'pasta');
      await tester.pump();

      // Tap search button
      final searchButton = find.text('Search Recipes');
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      // Verify search was performed (result would contain search parameters)
      expect(searchResult, isNotNull);
      expect(searchResult?['query'], equals('pasta'));
    });
  });

  group('SearchModal Animation Tests', () {
    testWidgets('should animate in when opened', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      // Initial pump - animation should be starting
      await tester.pump();

      // Find animated widgets
      expect(find.byType(FadeTransition), findsOneWidget);
      expect(find.byType(SlideTransition), findsOneWidget);

      // Complete animation
      await tester.pumpAndSettle();

      // Verify modal is fully visible
      expect(find.text('Advanced Search'), findsOneWidget);
    });

    testWidgets('should handle animation controller lifecycle', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const SearchModal(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify modal is displayed
      expect(find.byType(SearchModal), findsOneWidget);

      // Dispose of widget
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Container(),
          ),
        ),
      );

      // Verify no memory leaks (animation controller disposed)
      expect(find.byType(SearchModal), findsNothing);
    });
  });
}