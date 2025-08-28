import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/recipe_provider.dart';
import '../../../../shared/presentation/widgets/recipe_card_widget.dart';
import '../../../../shared/presentation/modals/search_modal.dart';
import '../../../../core/theme/design_tokens.dart';
import '../widgets/recipe_collection_widget.dart';
import '../widgets/recipe_filter_widget.dart';

enum RecipeBookViewType { grid, list }

class RecipeBookScreen extends ConsumerStatefulWidget {
  const RecipeBookScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RecipeBookScreen> createState() => _RecipeBookScreenState();
}

class _RecipeBookScreenState extends ConsumerState<RecipeBookScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RecipeBookViewType _viewType = RecipeBookViewType.grid;
  String _selectedCollection = 'All Recipes';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeState = ref.watch(recipeStateProvider);
    final filteredRecipes = ref.watch(filteredRecipesProvider);
    final favoriteRecipes = ref.watch(favoriteRecipesProvider);
    final recentRecipes = ref.watch(recentRecipesProvider);
    final recipeCategories = ref.watch(recipeCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchModal(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterModal(context),
          ),
          IconButton(
            icon: Icon(_viewType == RecipeBookViewType.grid 
                ? Icons.view_list 
                : Icons.grid_view),
            onPressed: () {
              setState(() {
                _viewType = _viewType == RecipeBookViewType.grid 
                    ? RecipeBookViewType.list 
                    : RecipeBookViewType.grid;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'create_collection',
                child: ListTile(
                  leading: Icon(Icons.create_new_folder),
                  title: Text('Create Collection'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'import_recipes',
                child: ListTile(
                  leading: Icon(Icons.file_upload),
                  title: Text('Import Recipes'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'export_recipes',
                child: ListTile(
                  leading: Icon(Icons.file_download),
                  title: Text('Export Recipes'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All', icon: Icon(Icons.restaurant_menu)),
            Tab(text: 'Favorites', icon: Icon(Icons.favorite)),
            Tab(text: 'Recent', icon: Icon(Icons.history)),
            Tab(text: 'Collections', icon: Icon(Icons.folder)),
          ],
        ),
      ),
      body: recipeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : recipeState.errorMessage != null
              ? _buildErrorState(recipeState.errorMessage!)
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _buildRecipeGrid(filteredRecipes, 'All Recipes'),
                    _buildRecipeGrid(favoriteRecipes, 'Favorite Recipes'),
                    _buildRecipeGrid(recentRecipes, 'Recent Recipes'),
                    _buildCollectionsView(recipeCategories),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateCollectionDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Collection'),
      ),
    );
  }

  Widget _buildRecipeGrid(List<dynamic> recipes, String title) {
    if (recipes.isEmpty) {
      return _buildEmptyState(title);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(recipeStateProvider.notifier).refresh();
      },
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingLg),
        child: _viewType == RecipeBookViewType.grid
            ? _buildGridView(recipes)
            : _buildListView(recipes),
      ),
    );
  }

  Widget _buildGridView(List<dynamic> recipes) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: DesignTokens.spacingMd,
        mainAxisSpacing: DesignTokens.spacingMd,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return RecipeCardWidget(
          title: recipe.title,
          imageUrl: recipe.imageUrl,
          cookingTime: recipe.cookingTime,
          difficulty: recipe.difficulty.displayName,
          rating: recipe.rating,
          onTap: () => _navigateToRecipeDetail(recipe.id),
          onFavorite: () => _toggleFavorite(recipe.id),
          isFavorite: recipe.isFavorite,
        );
      },
    );
  }

  Widget _buildListView(List<dynamic> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              child: recipe.imageUrl != null
                  ? Image.network(
                      recipe.imageUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                        width: 60,
                        height: 60,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.restaurant_menu,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.restaurant_menu,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
            title: Text(
              recipe.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: DesignTokens.spacingXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: DesignTokens.iconSm,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: DesignTokens.spacingXs),
                    Text(
                      '${recipe.cookingTime.inMinutes} min',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    Icon(
                      Icons.signal_cellular_alt,
                      size: DesignTokens.iconSm,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: DesignTokens.spacingXs),
                    Text(
                      recipe.difficulty.displayName,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                if (recipe.rating > 0) ...[
                  const SizedBox(height: DesignTokens.spacingXs),
                  Row(
                    children: [
                      ...List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < recipe.rating.floor()
                              ? Icons.star
                              : starIndex < recipe.rating
                                  ? Icons.star_half
                                  : Icons.star_border,
                          size: DesignTokens.iconSm,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: DesignTokens.spacingXs),
                      Text(
                        recipe.rating.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipe.isFavorite ? Colors.red : null,
              ),
              onPressed: () => _toggleFavorite(recipe.id),
            ),
            onTap: () => _navigateToRecipeDetail(recipe.id),
          ),
        );
      },
    );
  }

  Widget _buildCollectionsView(Map<String, List<dynamic>> categories) {
    if (categories.isEmpty) {
      return _buildEmptyState('Collections');
    }

    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories.keys.elementAt(index);
        final recipes = categories[category]!;
        
        return RecipeCollectionWidget(
          title: category,
          recipeCount: recipes.length,
          recipes: recipes.take(4).toList(), // Show preview of first 4 recipes
          onTap: () => _navigateToCollection(category, recipes),
          onEdit: () => _editCollection(category),
          onDelete: () => _deleteCollection(category),
        );
      },
    );
  }

  Widget _buildEmptyState(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getEmptyStateIcon(title),
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          Text(
            _getEmptyStateTitle(title),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            _getEmptyStateMessage(title),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignTokens.spacing2xl),
          ElevatedButton.icon(
            onPressed: () => _handleEmptyStateAction(title),
            icon: const Icon(Icons.add),
            label: Text(_getEmptyStateActionText(title)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            errorMessage,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignTokens.spacing2xl),
          ElevatedButton.icon(
            onPressed: () {
              ref.read(recipeStateProvider.notifier).clearError();
              ref.read(recipeStateProvider.notifier).refresh();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  IconData _getEmptyStateIcon(String title) {
    switch (title) {
      case 'Favorite Recipes':
        return Icons.favorite_border;
      case 'Recent Recipes':
        return Icons.history;
      case 'Collections':
        return Icons.folder_outlined;
      default:
        return Icons.restaurant_menu;
    }
  }

  String _getEmptyStateTitle(String title) {
    switch (title) {
      case 'Favorite Recipes':
        return 'No Favorites Yet';
      case 'Recent Recipes':
        return 'No Recent Recipes';
      case 'Collections':
        return 'No Collections';
      default:
        return 'No Recipes Yet';
    }
  }

  String _getEmptyStateMessage(String title) {
    switch (title) {
      case 'Favorite Recipes':
        return 'Recipes you favorite will appear here.\nStart exploring and save your favorites!';
      case 'Recent Recipes':
        return 'Recipes you\'ve recently viewed will appear here.\nStart cooking to build your history!';
      case 'Collections':
        return 'Organize your recipes into collections.\nCreate your first collection to get started!';
      default:
        return 'Generate or save recipes to build your collection.\nStart by creating your first recipe!';
    }
  }

  String _getEmptyStateActionText(String title) {
    switch (title) {
      case 'Collections':
        return 'Create Collection';
      default:
        return 'Generate Recipe';
    }
  }

  void _handleEmptyStateAction(String title) {
    switch (title) {
      case 'Collections':
        _showCreateCollectionDialog(context);
        break;
      default:
        // Navigate to home screen to generate recipe
        DefaultTabController.of(context)?.animateTo(0);
        break;
    }
  }

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchModal(),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const RecipeFilterWidget(),
    );
  }

  void _showCreateCollectionDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Collection'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Collection Name',
                hintText: 'e.g., Italian Favorites',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Describe your collection...',
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                _createCollection(
                  nameController.text.trim(),
                  descriptionController.text.trim(),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'create_collection':
        _showCreateCollectionDialog(context);
        break;
      case 'import_recipes':
        _importRecipes();
        break;
      case 'export_recipes':
        _exportRecipes();
        break;
    }
  }

  void _createCollection(String name, String description) {
    // TODO: Implement collection creation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Collection "$name" created!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _navigateToRecipeDetail(String recipeId) {
    // TODO: Navigate to recipe detail screen
    // Navigator.of(context).pushNamed('/recipe/$recipeId');
  }

  void _navigateToCollection(String category, List<dynamic> recipes) {
    // TODO: Navigate to collection detail screen
    // Navigator.of(context).pushNamed('/collection/$category');
  }

  void _toggleFavorite(String recipeId) {
    ref.read(recipeStateProvider.notifier).toggleFavorite(recipeId);
  }

  void _editCollection(String category) {
    // TODO: Implement collection editing
  }

  void _deleteCollection(String category) {
    // TODO: Implement collection deletion
  }

  void _importRecipes() {
    // TODO: Implement recipe import functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recipe import coming soon!'),
      ),
    );
  }

  void _exportRecipes() {
    // TODO: Implement recipe export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Recipe export coming soon!'),
      ),
    );
  }
}