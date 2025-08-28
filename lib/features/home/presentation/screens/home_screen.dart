import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../application/providers/recipe_provider.dart';
import '../../../../shared/presentation/widgets/ingredient_input_widget.dart';
import '../../../../shared/presentation/widgets/recipe_card_widget.dart';
import '../widgets/recipe_display_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _ingredientController = TextEditingController();

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final recipeGenerationState = ref.watch(recipeGenerationProvider);
    final selectedIngredients = recipeGenerationState.currentIngredients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChefMind AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Section
            userProfile.when(
              data: (profile) => _buildWelcomeSection(profile?.name ?? 'Chef'),
              loading: () => _buildWelcomeSection('Chef'),
              error: (_, __) => _buildWelcomeSection('Chef'),
            ),
            
            const SizedBox(height: 24),
            
            // Hero Cooking Animation
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'What\'s in your kitchen?',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Ingredient Input Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Add Ingredients',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    
                    // Ingredient Input
                    IngredientInputWidget(
                      controller: _ingredientController,
                      onIngredientAdded: _addIngredient,
                      onIngredientRemoved: _removeIngredient,
                      selectedIngredients: selectedIngredients,
                      enableVoiceInput: true,
                      enableAutoSuggestions: true,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Generate Recipe Button
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: selectedIngredients.isEmpty || recipeGenerationState.isGenerating
                            ? null
                            : _generateRecipe,
                        icon: recipeGenerationState.isGenerating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(recipeGenerationState.isGenerating ? 'Generating...' : 'Generate Recipe'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Generated Recipe Display
            if (recipeGenerationState.generatedRecipe != null)
              RecipeDisplayWidget(
                recipe: recipeGenerationState.generatedRecipe!,
                onSave: _saveRecipe,
                onShare: _shareRecipe,
                onRate: _rateRecipe,
              ),
            
            // Error Display
            if (recipeGenerationState.errorMessage != null)
              Card(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                        size: 48,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Recipe Generation Failed',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recipeGenerationState.errorMessage!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(recipeGenerationProvider.notifier).clearError();
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              ),
            
            const SizedBox(height: 32),
            
            // Quick Suggestions
            _buildQuickSuggestions(),
            
            const SizedBox(height: 32),
            
            // Recent Recipes
            _buildRecentRecipes(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(String name) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, $name!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ready to create something delicious?',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSuggestions() {
    final suggestions = [
      'Chicken', 'Rice', 'Pasta', 'Tomatoes', 'Onions', 'Garlic',
      'Eggs', 'Cheese', 'Potatoes', 'Carrots', 'Bell Peppers', 'Spinach'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Add',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: suggestions.map((ingredient) {
            final recipeGenerationState = ref.watch(recipeGenerationProvider);
            final isSelected = recipeGenerationState.currentIngredients.contains(ingredient);
            return FilterChip(
              label: Text(ingredient),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  _addIngredient(ingredient);
                } else {
                  _removeIngredient(ingredient);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentRecipes() {
    // TODO: Replace with actual recent recipes from provider
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Recipes',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to recipe book
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3, // TODO: Replace with actual count
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                child: RecipeCardWidget(
                  title: 'Sample Recipe ${index + 1}',
                  imageUrl: null,
                  cookingTime: const Duration(minutes: 30),
                  difficulty: 'Easy',
                  rating: 4.5,
                  onTap: () {
                    // TODO: Navigate to recipe detail
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addIngredient(String ingredient) {
    final currentIngredients = ref.read(recipeGenerationProvider).currentIngredients;
    if (!currentIngredients.contains(ingredient)) {
      final updatedIngredients = [...currentIngredients, ingredient];
      ref.read(recipeGenerationProvider.notifier).updateIngredients(updatedIngredients);
    }
  }

  void _removeIngredient(String ingredient) {
    final currentIngredients = ref.read(recipeGenerationProvider).currentIngredients;
    final updatedIngredients = currentIngredients.where((i) => i != ingredient).toList();
    ref.read(recipeGenerationProvider.notifier).updateIngredients(updatedIngredients);
  }

  Future<void> _generateRecipe() async {
    final currentIngredients = ref.read(recipeGenerationProvider).currentIngredients;
    if (currentIngredients.isEmpty) return;

    // Clear any previous recipe or error
    ref.read(recipeGenerationProvider.notifier).clearGeneratedRecipe();
    ref.read(recipeGenerationProvider.notifier).clearError();

    // Generate the recipe
    await ref.read(recipeGenerationProvider.notifier).generateRecipe(currentIngredients);
    
    // Show success message if recipe was generated
    final state = ref.read(recipeGenerationProvider);
    if (state.generatedRecipe != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _saveRecipe() async {
    final generatedRecipe = ref.read(recipeGenerationProvider).generatedRecipe;
    if (generatedRecipe == null) return;

    try {
      await ref.read(recipeStateProvider.notifier).addRecipe(generatedRecipe);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Recipe saved to your collection!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save recipe: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _shareRecipe() async {
    final generatedRecipe = ref.read(recipeGenerationProvider).generatedRecipe;
    if (generatedRecipe == null) return;

    // TODO: Implement recipe sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recipe sharing coming soon!'),
      ),
    );
  }

  Future<void> _rateRecipe(double rating) async {
    final generatedRecipe = ref.read(recipeGenerationProvider).generatedRecipe;
    if (generatedRecipe == null) return;

    // Update the recipe with the rating
    final updatedRecipe = generatedRecipe.copyWith(rating: rating);
    
    // If the recipe is already saved, update it
    final existingRecipe = ref.read(recipeByIdProvider(generatedRecipe.id));
    if (existingRecipe != null) {
      await ref.read(recipeStateProvider.notifier).updateRecipe(updatedRecipe);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recipe rated ${rating.toStringAsFixed(1)} stars!'),
      ),
    );
  }
}