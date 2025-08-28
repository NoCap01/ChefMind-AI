import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/router/page_transitions.dart';

void main() {
  group('PageTransitions Simple Tests', () {
    testWidgets('SharedAxisTransitionType enum should have all values', (tester) async {
      expect(SharedAxisTransitionType.values, hasLength(3));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.horizontal));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.vertical));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.scaled));
    });

    testWidgets('ChefMindTransitionPage should create route', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindTransitionPage<void>(
        child: testWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      );

      final route = page.createRoute(
        MaterialApp.createMaterialHeroController(),
      );

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, equals(const Duration(milliseconds: 500)));
      expect(route.reverseTransitionDuration, equals(const Duration(milliseconds: 300)));
    });

    testWidgets('ChefMindNoTransitionPage should create route with no transition', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindNoTransitionPage<void>(child: testWidget);
      
      final route = page.createRoute(
        MaterialApp.createMaterialHeroController(),
      );

      expect(route, isA<PageRouteBuilder>());
      expect(route.transitionDuration, equals(Duration.zero));
      expect(route.reverseTransitionDuration, equals(Duration.zero));
    });

    testWidgets('Transition pages should render widgets', (tester) async {
      final testWidget = Container(child: const Text('Test Widget'));
      
      final page = ChefMindTransitionPage<void>(
        child: testWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
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

    testWidgets('No transition page should render immediately', (tester) async {
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

      // Should be visible immediately without animation
      await tester.pump();
      expect(find.text('Test Widget'), findsOneWidget);
    });
  });
}