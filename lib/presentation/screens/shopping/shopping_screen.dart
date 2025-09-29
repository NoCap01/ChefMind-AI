import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers/pantry_provider.dart';
import '../../../application/providers/shopping_list_provider.dart';
import '../../../domain/entities/shopping_list_item.dart';
import '../../../core/utils/constants.dart';
import '../../../core/performance/memory_optimizer.dart';
import '../../../core/performance/state_optimization.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/pantry/add_pantry_item_dialog.dart';
import '../../widgets/shopping/add_shopping_item_dialog.dart';

class ShoppingScreen extends ConsumerStatefulWidget {
  const ShoppingScreen({super.key});

  @override
  ConsumerState<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends ConsumerState<ShoppingScreen>
    with MemoryOptimizedMixin, PerformanceOptimizationMixin {
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Debounce search input for better performance
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    debounce('search', const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _searchQuery = _searchController.text;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pantryState = ref.watch(pantryProvider);
    final shoppingState = ref.watch(shoppingListProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Shopping & Pantry'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced search and filter section
            _buildSearchAndFilters(context),

            const SizedBox(height: AppConstants.largePadding),

            // Quick stats with better error handling
            _buildQuickStats(context, pantryState, shoppingState),

            const SizedBox(height: AppConstants.largePadding),

            // Enhanced quick actions
            _buildQuickActions(context),

            const SizedBox(height: AppConstants.largePadding),

            // Smart suggestions section
            _buildSmartSuggestions(context, pantryState, shoppingState),

            const SizedBox(height: AppConstants.largePadding),

            // Pantry items section (when pantry filter is selected)
            _buildPantryItems(context, pantryState),

            const SizedBox(height: AppConstants.largePadding),

            // Expiring items section with better filtering
            _buildExpiringItems(context, pantryState),

            const SizedBox(height: AppConstants.largePadding),

            // Low stock items with enhanced features
            _buildLowStockItems(context, pantryState),

            const SizedBox(height: AppConstants.largePadding),

            // Enhanced shopping list preview
            _buildShoppingListPreview(context, shoppingState),

            const SizedBox(height: AppConstants.largePadding),

            // Recent activity section
            _buildRecentActivity(context, shoppingState),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItemDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search & Filter',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.smallPadding),

            // Search field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search items...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),

            const SizedBox(height: AppConstants.smallPadding),

            // Filter chips with "All" functionality
            Consumer(
              builder: (context, ref, child) {
                final pantryState = ref.watch(pantryProvider);
                final shoppingState = ref.watch(shoppingListProvider);

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: Text('All'),
                        selected: _selectedFilter == 'all',
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = 'all';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text('Pantry (${pantryState.items.length})'),
                        selected: _selectedFilter == 'pantry',
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = 'pantry';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text(
                            'Shopping (${shoppingState.pendingItemCount})'),
                        selected: _selectedFilter == 'shopping',
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = 'shopping';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text(
                            'Low Stock (${pantryState.lowStockItems.length})'),
                        selected: _selectedFilter == 'low_stock',
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = 'low_stock';
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: Text(
                            'Expiring (${pantryState.expiringSoonItems.length})'),
                        selected: _selectedFilter == 'expiring',
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = 'expiring';
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),

            // Filter status indicator
            if (_selectedFilter != 'all') ...[
              const SizedBox(height: AppConstants.smallPadding),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getFilterIcon(_selectedFilter),
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Showing: ${_getFilterDisplayName(_selectedFilter)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = 'all';
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getFilterIcon(String filter) {
    switch (filter) {
      case 'pantry':
        return Icons.inventory;
      case 'shopping':
        return Icons.shopping_cart;
      case 'low_stock':
        return Icons.warning;
      case 'expiring':
        return Icons.schedule;
      default:
        return Icons.filter_list;
    }
  }

  String _getFilterDisplayName(String filter) {
    switch (filter) {
      case 'pantry':
        return 'Pantry Items';
      case 'shopping':
        return 'Shopping List';
      case 'low_stock':
        return 'Low Stock Items';
      case 'expiring':
        return 'Expiring Items';
      default:
        return 'All Items';
    }
  }

  Widget _buildQuickStats(BuildContext context, PantryState pantryState,
      ShoppingListState shoppingState) {
    final theme = Theme.of(context);

    // Handle pantry initialization error
    if (pantryState.error != null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 8),
              Text(
                'Pantry Service Error',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                pantryState.error!,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  ref.read(pantryProvider.notifier).loadItems();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kitchen Overview',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Pantry Items',
                    pantryState.items.length.toString(),
                    Icons.inventory,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Shopping Items',
                    shoppingState.pendingItemCount.toString(),
                    Icons.shopping_cart,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Expiring Soon',
                    pantryState.expiringSoonItems.length.toString(),
                    Icons.schedule,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Low Stock',
                    pantryState.lowStockItems.length.toString(),
                    Icons.warning,
                    Colors.red,
                  ),
                ),
              ],
            ),
            if (shoppingState.estimatedTotalCost > 0) ...[
              const SizedBox(height: AppConstants.defaultPadding),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(Icons.currency_rupee,
                        color: theme.colorScheme.primary, size: 24),
                    const SizedBox(height: 4),
                    Text(
                      '₹${shoppingState.estimatedTotalCost.toStringAsFixed(2)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Estimated Shopping Cost',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value,
      IconData icon, Color color) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(4),
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
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                'View Pantry',
                Icons.kitchen,
                () => context.push('/shopping/pantry'),
              ),
            ),
            const SizedBox(width: AppConstants.smallPadding),
            Expanded(
              child: _buildActionCard(
                context,
                'Shopping List',
                Icons.shopping_cart,
                () => context.push('/shopping/list'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                'Scan Barcode',
                Icons.qr_code_scanner,
                () => _showBarcodeScanner(context),
              ),
            ),
            const SizedBox(width: AppConstants.smallPadding),
            Expanded(
              child: _buildActionCard(
                context,
                'Add Item',
                Icons.add_shopping_cart,
                () => _showAddItemDialog(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                'Price Tracker',
                Icons.trending_up,
                () => _showPriceTracker(context),
              ),
            ),
            const SizedBox(width: AppConstants.smallPadding),
            Expanded(
              child: _buildActionCard(
                context,
                'Export List',
                Icons.share,
                () => _showExportOptions(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartSuggestions(BuildContext context, PantryState pantryState,
      ShoppingListState shoppingState) {
    final theme = Theme.of(context);
    final suggestions = _getSmartSuggestions(pantryState, shoppingState);

    if (suggestions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Smart Suggestions',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        ...suggestions.map((suggestion) => Card(
              child: ListTile(
                leading: Icon(suggestion['icon'], color: suggestion['color']),
                title: Text(suggestion['title']),
                subtitle: Text(suggestion['subtitle']),
                trailing: TextButton(
                  onPressed: suggestion['action'],
                  child: Text(suggestion['actionText']),
                ),
              ),
            )),
      ],
    );
  }

  List<Map<String, dynamic>> _getSmartSuggestions(
      PantryState pantryState, ShoppingListState shoppingState) {
    final suggestions = <Map<String, dynamic>>[];

    // Suggest adding low stock items to shopping list
    if (pantryState.lowStockItems.isNotEmpty &&
        shoppingState.pendingItemCount < 5) {
      suggestions.add({
        'icon': Icons.add_shopping_cart,
        'color': Colors.orange,
        'title': 'Add Low Stock Items',
        'subtitle': '${pantryState.lowStockItems.length} items are running low',
        'actionText': 'Add All',
        'action': () => _addLowStockItemsToShoppingList(),
      });
    }

    // Suggest moving completed items to pantry
    if (shoppingState.completedItemCount > 0) {
      suggestions.add({
        'icon': Icons.kitchen,
        'color': Colors.green,
        'title': 'Move to Pantry',
        'subtitle': '${shoppingState.completedItemCount} completed items ready',
        'actionText': 'Move',
        'action': () => _moveCompletedItemsToPantry(),
      });
    }

    return suggestions;
  }

  Widget _buildPantryItems(BuildContext context, PantryState pantryState) {
    var pantryItems = pantryState.items;
    final theme = Theme.of(context);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      pantryItems = pantryItems
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Only show pantry items when 'all' or 'pantry' filter is selected
    if (_selectedFilter != 'all' && _selectedFilter != 'pantry') {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pantry Items',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (pantryItems.isNotEmpty)
              TextButton(
                onPressed: () => context.push('/shopping/pantry'),
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        if (pantryItems.isEmpty && _selectedFilter == 'all')
          Card(
            child: ListTile(
              leading: Icon(Icons.inventory_2_outlined,
                  color: theme.colorScheme.primary),
              title: const Text('Pantry is empty'),
              subtitle: const Text('Add items to get started'),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddItemDialog(context),
              ),
            ),
          )
        else if (pantryItems.isEmpty && _selectedFilter == 'pantry')
          Card(
            child: ListTile(
              leading: Icon(Icons.search_off, color: theme.colorScheme.outline),
              title: const Text('No pantry items found'),
              subtitle: const Text('Try adjusting your search'),
            ),
          )
        else
          ...pantryItems.take(5).map((item) => Card(
                child: ListTile(
                  leading: Icon(
                    Icons.inventory,
                    color: item.isLowStock
                        ? Colors.red
                        : item.isExpiringSoon
                            ? Colors.orange
                            : Colors.blue,
                  ),
                  title: Text(item.name),
                  subtitle: Text('${item.quantity} ${item.unit}' +
                      (item.category != null ? ' • ${item.category}' : '')),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.expirationDate != null)
                        Text(
                          '${item.expirationDate!.difference(DateTime.now()).inDays}d',
                          style: TextStyle(
                            color: item.isExpiringSoon ? Colors.orange : null,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(width: 8),
                      Consumer(
                        builder: (context, ref, child) => IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () =>
                              _addToShoppingList(context, ref, item),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildExpiringItems(BuildContext context, PantryState pantryState) {
    var expiringItems = pantryState.expiringSoonItems;
    final theme = Theme.of(context);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      expiringItems = expiringItems
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filter
    if (_selectedFilter == 'all' || _selectedFilter == 'expiring') {
      // Show expiring items when 'all' or 'expiring' is selected
    } else {
      // Hide expiring items for other filters
      expiringItems = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expiring Soon',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (expiringItems.isNotEmpty)
              TextButton(
                onPressed: () => context.push('/shopping/pantry'),
                child: const Text('View All'),
              ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        if (expiringItems.isEmpty && _selectedFilter == 'all')
          Card(
            child: ListTile(
              leading:
                  Icon(Icons.check_circle, color: theme.colorScheme.primary),
              title: const Text('No items expiring soon'),
              subtitle: const Text('Great! Your pantry looks fresh'),
            ),
          )
        else if (expiringItems.isEmpty && _selectedFilter == 'expiring')
          Card(
            child: ListTile(
              leading: Icon(Icons.search_off, color: theme.colorScheme.outline),
              title: const Text('No expiring items found'),
              subtitle: const Text('Try adjusting your search'),
            ),
          )
        else
          ...expiringItems.take(5).map((item) => Card(
                child: ListTile(
                  leading: const Icon(Icons.schedule, color: Colors.orange),
                  title: Text(item.name),
                  subtitle: Text(
                      'Expires in ${item.expirationDate?.difference(DateTime.now()).inDays ?? 0} days'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${item.quantity} ${item.unit}'),
                      const SizedBox(width: 8),
                      Consumer(
                        builder: (context, ref, child) => IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () =>
                              _addToShoppingList(context, ref, item),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildLowStockItems(BuildContext context, PantryState pantryState) {
    var lowStockItems = pantryState.lowStockItems;
    final theme = Theme.of(context);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      lowStockItems = lowStockItems
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filter
    if (_selectedFilter == 'all' || _selectedFilter == 'low_stock') {
      // Show low stock items when 'all' or 'low_stock' is selected
    } else {
      // Hide low stock items for other filters
      lowStockItems = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Low Stock Items',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (lowStockItems.isNotEmpty)
              TextButton(
                onPressed: () => _addLowStockItemsToShoppingList(),
                child: const Text('Add All to List'),
              ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        if (lowStockItems.isEmpty && _selectedFilter == 'all')
          Card(
            child: ListTile(
              leading:
                  Icon(Icons.check_circle, color: theme.colorScheme.primary),
              title: const Text('All items well stocked'),
              subtitle: const Text('You\'re good to go!'),
            ),
          )
        else if (lowStockItems.isEmpty && _selectedFilter == 'low_stock')
          Card(
            child: ListTile(
              leading: Icon(Icons.search_off, color: theme.colorScheme.outline),
              title: const Text('No low stock items found'),
              subtitle: const Text('Try adjusting your search'),
            ),
          )
        else
          ...lowStockItems.take(5).map((item) => Card(
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: Text(item.name),
                  subtitle: Text('${item.quantity} ${item.unit} remaining'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.minStockLevel != null)
                        Text('Min: ${item.minStockLevel} ${item.unit}'),
                      const SizedBox(width: 8),
                      Consumer(
                        builder: (context, ref, child) => IconButton(
                          icon: const Icon(Icons.add_shopping_cart),
                          onPressed: () =>
                              _addToShoppingList(context, ref, item),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildShoppingListPreview(
      BuildContext context, ShoppingListState shoppingState) {
    var pendingItems = shoppingState.pendingItems.take(5).toList();
    final theme = Theme.of(context);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      pendingItems = pendingItems
          .where((item) =>
              item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filter
    if (_selectedFilter == 'all' || _selectedFilter == 'shopping') {
      // Show shopping items when 'all' or 'shopping' is selected
    } else {
      // Hide shopping items for other filters
      pendingItems = [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shopping List Preview',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/shopping/list'),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.smallPadding),
        if (pendingItems.isEmpty && _selectedFilter == 'all')
          Card(
            child: ListTile(
              leading: Icon(Icons.shopping_cart_outlined,
                  color: theme.colorScheme.primary),
              title: const Text('Shopping list is empty'),
              subtitle: const Text('Add items to get started'),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddShoppingItemDialog(context),
              ),
            ),
          )
        else if (pendingItems.isEmpty && _selectedFilter == 'shopping')
          Card(
            child: ListTile(
              leading: Icon(Icons.search_off, color: theme.colorScheme.outline),
              title: const Text('No shopping items found'),
              subtitle: const Text('Try adjusting your search'),
            ),
          )
        else
          ...pendingItems.map((item) => Card(
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(item.name),
                  subtitle: Text('${item.quantity} ${item.unit}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.estimatedPrice != null)
                        Text('₹${item.estimatedPrice!.toStringAsFixed(2)}'),
                      const SizedBox(width: 8),
                      Consumer(
                        builder: (context, ref, child) => IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () => ref
                              .read(shoppingListProvider.notifier)
                              .toggleItemCompletion(item.id),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ],
    );
  }

  Widget _buildRecentActivity(
      BuildContext context, ShoppingListState shoppingState) {
    final theme = Theme.of(context);
    final recentItems = shoppingState.completedItems.take(3).toList();

    if (recentItems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.smallPadding),
        ...recentItems.map((item) => Card(
              child: ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text(item.name),
                subtitle: Text('Completed • ${item.quantity} ${item.unit}'),
                trailing: Text(
                  'Today', // You might want to format the actual date
                  style: theme.textTheme.bodySmall,
                ),
              ),
            )),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddPantryItemDialog(),
      ),
    );
  }

  void _showAddShoppingItemDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AddShoppingItemDialog(),
      ),
    );
  }

  void _addToShoppingList(BuildContext context, WidgetRef ref, dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Shopping List'),
        content: Text('Add ${item.name} to your shopping list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Create shopping list item from pantry item
              final shoppingItem = ShoppingListItem.create(
                name: item.name,
                quantity: item.minStockLevel ?? item.quantity,
                unit: item.unit,
                category: item.category,
                notes:
                    'Added from pantry - ${item.isLowStock ? "low stock" : "expiring soon"}',
              );

              ref.read(shoppingListProvider.notifier).addItem(shoppingItem);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} added to shopping list')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addLowStockItemsToShoppingList() {
    final pantryState = ref.read(pantryProvider);
    final shoppingNotifier = ref.read(shoppingListProvider.notifier);

    for (final item in pantryState.lowStockItems) {
      final shoppingItem = ShoppingListItem.create(
        name: item.name,
        quantity: item.minStockLevel ?? item.quantity,
        unit: item.unit,
        category: item.category,
        notes: 'Added from pantry - low stock',
      );
      shoppingNotifier.addItem(shoppingItem);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${pantryState.lowStockItems.length} items added to shopping list'),
      ),
    );
  }

  void _moveCompletedItemsToPantry() {
    ref.read(shoppingListProvider.notifier).moveCompletedItemsToPantry();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Completed items moved to pantry')),
    );
  }

  void _showBarcodeScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Barcode Scanner'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Barcode scanning feature coming soon!'),
            SizedBox(height: 8),
            Text(
              'This will allow you to quickly add items by scanning their barcodes.',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPriceTracker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Price Tracker'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.trending_up, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text('Price tracking feature coming soon!'),
            SizedBox(height: 8),
            Text(
              'Track price changes for your frequently bought items.',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showExportOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Shopping List'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.share, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text('Export options coming soon!'),
            SizedBox(height: 8),
            Text(
              'Share your shopping list via text, email, or other apps.',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
