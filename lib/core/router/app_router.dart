import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/recipe_book/presentation/screens/recipe_book_screen.dart';
import '../../features/shopping/presentation/screens/shopping_screen.dart';
import '../../features/meal_planner/presentation/screens/meal_planner_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/recipe/presentation/screens/recipe_detail_screen.dart';
import '../../shared/presentation/screens/main_screen.dart';
import '../../shared/presentation/modals/search_modal.dart';
import '../../shared/presentation/modals/settings_modal.dart';
import '../providers/auth_provider.dart';
import 'route_constants.dart';
import 'navigation_guards.dart';
import 'page_transitions.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteConstants.homePath,
    debugLogDiagnostics: true,
    
    // Global redirect for authentication
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final currentPath = state.matchedLocation;

      return authState.when(
        data: (user) {
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

          return null;
        },
        loading: () => null,
        error: (_, __) => currentPath != RouteConstants.authPath ? RouteConstants.authPath : null,
      );
    },
    
    // Error handling for invalid routes
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you\'re looking for doesn\'t exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.goNamed(RouteConstants.homeName),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
    
    routes: [
      // Auth Route
      GoRoute(
        path: RouteConstants.authPath,
        name: RouteConstants.authName,
        builder: (context, state) => const AuthScreen(),
      ),
      
      // Main Shell Route with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          // Home Tab
          GoRoute(
            path: RouteConstants.homePath,
            name: RouteConstants.homeName,
            builder: (context, state) => const HomeScreen(),
          ),
          
          // Recipe Book Tab
          GoRoute(
            path: RouteConstants.recipeBookPath,
            name: RouteConstants.recipeBookName,
            builder: (context, state) => const RecipeBookScreen(),
          ),
          
          // Shopping Tab
          GoRoute(
            path: RouteConstants.shoppingPath,
            name: RouteConstants.shoppingName,
            builder: (context, state) => const ShoppingScreen(),
          ),
          
          // Meal Planner Tab
          GoRoute(
            path: RouteConstants.mealPlannerPath,
            name: RouteConstants.mealPlannerName,
            builder: (context, state) => const MealPlannerScreen(),
          ),
          
          // Profile Tab
          GoRoute(
            path: RouteConstants.profilePath,
            name: RouteConstants.profileName,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      
      // Recipe Detail Route (outside shell for full-screen modal with hero transition)
      GoRoute(
        path: '/recipe/:id',
        name: RouteConstants.recipeDetailName,
        pageBuilder: (context, state) {
          final recipeId = state.pathParameters['id']!;
          return PageTransitions.heroTransition(
            RecipeDetailScreen(recipeId: recipeId),
            state,
            name: RouteConstants.recipeDetailName,
            heroTag: 'recipe-$recipeId',
          );
        },
      ),
      
      // Recipe Share Route for deep linking
      GoRoute(
        path: '/recipe/:id/share',
        name: RouteConstants.recipeShareName,
        pageBuilder: (context, state) {
          final recipeId = state.pathParameters['id']!;
          return PageTransitions.fadeWithScaleTransition(
            RecipeDetailScreen(
              recipeId: recipeId,
              isSharedLink: true,
            ),
            state,
            name: RouteConstants.recipeShareName,
          );
        },
      ),

      // Search Modal Route
      GoRoute(
        path: RouteConstants.searchPath,
        name: RouteConstants.searchName,
        pageBuilder: (context, state) {
          return PageTransitions.slideFromBottomTransition(
            const SearchModal(),
            state,
            name: RouteConstants.searchName,
          );
        },
      ),

      // Advanced Search Modal Route
      GoRoute(
        path: RouteConstants.advancedSearchPath,
        name: RouteConstants.advancedSearchName,
        pageBuilder: (context, state) {
          return PageTransitions.slideFromBottomTransition(
            const SearchModal(),
            state,
            name: RouteConstants.advancedSearchName,
          );
        },
      ),

      // Settings Modal Route
      GoRoute(
        path: RouteConstants.settingsPath,
        name: RouteConstants.settingsName,
        pageBuilder: (context, state) {
          return PageTransitions.slideFromRightTransition(
            const SettingsModal(),
            state,
            name: RouteConstants.settingsName,
          );
        },
      ),
    ],
  );
});

// Navigation Helper
class AppRouter {
  AppRouter._(); // Private constructor to prevent instantiation
  
  // Main navigation methods
  static void goToHome(BuildContext context) {
    context.goNamed(RouteConstants.homeName);
  }
  
  static void goToRecipeBook(BuildContext context) {
    context.goNamed(RouteConstants.recipeBookName);
  }
  
  static void goToShopping(BuildContext context) {
    context.goNamed(RouteConstants.shoppingName);
  }
  
  static void goToMealPlanner(BuildContext context) {
    context.goNamed(RouteConstants.mealPlannerName);
  }
  
  static void goToProfile(BuildContext context) {
    context.goNamed(RouteConstants.profileName);
  }
  
  static void goToAuth(BuildContext context) {
    context.goNamed(RouteConstants.authName);
  }
  
  // Recipe navigation methods
  static void goToRecipeDetail(BuildContext context, String recipeId) {
    context.goNamed(
      RouteConstants.recipeDetailName,
      pathParameters: {'id': recipeId},
    );
  }
  
  static void goToRecipeShare(BuildContext context, String recipeId) {
    context.goNamed(
      RouteConstants.recipeShareName,
      pathParameters: {'id': recipeId},
    );
  }
  
  // Modal navigation methods
  static void openSearchModal(BuildContext context) {
    context.goNamed(RouteConstants.searchName);
  }
  
  static void openAdvancedSearchModal(BuildContext context) {
    context.goNamed(RouteConstants.advancedSearchName);
  }
  
  static void openSettingsModal(BuildContext context) {
    context.goNamed(RouteConstants.settingsName);
  }

  // Deep linking methods
  static void handleDeepLink(BuildContext context, String link) {
    try {
      final uri = Uri.parse(link);
      final path = uri.path;
      
      // Handle recipe sharing links
      if (path.startsWith('/recipe/') && path.endsWith('/share')) {
        final recipeId = path.split('/')[2];
        goToRecipeShare(context, recipeId);
        return;
      }
      
      // Handle direct recipe links
      if (path.startsWith('/recipe/')) {
        final recipeId = path.split('/')[2];
        goToRecipeDetail(context, recipeId);
        return;
      }
      
      // Handle other deep links
      context.go(path);
    } catch (e) {
      // If deep link parsing fails, go to home
      goToHome(context);
    }
  }
  
  // Utility methods
  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      goToHome(context);
    }
  }
  
  static void popToHome(BuildContext context) {
    context.go(RouteConstants.homePath);
  }
  
  static String getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).matchedLocation;
  }
  
  static Map<String, String> getCurrentParameters(BuildContext context) {
    return GoRouterState.of(context).pathParameters;
  }
  
  static Map<String, String> getCurrentQueryParameters(BuildContext context) {
    return GoRouterState.of(context).uri.queryParameters;
  }
  
  // Share URL generation methods
  static String generateRecipeShareUrl(String recipeId) {
    return 'https://chefmind.ai${RouteConstants.buildRecipeSharePath(recipeId)}';
  }
  
  static String generateRecipeUrl(String recipeId) {
    return 'https://chefmind.ai${RouteConstants.buildRecipeDetailPath(recipeId)}';
  }
}