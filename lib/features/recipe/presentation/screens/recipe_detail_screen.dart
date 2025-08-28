import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../domain/entities/recipe.dart';
import '../../../../application/providers/recipe_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../widgets/recipe_header_widget.dart';
import '../widgets/recipe_ingredients_section.dart';
import '../widgets/recipe_instructions_section.dart';
import '../widgets/recipe_nutrition_section.dart';
import '../widgets/recipe_action_bar.dart';
import '../widgets/cooking_mode_widget.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({Key? key, required this.recipeId}) : super(key: key);

  @override
  ConsumerState<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isHeaderExpanded = true;
  bool _isCookingMode = false;
  int _servings = 4;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    final isExpanded = _scrollController.offset < 200;
    if (isExpanded != _isHeaderExpanded) {
      setState(() {
        _isHeaderExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipeAsync = ref.watch(recipeByIdProvider(widget.recipeId));

    if (recipeAsync == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recipe Details')),
        body: const Center(
          child: Text('Recipe not found'),
        ),
      );
    }
    
    // Initialize servings from recipe if not set
    if (_servings == 4 && recipeAsync.servings != 4) {
      _servings = recipeAsync.servings;
    }

    return Scaffold(
      body: _isCookingMode
          ? CookingModeWidget(
              recipe: recipeAsync,
              servings: _servings,
              onExitCookingMode: () {
                setState(() {
                  _isCookingMode = false;
                });
              },
            )
          : NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 300,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: RecipeHeaderWidget(
                        recipe: recipeAsync,
                        isExpanded: _isHeaderExpanded,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () => _shareRecipe(recipeAsync),
                      ),
                      IconButton(
                        icon: Icon(
                          recipeAsync.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: recipeAsync.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () => _toggleFavorite(recipeAsync),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) => _handleMenuAction(value, recipeAsync),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Edit Recipe'),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'print',
                            child: ListTile(
                              leading: Icon(Icons.print),
                              title: Text('Print Recipe'),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'duplicate',
                            child: ListTile(
                              leading: Icon(Icons.copy),
                              title: Text('Duplicate'),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: ListTile(
                              leading: Icon(Icons.delete, color: Colors.red),
                              title: Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ];
              },
              body: Column(
                children: [
                  // Recipe Action Bar
                  RecipeActionBar(
                    recipe: recipeAsync,
                    servings: _servings,
                    onServingsChanged: (newServings) {
                      setState(() {
                        _servings = newServings;
                      });
                    },
                    onStartCooking: () {
                      setState(() {
                        _isCookingMode = true;
                      });
                    },
                  ),
                  
                  // Tab Bar
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Ingredients', icon: Icon(Icons.list_alt)),
                      Tab(text: 'Instructions', icon: Icon(Icons.receipt_long)),
                      Tab(text: 'Nutrition', icon: Icon(Icons.local_dining)),
                      Tab(text: 'Reviews', icon: Icon(Icons.star)),
                    ],
                  ),
                  
                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        RecipeIngredientsSection(
                          recipe: recipeAsync,
                          servings: _servings,
                        ),
                        RecipeInstructionsSection(
                          recipe: recipeAsync,
                          servings: _servings,
                        ),
                        RecipeNutritionSection(
                          recipe: recipeAsync,
                          servings: _servings,
                        ),
                        _buildReviewsSection(recipeAsync),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void _shareRecipe(Recipe recipe) async {
    final text = '''${recipe.title}\n\n${recipe.description}\n\nIngredients:\n${recipe.ingredients.map((i) => '• ${i.quantity} ${i.unit} ${i.name}').join('\n')}\n\nInstructions:\n${recipe.instructions.asMap().entries.map((e) => '${e.key + 1}. ${e.value.instruction}').join('\n\n')}\n\nPrep Time: ${recipe.prepTime.inMinutes} min\nCook Time: ${recipe.cookingTime.inMinutes} min\nServings: ${recipe.servings}''';
    
    await Share.share(text, subject: recipe.title);
  }
  
  void _toggleFavorite(Recipe recipe) {
    ref.read(recipeStateProvider.notifier).toggleFavorite(recipe.id);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          recipe.isFavorite ? 'Removed from favorites' : 'Added to favorites',
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref.read(recipeStateProvider.notifier).toggleFavorite(recipe.id);
          },
        ),
      ),
    );
  }
  
  void _handleMenuAction(String action, Recipe recipe) {
    switch (action) {
      case 'edit':
        _editRecipe(recipe);
        break;
      case 'print':
        _printRecipe(recipe);
        break;
      case 'duplicate':
        _duplicateRecipe(recipe);
        break;
      case 'delete':
        _deleteRecipe(recipe);
        break;
    }
  }
  
  void _editRecipe(Recipe recipe) {
    // TODO: Navigate to recipe edit screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe editing coming soon!')),
    );
  }
  
  void _printRecipe(Recipe recipe) {
    // TODO: Implement print functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Print functionality coming soon!')),
    );
  }
  
  void _duplicateRecipe(Recipe recipe) async {
    try {
      final duplicatedRecipe = recipe.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '${recipe.title} (Copy)',
        createdAt: DateTime.now(),
      );
      
      await ref.read(recipeStateProvider.notifier).addRecipe(duplicatedRecipe);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Recipe duplicated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to duplicate recipe: $e')),
        );
      }
    }
  }
  
  void _deleteRecipe(Recipe recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Recipe'),
        content: Text('Are you sure you want to delete "${recipe.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              
              try {
                await ref.read(recipeStateProvider.notifier).deleteRecipe(recipe.id);
                
                if (mounted) {
                  Navigator.of(context).pop(); // Go back to previous screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recipe deleted successfully')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete recipe: $e')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildReviewsSection(Recipe recipe) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        recipe.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacingSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < recipe.rating.floor()
                                    ? Icons.star
                                    : index < recipe.rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                          Text(
                            'Based on ${recipe.reviewCount ?? 0} reviews',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  ElevatedButton(
                    onPressed: () => _showRatingDialog(recipe),
                    child: const Text('Rate this Recipe'),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Reviews List
          Text(
            'Reviews',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          // TODO: Implement actual reviews list
          const Card(
            child: Padding(
              padding: EdgeInsets.all(DesignTokens.spacingLg),
              child: Text(
                'No reviews yet. Be the first to review this recipe!',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showRatingDialog(Recipe recipe) {
    double currentRating = 0.0;
    final commentController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Rate this Recipe'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How would you rate this recipe?'),
              const SizedBox(height: DesignTokens.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starValue = index + 1.0;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentRating = starValue;
                      });
                    },
                    child: Icon(
                      starValue <= currentRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'Add a comment (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: currentRating > 0 ? () {
                _submitRating(recipe, currentRating, commentController.text);
                Navigator.of(context).pop();
              } : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
  
  void _submitRating(Recipe recipe, double rating, String comment) {
    // TODO: Implement rating submission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you for rating this recipe ${rating.toStringAsFixed(1)} stars!'),
      ),
    );
  }
}