import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/recipe_book_provider.dart';
import '../../../application/providers/shopping_list_provider.dart';
import '../../../domain/entities/recipe.dart';

class RecipeSelectionDialog extends ConsumerStatefulWidget {
  const RecipeSelectionDialog({super.key});

  @override
  ConsumerState<RecipeSelectionDialog> createState() => _RecipeSelectionDialogState();
}

class _RecipeSelectionDialogState extends ConsumerState<RecipeSelectionDialog> {
  final Set<String> _selectedRecipeIds = <String>{};
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeBookState = ref.watch(recipeBookProvider);
    
    // Get recipes from state
    final allRecipes = switch (recipeBookState) {
      RecipeBookLoaded(recipes: final recipes) => recipes,
      _ => <Recipe>[],
    };
    
    // Filter recipes based on search
    final filteredRecipes = allRecipes.where((recipe) {
      if (_searchController.text.isEmpty) return true;
      final query = _searchController.text.toLowerCase();
      return recipe.title.toLowerCase().contains(query) ||
             recipe.description.toLowerCase().contains(query) ||
             recipe.ingredients.any((ingredient) => 
                 ingredient.name.toLowerCase().contains(query));
    }).toList();

    return AlertDialog(
      title: const Text('Select Recipes'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            // Search field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search recipes...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 16),
            
            // Selection info
            if (_selectedRecipeIds.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${_selectedRecipeIds.length} recipe${_selectedRecipeIds.length == 1 ? '' : 's'} selected',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedRecipeIds.clear();
                        });
                      },
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            
            // Recipes list
            Expanded(
              child: switch (recipeBookState) {
                RecipeBookLoading() => const Center(child: CircularProgressIndicator()),
                RecipeBookError(message: final message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading recipes',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                _ => filteredRecipes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restaurant_menu_outlined,
                              size: 48,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchController.text.isNotEmpty
                                  ? 'No recipes match your search'
                                  : 'No recipes available',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _searchController.text.isNotEmpty
                                  ? 'Try adjusting your search terms'
                                  : 'Create some recipes first',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          final isSelected = _selectedRecipeIds.contains(recipe.id);
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: CheckboxListTile(
                              value: isSelected,
                              onChanged: (selected) {
                                setState(() {
                                  if (selected == true) {
                                    _selectedRecipeIds.add(recipe.id);
                                  } else {
                                    _selectedRecipeIds.remove(recipe.id);
                                  }
                                });
                              },
                              title: Text(
                                recipe.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${recipe.ingredients.length} ingredients • ${recipe.totalTime} min',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              secondary: recipe.metadata.cuisine != null
                                  ? Chip(
                                      label: Text(
                                        recipe.metadata.cuisine!,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    )
                                  : null,
                            ),
                          );
                        },
                      ),
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        if (filteredRecipes.isNotEmpty)
          TextButton(
            onPressed: _selectedRecipeIds.isEmpty
                ? null
                : () {
                    setState(() {
                      if (_selectedRecipeIds.length == filteredRecipes.length) {
                        _selectedRecipeIds.clear();
                      } else {
                        _selectedRecipeIds.addAll(
                          filteredRecipes.map((recipe) => recipe.id),
                        );
                      }
                    });
                  },
            child: Text(_selectedRecipeIds.length == filteredRecipes.length
                ? 'Deselect All'
                : 'Select All'),
          ),
        ElevatedButton(
          onPressed: _isLoading || _selectedRecipeIds.isEmpty
              ? null
              : _generateShoppingList,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Generate List'),
        ),
      ],
    );
  }

  Future<void> _generateShoppingList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final recipeBookState = ref.read(recipeBookProvider);
      final allRecipes = switch (recipeBookState) {
        RecipeBookLoaded(recipes: final recipes) => recipes,
        _ => <Recipe>[],
      };
      final selectedRecipes = allRecipes
          .where((recipe) => _selectedRecipeIds.contains(recipe.id))
          .toList();

      await ref.read(shoppingListProvider.notifier)
          .addRecipesToShoppingList(selectedRecipes);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Shopping list generated from ${selectedRecipes.length} recipe${selectedRecipes.length == 1 ? '' : 's'}',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating shopping list: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}