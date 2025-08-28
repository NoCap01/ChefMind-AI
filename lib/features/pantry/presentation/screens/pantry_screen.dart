import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/pantry_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/pantry_item.dart';
import '../widgets/pantry_stats_widget.dart';
import '../widgets/pantry_item_card.dart';
import '../widgets/pantry_filter_widget.dart';
import '../widgets/add_pantry_item_modal.dart';
import '../widgets/expiry_notifications_widget.dart';

class PantryScreen extends ConsumerStatefulWidget {
  const PantryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends ConsumerState<PantryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = true;
  
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
    final pantryState = ref.watch(pantryStateProvider);
    final filteredItems = ref.watch(filteredPantryItemsProvider);
    final expiringItems = ref.watch(expiringItemsProvider);
    final lowStockItems = ref.watch(lowStockItemsProvider);
    final itemsByCategory = ref.watch(pantryItemsByCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pantry'),
        actions: [
          IconButton(
            onPressed: () => _showFilterModal(),
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'scan_barcode',
                child: ListTile(
                  leading: Icon(Icons.qr_code_scanner),
                  title: Text('Scan Barcode'),
                ),
              ),
              const PopupMenuItem(
                value: 'shopping_list',
                child: ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Generate Shopping List'),
                ),
              ),
              const PopupMenuItem(
                value: 'recipe_suggestions',
                child: ListTile(
                  leading: Icon(Icons.restaurant),
                  title: Text('Recipe Suggestions'),
                ),
              ),
              const PopupMenuItem(
                value: 'export_data',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Export Data'),
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'All Items',
              icon: Badge(
                label: Text('${filteredItems.length}'),
                child: const Icon(Icons.inventory),
              ),
            ),
            Tab(
              text: 'Expiring',
              icon: Badge(
                label: Text('${expiringItems.length}'),
                backgroundColor: Colors.orange,
                child: const Icon(Icons.schedule),
              ),
            ),
            Tab(
              text: 'Low Stock',
              icon: Badge(
                label: Text('${lowStockItems.length}'),
                backgroundColor: Colors.red,
                child: const Icon(Icons.warning),
              ),
            ),
            Tab(
              text: 'Categories',
              icon: Badge(
                label: Text('${itemsByCategory.length}'),
                child: const Icon(Icons.category),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Statistics Overview
          const PantryStatsWidget(),
          
          // Expiry Notifications
          if (expiringItems.isNotEmpty)
            const ExpiryNotificationsWidget(),
          
          // Content
          Expanded(
            child: pantryState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : pantryState.errorMessage != null
                    ? _buildErrorState(pantryState.errorMessage!)
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _buildAllItemsTab(filteredItems),
                          _buildExpiringItemsTab(expiringItems),
                          _buildLowStockItemsTab(lowStockItems),
                          _buildCategoriesTab(itemsByCategory),
                        ],
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItemModal(),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }

  Widget _buildAllItemsTab(List<PantryItem> items) {
    if (items.isEmpty) {
      return _buildEmptyState(
        'No pantry items found',
        'Add items to your pantry to get started',
        Icons.inventory,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(pantryStateProvider.notifier).refresh(),
      child: _isGridView
          ? _buildGridView(items)
          : _buildListView(items),
    );
  }

  Widget _buildExpiringItemsTab(List<PantryItem> items) {
    if (items.isEmpty) {
      return _buildEmptyState(
        'No expiring items',
        'Great! All your items are fresh',
        Icons.check_circle,
        color: Colors.green,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(pantryStateProvider.notifier).refresh(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            margin: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.orange),
                const SizedBox(width: DesignTokens.spacingSm),
                Expanded(
                  child: Text(
                    '${items.length} items expiring within 7 days',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _getRecipeSuggestions(),
                  child: const Text('Get Recipes'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isGridView
                ? _buildGridView(items)
                : _buildListView(items),
          ),
        ],
      ),
    );
  }

  Widget _buildLowStockItemsTab(List<PantryItem> items) {
    if (items.isEmpty) {
      return _buildEmptyState(
        'No low stock items',
        'All items are well stocked',
        Icons.check_circle,
        color: Colors.green,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(pantryStateProvider.notifier).refresh(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingMd),
            margin: const EdgeInsets.all(DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning, color: Colors.red),
                const SizedBox(width: DesignTokens.spacingSm),
                Expanded(
                  child: Text(
                    '${items.length} items running low',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => _generateShoppingList(),
                  child: const Text('Shopping List'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isGridView
                ? _buildGridView(items)
                : _buildListView(items),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesTab(Map<String, List<PantryItem>> itemsByCategory) {
    if (itemsByCategory.isEmpty) {
      return _buildEmptyState(
        'No categories found',
        'Add items to see categories',
        Icons.category,
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(pantryStateProvider.notifier).refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        itemCount: itemsByCategory.length,
        itemBuilder: (context, index) {
          final categoryId = itemsByCategory.keys.elementAt(index);
          final items = itemsByCategory[categoryId]!;
          final category = PantryCategories.getById(categoryId);
          
          return Card(
            margin: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
            child: ExpansionTile(
              leading: Text(
                category?.icon ?? '📦',
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                category?.name ?? categoryId,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${items.length} items'),
              children: items.map((item) => PantryItemCard(
                item: item,
                isCompact: true,
                onTap: () => _showItemDetails(item),
              )).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridView(List<PantryItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: DesignTokens.spacingMd,
        mainAxisSpacing: DesignTokens.spacingMd,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PantryItemCard(
          item: item,
          onTap: () => _showItemDetails(item),
        );
      },
    );
  }

  Widget _buildListView(List<PantryItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return PantryItemCard(
          item: item,
          isCompact: true,
          onTap: () => _showItemDetails(item),
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon, {Color? color}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: color ?? Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color ?? Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            ElevatedButton(
              onPressed: () {
                ref.read(pantryStateProvider.notifier).clearError();
                ref.read(pantryStateProvider.notifier).refresh();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddPantryItemModal(),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PantryFilterWidget(),
    );
  }

  void _showItemDetails(PantryItem item) {
    // TODO: Navigate to item details screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item details for ${item.name} coming soon!')),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'scan_barcode':
        _scanBarcode();
        break;
      case 'shopping_list':
        _generateShoppingList();
        break;
      case 'recipe_suggestions':
        _getRecipeSuggestions();
        break;
      case 'export_data':
        _exportData();
        break;
    }
  }

  void _scanBarcode() {
    // TODO: Implement barcode scanning
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barcode scanning coming soon!')),
    );
  }

  void _generateShoppingList() async {
    try {
      final shoppingList = await ref.read(pantryStateProvider.notifier).generateShoppingList();
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Shopping List Generated'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Generated ${shoppingList.length} items for your shopping list:'),
                const SizedBox(height: DesignTokens.spacingMd),
                ...shoppingList.take(5).map((item) => Text('• ${item.name}')),
                if (shoppingList.length > 5)
                  Text('... and ${shoppingList.length - 5} more items'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to shopping list screen
                },
                child: const Text('View List'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate shopping list: $e')),
        );
      }
    }
  }

  void _getRecipeSuggestions() async {
    try {
      final suggestions = await ref.read(pantryStateProvider.notifier).getRecipeSuggestions();
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Recipe Suggestions'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Here are some recipes to use your expiring items:'),
                const SizedBox(height: DesignTokens.spacingMd),
                ...suggestions.take(5).map((recipe) => Text('• $recipe')),
                if (suggestions.length > 5)
                  Text('... and ${suggestions.length - 5} more recipes'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Navigate to recipes screen
                },
                child: const Text('View Recipes'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get recipe suggestions: $e')),
        );
      }
    }
  }

  void _exportData() {
    // TODO: Implement data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export coming soon!')),
    );
  }
}