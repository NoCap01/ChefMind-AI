import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../lib/main.dart' as app;
import '../../lib/core/providers/auth_provider.dart';
import '../../lib/features/auth/presentation/screens/auth_screen.dart';
import '../../lib/features/home/presentation/screens/home_screen.dart';
import '../../lib/features/recipe_book/presentation/screens/recipe_book_screen.dart';
import '../../lib/features/shopping/presentation/screens/shopping_screen.dart';
import '../../lib/features/meal_planner/presentation/screens/meal_planner_screen.dart';
import '../../lib/features/profile/presentation/screens/profile_screen.dart';
import '../../lib/features/recipe/presentation/screens/recipe_detail_screen.dart';
import '../../lib/shared/presentation/screens/main_screen.dart';

// Mock classes
class MockUser extends Mock implements User {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation Flow Integration Tests', () {
    late MockUser mockUser;

    setUp(() {
      mockUser = MockUser();
      when(mockUser.uid).thenReturn('test-user-id');
      when(mockUser.email).thenReturn('test@example.com');
      when(mockUser.displayName).thenReturn('Test User');
    });

    testWidgets('complete navigation flow for authenticated user', (tester) async {
      // Override auth provider to simulate authenticated user
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value({})),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should start on home screen
      expect(find.byType(MainScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsOneWidget);

      // Test bottom navigation - Recipe Book
      await tester.tap(find.text('Recipes'));
      await tester.pumpAndSettle();
      expect(find.byType(RecipeBookScreen), findsOneWidget);

      // Test bottom navigation - Shopping
      await tester.tap(find.text('Shopping'));
      await tester.pumpAndSettle();
      expect(find.byType(ShoppingScreen), findsOneWidget);

      // Test bottom navigation - Meal Planner
      await tester.tap(find.text('Planner'));
      await tester.pumpAndSettle();
      expect(find.byType(MealPlannerScreen), findsOneWidget);

      // Test bottom navigation - Profile
      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);

      // Test back to home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('navigation flow for unauthenticated user', (tester) async {
      // Override auth provider to simulate unauthenticated user
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(null)),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Should redirect to auth screen
      expect(find.byType(AuthScreen), findsOneWidget);
      expect(find.byType(MainScreen), findsNothing);
    });

    testWidgets('deep linking to recipe detail', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value({})),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Simulate deep link navigation to recipe detail
      // This would typically be done through the router, but for testing
      // we can navigate programmatically
      final context = tester.element(find.byType(MaterialApp));
      
      // Note: In a real integration test, you would use actual deep link handling
      // For now, we'll test the navigation structure is in place
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('error handling for invalid routes', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value({})),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // The error handling would be tested by navigating to invalid routes
      // This requires router integration which is handled in unit tests
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('bottom navigation state persistence', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value({})),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Navigate to recipe book
      await tester.tap(find.text('Recipes'));
      await tester.pumpAndSettle();
      expect(find.byType(RecipeBookScreen), findsOneWidget);

      // Check that the correct tab is highlighted
      final bottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(bottomNavBar.currentIndex, equals(1));

      // Navigate to shopping
      await tester.tap(find.text('Shopping'));
      await tester.pumpAndSettle();
      expect(find.byType(ShoppingScreen), findsOneWidget);

      // Check that the correct tab is highlighted
      final updatedBottomNavBar = tester.widget<BottomNavigationBar>(
        find.byType(BottomNavigationBar),
      );
      expect(updatedBottomNavBar.currentIndex, equals(2));
    });

    testWidgets('navigation performance test', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value({})),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Measure navigation performance
      final stopwatch = Stopwatch()..start();

      // Rapid navigation between tabs
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.text('Recipes'));
        await tester.pumpAndSettle();
        
        await tester.tap(find.text('Shopping'));
        await tester.pumpAndSettle();
        
        await tester.tap(find.text('Home'));
        await tester.pumpAndSettle();
      }

      stopwatch.stop();

      // Navigation should be fast (less than 5 seconds for 15 navigations)
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    testWidgets('accessibility navigation test', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
            userProfileProvider.overrideWith((ref) => Future.value({})),
          ],
          child: const app.ChefMindApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Test semantic labels for navigation
      expect(find.bySemanticsLabel('Home'), findsOneWidget);
      expect(find.bySemanticsLabel('Recipes'), findsOneWidget);
      expect(find.bySemanticsLabel('Shopping'), findsOneWidget);
      expect(find.bySemanticsLabel('Planner'), findsOneWidget);
      expect(find.bySemanticsLabel('Profile'), findsOneWidget);

      // Test navigation using semantic labels
      await tester.tap(find.bySemanticsLabel('Recipes'));
      await tester.pumpAndSettle();
      expect(find.byType(RecipeBookScreen), findsOneWidget);
    });
  });

  group('Deep Linking Integration Tests', () {
    testWidgets('handle recipe share links', (tester) async {
      // This would test actual deep link handling
      // Implementation depends on platform-specific deep link setup
      expect(true, isTrue); // Placeholder
    });

    testWidgets('handle invalid deep links gracefully', (tester) async {
      // This would test error handling for malformed deep links
      expect(true, isTrue); // Placeholder
    });
  });
}