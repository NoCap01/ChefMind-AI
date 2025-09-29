import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/ingredient_suggestions_service.dart';
import '../../../services/recipe_storage_service.dart';
import '../../widgets/recipe/ingredient_input_widget.dart';
import '../../widgets/recipe/recipe_detail_dialog.dart';
import '../../../application/providers/recipe_provider.dart';
import '../../../domain/entities/recipe.dart';
import '../../widgets/common/themed_screen_wrapper.dart';
import '../../../core/performance/memory_optimizer.dart';
import '../../../core/performance/state_optimization.dart';

// Simple state management for recipe generation
final ingredientsProvider = StateProvider<List<String>>((ref) => []);
final selectedCuisineProvider = StateProvider<String?>((ref) => null);
final selectedMealTypeProvider = StateProvider<String?>((ref) => null);
final servingsProvider = StateProvider<int>((ref) => 4);
final maxCookingTimeProvider = StateProvider<Duration?>((ref) => null);

class SimpleRecipeGenerationScreen extends ConsumerStatefulWidget {
  const SimpleRecipeGenerationScreen({super.key});

  @override
  ConsumerState<SimpleRecipeGenerationScreen> createState() =>
      _SimpleRecipeGenerationScreenState();
}

class _SimpleRecipeGenerationScreenState
    extends ConsumerState<SimpleRecipeGenerationScreen>
    with MemoryOptimizedMixin, PerformanceOptimizationMixin {
  final _ingredientController = TextEditingController();

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ingredients = ref.watch(ingredientsProvider);
    final recipeGenerationState = ref.watch(recipeGenerationProvider);
    final selectedCuisine = ref.watch(selectedCuisineProvider);
    final selectedMealType = ref.watch(selectedMealTypeProvider);
    final servings = ref.watch(servingsProvider);
    final maxCookingTime = ref.watch(maxCookingTimeProvider);

    final isDark = theme.brightness == Brightness.dark;

    return ThemedScreenWrapper(
      title: 'Generate Recipe',
      showAppBar: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Enhanced Header with gradient background
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.8),
                    theme.colorScheme.secondaryContainer.withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      size: 32,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Create Your Perfect Recipe',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? Colors.white : theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add ingredients and let AI create a delicious recipe for you!',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8)
                          : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Enhanced Ingredient Input Card
            Card(
              elevation: isDark ? 4 : 2,
              shadowColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark
                          ? Colors.grey.shade800.withValues(alpha: 0.8)
                          : Colors.white,
                      isDark
                          ? Colors.grey.shade900.withValues(alpha: 0.6)
                          : theme.colorScheme.surface,
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
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.kitchen,
                              color: Colors.orange,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Ingredients',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          if (ingredients.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${ingredients.length}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      IngredientInputWidget(
                        ingredients: ingredients,
                        onIngredientAdded: _addIngredient,
                        onIngredientRemoved: _removeIngredient,
                        hintText: 'e.g., chicken, rice, tomatoes',
                        showSuggestions: true,
                        showPopularIngredients: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Enhanced Preferences Card
            Card(
              elevation: isDark ? 4 : 2,
              shadowColor: theme.colorScheme.secondary.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark
                          ? Colors.grey.shade800.withValues(alpha: 0.8)
                          : Colors.white,
                      isDark
                          ? Colors.grey.shade900.withValues(alpha: 0.6)
                          : theme.colorScheme.surface,
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
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.purple,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Preferences (Optional)',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Cuisine Type
                      DropdownButtonFormField<String>(
                        initialValue: selectedCuisine,
                        decoration: InputDecoration(
                          labelText: 'Cuisine Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey.shade800.withValues(alpha: 0.3)
                              : theme.colorScheme.surface,
                          prefixIcon: const Icon(Icons.public),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: null, child: Text('Any Cuisine')),
                          DropdownMenuItem(
                              value: 'Italian', child: Text('🇮🇹 Italian')),
                          DropdownMenuItem(
                              value: 'Mexican', child: Text('🇲🇽 Mexican')),
                          DropdownMenuItem(
                              value: 'Chinese', child: Text('🇨🇳 Chinese')),
                          DropdownMenuItem(
                              value: 'Indian', child: Text('🇮🇳 Indian')),
                          DropdownMenuItem(
                              value: 'Thai', child: Text('🇹🇭 Thai')),
                          DropdownMenuItem(
                              value: 'American', child: Text('🇺🇸 American')),
                          DropdownMenuItem(
                              value: 'French', child: Text('🇫🇷 French')),
                        ],
                        onChanged: (value) => ref
                            .read(selectedCuisineProvider.notifier)
                            .state = value,
                      ),

                      const SizedBox(height: 16),

                      // Meal Type
                      DropdownButtonFormField<String>(
                        initialValue: selectedMealType,
                        decoration: InputDecoration(
                          labelText: 'Meal Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey.shade800.withValues(alpha: 0.3)
                              : theme.colorScheme.surface,
                          prefixIcon: const Icon(Icons.restaurant_menu),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: null, child: Text('Any Meal')),
                          DropdownMenuItem(
                              value: 'Breakfast', child: Text('🍳 Breakfast')),
                          DropdownMenuItem(
                              value: 'Lunch', child: Text('🥪 Lunch')),
                          DropdownMenuItem(
                              value: 'Dinner', child: Text('🍽️ Dinner')),
                          DropdownMenuItem(
                              value: 'Snack', child: Text('🍿 Snack')),
                          DropdownMenuItem(
                              value: 'Dessert', child: Text('🍰 Dessert')),
                        ],
                        onChanged: (value) => ref
                            .read(selectedMealTypeProvider.notifier)
                            .state = value,
                      ),

                      const SizedBox(height: 16),

                      // Enhanced Servings Selector
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.grey.shade800.withValues(alpha: 0.3)
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.outline
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.people,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Servings: $servings',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? Colors.white
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: servings > 1
                                        ? () => ref
                                            .read(servingsProvider.notifier)
                                            .state = servings - 1
                                        : null,
                                    icon: const Icon(Icons.remove),
                                    style: IconButton.styleFrom(
                                      foregroundColor:
                                          theme.colorScheme.primary,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      servings.toString(),
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: servings < 12
                                        ? () => ref
                                            .read(servingsProvider.notifier)
                                            .state = servings + 1
                                        : null,
                                    icon: const Icon(Icons.add),
                                    style: IconButton.styleFrom(
                                      foregroundColor:
                                          theme.colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Max Cooking Time
                      DropdownButtonFormField<Duration>(
                        initialValue: maxCookingTime,
                        decoration: InputDecoration(
                          labelText: 'Max Cooking Time',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: isDark
                              ? Colors.grey.shade800.withValues(alpha: 0.3)
                              : theme.colorScheme.surface,
                          prefixIcon: const Icon(Icons.schedule),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: null, child: Text('No limit')),
                          DropdownMenuItem(
                            value: Duration(minutes: 15),
                            child: Text('15 minutes'),
                          ),
                          DropdownMenuItem(
                            value: Duration(minutes: 30),
                            child: Text('30 minutes'),
                          ),
                          DropdownMenuItem(
                            value: Duration(minutes: 45),
                            child: Text('45 minutes'),
                          ),
                          DropdownMenuItem(
                            value: Duration(hours: 1),
                            child: Text('1 hour'),
                          ),
                          DropdownMenuItem(
                            value: Duration(hours: 2),
                            child: Text('2 hours'),
                          ),
                        ],
                        onChanged: (value) => ref
                            .read(maxCookingTimeProvider.notifier)
                            .state = value,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Enhanced Generate Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: ingredients.isNotEmpty &&
                          recipeGenerationState is! RecipeGenerationLoading
                      ? [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withValues(alpha: 0.8),
                        ]
                      : [
                          theme.colorScheme.outline.withValues(alpha: 0.3),
                          theme.colorScheme.outline.withValues(alpha: 0.2),
                        ],
                ),
                boxShadow: ingredients.isNotEmpty &&
                        recipeGenerationState is! RecipeGenerationLoading
                    ? [
                        BoxShadow(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: FilledButton(
                onPressed: ingredients.isNotEmpty &&
                        recipeGenerationState is! RecipeGenerationLoading
                    ? _generateRecipe
                    : null,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: recipeGenerationState is RecipeGenerationLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            recipeGenerationState.message ??
                                'Generating Recipe...',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Generate Recipe with AI',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Recipe Generation Result
            _buildRecipeResult(recipeGenerationState, theme, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeResult(
      RecipeGenerationState state, ThemeData theme, bool isDark) {
    return switch (state) {
      RecipeGenerationInitial() => const SizedBox.shrink(),
      RecipeGenerationLoading(message: final message) => Card(
          elevation: isDark ? 6 : 3,
          shadowColor: theme.colorScheme.primary.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark
                      ? Colors.grey.shade800.withValues(alpha: 0.9)
                      : Colors.white,
                  isDark
                      ? Colors.grey.shade900.withValues(alpha: 0.7)
                      : theme.colorScheme.surface,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    message ?? 'Generating your recipe...',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? Colors.white : theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This may take a few moments',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.7)
                          : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      RecipeGenerationSuccess(recipe: final recipe) => Card(
          elevation: isDark ? 6 : 3,
          shadowColor: Colors.green.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark
                      ? Colors.grey.shade800.withValues(alpha: 0.9)
                      : Colors.white,
                  isDark
                      ? Colors.grey.shade900.withValues(alpha: 0.7)
                      : theme.colorScheme.surface,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Recipe Generated Successfully!',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    recipe.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDark ? Colors.white : theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    recipe.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8)
                          : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Recipe metadata
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.schedule,
                              size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: 4),
                          Text('${recipe.totalTime} min'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.people,
                              size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: 4),
                          Text('${recipe.metadata.servings} servings'),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bar_chart,
                              size: 16, color: theme.colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(recipe.metadata.difficulty.displayName),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _showFullRecipe(recipe),
                          icon: const Icon(Icons.visibility),
                          label: const Text('View Details'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _saveRecipe(recipe),
                          icon: const Icon(Icons.bookmark),
                          label: const Text('Save Recipe'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      RecipeGenerationError(message: final message) => Card(
          elevation: isDark ? 6 : 3,
          shadowColor: theme.colorScheme.error.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark
                      ? Colors.grey.shade800.withValues(alpha: 0.9)
                      : Colors.white,
                  isDark
                      ? Colors.grey.shade900.withValues(alpha: 0.7)
                      : theme.colorScheme.surface,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline,
                      size: 32,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Recipe Generation Failed',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.8)
                          : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(recipeGenerationProvider.notifier)
                              .clearGeneration(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _generateRecipe,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Try Again'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
    };
  }

  void _addIngredient(String ingredient) {
    final currentIngredients = ref.read(ingredientsProvider);
    final formatted = IngredientSuggestionsService.formatIngredient(ingredient);

    final validationError = IngredientSuggestionsService.validateIngredient(
      formatted,
      currentIngredients,
    );

    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ref.read(ingredientsProvider.notifier).state = [
      ...currentIngredients,
      formatted
    ];
  }

  void _removeIngredient(String ingredient) {
    final currentIngredients = ref.read(ingredientsProvider);
    ref.read(ingredientsProvider.notifier).state =
        currentIngredients.where((i) => i != ingredient).toList();
  }

  void _generateRecipe() {
    final ingredients = ref.read(ingredientsProvider);
    final cuisine = ref.read(selectedCuisineProvider);
    final mealType = ref.read(selectedMealTypeProvider);
    final servings = ref.read(servingsProvider);
    final maxCookingTime = ref.read(maxCookingTimeProvider);

    if (ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one ingredient'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    ref.read(recipeGenerationProvider.notifier).generateRecipe(
          ingredients: ingredients,
          cuisineType: cuisine,
          mealType: mealType,
          servings: servings,
          maxCookingTime: maxCookingTime,
        );
  }

  void _showFullRecipe(Recipe recipe) async {
    final storageService = RecipeStorageService();
    final isFavorite = await storageService.isFavoriteRecipe(recipe.id);

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => RecipeDetailDialog(
        recipe: recipe,
        isFavorite: isFavorite,
        onSave: () => _saveRecipe(recipe),
        onFavorite: () => _toggleFavorite(recipe.id),
      ),
    );
  }

  void _saveRecipe(Recipe recipe) async {
    final storageService = RecipeStorageService();
    final success = await storageService.saveRecipe(recipe);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe "${recipe.title}" saved to your collection!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'View Collection',
            onPressed: () {
              // Navigate to recipe book
              if (mounted) {
                context.go('/recipes');
              }
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save recipe. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleFavorite(String recipeId) async {
    final storageService = RecipeStorageService();
    final success = await storageService.toggleFavorite(recipeId);

    if (!mounted) return;

    if (success) {
      final isFavorite = await storageService.isFavoriteRecipe(recipeId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFavorite
                ? 'Recipe added to favorites!'
                : 'Recipe removed from favorites!',
          ),
          backgroundColor: isFavorite ? Colors.green : Colors.orange,
        ),
      );
    }
  }
}
