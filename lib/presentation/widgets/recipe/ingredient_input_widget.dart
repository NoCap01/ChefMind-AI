import 'package:flutter/material.dart';
import '../../../services/ingredient_suggestions_service.dart';

class IngredientInputWidget extends StatefulWidget {
  final List<String> ingredients;
  final Function(String) onIngredientAdded;
  final Function(String) onIngredientRemoved;
  final String? hintText;
  final bool showSuggestions;
  final bool showPopularIngredients;

  const IngredientInputWidget({
    super.key,
    required this.ingredients,
    required this.onIngredientAdded,
    required this.onIngredientRemoved,
    this.hintText = 'e.g., chicken, rice, tomatoes',
    this.showSuggestions = true,
    this.showPopularIngredients = true,
  });

  @override
  State<IngredientInputWidget> createState() => _IngredientInputWidgetState();
}

class _IngredientInputWidgetState extends State<IngredientInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _suggestions = [];
  bool _showSuggestions = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text;
    setState(() {
      _errorText = null;
      if (query.isNotEmpty && widget.showSuggestions) {
        _suggestions = IngredientSuggestionsService.getSuggestions(query);
        _showSuggestions = _suggestions.isNotEmpty;
      } else {
        _showSuggestions = false;
      }
    });
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      setState(() {
        _showSuggestions = false;
      });
    }
  }

  void _addIngredient([String? ingredient]) {
    final ingredientToAdd = ingredient ?? _controller.text;
    final formatted = IngredientSuggestionsService.formatIngredient(ingredientToAdd);
    
    final validationError = IngredientSuggestionsService.validateIngredient(
      formatted, 
      widget.ingredients,
    );
    
    if (validationError != null) {
      setState(() {
        _errorText = validationError;
      });
      return;
    }

    widget.onIngredientAdded(formatted);
    _controller.clear();
    setState(() {
      _errorText = null;
      _showSuggestions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input field with suggestions
        Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: widget.hintText,
                          errorText: _errorText,
                          border: const OutlineInputBorder(),
                          suffixIcon: _controller.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _controller.clear();
                                    setState(() {
                                      _errorText = null;
                                      _showSuggestions = false;
                                    });
                                  },
                                )
                              : null,
                        ),
                        onSubmitted: _addIngredient,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _controller.text.isNotEmpty ? () => _addIngredient() : null,
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        backgroundColor: _controller.text.isNotEmpty 
                            ? theme.colorScheme.primary 
                            : theme.colorScheme.surfaceContainerHighest,
                        foregroundColor: _controller.text.isNotEmpty 
                            ? theme.colorScheme.onPrimary 
                            : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                
                // Suggestions dropdown
                if (_showSuggestions && _suggestions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = _suggestions[index];
                        return ListTile(
                          dense: true,
                          title: Text(suggestion),
                          leading: const Icon(Icons.search, size: 16),
                          onTap: () => _addIngredient(suggestion),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Popular ingredients (quick add)
        if (widget.showPopularIngredients && widget.ingredients.isEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular ingredients:',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: IngredientSuggestionsService.getPopularIngredients()
                    .map((ingredient) => ActionChip(
                          label: Text(ingredient),
                          onPressed: () => _addIngredient(ingredient),
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),

        // Complementary suggestions based on existing ingredients
        if (widget.ingredients.isNotEmpty)
          Builder(
            builder: (context) {
              final complementary = IngredientSuggestionsService.getComplementaryIngredients(
                widget.ingredients,
              );
              
              if (complementary.isEmpty) return const SizedBox.shrink();
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggested additions:',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: complementary
                        .map((ingredient) => ActionChip(
                              label: Text(ingredient),
                              onPressed: () => _addIngredient(ingredient),
                              backgroundColor: theme.colorScheme.secondaryContainer,
                              labelStyle: TextStyle(
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),

        // Current ingredients chips
        if (widget.ingredients.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.ingredients.map((ingredient) {
              return Chip(
                label: Text(ingredient),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => widget.onIngredientRemoved(ingredient),
                backgroundColor: theme.colorScheme.primaryContainer,
                labelStyle: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              );
            }).toList(),
          ),

        // Empty state
        if (widget.ingredients.isEmpty && !widget.showPopularIngredients)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 48,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add ingredients to get started',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}