import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/design_tokens.dart';

/// Advanced search modal with filtering and voice input support
class SearchModal extends ConsumerStatefulWidget {
  const SearchModal({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends ConsumerState<SearchModal>
    with TickerProviderStateMixin {
  late TextEditingController _searchController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = '';

  // Filter states
  List<String> _selectedCuisines = [];
  List<String> _selectedDifficulties = [];
  RangeValues _cookingTimeRange = const RangeValues(0, 120);
  bool _vegetarianOnly = false;
  bool _veganOnly = false;
  bool _glutenFreeOnly = false;

  final List<String> _cuisineOptions = [
    'Italian',
    'Chinese',
    'Mexican',
    'Indian',
    'Japanese',
    'French',
    'Thai',
    'Mediterranean',
    'American',
    'Korean',
  ];

  final List<String> _difficultyOptions = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _initSpeech();
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _searchController.text = _lastWords;
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedCuisines.clear();
      _selectedDifficulties.clear();
      _cookingTimeRange = const RangeValues(0, 120);
      _vegetarianOnly = false;
      _veganOnly = false;
      _glutenFreeOnly = false;
    });
  }

  void _performSearch() {
    // TODO: Implement search logic
    Navigator.of(context).pop({
      'query': _searchController.text,
      'cuisines': _selectedCuisines,
      'difficulties': _selectedDifficulties,
      'cookingTimeRange': _cookingTimeRange,
      'vegetarianOnly': _vegetarianOnly,
      'veganOnly': _veganOnly,
      'glutenFreeOnly': _glutenFreeOnly,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Dialog.fullscreen(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Advanced Search'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: _clearFilters,
                      child: const Text('Clear All'),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchInput(),
                      const SizedBox(height: DesignTokens.spacing24),
                      _buildCuisineFilter(),
                      const SizedBox(height: DesignTokens.spacing24),
                      _buildDifficultyFilter(),
                      const SizedBox(height: DesignTokens.spacing24),
                      _buildCookingTimeFilter(),
                      const SizedBox(height: DesignTokens.spacing24),
                      _buildDietaryFilters(),
                      const SizedBox(height: DesignTokens.spacing32),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: ElevatedButton(
                      onPressed: _performSearch,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Search Recipes'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Query',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for recipes, ingredients, or cuisines...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  ),
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.red : null,
                  ),
                  onPressed: _speechEnabled
                      ? (_isListening ? _stopListening : _startListening)
                      : null,
                ),
              ],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DesignTokens.cornerRadius12),
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
        if (_isListening)
          Padding(
            padding: const EdgeInsets.only(top: DesignTokens.spacing8),
            child: Row(
              children: [
                const Icon(Icons.mic, color: Colors.red, size: 16),
                const SizedBox(width: DesignTokens.spacing8),
                Text(
                  'Listening...',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.red,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCuisineFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cuisine Type',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        Wrap(
          spacing: DesignTokens.spacing8,
          runSpacing: DesignTokens.spacing8,
          children: _cuisineOptions.map((cuisine) {
            final isSelected = _selectedCuisines.contains(cuisine);
            return FilterChip(
              label: Text(cuisine),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedCuisines.add(cuisine);
                  } else {
                    _selectedCuisines.remove(cuisine);
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
          'Difficulty Level',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        Wrap(
          spacing: DesignTokens.spacing8,
          runSpacing: DesignTokens.spacing8,
          children: _difficultyOptions.map((difficulty) {
            final isSelected = _selectedDifficulties.contains(difficulty);
            return FilterChip(
              label: Text(difficulty),
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

  Widget _buildCookingTimeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooking Time (minutes)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        RangeSlider(
          values: _cookingTimeRange,
          min: 0,
          max: 240,
          divisions: 24,
          labels: RangeLabels(
            '${_cookingTimeRange.start.round()} min',
            '${_cookingTimeRange.end.round()} min',
          ),
          onChanged: (values) {
            setState(() {
              _cookingTimeRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_cookingTimeRange.start.round()} min',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '${_cookingTimeRange.end.round()} min',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDietaryFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Preferences',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DesignTokens.spacing8),
        CheckboxListTile(
          title: const Text('Vegetarian'),
          value: _vegetarianOnly,
          onChanged: (value) {
            setState(() {
              _vegetarianOnly = value ?? false;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: const Text('Vegan'),
          value: _veganOnly,
          onChanged: (value) {
            setState(() {
              _veganOnly = value ?? false;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          title: const Text('Gluten-Free'),
          value: _glutenFreeOnly,
          onChanged: (value) {
            setState(() {
              _glutenFreeOnly = value ?? false;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}