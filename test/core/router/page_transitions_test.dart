import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../lib/core/router/page_transitions.dart' as transitions;

void main() {
  group('PageTransitions Tests', () {
    late GoRouterState mockState;

    setUp(() {
      // Create a simple mock state for testing
      mockState = GoRouterState(
        GoRouteInformation(
          uri: Uri.parse('/test'),
          location: '/test',
        ),
        matchedLocation: '/test',
        name: 'test',
        path: '/test',
        pathParameters: {},
        uri: Uri.parse('/test'),
        pageKey: const ValueKey('test'),
      );
    });

    group('Slide From Bottom Transition', () {
      testWidgets('should create slide from bottom transition page', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.slideFromBottomTransition(
          testWidget,
          mockState,
          name: 'test',
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.name, equals('test'));
        expect(page.child, equals(testWidget));
      });

      testWidgets('should animate slide from bottom', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.slideFromBottomTransition(
          testWidget,
          mockState,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Navigator(
              pages: [page],
              onPopPage: (route, result) => route.didPop(result),
            ),
          ),
        );

        // Initial state - widget should be present but potentially off-screen
        await tester.pump();
        
        // Animation should complete
        await tester.pumpAndSettle();
        
        // Widget should be visible after animation
        expect(find.text('Test Widget'), findsOneWidget);
      });
    });

    group('Slide From Right Transition', () {
      testWidgets('should create slide from right transition page', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.slideFromRightTransition(
          testWidget,
          mockState,
          name: 'test',
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.name, equals('test'));
        expect(page.child, equals(testWidget));
      });

      testWidgets('should animate slide from right', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.slideFromRightTransition(
          testWidget,
          mockState,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Navigator(
              pages: [page],
              onPopPage: (route, result) => route.didPop(result),
            ),
          ),
        );

        await tester.pump();
        await tester.pumpAndSettle();
        
        expect(find.text('Test Widget'), findsOneWidget);
      });
    });

    group('Fade With Scale Transition', () {
      testWidgets('should create fade with scale transition page', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.fadeWithScaleTransition(
          testWidget,
          mockState,
          name: 'test',
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.name, equals('test'));
        expect(page.child, equals(testWidget));
      });

      testWidgets('should animate fade with scale', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.fadeWithScaleTransition(
          testWidget,
          mockState,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Navigator(
              pages: [page],
              onPopPage: (route, result) => route.didPop(result),
            ),
          ),
        );

        await tester.pump();
        await tester.pumpAndSettle();
        
        expect(find.text('Test Widget'), findsOneWidget);
      });
    });

    group('Hero Transition', () {
      testWidgets('should create hero transition page', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.heroTransition(
          testWidget,
          mockState,
          name: 'test',
          heroTag: 'hero-test',
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.name, equals('test'));
        expect(page.child, equals(testWidget));
      });

      testWidgets('should animate hero transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.heroTransition(
          testWidget,
          mockState,
          heroTag: 'hero-test',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Navigator(
              pages: [page],
              onPopPage: (route, result) => route.didPop(result),
            ),
          ),
        );

        await tester.pump();
        await tester.pumpAndSettle();
        
        expect(find.text('Test Widget'), findsOneWidget);
      });
    });

    group('Shared Axis Transition', () {
      testWidgets('should create horizontal shared axis transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.sharedAxisTransition(
          testWidget,
          mockState,
          transitionType: SharedAxisTransitionType.horizontal,
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.child, equals(testWidget));
      });

      testWidgets('should create vertical shared axis transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.sharedAxisTransition(
          testWidget,
          mockState,
          transitionType: SharedAxisTransitionType.vertical,
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.child, equals(testWidget));
      });

      testWidgets('should create scaled shared axis transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.sharedAxisTransition(
          testWidget,
          mockState,
          transitionType: SharedAxisTransitionType.scaled,
        );

        expect(page, isA<CustomTransitionPage>());
        expect(page.child, equals(testWidget));
      });

      testWidgets('should animate shared axis transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.sharedAxisTransition(
          testWidget,
          mockState,
          transitionType: SharedAxisTransitionType.horizontal,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Navigator(
              pages: [page],
              onPopPage: (route, result) => route.didPop(result),
            ),
          ),
        );

        await tester.pump();
        await tester.pumpAndSettle();
        
        expect(find.text('Test Widget'), findsOneWidget);
      });
    });

    group('No Transition', () {
      testWidgets('should create no transition page', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.noTransition(
          testWidget,
          mockState,
          name: 'test',
        );

        expect(page, isA<NoTransitionPage>());
        expect(page.name, equals('test'));
        expect(page.child, equals(testWidget));
      });

      testWidgets('should show widget immediately with no transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.noTransition(
          testWidget,
          mockState,
        );

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

    group('Custom Transition Page', () {
      testWidgets('should create route with custom transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = CustomTransitionPage<void>(
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
    });

    group('No Transition Page', () {
      testWidgets('should create route with no transition', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = NoTransitionPage<void>(child: testWidget);
        
        final route = page.createRoute(
          MaterialApp.createMaterialHeroController(),
        );

        expect(route, isA<PageRouteBuilder>());
        expect(route.transitionDuration, equals(Duration.zero));
        expect(route.reverseTransitionDuration, equals(Duration.zero));
      });
    });

    group('Transition Duration Tests', () {
      testWidgets('should respect custom transition durations', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final page = PageTransitions.slideFromBottomTransition(
          testWidget,
          mockState,
        ) as CustomTransitionPage;

        expect(page.transitionDuration, equals(const Duration(milliseconds: 300)));
        expect(page.reverseTransitionDuration, equals(const Duration(milliseconds: 250)));
      });

      testWidgets('should have different durations for different transitions', (tester) async {
        final testWidget = Container(child: const Text('Test Widget'));
        
        final slideFromBottomPage = PageTransitions.slideFromBottomTransition(
          testWidget,
          mockState,
        ) as CustomTransitionPage;

        final fadeWithScalePage = PageTransitions.fadeWithScaleTransition(
          testWidget,
          mockState,
        ) as CustomTransitionPage;

        final heroPage = PageTransitions.heroTransition(
          testWidget,
          mockState,
        ) as CustomTransitionPage;

        // Different transitions should have different durations
        expect(slideFromBottomPage.transitionDuration, equals(const Duration(milliseconds: 300)));
        expect(fadeWithScalePage.transitionDuration, equals(const Duration(milliseconds: 350)));
        expect(heroPage.transitionDuration, equals(const Duration(milliseconds: 400)));
      });
    });
  });

  group('SharedAxisTransitionType Enum Tests', () {
    test('should have all expected transition types', () {
      expect(SharedAxisTransitionType.values, hasLength(3));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.horizontal));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.vertical));
      expect(SharedAxisTransitionType.values, contains(SharedAxisTransitionType.scaled));
    });
  });
}