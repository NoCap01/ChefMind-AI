import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

import '../providers/auth_provider.dart';
import 'route_constants.dart';

/// Navigation guards for handling authentication and authorization
class NavigationGuards {
  NavigationGuards._();

  /// Authentication guard that redirects unauthenticated users to login
  static String? authGuard(
    GoRouterState state,
    Ref ref,
  ) {
    final authState = ref.read(authStateProvider);
    final currentPath = state.matchedLocation;

    return authState.when(
      data: (user) => _handleAuthenticatedUser(user, currentPath),
      loading: () => _handleLoadingState(currentPath),
      error: (_, __) => _handleAuthError(currentPath),
    );
  }

  /// Handle navigation for authenticated users
  static String? _handleAuthenticatedUser(User? user, String currentPath) {
    final isLoggedIn = user != null;
    final isOnAuthPage = currentPath == RouteConstants.authPath;

    // If user is logged in but on auth page, redirect to home
    if (isLoggedIn && isOnAuthPage) {
      return RouteConstants.homePath;
    }

    // If user is not logged in and trying to access protected route
    if (!isLoggedIn && RouteConstants.requiresAuth(currentPath)) {
      return RouteConstants.authPath;
    }

    // Allow navigation
    return null;
  }

  /// Handle navigation during loading state
  static String? _handleLoadingState(String currentPath) {
    // During loading, only allow access to public routes
    if (RouteConstants.isPublicRoute(currentPath)) {
      return null;
    }
    
    // For protected routes during loading, stay on current route
    // The auth state will resolve and redirect appropriately
    return null;
  }

  /// Handle navigation when auth state has error
  static String? _handleAuthError(String currentPath) {
    // On auth error, redirect to auth page unless already there
    if (currentPath != RouteConstants.authPath) {
      return RouteConstants.authPath;
    }
    return null;
  }

  /// Profile completion guard - ensures user has completed their profile
  static String? profileCompletionGuard(
    GoRouterState state,
    Ref ref,
  ) {
    final userProfile = ref.read(userProfileProvider);
    final currentPath = state.matchedLocation;

    return userProfile.when(
      data: (profile) {
        // If profile is null or incomplete, redirect to profile setup
        if (profile == null || !_isProfileComplete(profile)) {
          if (currentPath != RouteConstants.preferencesPath) {
            return RouteConstants.preferencesPath;
          }
        }
        return null;
      },
      loading: () => null, // Allow navigation during loading
      error: (_, __) => null, // Allow navigation on error
    );
  }

  /// Check if user profile is complete
  static bool _isProfileComplete(dynamic profile) {
    // Add logic to check if profile has required fields
    // This is a placeholder - implement based on UserProfile model
    return profile != null;
  }

  /// Premium feature guard - checks if user has access to premium features
  static String? premiumFeatureGuard(
    GoRouterState state,
    Ref ref,
  ) {
    // This would check subscription status
    // For now, allow all users access
    return null;
  }

  /// Admin guard - restricts access to admin-only features
  static String? adminGuard(
    GoRouterState state,
    Ref ref,
  ) {
    final user = ref.read(currentUserProvider);
    
    // Check if user has admin privileges
    // This is a placeholder - implement based on user roles
    if (user == null || !_isAdmin(user)) {
      return RouteConstants.homePath;
    }
    
    return null;
  }

  /// Check if user has admin privileges
  static bool _isAdmin(User user) {
    // Implement admin check logic
    // This could check custom claims or user roles
    return false;
  }

  /// Deep link validation guard
  static String? deepLinkGuard(
    GoRouterState state,
    Ref ref,
  ) {
    final currentPath = state.matchedLocation;
    final pathParameters = state.pathParameters;

    // Validate recipe ID format
    if (currentPath.startsWith('/recipe/')) {
      final recipeId = pathParameters['id'];
      if (recipeId == null || !_isValidRecipeId(recipeId)) {
        return RouteConstants.notFoundPath;
      }
    }

    // Validate shopping list ID format
    if (currentPath.startsWith('/shopping/list/')) {
      final listId = pathParameters['id'];
      if (listId == null || !_isValidId(listId)) {
        return RouteConstants.notFoundPath;
      }
    }

    // Validate meal plan ID format
    if (currentPath.startsWith('/meal-planner/plan/')) {
      final planId = pathParameters['id'];
      if (planId == null || !_isValidId(planId)) {
        return RouteConstants.notFoundPath;
      }
    }

    // Validate community group ID format
    if (currentPath.startsWith('/community/group/')) {
      final groupId = pathParameters['id'];
      if (groupId == null || !_isValidId(groupId)) {
        return RouteConstants.notFoundPath;
      }
    }

    return null;
  }

  /// Validate recipe ID format
  static bool _isValidRecipeId(String id) {
    // Implement recipe ID validation logic
    // For now, just check it's not empty and has reasonable length
    return id.isNotEmpty && id.length >= 3 && id.length <= 50;
  }

  /// Validate generic ID format
  static bool _isValidId(String id) {
    // Implement generic ID validation logic
    return id.isNotEmpty && id.length >= 3 && id.length <= 50;
  }

  /// Combine multiple guards
  static String? combineGuards(
    GoRouterState state,
    Ref ref,
    List<String? Function(GoRouterState, Ref)> guards,
  ) {
    for (final guard in guards) {
      final result = guard(state, ref);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

/// Extension to make guard usage more convenient
extension GoRouterStateExtension on GoRouterState {
  /// Check if current route requires authentication
  bool get requiresAuth => RouteConstants.requiresAuth(matchedLocation);
  
  /// Check if current route is public
  bool get isPublicRoute => RouteConstants.isPublicRoute(matchedLocation);
  
  /// Get the current tab index based on location
  int get currentTabIndex {
    final location = matchedLocation;
    if (location.startsWith(RouteConstants.recipeBookPath)) return 1;
    if (location.startsWith(RouteConstants.shoppingPath)) return 2;
    if (location.startsWith(RouteConstants.mealPlannerPath)) return 3;
    if (location.startsWith(RouteConstants.profilePath)) return 4;
    return 0; // Home tab
  }
}