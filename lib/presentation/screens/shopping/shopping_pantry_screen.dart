import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/shopping_list_provider.dart';
import '../../../application/providers/pantry_provider.dart';
import '../../../domain/entities/shopping_list_item.dart';
import '../../../domain/entities/pantry_item.dart';
import '../../widgets/shopping/add_shopping_item_dialog.dart';
import '../../widgets/pantry/add_pantry_item_dialog.dart';

class ShoppingPantryScreen extends ConsumerStatefulWidget {
  const ShoppingPantryScreen({super.key});

  @override
  ConsumerState<ShoppingPantryScreen> createState() =>
      _ShoppingPantryScreenState();
}

class _ShoppingPantryScreenState extends ConsumerState<ShoppingPantryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _shoppingSearchController =
      TextEditingController();
  final TextEditingController _pantrySearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _shoppingSearchController.dispose();
    _pantrySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping & Pantry'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.shopping_cart), text: 'Shopping'),
            Tab(icon: Icon(Icons.kitchen), text: 'Pantry'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildShoppingTab(),
          _buildPantryTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddShoppingItemDialog();
          } else {
            _showAddPantryItemDialog();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildShoppingTab() {
    final shoppingState = ref.watch(shoppingListProvider);
    final shoppingNotifier = ref.read(shoppingListProvider.notifier);

    return Column(
      children: [
        // Search and actions
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _shoppingSearchController,
                decoration: InputDecoration(
                  hintText: 'Search shopping items...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _shoppingSearchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _shoppingSearchController.clear();
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
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddShoppingItemDialog(),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Item'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (shoppingState.completedItemCount > 0)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _moveCompletedToPantry(),
                        icon: const Icon(Icons.kitchen),
                        label: const Text('Move to Pantry'),
                      ),
                    ),
                ],
              ),
            ],
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
                _buildSummaryItem('Total', '${shoppingState.totalItemCount}',
                    Icons.shopping_cart),
                _buildSummaryItem(
                    'Pending',
                    '${shoppingState.pendingItemCount}',
                    Icons.pending_actions,
                    Colors.orange),
                _buildSummaryItem('Done', '${shoppingState.completedItemCount}',
                    Icons.check_circle, Colors.green),
              ],
            ),
          ),

        // Shopping list
        Expanded(
          child: _buildShoppingList(shoppingState, shoppingNotifier),
        ),
      ],
    );
  }

  Widget _buildPantryTab() {
    final pantryState = ref.watch(pantryProvider);
    final pantryNotifier = ref.read(pantryProvider.notifier);

    return Column(
      children: [
        // Search
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _pantrySearchController,
                decoration: InputDecoration(
                  hintText: 'Search pantry items...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _pantrySearchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _pantrySearchController.clear();
                            pantryNotifier.setSearchQuery('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) => pantryNotifier.setSearchQuery(value),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddPantryItemDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ),
            ],
          ),
        ),

        // Notifications
        if (pantryState.hasNotifications)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      'Pantry Alerts',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (pantryState.expiredItems.isNotEmpty)
                  Text('${pantryState.expiredItems.length} expired items'),
                if (pantryState.expiringSoonItems.isNotEmpty)
                  Text(
                      '${pantryState.expiringSoonItems.length} items expiring soon'),
                if (pantryState.lowStockItems.isNotEmpty)
                  Text('${pantryState.lowStockItems.length} low stock items'),
              ],
            ),
          ),

        // Pantry list
        Expanded(
          child: _buildPantryList(pantryState, pantryNotifier),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon,
      [Color? color]) {
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

  Widget _buildShoppingList(
      ShoppingListState state, ShoppingListNotifier notifier) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return _buildErrorWidget(state.error!, () => notifier.loadItems());
    }

    final items = state.filteredItems;

    if (items.isEmpty) {
      return _buildEmptyWidget(
        Icons.shopping_cart_outlined,
        state.searchQuery.isNotEmpty
            ? 'No items match your search'
            : 'Your shopping list is empty',
        state.searchQuery.isNotEmpty
            ? 'Try adjusting your search'
            : 'Add items to get started',
        () => _showAddShoppingItemDialog(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => notifier.loadItems(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildShoppingItemCard(item, notifier);
        },
      ),
    );
  }

  Widget _buildPantryList(PantryState state, PantryNotifier notifier) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return _buildErrorWidget(state.error!, () => notifier.loadItems());
    }

    final items = state.filteredItems;

    if (items.isEmpty) {
      return _buildEmptyWidget(
        Icons.inventory_2_outlined,
        state.searchQuery.isNotEmpty
            ? 'No items match your search'
            : 'Your pantry is empty',
        state.searchQuery.isNotEmpty
            ? 'Try adjusting your search'
            : 'Add items to get started',
        () => _showAddPantryItemDialog(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => notifier.loadItems(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildPantryItemCard(item, notifier);
        },
      ),
    );
  }

  Widget _buildErrorWidget(String error, VoidCallback onRetry) {
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
            'Error: $error',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(
      IconData icon, String title, String subtitle, VoidCallback onAdd) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add Item'),
          ),
        ],
      ),
    );
  }

  Widget _buildShoppingItemCard(
      ShoppingListItem item, ShoppingListNotifier notifier) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Checkbox(
          value: item.isCompleted,
          onChanged: (_) => notifier.toggleItemCompletion(item.id),
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
                _showEditShoppingItemDialog(item);
                break;
              case 'delete':
                _confirmDeleteShoppingItem(item, notifier);
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

  Widget _buildPantryItemCard(PantryItem item, PantryNotifier notifier) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(item.name),
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
            if (item.isExpired || item.isExpiringSoon || item.isLowStock)
              Wrap(
                spacing: 4,
                children: [
                  if (item.isExpired)
                    Chip(
                      label:
                          const Text('Expired', style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.red.withValues(alpha: 0.1),
                      side:
                          BorderSide(color: Colors.red.withValues(alpha: 0.3)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  if (item.isExpiringSoon && !item.isExpired)
                    Chip(
                      label: const Text('Expiring Soon',
                          style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.orange.withValues(alpha: 0.1),
                      side: BorderSide(
                          color: Colors.orange.withValues(alpha: 0.3)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  if (item.isLowStock)
                    Chip(
                      label: const Text('Low Stock',
                          style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.blue.withValues(alpha: 0.1),
                      side:
                          BorderSide(color: Colors.blue.withValues(alpha: 0.3)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                ],
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _showEditPantryItemDialog(item);
                break;
              case 'delete':
                _confirmDeletePantryItem(item, notifier);
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

  void _showAddShoppingItemDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddShoppingItemDialog(),
    );
  }

  void _showEditShoppingItemDialog(ShoppingListItem item) {
    showDialog(
      context: context,
      builder: (context) => AddShoppingItemDialog(item: item),
    );
  }

  void _showAddPantryItemDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddPantryItemDialog(),
    );
  }

  void _showEditPantryItemDialog(PantryItem item) {
    showDialog(
      context: context,
      builder: (context) => AddPantryItemDialog(item: item),
    );
  }

  void _confirmDeleteShoppingItem(
      ShoppingListItem item, ShoppingListNotifier notifier) {
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
              notifier.deleteItem(item.id);
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

  void _confirmDeletePantryItem(PantryItem item, PantryNotifier notifier) {
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
              notifier.deleteItem(item.id);
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

  Future<void> _moveCompletedToPantry() async {
    try {
      await ref
          .read(shoppingListProvider.notifier)
          .moveCompletedItemsToPantry();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Completed items moved to pantry')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error moving items: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
