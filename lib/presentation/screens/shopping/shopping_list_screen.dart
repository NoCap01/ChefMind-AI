import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/shopping_list_provider.dart';
import '../../../domain/entities/shopping_list_item.dart';
import '../../widgets/shopping/shopping_list_item_card.dart';
import '../../widgets/shopping/add_shopping_item_dialog.dart';
import '../../widgets/shopping/recipe_selection_dialog.dart';
import '../pantry/pantry_screen.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoppingState = ref.watch(shoppingListProvider);
    final shoppingNotifier = ref.read(shoppingListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping & Pantry'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.shopping_cart), text: 'Shopping List'),
            Tab(icon: Icon(Icons.kitchen), text: 'Pantry'),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'add_from_recipe':
                  _showRecipeSelectionDialog(context);
                  break;
                case 'move_to_pantry':
                  final messenger = ScaffoldMessenger.of(context);
                  await shoppingNotifier.moveCompletedItemsToPantry();
                  if (mounted) {
                    messenger.showSnackBar(
                      const SnackBar(
                          content: Text('Completed items moved to pantry')),
                    );
                  }
                  break;
                case 'clear_completed':
                  await shoppingNotifier.clearCompletedItems();
                  break;
                case 'clear_all':
                  _confirmClearAll(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'add_from_recipe',
                child: Row(
                  children: [
                    Icon(Icons.restaurant_menu),
                    SizedBox(width: 8),
                    Text('Add from Recipe'),
                  ],
                ),
              ),
              if (shoppingState.completedItemCount > 0)
                const PopupMenuItem(
                  value: 'move_to_pantry',
                  child: Row(
                    children: [
                      Icon(Icons.kitchen),
                      SizedBox(width: 8),
                      Text('Move to Pantry'),
                    ],
                  ),
                ),
              if (shoppingState.completedItemCount > 0)
                const PopupMenuItem(
                  value: 'clear_completed',
                  child: Row(
                    children: [
                      Icon(Icons.clear_all),
                      SizedBox(width: 8),
                      Text('Clear Completed'),
                    ],
                  ),
                ),
              if (shoppingState.totalItemCount > 0)
                const PopupMenuItem(
                  value: 'clear_all',
                  child: Row(
                    children: [
                      Icon(Icons.delete_sweep, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Clear All', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildShoppingListTab(context, shoppingState, shoppingNotifier),
          const PantryScreen(),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: () => _showAddItemDialog(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildShoppingListTab(
    BuildContext context,
    ShoppingListState shoppingState,
    ShoppingListNotifier shoppingNotifier,
  ) {
    return Column(
      children: [
        // Search and filter section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search shopping items...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            shoppingNotifier.setSearchQuery('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  shoppingNotifier.setSearchQuery(value);
                },
              ),
              const SizedBox(height: 12),

              // Filter chips
              Row(
                children: [
                  FilterChip(
                    label: Text(
                        'Show Completed (${shoppingState.completedItemCount})'),
                    selected: shoppingState.showCompletedItems,
                    onSelected: (_) =>
                        shoppingNotifier.toggleShowCompletedItems(),
                  ),
                  const SizedBox(width: 8),
                  if (shoppingState.categories.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterChip(
                              label: const Text('All'),
                              selected: shoppingState.selectedCategory == null,
                              onSelected: (_) =>
                                  shoppingNotifier.setSelectedCategory(null),
                            ),
                            const SizedBox(width: 8),
                            ...shoppingState.categories
                                .map((category) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: FilterChip(
                                        label: Text(category),
                                        selected:
                                            shoppingState.selectedCategory ==
                                                category,
                                        onSelected: (_) => shoppingNotifier
                                            .setSelectedCategory(category),
                                      ),
                                    )),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        // Summary card
        if (shoppingState.totalItemCount > 0)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryItem(
                  label: 'Total Items',
                  value: '${shoppingState.totalItemCount}',
                  icon: Icons.shopping_cart,
                ),
                _SummaryItem(
                  label: 'Pending',
                  value: '${shoppingState.pendingItemCount}',
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                ),
                _SummaryItem(
                  label: 'Completed',
                  value: '${shoppingState.completedItemCount}',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                if (shoppingState.estimatedTotalCost > 0)
                  _SummaryItem(
                    label: 'Est. Cost',
                    value:
                        '₹${shoppingState.estimatedTotalCost.toStringAsFixed(2)}',
                    icon: Icons.currency_rupee,
                    color: Colors.blue,
                  ),
              ],
            ),
          ),

        // Items list
        Expanded(
          child: shoppingState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : shoppingState.error != null
                  ? Center(
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
                            'Error: ${shoppingState.error}',
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => shoppingNotifier.loadItems(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : shoppingState.filteredItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 64,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                shoppingState.searchQuery.isNotEmpty ||
                                        shoppingState.selectedCategory !=
                                            null ||
                                        shoppingState.showCompletedItems
                                    ? 'No items match your filters'
                                    : 'Your shopping list is empty',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                shoppingState.searchQuery.isNotEmpty ||
                                        shoppingState.selectedCategory !=
                                            null ||
                                        shoppingState.showCompletedItems
                                    ? 'Try adjusting your search or filters'
                                    : 'Add items or generate from recipes',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        _showAddItemDialog(context),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add Item'),
                                  ),
                                  const SizedBox(width: 12),
                                  OutlinedButton.icon(
                                    onPressed: () =>
                                        _showRecipeSelectionDialog(context),
                                    icon: const Icon(Icons.restaurant_menu),
                                    label: const Text('From Recipe'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () => shoppingNotifier.loadItems(),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: shoppingState.filteredItems.length,
                            itemBuilder: (context, index) {
                              final item = shoppingState.filteredItems[index];
                              return ShoppingListItemCard(
                                item: item,
                                onTap: () => _showItemDetails(context, item),
                                onToggleCompleted: () => shoppingNotifier
                                    .toggleItemCompletion(item.id),
                                onEdit: () =>
                                    _showEditItemDialog(context, item),
                                onDelete: () =>
                                    _confirmDeleteItem(context, item),
                              );
                            },
                          ),
                        ),
        ),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddShoppingItemDialog(),
    );
  }

  void _showEditItemDialog(BuildContext context, ShoppingListItem item) {
    showDialog(
      context: context,
      builder: (context) => AddShoppingItemDialog(item: item),
    );
  }

  void _showRecipeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const RecipeSelectionDialog(),
    );
  }

  void _showItemDetails(BuildContext context, ShoppingListItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: ${item.quantity} ${item.unit}'),
            if (item.category != null) Text('Category: ${item.category}'),
            if (item.estimatedPrice != null)
              Text(
                  'Estimated Price: ₹${item.estimatedPrice!.toStringAsFixed(2)}'),
            if (item.recipeId != null) Text('From Recipe: ${item.recipeId}'),
            if (item.notes != null && item.notes!.isNotEmpty)
              Text('Notes: ${item.notes}'),
            Text('Status: ${item.isCompleted ? "Completed" : "Pending"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showEditItemDialog(context, item);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteItem(BuildContext context, ShoppingListItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(shoppingListProvider.notifier).deleteItem(item.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmClearAll(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Items'),
        content: const Text(
            'Are you sure you want to delete all shopping list items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(shoppingListProvider.notifier).clearAllItems();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final itemColor = color ?? theme.colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: itemColor, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: itemColor,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
