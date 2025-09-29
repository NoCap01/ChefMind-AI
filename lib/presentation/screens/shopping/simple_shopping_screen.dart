import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/shopping_list_provider.dart';
import '../../../domain/entities/shopping_list_item.dart';
import '../../widgets/shopping/add_shopping_item_dialog.dart';
import '../../widgets/common/themed_screen_wrapper.dart';

class SimpleShoppingScreen extends ConsumerStatefulWidget {
  const SimpleShoppingScreen({super.key});

  @override
  ConsumerState<SimpleShoppingScreen> createState() =>
      _SimpleShoppingScreenState();
}

class _SimpleShoppingScreenState extends ConsumerState<SimpleShoppingScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoppingState = ref.watch(shoppingListProvider);
    final shoppingNotifier = ref.read(shoppingListProvider.notifier);

    return ThemedScreenWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping List'),
          actions: [
            if (shoppingState.completedItemCount > 0)
              IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: () => _showClearCompletedDialog(context),
                tooltip: 'Clear completed items',
              ),
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'move_to_pantry':
                    await shoppingNotifier.moveCompletedItemsToPantry();
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Items moved to pantry')),
                      );
                    }
                    break;
                  case 'clear_all':
                    _showClearAllDialog(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                if (shoppingState.completedItemCount > 0)
                  const PopupMenuItem(
                    value: 'move_to_pantry',
                    child: Row(
                      children: [
                        Icon(Icons.kitchen),
                        SizedBox(width: 8),
                        Text('Move completed to pantry'),
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
                        Text('Clear all items',
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search items...',
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
                onChanged: (value) => shoppingNotifier.setSearchQuery(value),
              ),
            ),

            // Summary
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
                    _buildSummaryItem(
                      context,
                      'Total',
                      '${shoppingState.totalItemCount}',
                      Icons.shopping_cart,
                    ),
                    _buildSummaryItem(
                      context,
                      'Pending',
                      '${shoppingState.pendingItemCount}',
                      Icons.pending_actions,
                      Colors.orange,
                    ),
                    _buildSummaryItem(
                      context,
                      'Done',
                      '${shoppingState.completedItemCount}',
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ],
                ),
              ),

            // Items list
            Expanded(
              child: _buildItemsList(context, shoppingState, shoppingNotifier),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddItemDialog(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, [
    Color? color,
  ]) {
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

  Widget _buildItemsList(
    BuildContext context,
    ShoppingListState shoppingState,
    ShoppingListNotifier shoppingNotifier,
  ) {
    if (shoppingState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (shoppingState.error != null) {
      return Center(
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
      );
    }

    final items = shoppingState.filteredItems;

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              shoppingState.searchQuery.isNotEmpty
                  ? 'No items match your search'
                  : 'Your shopping list is empty',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              shoppingState.searchQuery.isNotEmpty
                  ? 'Try adjusting your search'
                  : 'Add items to get started',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showAddItemDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => shoppingNotifier.loadItems(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildItemCard(context, item, shoppingNotifier);
        },
      ),
    );
  }

  Widget _buildItemCard(
    BuildContext context,
    ShoppingListItem item,
    ShoppingListNotifier shoppingNotifier,
  ) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: item.isCompleted,
          onChanged: (_) => shoppingNotifier.toggleItemCompletion(item.id),
        ),
        title: Text(
          item.name,
          style: TextStyle(
            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
            color: item.isCompleted ? theme.colorScheme.onSurfaceVariant : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${item.quantity} ${item.unit}'),
            if (item.category != null)
              Text(
                item.category!,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _showEditItemDialog(context, item);
                break;
              case 'delete':
                _confirmDeleteItem(context, item, shoppingNotifier);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
      ),
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

  void _confirmDeleteItem(
    BuildContext context,
    ShoppingListItem item,
    ShoppingListNotifier shoppingNotifier,
  ) {
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
              shoppingNotifier.deleteItem(item.id);
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

  void _showClearCompletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Completed Items'),
        content: const Text('Remove all completed items from the list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(shoppingListProvider.notifier).clearCompletedItems();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Items'),
        content: const Text('Remove all items from the shopping list?'),
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
