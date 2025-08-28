import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/router/route_constants.dart';

void main() {
  group('Route Constants Tests', () {
    test('should have correct route paths', () {
      expect(RouteConstants.homePath, equals('/'));
      expect(RouteConstants.authPath, equals('/auth'));
      expect(RouteConstants.recipeBookPath, equals('/recipe-book'));
      expect(RouteConstants.shoppingPath, equals('/shopping'));
      expect(RouteConstants.mealPlannerPath, equals('/meal-planner'));
      expect(RouteConstants.profilePath, equals('/profile'));
    });

    test('should have correct route names', () {
      expect(RouteConstants.homeName, equals('home'));
      expect(RouteConstants.authName, equals('auth'));
      expect(RouteConstants.recipeBookName, equals('recipe-book'));
      expect(RouteConstants.shoppingName, equals('shopping'));
      expect(RouteConstants.mealPlannerName, equals('meal-planner'));
      expect(RouteConstants.profileName, equals('profile'));
    });

    test('should build correct dynamic paths', () {
      const recipeId = 'test-recipe-123';
      const listId = 'test-list-456';
      const planId = 'test-plan-789';
      
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
      expect(
        RouteConstants.buildMealPlanPath(planId),
        equals('/meal-planner/plan/test-plan-789'),
      );
    });

    test('should correctly identify authenticated routes', () {
      expect(RouteConstants.requiresAuth('/'), isTrue);
      expect(RouteConstants.requiresAuth('/recipe-book'), isTrue);
      expect(RouteConstants.requiresAuth('/shopping'), isTrue);
      expect(RouteConstants.requiresAuth('/meal-planner'), isTrue);
      expect(RouteConstants.requiresAuth('/profile'), isTrue);
      expect(RouteConstants.requiresAuth('/auth'), isFalse);
      expect(RouteConstants.requiresAuth('/404'), isFalse);
      expect(RouteConstants.requiresAuth('/error'), isFalse);
    });

    test('should correctly identify public routes', () {
      expect(RouteConstants.isPublicRoute('/auth'), isTrue);
      expect(RouteConstants.isPublicRoute('/404'), isTrue);
      expect(RouteConstants.isPublicRoute('/error'), isTrue);
      expect(RouteConstants.isPublicRoute('/'), isFalse);
      expect(RouteConstants.isPublicRoute('/recipe-book'), isFalse);
      expect(RouteConstants.isPublicRoute('/shopping'), isFalse);
    });

    test('should handle dynamic route authentication checks', () {
      expect(RouteConstants.requiresAuth('/recipe/123'), isTrue);
      expect(RouteConstants.requiresAuth('/recipe/abc-def'), isTrue);
      expect(RouteConstants.requiresAuth('/shopping/list/456'), isTrue);
      expect(RouteConstants.requiresAuth('/meal-planner/plan/789'), isTrue);
      expect(RouteConstants.requiresAuth('/community/group/xyz'), isTrue);
      expect(RouteConstants.requiresAuth('/learn/tutorial/abc'), isTrue);
    });

    test('should contain all expected authenticated routes', () {
      final expectedRoutes = [
        RouteConstants.homePath,
        RouteConstants.recipeBookPath,
        RouteConstants.shoppingPath,
        RouteConstants.mealPlannerPath,
        RouteConstants.profilePath,
        RouteConstants.searchPath,
        RouteConstants.advancedSearchPath,
        RouteConstants.pantryPath,
        RouteConstants.nutritionTrackerPath,
        RouteConstants.settingsPath,
        RouteConstants.preferencesPath,
        RouteConstants.achievementsPath,
        RouteConstants.communityPath,
        RouteConstants.kitchenToolsPath,
        RouteConstants.timersPath,
        RouteConstants.converterPath,
        RouteConstants.tutorialsPath,
      ];

      for (final route in expectedRoutes) {
        expect(
          RouteConstants.authenticatedRoutes.contains(route),
          isTrue,
          reason: 'Route $route should be in authenticatedRoutes list',
        );
      }
    });

    test('should contain all expected public routes', () {
      final expectedRoutes = [
        RouteConstants.authPath,
        RouteConstants.notFoundPath,
        RouteConstants.errorPath,
      ];

      for (final route in expectedRoutes) {
        expect(
          RouteConstants.publicRoutes.contains(route),
          isTrue,
          reason: 'Route $route should be in publicRoutes list',
        );
      }
    });

    test('should not have overlapping authenticated and public routes', () {
      final authenticatedSet = RouteConstants.authenticatedRoutes.toSet();
      final publicSet = RouteConstants.publicRoutes.toSet();
      
      final intersection = authenticatedSet.intersection(publicSet);
      
      expect(
        intersection.isEmpty,
        isTrue,
        reason: 'Authenticated and public routes should not overlap. Found: $intersection',
      );
    });
  });
}