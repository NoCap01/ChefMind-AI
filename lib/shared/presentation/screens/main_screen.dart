import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_constants.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
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
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    
    if (location.startsWith(RouteConstants.recipeBookPath)) {
      return 1;
    }
    if (location.startsWith(RouteConstants.shoppingPath)) {
      return 2;
    }
    if (location.startsWith(RouteConstants.mealPlannerPath)) {
      return 3;
    }
    if (location.startsWith(RouteConstants.profilePath)) {
      return 4;
    }
    return 0; // Home tab
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(RouteConstants.homeName);
        break;
      case 1:
        context.goNamed(RouteConstants.recipeBookName);
        break;
      case 2:
        context.goNamed(RouteConstants.shoppingName);
        break;
      case 3:
        context.goNamed(RouteConstants.mealPlannerName);
        break;
      case 4:
        context.goNamed(RouteConstants.profileName);
        break;
    }
  }
}