import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/theme/design_tokens.dart';

class IngredientInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onIngredientAdded;
  final List<String> selectedIngredients;
  final Function(String)? onIngredientRemoved;
  final bool enableVoiceInput;
  final bool enableAutoSuggestions;
  final List<String>? customSuggestions;

  const IngredientInputWidget({
    Key? key,
    required this.controller,
    required this.onIngredientAdded,
    required this.selectedIngredients,
    this.onIngredientRemoved,
    this.enableVoiceInput = true,
    this.enableAutoSuggestions = true,
    this.customSuggestions,
  }) : super(key: key);

  @override
  State<IngredientInputWidget> createState() => _IngredientInputWidgetState();
}

class _IngredientInputWidgetState extends State<IngredientInputWidget>
    with TickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  final SpeechToText _speechToText = SpeechToText();
  final LayerLink _layerLink = LayerLink();
  
  bool _isListening = false;
  bool _speechEnabled = false;
  String _lastWords = '';
  String _currentInput = '';
  List<String> _suggestions = [];
  bool _showSuggestions = false;
  OverlayEntry? _overlayEntry;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Common ingredient suggestions
  static const List<String> _commonIngredients = [
    'chicken breast', 'ground beef', 'salmon', 'shrimp', 'eggs', 'milk', 'cheese',
    'butter', 'olive oil', 'onion', 'garlic', 'tomatoes', 'potatoes', 'carrots',
    'bell peppers', 'broccoli', 'spinach', 'lettuce', 'mushrooms', 'zucchini',
    'rice', 'pasta', 'bread', 'flour', 'sugar', 'salt', 'black pepper',
    'basil', 'oregano', 'thyme', 'rosemary', 'parsley', 'cilantro', 'ginger',
    'lemon', 'lime', 'avocado', 'cucumber', 'celery', 'corn', 'beans',
    'quinoa', 'oats', 'almonds', 'walnuts', 'honey', 'vanilla extract'
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    _focusNode.dispose();
    _pulseController.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main input field
        CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Enter ingredients (e.g., chicken, rice, tomatoes)',
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              prefixIcon: Icon(
                Icons.restaurant_menu,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Clear button
                  if (widget.controller.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        widget.controller.clear();
                        _hideSuggestions();
                      },
                      tooltip: 'Clear input',
                    ),
                  
                  // Voice Input Button
                  if (widget.enableVoiceInput)
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _isListening ? _pulseAnimation.value : 1.0,
                          child: IconButton(
                            icon: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: _isListening 
                                  ? Theme.of(context).colorScheme.primary 
                                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                            onPressed: _speechEnabled ? _toggleVoiceInput : null,
                            tooltip: _speechEnabled 
                                ? (_isListening ? 'Stop listening' : 'Start voice input')
                                : 'Voice input not available',
                          ),
                        );
                      },
                    ),
                  
                  // Add Button
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: widget.controller.text.trim().isNotEmpty 
                        ? _addIngredient 
                        : null,
                    color: Theme.of(context).colorScheme.primary,
                    tooltip: 'Add ingredient',
                  ),
                ],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
            onSubmitted: (_) => _addIngredient(),
            textInputAction: TextInputAction.done,
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
        
        // Voice Input Status
        if (_isListening)
          Container(
            margin: const EdgeInsets.only(top: DesignTokens.spacingSm),
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacingMd,
              vertical: DesignTokens.spacingSm,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.mic,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                Text(
                  _lastWords.isEmpty ? 'Listening...' : 'Heard: "$_lastWords"',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacingSm),
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Selected Ingredients Chips
        if (widget.selectedIngredients.isNotEmpty) ...[
          const SizedBox(height: DesignTokens.spacingLg),
          Wrap(
            spacing: DesignTokens.spacingSm,
            runSpacing: DesignTokens.spacingSm,
            children: widget.selectedIngredients.map((ingredient) {
              return _buildIngredientChip(ingredient);
            }).toList(),
          ),
        ],

        // Input validation message
        if (_currentInput.isNotEmpty && !_isValidIngredient(_currentInput))
          Padding(
            padding: const EdgeInsets.only(top: DesignTokens.spacingSm),
            child: Text(
              'Please enter a valid ingredient name',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  // Initialize speech-to-text
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(
      onError: (error) {
        setState(() {
          _isListening = false;
        });
        _pulseController.stop();
      },
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          setState(() {
            _isListening = false;
          });
          _pulseController.stop();
        }
      },
    );
    setState(() {});
  }

  // Handle focus changes
  void _onFocusChange() {
    if (_focusNode.hasFocus && widget.enableAutoSuggestions) {
      _updateSuggestions();
      _showSuggestionsOverlay();
    } else {
      _hideSuggestions();
    }
  }

  // Handle text changes
  void _onTextChange() {
    final text = widget.controller.text;
    setState(() {
      _currentInput = text;
    });

    if (widget.enableAutoSuggestions && _focusNode.hasFocus) {
      _updateSuggestions();
      if (_suggestions.isNotEmpty) {
        _showSuggestionsOverlay();
      } else {
        _hideSuggestions();
      }
    }
  }

  // Update suggestions based on current input
  void _updateSuggestions() {
    final query = widget.controller.text.toLowerCase().trim();
    if (query.isEmpty) {
      _suggestions = [];
      return;
    }

    final allIngredients = widget.customSuggestions ?? _commonIngredients;
    _suggestions = allIngredients
        .where((ingredient) => 
            ingredient.toLowerCase().contains(query) &&
            !widget.selectedIngredients.contains(ingredient))
        .take(5)
        .toList();
  }

  // Show suggestions overlay
  void _showSuggestionsOverlay() {
    if (_suggestions.isEmpty || _overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32, // Account for padding
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 60),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.restaurant_menu,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      suggestion,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      widget.controller.text = suggestion;
                      _addIngredient();
                      _hideSuggestions();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _showSuggestions = true;
    });
  }

  // Hide suggestions overlay
  void _hideSuggestions() {
    _removeOverlay();
    setState(() {
      _showSuggestions = false;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // Build ingredient chip
  Widget _buildIngredientChip(String ingredient) {
    return Chip(
      avatar: Icon(
        Icons.restaurant_menu,
        size: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        ingredient,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
      ),
      onDeleted: () {
        widget.onIngredientRemoved?.call(ingredient);
      },
      backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      deleteIconColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
    );
  }

  // Validate ingredient input
  bool _isValidIngredient(String ingredient) {
    final trimmed = ingredient.trim();
    if (trimmed.isEmpty) return false;
    if (trimmed.length < 2) return false;
    if (RegExp(r'^[0-9]+$').hasMatch(trimmed)) return false; // Only numbers
    if (RegExp(r'[!@#$%^&*()_+=\[\]{}|;:,.<>?]').hasMatch(trimmed)) return false; // Special chars
    return true;
  }

  // Add ingredient with validation
  void _addIngredient() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;

    // Split by common separators and add each ingredient
    final ingredients = text
        .split(RegExp(r'[,;]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty && _isValidIngredient(e))
        .toList();
    
    for (final ingredient in ingredients) {
      final normalizedIngredient = _normalizeIngredient(ingredient);
      if (!widget.selectedIngredients.contains(normalizedIngredient)) {
        widget.onIngredientAdded(normalizedIngredient);
      }
    }
    
    widget.controller.clear();
    _hideSuggestions();
    _focusNode.requestFocus();
  }

  // Normalize ingredient name
  String _normalizeIngredient(String ingredient) {
    return ingredient.toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty 
            ? word[0].toUpperCase() + word.substring(1) 
            : word)
        .join(' ');
  }

  // Toggle voice input
  void _toggleVoiceInput() {
    if (!_speechEnabled) return;

    if (_isListening) {
      _stopVoiceInput();
    } else {
      _startVoiceInput();
    }
  }

  // Start voice input
  void _startVoiceInput() async {
    if (!_speechEnabled) return;

    setState(() {
      _isListening = true;
      _lastWords = '';
    });

    _pulseController.repeat(reverse: true);

    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      localeId: 'en_US',
      onSoundLevelChange: (level) {
        // Could use this for visual feedback
      },
    );
  }

  // Stop voice input
  void _stopVoiceInput() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
    _pulseController.stop();
  }

  // Handle speech recognition results
  void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
      if (result.finalResult) {
        widget.controller.text = _lastWords;
        _isListening = false;
        _pulseController.stop();
        
        // Auto-add if it's a valid ingredient
        if (_isValidIngredient(_lastWords)) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _addIngredient();
          });
        }
      }
    });
  }
}