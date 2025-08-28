import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/providers/recipe_provider.dart';
import '../../../../domain/entities/recipe.dart';
import '../../../../domain/entities/user_profile.dart';
import '../../../../core/theme/design_tokens.dart';

class RecipeFilterWidget extends ConsumerStatefulWidget {
  const RecipeFilterWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<RecipeFilterWidget> createState() => _RecipeFilterWidgetState();
}

class _RecipeFilterWidgetState extends ConsumerState<RecipeFilterWidget> {
  late RecipeFilter _currentFilter;
  final List<String> _selectedCuisines = [];
  final List<DifficultyLevel> _selectedDifficulties = [];
  final List<String> _selectedTags = [];
  Duration? _maxCookingTime;
  Duration? _maxPrepTime;
  double? _minRating;
  bool? _isFavorite;

  @override
  void initState() {
    super.initState();
    _currentFilter = ref.read(recipeFilterProvider);
    _initializeFromCurrentFilter();
  }

  void _initializeFromCurrentFilter() {
    _selectedCuisines.addAll(_currentFilter.cuisines);
    _selectedDifficulties.addAll(_currentFilter.difficulties);
    _selectedTags.addAll(_currentFilter.tags);
    _maxCookingTime = _currentFilter.maxCookingTime;
    _maxPrepTime = _currentFilter.maxPrepTime;
    _minRating = _currentFilter.minRating;
    _isFavorite = _currentFilter.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radiusXl),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: DesignTokens.spacingMd),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacingLg),
            child: Row(
              children: [
                Text(
                  'Filter Recipes',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Filter content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCuisineFilter(),
                  const SizedBox(height: DesignTokens.spacing2xl),
                  _buildDifficultyFilter(),
                  const SizedBox(height: DesignTokens.spacing2xl),
                  _buildTimeFilters(),
                  const SizedBox(height: DesignTokens.spacing2xl),
                  _buildRatingFilter(),
                  const SizedBox(height: DesignTokens.spacing2xl),
                  _buildFavoriteFilter(),
                  const SizedBox(height: DesignTokens.spacing2xl),
                  _buildTagFilter(),
                ],
              ),
            ),
          ),
          
          // Action buttons
          Container(
            padding: const EdgeInsets.all(DesignTokens.spacingLg),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingMd),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    child: const Text('Apply Filters'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineFilter() {
    const cuisines = [
      'Italian', 'Mexican', 'Chinese', 'Japanese', 'Indian', 'Thai',
      'French', 'Mediterranean', 'American', 'Korean', 'Vietnamese',
      'Greek', 'Spanish', 'Middle Eastern', 'African', 'Caribbean'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuisine',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Wrap(
          spacing: DesignTokens.spacingSm,
          runSpacing: DesignTokens.spacingSm,
          children: cuisines.map((cuisine) {
            final isSelected = _selectedCuisines.contains(cuisine.toLowerCase());
            return FilterChip(
              label: Text(cuisine),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCuisines.add(cuisine.toLowerCase());
                  } else {
                    _selectedCuisines.remove(cuisine.toLowerCase());
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDifficultyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Wrap(
          spacing: DesignTokens.spacingSm,
          runSpacing: DesignTokens.spacingSm,
          children: DifficultyLevel.values.map((difficulty) {
            final isSelected = _selectedDifficulties.contains(difficulty);
            return FilterChip(
              label: Text(difficulty.displayName),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedDifficulties.add(difficulty);
                  } else {
                    _selectedDifficulties.remove(difficulty);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimeFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooking Time',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Text(
          'Maximum: ${_maxCookingTime?.inMinutes ?? 120} minutes',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Slider(
          value: (_maxCookingTime?.inMinutes ?? 120).toDouble(),
          min: 15,
          max: 240,
          divisions: 15,
          onChanged: (value) {
            setState(() {
              _maxCookingTime = Duration(minutes: value.round());
            });
          },
        ),
        
        const SizedBox(height: DesignTokens.spacingLg),
        
        Text(
          'Prep Time',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Text(
          'Maximum: ${_maxPrepTime?.inMinutes ?? 60} minutes',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Slider(
          value: (_maxPrepTime?.inMinutes ?? 60).toDouble(),
          min: 5,
          max: 120,
          divisions: 23,
          onChanged: (value) {
            setState(() {
              _maxPrepTime = Duration(minutes: value.round());
            });
          },
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Rating',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _minRating ?? 0.0,
                min: 0.0,
                max: 5.0,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _minRating = value;
                  });
                },
              ),
            ),
            const SizedBox(width: DesignTokens.spacingMd),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < (_minRating ?? 0).floor()
                        ? Icons.star
                        : index < (_minRating ?? 0)
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.amber,
                    size: DesignTokens.iconMd,
                  );
                }),
                const SizedBox(width: DesignTokens.spacingSm),
                Text(
                  (_minRating ?? 0.0).toStringAsFixed(1),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFavoriteFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Favorites',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Row(
          children: [
            FilterChip(
              label: const Text('All Recipes'),
              selected: _isFavorite == null,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _isFavorite = null;
                  });
                }
              },
            ),
            const SizedBox(width: DesignTokens.spacingSm),
            FilterChip(
              label: const Text('Favorites Only'),
              selected: _isFavorite == true,
              onSelected: (selected) {
                setState(() {
                  _isFavorite = selected ? true : null;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagFilter() {
    const commonTags = [
      'quick', 'healthy', 'vegetarian', 'vegan', 'gluten-free', 'dairy-free',
      'low-carb', 'high-protein', 'comfort-food', 'spicy', 'sweet', 'savory',
      'breakfast', 'lunch', 'dinner', 'snack', 'dessert', 'appetizer'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: DesignTokens.spacingMd),
        Wrap(
          spacing: DesignTokens.spacingSm,
          runSpacing: DesignTokens.spacingSm,
          children: commonTags.map((tag) {
            final isSelected = _selectedTags.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.remove(tag);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCuisines.clear();
      _selectedDifficulties.clear();
      _selectedTags.clear();
      _maxCookingTime = null;
      _maxPrepTime = null;
      _minRating = null;
      _isFavorite = null;
    });
  }

  void _applyFilters() {
    final newFilter = RecipeFilter(
      cuisines: _selectedCuisines,
      difficulties: _selectedDifficulties,
      maxCookingTime: _maxCookingTime,
      maxPrepTime: _maxPrepTime,
      minRating: _minRating,
      tags: _selectedTags,
      isFavorite: _isFavorite,
    );

    ref.read(recipeFilterProvider.notifier).state = newFilter;
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filters applied successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}