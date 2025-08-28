import 'package:flutter/material.dart';
import '../../../../domain/entities/recipe.dart';
import '../../../../domain/entities/recipe_rating.dart';
import '../../../../shared/widgets/star_rating.dart';

class RecipeRatingDialog extends StatefulWidget {
  final Recipe recipe;
  final RecipeRating? existingRating;
  final Function(RecipeRating rating) onRatingSubmitted;

  const RecipeRatingDialog({
    super.key,
    required this.recipe,
    this.existingRating,
    required this.onRatingSubmitted,
  });

  @override
  State<RecipeRatingDialog> createState() => _RecipeRatingDialogState();
}

class _RecipeRatingDialogState extends State<RecipeRatingDialog> {
  late double _overallRating;
  late double _tasteRating;
  late double _difficultyRating;
  late double _instructionsRating;
  late bool _wasSuccessful;
  final _feedbackController = TextEditingController();
  final _notesController = TextEditingController();
  Duration? _actualCookingTime;
  final _cookingTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    if (widget.existingRating != null) {
      _overallRating = widget.existingRating!.rating;
      _wasSuccessful = widget.existingRating!.wasSuccessful;
      _feedbackController.text = widget.existingRating!.feedback ?? '';
      _notesController.text = widget.existingRating!.notes ?? '';
      _actualCookingTime = widget.existingRating!.actualCookingTime;
      if (_actualCookingTime != null) {
        _cookingTimeController.text = _actualCookingTime!.inMinutes.toString();
      }
    } else {
      _overallRating = 5.0;
      _wasSuccessful = true;
    }
    
    _tasteRating = _overallRating;
    _difficultyRating = _overallRating;
    _instructionsRating = _overallRating;
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _notesController.dispose();
    _cookingTimeController.dispose();
    super.dispose();
  }

  void _submitRating() {
    final rating = RecipeRating(
      id: widget.existingRating?.id ?? 
          '${widget.recipe.id}_${DateTime.now().millisecondsSinceEpoch}',
      recipeId: widget.recipe.id,
      userId: 'current_user', // TODO: Get from auth service
      rating: _overallRating,
      feedback: _feedbackController.text.trim().isEmpty ? null : _feedbackController.text.trim(),
      createdAt: widget.existingRating?.createdAt ?? DateTime.now(),
      updatedAt: widget.existingRating != null ? DateTime.now() : null,
      wasSuccessful: _wasSuccessful,
      actualCookingTime: _actualCookingTime,
      notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
      tags: _generateTags(),
    );

    widget.onRatingSubmitted(rating);
    Navigator.of(context).pop();
  }

  List<String> _generateTags() {
    final tags = <String>[];
    
    if (_wasSuccessful) {
      tags.add('successful');
    } else {
      tags.add('needs_improvement');
    }
    
    if (_overallRating >= 4.5) {
      tags.add('excellent');
    } else if (_overallRating >= 3.5) {
      tags.add('good');
    } else if (_overallRating >= 2.5) {
      tags.add('average');
    } else {
      tags.add('poor');
    }
    
    if (_actualCookingTime != null && widget.recipe.cookingTime.inMinutes > 0) {
      final timeDifference = _actualCookingTime!.inMinutes - widget.recipe.cookingTime.inMinutes;
      if (timeDifference > 15) {
        tags.add('took_longer');
      } else if (timeDifference < -15) {
        tags.add('faster_than_expected');
      } else {
        tags.add('accurate_timing');
      }
    }
    
    return tags;
  }

  void _updateCookingTime(String value) {
    final minutes = int.tryParse(value);
    if (minutes != null && minutes > 0) {
      _actualCookingTime = Duration(minutes: minutes);
    } else {
      _actualCookingTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Rate Recipe',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipe.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Success toggle
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _wasSuccessful 
                            ? theme.colorScheme.primaryContainer.withOpacity(0.3)
                            : theme.colorScheme.errorContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _wasSuccessful 
                              ? theme.colorScheme.primary.withOpacity(0.3)
                              : theme.colorScheme.error.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _wasSuccessful ? Icons.check_circle : Icons.error,
                            color: _wasSuccessful 
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How did it turn out?',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    ChoiceChip(
                                      label: const Text('Success!'),
                                      selected: _wasSuccessful,
                                      onSelected: (selected) {
                                        setState(() {
                                          _wasSuccessful = true;
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    ChoiceChip(
                                      label: const Text('Needs work'),
                                      selected: !_wasSuccessful,
                                      onSelected: (selected) {
                                        setState(() {
                                          _wasSuccessful = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Overall rating
                    InteractiveStarRating(
                      rating: _overallRating,
                      onRatingChanged: (rating) {
                        setState(() {
                          _overallRating = rating;
                        });
                      },
                      label: 'Overall Rating',
                      description: 'How would you rate this recipe overall?',
                      size: 36,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Detailed ratings
                    ExpansionTile(
                      title: const Text('Detailed Ratings'),
                      subtitle: const Text('Rate specific aspects (optional)'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              InteractiveStarRating(
                                rating: _tasteRating,
                                onRatingChanged: (rating) {
                                  setState(() {
                                    _tasteRating = rating;
                                  });
                                },
                                label: 'Taste',
                                description: 'How delicious was it?',
                              ),
                              const SizedBox(height: 16),
                              InteractiveStarRating(
                                rating: _difficultyRating,
                                onRatingChanged: (rating) {
                                  setState(() {
                                    _difficultyRating = rating;
                                  });
                                },
                                label: 'Difficulty',
                                description: 'How challenging was it to make?',
                              ),
                              const SizedBox(height: 16),
                              InteractiveStarRating(
                                rating: _instructionsRating,
                                onRatingChanged: (rating) {
                                  setState(() {
                                    _instructionsRating = rating;
                                  });
                                },
                                label: 'Instructions',
                                description: 'How clear were the instructions?',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Cooking time
                    TextField(
                      controller: _cookingTimeController,
                      decoration: InputDecoration(
                        labelText: 'Actual Cooking Time (minutes)',
                        hintText: 'How long did it actually take?',
                        helperText: 'Recipe estimated: ${widget.recipe.cookingTime.inMinutes} minutes',
                        prefixIcon: const Icon(Icons.timer),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _updateCookingTime,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Feedback
                    TextField(
                      controller: _feedbackController,
                      decoration: const InputDecoration(
                        labelText: 'Feedback (optional)',
                        hintText: 'What did you think about this recipe?',
                        prefixIcon: Icon(Icons.comment),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Notes
                    TextField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        hintText: 'Any modifications or tips for next time?',
                        prefixIcon: Icon(Icons.note),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            
            // Actions
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _submitRating,
                    child: Text(widget.existingRating != null ? 'Update Rating' : 'Submit Rating'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}