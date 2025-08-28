import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/pantry_provider.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../domain/entities/pantry_item.dart';

class PantryFilterWidget extends ConsumerStatefulWidget {
  const PantryFilterWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<PantryFilterWidget> createState() => _PantryFilterWidgetState();
}

class _PantryFilterWidgetState extends ConsumerState<PantryFilterWidget> {
  late PantryFilter _currentFilter;
  late PantrySortOption _currentSort;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentFilter = ref.read(pantryFilterProvider);
    _currentSort = ref.read(pantrySortProvider);
    _searchController.text = _currentFilter.searchQuery ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: DesignTokens.spacingSm),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingMd),
            child: Row(
              children: [
                Text(
                  'Filter & Sort',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text('Reset'),
                ),
                TextButton(
                  onPressed: _applyFilters,
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),

          const Divider(),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search
                  _buildSearchSection(theme),
                  const SizedBox(height: DesignTokens.spacingLg),

                  // Sort options
                  _buildSortSection(theme),
                  const SizedBox(height: DesignTokens.spacingLg),

                  // Categories
                  _buildCategoriesSection(theme),
                  const SizedBox(height: DesignTokens.spacingLg),

                  // Locations
                  _buildLocationsSection(theme),
                  const SizedBox(height: DesignTokens.spacingLg),

                  // Quick filters
                  _buildQuickFiltersSection(theme),
                  const SizedBox(height: DesignTokens.spacingLg),

                  // Date range
                  _buildDateRangeSection(theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search items, brands, or notes...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _currentFilter = _currentFilter.copyWith(searchQuery: value.isEmpty ? null : value);
            });
          },
        ),
      ],
    );
  }

  Widget _buildSortSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort By',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Wrap(
          spacing: DesignTokens.spacingSm,
          children: PantrySortOption.values.map((option) {
            final isSelected = _currentSort == option;
            return FilterChip(
              label: Text(option.displayName),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _currentSort = option;
                  });
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Wrap(
          spacing: DesignTokens.spacingSm,
          runSpacing: DesignTokens.spacingSm,
          children: PantryCategories.all.map((category) {
            final isSelected = _currentFilter.categories.contains(category.id);
            return FilterChip(
              avatar: Text(category.icon),
              label: Text(category.name),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  final categories = List<String>.from(_currentFilter.categories);
                  if (selected) {
                    categories.add(category.id);
                  } else {
                    categories.remove(category.id);
                  }
                  _currentFilter = _currentFilter.copyWith(categories: categories);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationsSection(ThemeData theme) {
    final commonLocations = ['Fridge', 'Freezer', 'Pantry', 'Cabinet', 'Counter'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Storage Locations',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Wrap(
          spacing: DesignTokens.spacingSm,
          children: commonLocations.map((location) {
            final isSelected = _currentFilter.locations.contains(location);
            return FilterChip(
              label: Text(location),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  final locations = List<String>.from(_currentFilter.locations);
                  if (selected) {
                    locations.add(location);
                  } else {
                    locations.remove(location);
                  }
                  _currentFilter = _currentFilter.copyWith(locations: locations);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickFiltersSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Filters',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Column(
          children: [
            SwitchListTile(
              title: const Text('Show expiring items only'),
              subtitle: const Text('Items expiring within 7 days'),
              value: _currentFilter.showExpiringOnly,
              onChanged: (value) {
                setState(() {
                  _currentFilter = _currentFilter.copyWith(showExpiringOnly: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show low stock items only'),
              subtitle: const Text('Items below minimum quantity'),
              value: _currentFilter.showLowStockOnly,
              onChanged: (value) {
                setState(() {
                  _currentFilter = _currentFilter.copyWith(showLowStockOnly: value);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRangeSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiry Date Range',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingSm),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectDate(true),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _currentFilter.expiryAfter != null
                      ? 'From: ${_formatDate(_currentFilter.expiryAfter!)}'
                      : 'From Date',
                ),
              ),
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _selectDate(false),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _currentFilter.expiryBefore != null
                      ? 'To: ${_formatDate(_currentFilter.expiryBefore!)}'
                      : 'To Date',
                ),
              ),
            ),
          ],
        ),
        if (_currentFilter.expiryAfter != null || _currentFilter.expiryBefore != null) ...[
          const SizedBox(height: DesignTokens.spacingSm),
          TextButton(
            onPressed: () {
              setState(() {
                _currentFilter = _currentFilter.copyWith(
                  expiryAfter: null,
                  expiryBefore: null,
                );
              });
            },
            child: const Text('Clear Date Range'),
          ),
        ],
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(bool isStartDate) async {
    final initialDate = isStartDate 
        ? _currentFilter.expiryAfter ?? DateTime.now()
        : _currentFilter.expiryBefore ?? DateTime.now().add(const Duration(days: 30));

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      setState(() {
        if (isStartDate) {
          _currentFilter = _currentFilter.copyWith(expiryAfter: selectedDate);
        } else {
          _currentFilter = _currentFilter.copyWith(expiryBefore: selectedDate);
        }
      });
    }
  }

  void _resetFilters() {
    setState(() {
      _currentFilter = const PantryFilter();
      _currentSort = PantrySortOption.expiryDate;
      _searchController.clear();
    });
  }

  void _applyFilters() {
    ref.read(pantryFilterProvider.notifier).state = _currentFilter;
    ref.read(pantrySortProvider.notifier).state = _currentSort;
    Navigator.of(context).pop();
  }
}