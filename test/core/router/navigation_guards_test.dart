import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../lib/core/router/navigation_guards.dart';
import '../../../lib/core/router/route_constants.dart';
import '../../../lib/core/providers/auth_provider.dart';

// Mock classes
class MockUser extends Mock implements User {}

class MockGoRouterState extends Mock implements GoRouterState {}

class MockProviderRef extends Mock implements WidgetRef {}

void main() {
  group('NavigationGuards Tests', () {
    late MockUser mockUser;
    late MockGoRouterState mockState;
    late ProviderContainer container;

    setUp(() {
      mockUser = MockUser();
      mockState = MockGoRouterState();
      when(mockUser.uid).thenReturn('test-user-id');
      when(mockUser.email).thenReturn('test@example.com');
    });

    tearDown(() {
      container.dispose();
    });

    group('Auth Guard Tests', () {
      testWidgets('should redirect to auth when user is not authenticated', (tester) async {
        container = ProviderContainer(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(null)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/recipe-book');

        final result = NavigationGuards.authGuard(mockState, container);

        expect(result, equals(RouteConstants.authPath));
      });

      testWidgets('should redirect to home when authenticated user visits auth page', (tester) async {
        container = ProviderContainer(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/auth');

        final result = NavigationGuards.authGuard(mockState, container);

        expect(result, equals(RouteConstants.homePath));
      });

      testWidgets('should allow navigation when user is authenticated and not on auth page', (tester) async {
        container = ProviderContainer(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/recipe-book');

        final result = NavigationGuards.authGuard(mockState, container);

        expect(result, isNull);
      });

      testWidgets('should allow navigation to public routes when not authenticated', (tester) async {
        container = ProviderContainer(
          overrides: [
            authStateProvider.overrideWith((ref) => Stream.value(null)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/auth');

        final result = NavigationGuards.authGuard(mockState, container);

        expect(result, isNull);
      });
    });

    group('Deep Link Guard Tests', () {
      test('should allow valid recipe IDs', () {
        when(mockState.matchedLocation).thenReturn('/recipe/valid-recipe-123');
        when(mockState.pathParameters).thenReturn({'id': 'valid-recipe-123'});

        final result = NavigationGuards.deepLinkGuard(mockState, container);

        expect(result, isNull);
      });

      test('should redirect to 404 for invalid recipe IDs', () {
        when(mockState.matchedLocation).thenReturn('/recipe/ab');
        when(mockState.pathParameters).thenReturn({'id': 'ab'});

        final result = NavigationGuards.deepLinkGuard(mockState, container);

        expect(result, equals(RouteConstants.notFoundPath));
      });

      test('should redirect to 404 for missing recipe IDs', () {
        when(mockState.matchedLocation).thenReturn('/recipe/');
        when(mockState.pathParameters).thenReturn(<String, String>{});

        final result = NavigationGuards.deepLinkGuard(mockState, container);

        expect(result, equals(RouteConstants.notFoundPath));
      });

      test('should allow valid shopping list IDs', () {
        when(mockState.matchedLocation).thenReturn('/shopping/list/valid-list-456');
        when(mockState.pathParameters).thenReturn({'id': 'valid-list-456'});

        final result = NavigationGuards.deepLinkGuard(mockState, container);

        expect(result, isNull);
      });

      test('should redirect to 404 for invalid shopping list IDs', () {
        when(mockState.matchedLocation).thenReturn('/shopping/list/x');
        when(mockState.pathParameters).thenReturn({'id': 'x'});

        final result = NavigationGuards.deepLinkGuard(mockState, container);

        expect(result, equals(RouteConstants.notFoundPath));
      });
    });

    group('Profile Completion Guard Tests', () {
      testWidgets('should allow navigation when profile is complete', (tester) async {
        // Mock a complete user profile
        final mockProfile = {'id': 'test-user', 'name': 'Test User'};
        
        container = ProviderContainer(
          overrides: [
            userProfileProvider.overrideWith((ref) => Future.value(mockProfile)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/recipe-book');

        final result = NavigationGuards.profileCompletionGuard(mockState, container);

        expect(result, isNull);
      });

      testWidgets('should redirect to preferences when profile is incomplete', (tester) async {
        container = ProviderContainer(
          overrides: [
            userProfileProvider.overrideWith((ref) => Future.value(null)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/recipe-book');

        final result = NavigationGuards.profileCompletionGuard(mockState, container);

        expect(result, equals(RouteConstants.preferencesPath));
      });

      testWidgets('should not redirect when already on preferences page', (tester) async {
        container = ProviderContainer(
          overrides: [
            userProfileProvider.overrideWith((ref) => Future.value(null)),
          ],
        );

        when(mockState.matchedLocation).thenReturn('/profile/preferences');

        final result = NavigationGuards.profileCompletionGuard(mockState, container);

        expect(result, isNull);
      });
    });

    group('Guard Combination Tests', () {
      test('should return first non-null result from multiple guards', () {
        final guard1 = (GoRouterState state, WidgetRef ref) => null;
        final guard2 = (GoRouterState state, WidgetRef ref) => '/redirect';
        final guard3 = (GoRouterState state, WidgetRef ref) => '/another-redirect';

        final result = NavigationGuards.combineGuards(
          mockState,
          container,
          [guard1, guard2, guard3],
        );

        expect(result, equals('/redirect'));
      });

      test('should return null when all guards return null', () {
        final guard1 = (GoRouterState state, WidgetRef ref) => null;
        final guard2 = (GoRouterState state, WidgetRef ref) => null;
        final guard3 = (GoRouterState state, WidgetRef ref) => null;

        final result = NavigationGuards.combineGuards(
          mockState,
          container,
          [guard1, guard2, guard3],
        );

        expect(result, isNull);
      });
    });

    group('ID Validation Tests', () {
      test('should validate recipe IDs correctly', () {
        expect(NavigationGuards._isValidRecipeId('valid-recipe-123'), isTrue);
        expect(NavigationGuards._isValidRecipeId('abc'), isTrue);
        expect(NavigationGuards._isValidRecipeId(''), isFalse);
        expect(NavigationGuards._isValidRecipeId('ab'), isFalse);
        expect(NavigationGuards._isValidRecipeId('a' * 51), isFalse);
      });

      test('should validate generic IDs correctly', () {
        expect(NavigationGuards._isValidId('valid-id-123'), isTrue);
        expect(NavigationGuards._isValidId('abc'), isTrue);
        expect(NavigationGuards._isValidId(''), isFalse);
        expect(NavigationGuards._isValidId('ab'), isFalse);
        expect(NavigationGuards._isValidId('a' * 51), isFalse);
      });
    });
  });

  group('GoRouterState Extension Tests', () {
    late MockGoRouterState mockState;

    setUp(() {
      mockState = MockGoRouterState();
    });

    test('should correctly identify if route requires auth', () {
      when(mockState.matchedLocation).thenReturn('/recipe-book');
      expect(mockState.requiresAuth, isTrue);

      when(mockState.matchedLocation).thenReturn('/auth');
      expect(mockState.requiresAuth, isFalse);
    });

    test('should correctly identify public routes', () {
      when(mockState.matchedLocation).thenReturn('/auth');
      expect(mockState.isPublicRoute, isTrue);

      when(mockState.matchedLocation).thenReturn('/recipe-book');
      expect(mockState.isPublicRoute, isFalse);
    });

    test('should calculate correct tab index', () {
      when(mockState.matchedLocation).thenReturn('/');
      expect(mockState.currentTabIndex, equals(0));

      when(mockState.matchedLocation).thenReturn('/recipe-book');
      expect(mockState.currentTabIndex, equals(1));

      when(mockState.matchedLocation).thenReturn('/shopping');
      expect(mockState.currentTabIndex, equals(2));

      when(mockState.matchedLocation).thenReturn('/meal-planner');
      expect(mockState.currentTabIndex, equals(3));

      when(mockState.matchedLocation).thenReturn('/profile');
      expect(mockState.currentTabIndex, equals(4));
    });
  });
}