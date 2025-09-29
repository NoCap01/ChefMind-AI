import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shopping/shopping_list_screen.dart';
import '../widgets/common/themed_screen_wrapper.dart';
import 'home/simple_recipe_generation_screen.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/enums/meal_type.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../services/recipe_storage_service.dart';
import '../widgets/recipe/recipe_detail_dialog.dart';

// Export the meal planner implementation
export 'meal_planner/simple_meal_planner_screen.dart';

// Export the shopping and pantry screen
export 'shopping/shopping_pantry_screen.dart';

// Helper function to add sample recipes for testing
Future<void> _addSampleRecipes(RecipeStorageService storageService) async {
  final sampleRecipes = [
    Recipe(
      id: 'sample-1',
      title: 'Classic Spaghetti Carbonara',
      description:
          'A traditional Italian pasta dish with eggs, cheese, and pancetta',
      ingredients: [
        const Ingredient(name: 'Spaghetti', quantity: 400, unit: 'g'),
        const Ingredient(name: 'Pancetta', quantity: 200, unit: 'g'),
        const Ingredient(name: 'Eggs', quantity: 4, unit: 'large'),
        const Ingredient(name: 'Parmesan cheese', quantity: 100, unit: 'g'),
        const Ingredient(name: 'Black pepper', quantity: 1, unit: 'to taste'),
      ],
      instructions: [
        const CookingStep(
          stepNumber: 1,
          instruction: 'Cook spaghetti according to package instructions',
          duration: 10,
        ),
        const CookingStep(
          stepNumber: 2,
          instruction: 'Fry pancetta until crispy',
          duration: 5,
        ),
        const CookingStep(
          stepNumber: 3,
          instruction: 'Mix eggs and cheese in a bowl',
          duration: 2,
        ),
        const CookingStep(
          stepNumber: 4,
          instruction: 'Combine pasta with pancetta and egg mixture',
          duration: 3,
        ),
      ],
      metadata: const RecipeMetadata(
        servings: 4,
        prepTime: 10,
        cookTime: 20,
        difficulty: DifficultyLevel.medium,
        mealType: MealType.dinner,
        cuisine: 'Italian',
      ),
      tags: ['pasta', 'italian', 'quick'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      source: 'ChefMind AI',
    ),
    Recipe(
      id: 'sample-2',
      title: 'Avocado Toast with Poached Egg',
      description:
          'Healthy breakfast with creamy avocado and perfectly poached egg',
      ingredients: [
        const Ingredient(name: 'Bread slices', quantity: 2, unit: 'slices'),
        const Ingredient(name: 'Avocado', quantity: 1, unit: 'ripe'),
        const Ingredient(name: 'Eggs', quantity: 2, unit: 'pieces'),
        const Ingredient(name: 'Lemon juice', quantity: 1, unit: 'tbsp'),
        const Ingredient(name: 'Salt', quantity: 1, unit: 'to taste'),
        const Ingredient(name: 'Red pepper flakes', quantity: 1, unit: 'pinch'),
      ],
      instructions: [
        const CookingStep(
          stepNumber: 1,
          instruction: 'Toast bread slices until golden',
          duration: 3,
        ),
        const CookingStep(
          stepNumber: 2,
          instruction: 'Mash avocado with lemon juice and salt',
          duration: 2,
        ),
        const CookingStep(
          stepNumber: 3,
          instruction: 'Poach eggs in simmering water',
          duration: 4,
        ),
        const CookingStep(
          stepNumber: 4,
          instruction: 'Spread avocado on toast and top with egg',
          duration: 1,
        ),
      ],
      metadata: const RecipeMetadata(
        servings: 2,
        prepTime: 5,
        cookTime: 10,
        difficulty: DifficultyLevel.easy,
        mealType: MealType.breakfast,
        cuisine: 'Modern',
      ),
      tags: ['healthy', 'breakfast', 'avocado', 'quick'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      source: 'ChefMind AI',
    ),
    Recipe(
      id: 'sample-3',
      title: 'Chocolate Chip Cookies',
      description:
          'Classic homemade chocolate chip cookies that are crispy outside and chewy inside',
      ingredients: [
        const Ingredient(
            name: 'All-purpose flour', quantity: 2.25, unit: 'cups'),
        const Ingredient(name: 'Butter', quantity: 1, unit: 'cup'),
        const Ingredient(name: 'Brown sugar', quantity: 0.75, unit: 'cup'),
        const Ingredient(name: 'White sugar', quantity: 0.75, unit: 'cup'),
        const Ingredient(name: 'Eggs', quantity: 2, unit: 'pieces'),
        const Ingredient(name: 'Vanilla extract', quantity: 2, unit: 'tsp'),
        const Ingredient(name: 'Chocolate chips', quantity: 2, unit: 'cups'),
      ],
      instructions: [
        const CookingStep(
          stepNumber: 1,
          instruction: 'Preheat oven to 375°F (190°C)',
          duration: 5,
        ),
        const CookingStep(
          stepNumber: 2,
          instruction: 'Cream butter and sugars together',
          duration: 3,
        ),
        const CookingStep(
          stepNumber: 3,
          instruction: 'Add eggs and vanilla, mix well',
          duration: 2,
        ),
        const CookingStep(
          stepNumber: 4,
          instruction: 'Gradually add flour, then fold in chocolate chips',
          duration: 5,
        ),
        const CookingStep(
          stepNumber: 5,
          instruction: 'Bake for 9-11 minutes until golden brown',
          duration: 10,
        ),
      ],
      metadata: const RecipeMetadata(
        servings: 24,
        prepTime: 15,
        cookTime: 25,
        difficulty: DifficultyLevel.easy,
        mealType: MealType.dessert,
        cuisine: 'American',
      ),
      tags: ['dessert', 'cookies', 'chocolate', 'baking'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      source: 'ChefMind AI',
    ),
  ];

  for (final recipe in sampleRecipes) {
    final exists = await storageService.isRecipeSaved(recipe.id);
    if (!exists) {
      await storageService.saveRecipe(recipe);
    }
  }

  // Make the first recipe a favorite for testing
  await storageService.addFavorite('sample-1');
}

// Provider for saved recipes with favorite status
final savedRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final storageService = RecipeStorageService();
  final recipes = await storageService.getSavedRecipes();
  final favoriteIds = await storageService.getFavoriteRecipeIds();

  // Update recipes with correct favorite status
  return recipes.map((recipe) {
    return recipe.copyWith(isFavorite: favoriteIds.contains(recipe.id));
  }).toList();
});

// Provider for recipe storage service
final recipeStorageServiceProvider = Provider<RecipeStorageService>((ref) {
  return RecipeStorageService();
});

// Simple Recipe Book Screen
class SimpleRecipeBookScreen extends ConsumerWidget {
  const SimpleRecipeBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ThemedScreenWrapper(
      title: 'Recipe Book',
      enablePullToRefresh: true,
      onRefresh: () async {
        // Refresh saved recipes
        await Future.delayed(const Duration(seconds: 1));
        ref.invalidate(savedRecipesProvider);
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SimpleRecipeGenerationScreen(),
          ),
        ),
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Generate Recipe'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final savedRecipesAsync = ref.watch(savedRecipesProvider);

          return savedRecipesAsync.when(
            data: (recipes) {
              if (recipes.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Recipe collection statistics
                  _buildStatisticsCard(context, recipes),
                  const SizedBox(height: 16),

                  // Recipe list
                  ...recipes.map((recipe) => _buildRecipeCard(
                        context,
                        ref,
                        recipe,
                      )),
                  const SizedBox(
                      height: 80), // Space for floating action button
                ],
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load recipes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => ref.invalidate(savedRecipesProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatisticsCard(BuildContext context, List<Recipe> recipes) {
    final totalRecipes = recipes.length;
    final avgCookTime = recipes.isEmpty
        ? 0
        : recipes.map((r) => r.totalTime).reduce((a, b) => a + b) /
            recipes.length;
    final favoriteCount = recipes.where((r) => r.isFavorite).length;
    final quickRecipes = recipes.where((r) => r.totalTime <= 30).length;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Recipe Collection Stats',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.book_outlined,
                      totalRecipes.toString(),
                      'Total Recipes',
                      Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.schedule_outlined,
                      '${avgCookTime.round()} min',
                      'Avg Cook Time',
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.favorite_outline,
                      favoriteCount.toString(),
                      'Favorites',
                      Colors.red,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      Icons.flash_on_outlined,
                      quickRecipes.toString(),
                      'Quick (≤30min)',
                      Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String value,
      String label, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey.shade800.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.8)
                  : Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.restaurant_menu_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your Recipe Collection Awaits!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Create delicious recipes with AI assistance and build your personal cookbook',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SimpleRecipeGenerationScreen(),
                ),
              ),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Generate Your First Recipe'),
              style: FilledButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return OutlinedButton.icon(
                      onPressed: () async {
                        try {
                          final storageService = RecipeStorageService();
                          await _addSampleRecipes(storageService);
                          ref.invalidate(savedRecipesProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Sample recipes added successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error adding sample recipes: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.auto_stories_outlined),
                      label: const Text('Add Sample Recipes'),
                    );
                  },
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Import feature coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.upload_file_outlined),
                  label: const Text('Import Recipes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeCard(
    BuildContext context,
    WidgetRef ref,
    Recipe recipe,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showRecipeDetail(context, ref, recipe),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getRecipeIcon(recipe.metadata.mealType),
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                recipe.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (recipe.isFavorite)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe.description,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        _handleRecipeAction(context, ref, recipe, value),
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view',
                        child: ListTile(
                          leading: Icon(Icons.visibility_outlined),
                          title: Text('View Details'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'favorite',
                        child: ListTile(
                          leading: Icon(
                            recipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: recipe.isFavorite ? Colors.red : null,
                          ),
                          title: Text(recipe.isFavorite
                              ? 'Remove Favorite'
                              : 'Add Favorite'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading:
                              Icon(Icons.delete_outline, color: Colors.red),
                          title: Text('Delete',
                              style: TextStyle(color: Colors.red)),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildInfoChip(
                      context,
                      Icons.schedule_outlined,
                      '${recipe.totalTime} min',
                      Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                      context,
                      Icons.people_outline,
                      '${recipe.metadata.servings} servings',
                      Colors.green,
                    ),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                      context,
                      Icons.signal_cellular_alt,
                      recipe.metadata.difficulty.name,
                      _getDifficultyColor(recipe.metadata.difficulty),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
      BuildContext context, IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    return switch (difficulty) {
      DifficultyLevel.beginner => Colors.lightGreen,
      DifficultyLevel.easy => Colors.green,
      DifficultyLevel.medium => Colors.orange,
      DifficultyLevel.hard => Colors.red,
      DifficultyLevel.expert => Colors.purple,
    };
  }

  IconData _getRecipeIcon(MealType? mealType) {
    return switch (mealType) {
      MealType.breakfast => Icons.free_breakfast,
      MealType.lunch => Icons.lunch_dining,
      MealType.dinner => Icons.dinner_dining,
      MealType.snack => Icons.cookie,
      MealType.dessert => Icons.cake,
      _ => Icons.restaurant,
    };
  }

  void _showRecipeDetail(
      BuildContext context, WidgetRef ref, Recipe recipe) async {
    final storageService = RecipeStorageService();
    final isFavorite = await storageService.isFavoriteRecipe(recipe.id);

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => RecipeDetailDialog(
        recipe: recipe,
        isFavorite: isFavorite,
        onSave: () async {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Recipe is already in your collection!'),
              backgroundColor: Colors.blue,
            ),
          );
        },
        onFavorite: () {
          Navigator.pop(context);
          _toggleFavorite(context, ref, recipe);
        },
        onEdit: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Edit feature coming soon!')),
          );
        },
        onDelete: () {
          Navigator.pop(context);
          _deleteRecipe(context, ref, recipe);
        },
      ),
    );
  }

  void _toggleFavorite(
      BuildContext context, WidgetRef ref, Recipe recipe) async {
    try {
      final storageService = RecipeStorageService();
      final success = await storageService.toggleFavorite(recipe.id);

      if (!context.mounted) return;

      if (success) {
        final isFavorite = await storageService.isFavoriteRecipe(recipe.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? '${recipe.title} added to favorites!'
                  : '${recipe.title} removed from favorites!',
            ),
            backgroundColor: isFavorite ? Colors.green : Colors.orange,
          ),
        );
        ref.invalidate(savedRecipesProvider);
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleRecipeAction(
      BuildContext context, WidgetRef ref, Recipe recipe, String action) {
    switch (action) {
      case 'view':
        _showRecipeDetail(context, ref, recipe);
        break;
      case 'favorite':
        _toggleFavorite(context, ref, recipe);
        break;
      case 'delete':
        _deleteRecipe(context, ref, recipe);
        break;
    }
  }

  void _deleteRecipe(BuildContext context, WidgetRef ref, Recipe recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: Text('Are you sure you want to delete "${recipe.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              try {
                final storageService = RecipeStorageService();
                await storageService.deleteRecipe(recipe.id);
                ref.invalidate(savedRecipesProvider);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${recipe.title} deleted successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete recipe: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Simple Shopping Screen
class SimpleShoppingScreen extends ConsumerWidget {
  const SimpleShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ShoppingListScreen();
  }
}

// Simple Pantry Screen
class SimplePantryScreen extends ConsumerWidget {
  const SimplePantryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemedScreenWrapper(
      title: 'Pantry',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.kitchen,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Pantry Management',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your pantry items here',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Shopping List Screen
class SimpleShoppingListScreen extends ConsumerWidget {
  const SimpleShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemedScreenWrapper(
      title: 'Shopping List',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Shopping List',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your shopping list here',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Profile Screen
class SimpleProfileScreen extends ConsumerWidget {
  const SimpleProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ThemedScreenWrapper(
      title: 'Profile',
      enablePullToRefresh: true,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile refreshed!')),
        );
      },
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings coming soon!')),
            );
          },
        ),
      ],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chef User',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Cooking enthusiast',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Cooking stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cooking Stats',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          'Recipes Created',
                          '12',
                          Icons.restaurant_menu,
                          Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'Meals Cooked',
                          '45',
                          Icons.local_fire_department,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          'Favorites',
                          '8',
                          Icons.favorite,
                          Colors.red,
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'Cooking Days',
                          '23',
                          Icons.calendar_today,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Quick actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.auto_awesome),
                    title: const Text('Generate Recipe'),
                    subtitle: const Text('Create a new recipe with AI'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const SimpleRecipeGenerationScreen(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('My Recipes'),
                    subtitle: const Text('View your recipe collection'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SimpleRecipeBookScreen(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Shopping List'),
                    subtitle: const Text('Manage your ingredients'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SimpleShoppingScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
