import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  // Navigation guards
  static bool canNavigateToRoute(String route, BuildContext context) {
    // Add any navigation guards here
    // For example, check if user is authenticated, has required permissions, etc.
    
    switch (route) {
      case '/profile':
        // Could check if user is logged in
        return true;
      case '/shopping':
        // Could check if shopping features are enabled
        return true;
      case '/meal-planner':
        // Could check if meal planning is available
        return true;
      default:
        return true;
    }
  }

  // Handle navigation with guards
  static void navigateWithGuard(BuildContext context, String route) {
    if (canNavigateToRoute(route, context)) {
      context.go(route);
    } else {
      _showNavigationError(context, route);
    }
  }

  // Show error when navigation is blocked
  static void _showNavigationError(BuildContext context, String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cannot navigate to ${route.replaceAll('/', '')}'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Handle back navigation with custom logic
  static bool handleBackNavigation(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case '/recipe-generation':
        // From recipe generation, always go back to home
        context.go('/');
        return true;
      case '/recipes':
      case '/shopping':
      case '/meal-planner':
      case '/profile':
        // From main tabs, go to home if no history
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          context.go('/');
        }
        return true;
      default:
        return false; // Let system handle
    }
  }

  // Get route title for app bar
  static String getRouteTitle(String route) {
    switch (route) {
      case '/':
        return 'ChefMind AI';
      case '/recipe-generation':
        return 'Generate Recipe';
      case '/recipes':
        return 'Recipe Book';
      case '/shopping':
        return 'Shopping & Pantry';
      case '/meal-planner':
        return 'Meal Planner';
      case '/profile':
        return 'Profile';
      default:
        return 'ChefMind AI';
    }
  }

  // Check if route should show back button
  static bool shouldShowBackButton(String route) {
    return route == '/recipe-generation' || route.contains('/');
  }

  // Get parent route for breadcrumb navigation
  static String? getParentRoute(String route) {
    if (route == '/recipe-generation') return '/';
    if (route.startsWith('/recipes/')) return '/recipes';
    if (route.startsWith('/shopping/')) return '/shopping';
    if (route.startsWith('/meal-planner/')) return '/meal-planner';
    if (route.startsWith('/profile/')) return '/profile';
    return null;
  }
}