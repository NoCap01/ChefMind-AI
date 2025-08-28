import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../lib/core/router/app_router.dart';
import '../../../lib/core/router/route_constants.dart';
import '../../../lib/core/providers/auth_provider.dart';
import '../../../lib/features/auth/presentation/screens/auth_screen.dart';
import '../../../lib/features/home/presentation/screens/home_screen.dart';
import '../../../lib/features/recipe/presentation/screens/recipe_detail_screen.dart';
import '../../../lib/shared/presentation/screens/main_screen.dart';

// Mock classes
class MockUser extends Mock implements User {}

class MockAuthState extends Mock implements AsyncValue<User?> {}

void main() {
  group('AppRouter Tests', () {
    late ProviderContainer container;
    late MockUser mockUser;

    setUp(() {
      mockUser = MockUser();
      when(mockUser.uid).thenReturn('test-user-id');
      when(mockUser.email).thenReturn('test@example.com');
      when(mockUser.displayName).thenReturn('Test User');
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('should navigate to auth screen when not authenticated', (tester) async {
      container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(null)),
        ],
      );

      final router = container.read(appRouterProvider);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should redirect to auth screen
      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets('should navigate to home screen when authenticated', (tester) async {
      container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
          userProfileProvider.overrideWith((ref) => Future.value(null)),
        ],
      );

      final router = container.read(appRouterProvider);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should show main screen with home content
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('should handle deep link to recipe detail', (tester) async {
      container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
          userProfileProvider.overrideWith((ref) => Future.value(null)),
        ],
      );

      final router = container.read(appRouterProvider);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Navigate to recipe detail
      router.go('/recipe/test-recipe-123');
      await tester.pumpAndSettle();

      // Should show recipe detail screen
      expect(find.byType(RecipeDetailScreen), findsOneWidget);
    });

    testWidgets('should handle shared recipe link', (tester) async {
      container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
          userProfileProvider.overrideWith((ref) => Future.value(null)),
        ],
      );

      final router = container.read(appRouterProvider);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Navigate to shared recipe
      router.go('/recipe/test-recipe-123/share');
      await tester.pumpAndSettle();

      // Should show recipe detail screen with shared flag
      expect(find.byType(RecipeDetailScreen), findsOneWidget);
      expect(find.text('Shared Recipe'), findsOneWidget);
    });

    testWidgets('should show error page for invalid routes', (tester) async {
      container = ProviderContainer(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
          userProfileProvider.overrideWith((ref) => Future.value(null)),
        ],
      );

      final router = container.read(appRouterProvider);

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );

      // Navigate to invalid route
      router.go('/invalid-route');
      await tester.pumpAndSettle();

      // Should show error page
      expect(find.text('Page Not Found'), findsOneWidget);
      expect(find.text('Go Home'), findsOneWidget);
    });

    group('AppRouter Helper Methods', () {
      testWidgets('should generate correct share URLs', (tester) async {
        const recipeId = 'test-recipe-123';
        
        final shareUrl = AppRouter.generateRecipeShareUrl(recipeId);
        final recipeUrl = AppRouter.generateRecipeUrl(recipeId);

        expect(shareUrl, equals('https://chefmind.ai/recipe/test-recipe-123/share'));
        expect(recipeUrl, equals('https://chefmind.ai/recipe/test-recipe-123'));
      });

      testWidgets('should handle deep links correctly', (tester) async {
        container = ProviderContainer(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value(null)),
          ],
        );

        final router = container.read(appRouterProvider);

        await tester.pumpWidget(
          ProviderScope(
            parent: container,
            child: MaterialApp.router(
              routerConfig: router,
            ),
          ),
        );

        // Test recipe share link handling
        AppRouter.handleDeepLink(
          tester.element(find.byType(MaterialApp)),
          'https://chefmind.ai/recipe/test-recipe-123/share',
        );
        await tester.pumpAndSettle();

        expect(find.byType(RecipeDetailScreen), findsOneWidget);
        expect(find.text('Shared Recipe'), findsOneWidget);
      });
    });
  });

  group('Route Constants Tests', () {
    test('should have correct route paths', () {
      expect(RouteConstants.homePath, equals('/'));
      expect(RouteConstants.authPath, equals('/auth'));
      expect(RouteConstants.recipeBookPath, equals('/recipe-book'));
      expect(RouteConstants.shoppingPath, equals('/shopping'));
      expect(RouteConstants.mealPlannerPath, equals('/meal-planner'));
      expect(RouteConstants.profilePath, equals('/profile'));
    });

    test('should build correct dynamic paths', () {
      const recipeId = 'test-recipe-123';
      const listId = 'test-list-456';
      
      expect(
        RouteConstants.buildRecipeDetailPath(recipeId),
        equals('/recipe/test-recipe-123'),
      );
      expect(
        RouteConstants.buildRecipeSharePath(recipeId),
        equals('/recipe/test-recipe-123/share'),
      );
      expect(
        RouteConstants.buildShoppingListPath(listId),
        equals('/shopping/list/test-list-456'),
      );
    });

    test('should correctly identify authenticated routes', () {
      expect(RouteConstants.requiresAuth('/'), isTrue);
      expect(RouteConstants.requiresAuth('/recipe-book'), isTrue);
      expect(RouteConstants.requiresAuth('/shopping'), isTrue);
      expect(RouteConstants.requiresAuth('/auth'), isFalse);
      expect(RouteConstants.requiresAuth('/recipe/123'), isTrue);
    });

    test('should correctly identify public routes', () {
      expect(RouteConstants.isPublicRoute('/auth'), isTrue);
      expect(RouteConstants.isPublicRoute('/404'), isTrue);
      expect(RouteConstants.isPublicRoute('/error'), isTrue);
      expect(RouteConstants.isPublicRoute('/'), isFalse);
      expect(RouteConstants.isPublicRoute('/recipe-book'), isFalse);
    });
  });
}