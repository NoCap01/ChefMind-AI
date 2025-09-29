import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/simple_home_screen.dart';
import '../../presentation/screens/home/simple_recipe_generation_screen.dart';
import '../../presentation/screens/simple_screens.dart';
import '../services/navigation_service.dart';

// Simple route generator for MaterialApp
Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => const SimpleMainNavigation(child: SimpleHomeScreen()),
        settings: settings,
      );
    case '/recipe-generation':
      return MaterialPageRoute(
        builder: (_) =>
            const SimpleMainNavigation(child: SimpleRecipeGenerationScreen()),
        settings: settings,
      );
    case '/recipes':
      return MaterialPageRoute(
        builder: (_) =>
            const SimpleMainNavigation(child: SimpleRecipeBookScreen()),
        settings: settings,
      );
    case '/shopping':
      return MaterialPageRoute(
        builder: (_) =>
            const SimpleMainNavigation(child: SimpleShoppingScreen()),
        settings: settings,
      );
    case '/meal-planner':
      return MaterialPageRoute(
        builder: (_) =>
            const SimpleMainNavigation(child: SimpleMealPlannerScreen()),
        settings: settings,
      );
    case '/profile':
      return MaterialPageRoute(
        builder: (_) =>
            const SimpleMainNavigation(child: SimpleProfileScreen()),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const SimpleMainNavigation(child: SimpleHomeScreen()),
        settings: settings,
      );
  }
}

// Navigation state provider
final navigationStateProvider =
    StateNotifierProvider<NavigationStateNotifier, NavigationState>((ref) {
  return NavigationStateNotifier();
});

class NavigationState {
  final int currentIndex;
  final String currentPath;
  final bool canPop;

  const NavigationState({
    required this.currentIndex,
    required this.currentPath,
    required this.canPop,
  });

  NavigationState copyWith({
    int? currentIndex,
    String? currentPath,
    bool? canPop,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      currentPath: currentPath ?? this.currentPath,
      canPop: canPop ?? this.canPop,
    );
  }
}

class NavigationStateNotifier extends StateNotifier<NavigationState> {
  NavigationStateNotifier()
      : super(const NavigationState(
          currentIndex: 0,
          currentPath: '/',
          canPop: false,
        ));

  void updateNavigation(String path, bool canPop) {
    final index = _getIndexFromPath(path);
    state = state.copyWith(
      currentIndex: index,
      currentPath: path,
      canPop: canPop,
    );
  }

  int _getIndexFromPath(String path) {
    if (path == '/' || path.startsWith('/recipe-generation')) return 0;
    if (path.startsWith('/recipes')) return 1;
    if (path.startsWith('/shopping')) return 2;
    if (path.startsWith('/meal-planner')) return 3;
    if (path.startsWith('/profile')) return 4;
    return 0;
  }
}

final simpleRouterProvider = Provider<GoRouter>((ref) {
  final navigationNotifier = ref.read(navigationStateProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        ErrorScreen(error: state.error.toString()),
    redirect: (context, state) {
      // Update navigation state on route changes
      // Note: We can't access GoRouter.of(context) here as it's not yet available
      navigationNotifier.updateNavigation(state.uri.path, false);
      return null; // No redirect needed
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => SimpleMainNavigation(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const SimpleHomeScreen(),
          ),
          GoRoute(
            path: '/recipe-generation',
            name: 'recipe-generation',
            builder: (context, state) => const SimpleRecipeGenerationScreen(),
          ),
          GoRoute(
            path: '/recipes',
            name: 'recipes',
            builder: (context, state) => const SimpleRecipeBookScreen(),
          ),
          GoRoute(
            path: '/shopping',
            name: 'shopping',
            builder: (context, state) => const SimpleShoppingScreen(),
            routes: [
              GoRoute(
                path: 'pantry',
                name: 'shopping-pantry',
                builder: (context, state) => const SimplePantryScreen(),
              ),
              GoRoute(
                path: 'list',
                name: 'shopping-list',
                builder: (context, state) => const SimpleShoppingListScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/meal-planner',
            name: 'meal-planner',
            builder: (context, state) => const SimpleMealPlannerScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const SimpleProfileScreen(),
          ),
        ],
      ),
    ],
  );
});

// Error screen for navigation errors
class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                'Navigation Error',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleMainNavigation extends ConsumerStatefulWidget {
  final Widget child;

  const SimpleMainNavigation({super.key, required this.child});

  @override
  ConsumerState<SimpleMainNavigation> createState() =>
      _SimpleMainNavigationState();
}

class _SimpleMainNavigationState extends ConsumerState<SimpleMainNavigation> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update navigation state based on current route
    final route = ModalRoute.of(context);
    if (route != null && route.settings.name != null) {
      final canPop = Navigator.of(context).canPop();
      ref
          .read(navigationStateProvider.notifier)
          .updateNavigation(route.settings.name!, canPop);
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationState = ref.watch(navigationStateProvider);

    return PopScope(
      canPop: navigationState.canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && navigationState.canPop) {
          // Handle back button navigation
          _handleBackNavigation(context, navigationState.currentPath);
        }
      },
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: SimpleBottomNavBar(
          currentIndex: navigationState.currentIndex,
          currentPath: navigationState.currentPath,
        ),
      ),
    );
  }

  void _handleBackNavigation(BuildContext context, String currentPath) {
    // Use navigation service for consistent back navigation
    if (!NavigationService.handleBackNavigation(context, currentPath)) {
      // Fallback to default behavior
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pushReplacementNamed('/');
      }
    }
  }
}

class SimpleBottomNavBar extends ConsumerWidget {
  final int currentIndex;
  final String currentPath;

  const SimpleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor:
          Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
      onTap: (index) => _onTap(context, ref, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          activeIcon: Icon(Icons.book),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Shopping',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Planner',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  void _onTap(BuildContext context, WidgetRef ref, int index) {
    // Prevent navigation to the same tab
    if (index == currentIndex && !_isSubRoute(currentPath)) {
      return;
    }

    // Navigate to the selected tab with guards
    final routes = ['/', '/recipes', '/shopping', '/meal-planner', '/profile'];
    if (index < routes.length) {
      Navigator.of(context).pushReplacementNamed(routes[index]);
    }
  }

  bool _isSubRoute(String path) {
    // Check if current path is a sub-route (like /recipe-generation)
    return path == '/recipe-generation' ||
        path.contains('/recipes/') ||
        path.contains('/shopping/') ||
        path.contains('/meal-planner/') ||
        path.contains('/profile/');
  }
}
