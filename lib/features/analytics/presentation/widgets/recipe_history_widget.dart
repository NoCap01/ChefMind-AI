import 'package:flutter/material.dart';
import '../../../../domain/entities/recipe.dart';
import '../../../../domain/entities/recipe_rating.dart';
import '../../../../shared/widgets/star_rating.dart';
import '../../../../shared/widgets/recipe_card.dart';

class RecipeHistoryWidget extends StatefulWidget {
  final String userId;
  final Function(Recipe recipe)? onRecipeTap;

  const RecipeHistoryWidget({
    super.key,
    required this.userId,
    this.onRecipeTap,
  });

  @override
  State<RecipeHistoryWidget> createState() => _RecipeHistoryWidgetState();
}

class _RecipeHistoryWidgetState extends State<RecipeHistoryWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Recipe> _recentlyViewed = [];
  List<Recipe> _mostCooked = [];
  List<Recipe> _highestRated = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadHistoryData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadHistoryData() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // TODO: Get data from repository
      // For now, create mock data
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _recentlyViewed = _generateMockRecipes('recently_viewed');
        _mostCooked = _generateMockRecipes('most_cooked');
        _highestRated = _generateMockRecipes('highest_rated');
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<Recipe> _generateMockRecipes(String type) {
    final baseRecipes = [
      Recipe(
        id: '1',
        title: 'Spaghetti Carbonara',
        description: 'Classic Italian pasta dish with eggs, cheese, and pancetta',
        ingredients: [
          const Ingredient(name: 'Spaghetti', quantity: 400, unit: 'g'),
          const Ingredient(name: 'Eggs', quantity: 4, unit: 'pieces'),
          const Ingredient(name: 'Pancetta', quantity: 150, unit: 'g'),
        ],
        instructions: [
          const CookingStep(stepNumber: 1, instruction: 'Cook pasta'),
          const CookingStep(stepNumber: 2, instruction: 'Prepare sauce'),
        ],
        cookingTime: const Duration(minutes: 20),
        prepTime: const Duration(minutes: 10),
        difficulty: DifficultyLevel.intermediate,
        servings: 4,
        tags: ['Italian', 'Pasta', 'Quick'],
        nutrition: const NutritionInfo(
          calories: 450,
          protein: 20,
          carbs: 45,
          fat: 18,
          fiber: 2,
          sugar: 3,
          sodium: 800,
        ),
        tips: ['Use fresh eggs', 'Don\'t overcook'],
        rating: type == 'highest_rated' ? 4.8 : 4.2,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        cookCount: type == 'most_cooked' ? 12 : 3,
      ),
      Recipe(
        id: '2',
        title: 'Chicken Tikka Masala',
        description: 'Creamy Indian curry with tender chicken pieces',
        ingredients: [
          const Ingredient(name: 'Chicken breast', quantity: 500, unit: 'g'),
          const Ingredient(name: 'Yogurt', quantity: 200, unit: 'ml'),
          const Ingredient(name: 'Tomato sauce', quantity: 400, unit: 'ml'),
        ],
        instructions: [
          const CookingStep(stepNumber: 1, instruction: 'Marinate chicken'),
          const CookingStep(stepNumber: 2, instruction: 'Cook curry'),
        ],
        cookingTime: const Duration(minutes: 45),
        prepTime: const Duration(minutes: 30),
        difficulty: DifficultyLevel.intermediate,
        servings: 4,
        tags: ['Indian', 'Curry', 'Spicy'],
        nutrition: const NutritionInfo(
          calories: 380,
          protein: 35,
          carbs: 15,
          fat: 22,
          fiber: 3,
          sugar: 8,
          sodium: 900,
        ),
        tips: ['Marinate overnight', 'Use fresh spices'],
        rating: type == 'highest_rated' ? 4.9 : 4.1,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        cookCount: type == 'most_cooked' ? 8 : 2,
      ),
      Recipe(
        id: '3',
        title: 'Chocolate Chip Cookies',
        description: 'Classic homemade cookies with chocolate chips',
        ingredients: [
          const Ingredient(name: 'Flour', quantity: 300, unit: 'g'),
          const Ingredient(name: 'Butter', quantity: 200, unit: 'g'),
          const Ingredient(name: 'Chocolate chips', quantity: 150, unit: 'g'),
        ],
        instructions: [
          const CookingStep(stepNumber: 1, instruction: 'Mix ingredients'),
          const CookingStep(stepNumber: 2, instruction: 'Bake cookies'),
        ],
        cookingTime: const Duration(minutes: 15),
        prepTime: const Duration(minutes: 20),
        difficulty: DifficultyLevel.beginner,
        servings: 24,
        tags: ['Dessert', 'Baking', 'Sweet'],
        nutrition: const NutritionInfo(
          calories: 180,
          protein: 3,
          carbs: 25,
          fat: 8,
          fiber: 1,
          sugar: 12,
          sodium: 150,
        ),
        tips: ['Don\'t overbake', 'Use room temperature butter'],
        rating: type == 'highest_rated' ? 4.7 : 4.5,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        cookCount: type == 'most_cooked' ? 15 : 5,
      ),
    ];

    // Sort based on type
    switch (type) {
      case 'most_cooked':
        baseRecipes.sort((a, b) => b.cookCount.compareTo(a.cookCount));
        break;
      case 'highest_rated':
        baseRecipes.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'recently_viewed':
      default:
        baseRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return baseRecipes;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.history,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Recipe History',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          tabs: const [
            Tab(text: 'Recently Viewed'),
            Tab(text: 'Most Cooked'),
            Tab(text: 'Highest Rated'),
          ],
        ),
        SizedBox(
          height: 400,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
                  ? _buildErrorWidget()
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildRecipeList(_recentlyViewed, 'recently_viewed'),
                        _buildRecipeList(_mostCooked, 'most_cooked'),
                        _buildRecipeList(_highestRated, 'highest_rated'),
                      ],
                    ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load recipe history',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _error!,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _loadHistoryData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeList(List<Recipe> recipes, String type) {
    if (recipes.isEmpty) {
      return _buildEmptyState(type);
    }

    return RefreshIndicator(
      onRefresh: _loadHistoryData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildRecipeHistoryCard(recipe, type),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String type) {
    final theme = Theme.of(context);
    
    String title;
    String subtitle;
    IconData icon;

    switch (type) {
      case 'most_cooked':
        title = 'No recipes cooked yet';
        subtitle = 'Start cooking to see your most cooked recipes here';
        icon = Icons.restaurant;
        break;
      case 'highest_rated':
        title = 'No rated recipes yet';
        subtitle = 'Rate some recipes to see your favorites here';
        icon = Icons.star;
        break;
      case 'recently_viewed':
      default:
        title = 'No recent activity';
        subtitle = 'Browse recipes to see your viewing history here';
        icon = Icons.visibility;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeHistoryCard(Recipe recipe, String type) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => widget.onRecipeTap?.call(recipe),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Recipe image placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: recipe.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          recipe.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant,
                              color: theme.colorScheme.onPrimaryContainer,
                              size: 32,
                            );
                          },
                        ),
                      )
                    : Icon(
                        Icons.restaurant,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 32,
                      ),
              ),
              const SizedBox(width: 16),
              
              // Recipe details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CompactStarRating(
                          rating: recipe.rating,
                          size: 14,
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.timer,
                          size: 14,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.cookingTime.inMinutes}m',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        if (type == 'most_cooked') ...[
                          const SizedBox(width: 12),
                          Icon(
                            Icons.restaurant,
                            size: 14,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.cookCount}x',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              
              // Action button
              IconButton(
                onPressed: () => widget.onRecipeTap?.call(recipe),
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}