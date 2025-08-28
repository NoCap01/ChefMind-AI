import 'package:flutter/material.dart';
import '../widgets/cooking_analytics_dashboard.dart';
import '../widgets/recipe_history_widget.dart';
import '../../../../domain/entities/recipe.dart';

class AnalyticsScreen extends StatefulWidget {
  final String userId;

  const AnalyticsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onRecipeTap(Recipe recipe) {
    // TODO: Navigate to recipe detail screen
    // Navigator.of(context).pushNamed('/recipe/${recipe.id}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${recipe.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cooking Analytics'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          tabs: const [
            Tab(
              icon: Icon(Icons.analytics),
              text: 'Dashboard',
            ),
            Tab(
              icon: Icon(Icons.history),
              text: 'History',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CookingAnalyticsDashboard(userId: widget.userId),
          RecipeHistoryWidget(
            userId: widget.userId,
            onRecipeTap: _onRecipeTap,
          ),
        ],
      ),
    );
  }
}