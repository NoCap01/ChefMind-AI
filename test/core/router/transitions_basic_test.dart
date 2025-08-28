import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/router/page_transitions.dart';

void main() {
  group('Basic Transitions Tests', () {
    test('SharedAxisTransitionType enum should have all values', () {
      expect(SharedAxisTransitionType.values, hasLength(3));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.horizontal));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.vertical));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.scaled));
    });

    testWidgets('ChefMindTransitionPage should be creatable', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindTransitionPage<void>(
        child: testWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      );

      expect(page, isA<ChefMindTransitionPage>());
      expect(page.child, equals(testWidget));
      expect(page.transitionDuration, equals(const Duration(milliseconds: 500)));
      expect(page.reverseTransitionDuration, equals(const Duration(milliseconds: 300)));
    });

    testWidgets('ChefMindNoTransitionPage should be creatable', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindNoTransitionPage<void>(child: testWidget);
      
      expect(page, isA<ChefMindNoTransitionPage>());
      expect(page.child, equals(testWidget));
    });

    testWidgets('Transition pages should render widgets in Navigator', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindTransitionPage<void>(
        child: testWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child; // No animation for test simplicity
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Navigator(
            pages: [page],
            onPopPage: (route, result) => route.didPop(result),
          ),
        ),
      );

      await tester.pumpAndSettle();
      
      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('No transition page should render widgets in Navigator', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindNoTransitionPage<void>(child: testWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: Navigator(
            pages: [page],
            onPopPage: (route, result) => route.didPop(result),
          ),
        ),
      );

      // Should be visible immediately
      await tester.pump();
      expect(find.text('Test Widget'), findsOneWidget);
    });

    testWidgets('Transition pages should handle animation lifecycle', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindTransitionPage<void>(
        child: testWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Navigator(
            pages: [page],
            onPopPage: (route, result) => route.didPop(result),
          ),
        ),
      );

      // Start animation
      await tester.pump();
      
      // Complete animation
      await tester.pumpAndSettle();
      
      expect(find.text('Test Widget'), findsOneWidget);
    });
  });
}