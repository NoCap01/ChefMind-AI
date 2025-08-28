import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../domain/entities/recipe.dart';
import '../../../../core/theme/design_tokens.dart';

class RecipeInstructionsSection extends StatefulWidget {
  final Recipe recipe;
  final int servings;

  const RecipeInstructionsSection({
    Key? key,
    required this.recipe,
    required this.servings,
  }) : super(key: key);

  @override
  State<RecipeInstructionsSection> createState() => _RecipeInstructionsSectionState();
}

class _RecipeInstructionsSectionState extends State<RecipeInstructionsSection> {
  final Set<int> _completedSteps = {};
  final Map<int, Timer?> _stepTimers = {};
  final Map<int, int> _remainingTimes = {};
  bool _showTimers = true;

  @override
  void dispose() {
    // Cancel all timers
    for (final timer in _stepTimers.values) {
      timer?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            children: [
              Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showTimers = !_showTimers;
                  });
                },
                icon: Icon(
                  _showTimers ? Icons.timer_off : Icons.timer,
                ),
                tooltip: _showTimers ? 'Hide timers' : 'Show timers',
              ),
            ],
          ),
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          // Instructions List
          ...widget.recipe.instructions.asMap().entries.map((entry) {
            final index = entry.key;
            final instruction = entry.value;
            final isCompleted = _completedSteps.contains(index);
            final hasTimer = instruction.duration != null && _showTimers;
            final isTimerRunning = _stepTimers[index]?.isActive ?? false;
            final remainingTime = _remainingTimes[index];
            
            return Card(
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step Header
                    Row(
                      children: [
                        // Step Number
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.green
                                : Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isCompleted
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  )
                                : Text(
                                    '${instruction.stepNumber}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        
                        const SizedBox(width: DesignTokens.spacingMd),
                        
                        // Timer Info
                        if (hasTimer)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignTokens.spacingSm,
                              vertical: DesignTokens.spacing2xs,
                            ),
                            decoration: BoxDecoration(
                              color: isTimerRunning
                                  ? Colors.orange.withOpacity(0.2)
                                  : Theme.of(context).colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: DesignTokens.iconXs,
                                  color: isTimerRunning
                                      ? Colors.orange
                                      : Theme.of(context).colorScheme.onTertiaryContainer,
                                ),
                                const SizedBox(width: DesignTokens.spacing2xs),
                                Text(
                                  isTimerRunning && remainingTime != null
                                      ? _formatTime(remainingTime)
                                      : '${instruction.duration!.inMinutes} min',
                                  style: TextStyle(
                                    color: isTimerRunning
                                        ? Colors.orange
                                        : Theme.of(context).colorScheme.onTertiaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        const Spacer(),
                        
                        // Complete Step Button
                        Checkbox(
                          value: isCompleted,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                _completedSteps.add(index);
                                // Cancel timer if running
                                _stepTimers[index]?.cancel();
                                _stepTimers[index] = null;
                                _remainingTimes.remove(index);
                              } else {
                                _completedSteps.remove(index);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: DesignTokens.spacingMd),
                    
                    // Instruction Text
                    Text(
                      instruction.instruction,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                        color: isCompleted 
                            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                            : null,
                      ),
                    ),
                    
                    // Timer Controls
                    if (hasTimer && !isCompleted)
                      Padding(
                        padding: const EdgeInsets.only(top: DesignTokens.spacingMd),
                        child: Row(
                          children: [
                            if (!isTimerRunning)
                              ElevatedButton.icon(
                                onPressed: () => _startTimer(index, instruction.duration!),
                                icon: const Icon(Icons.play_arrow, size: 18),
                                label: Text('Start ${instruction.duration!.inMinutes}m Timer'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                                  foregroundColor: Theme.of(context).colorScheme.onTertiary,
                                ),
                              )
                            else ...[
                              ElevatedButton.icon(
                                onPressed: () => _pauseTimer(index),
                                icon: const Icon(Icons.pause, size: 18),
                                label: const Text('Pause'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              const SizedBox(width: DesignTokens.spacingSm),
                              OutlinedButton.icon(
                                onPressed: () => _resetTimer(index, instruction.duration!),
                                icon: const Icon(Icons.refresh, size: 18),
                                label: const Text('Reset'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    
                    // Equipment or Notes
                    if (instruction.equipment != null && instruction.equipment!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: DesignTokens.spacingMd),
                        child: Container(
                          padding: const EdgeInsets.all(DesignTokens.spacingSm),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.kitchen,
                                size: DesignTokens.iconSm,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: DesignTokens.spacingSm),
                              Expanded(
                                child: Text(
                                  'Equipment: ${instruction.equipment!.join(', ')}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Progress Summary
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Cooking Progress',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_completedSteps.length}/${widget.recipe.instructions.length}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  LinearProgressIndicator(
                    value: widget.recipe.instructions.isEmpty 
                        ? 0.0 
                        : _completedSteps.length / widget.recipe.instructions.length,
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingMd),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _completedSteps.isEmpty ? null : () {
                            setState(() {
                              _completedSteps.clear();
                              // Cancel all timers
                              for (final timer in _stepTimers.values) {
                                timer?.cancel();
                              }
                              _stepTimers.clear();
                              _remainingTimes.clear();
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset All'),
                        ),
                      ),
                      const SizedBox(width: DesignTokens.spacingMd),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _completedSteps.length == widget.recipe.instructions.length
                              ? () => _showCompletionDialog()
                              : null,
                          icon: const Icon(Icons.celebration),
                          label: const Text('Complete!'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _startTimer(int stepIndex, Duration duration) {
    setState(() {
      _remainingTimes[stepIndex] = duration.inSeconds;
    });
    
    _stepTimers[stepIndex] = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final remaining = _remainingTimes[stepIndex];
        if (remaining != null && remaining > 0) {
          _remainingTimes[stepIndex] = remaining - 1;
        } else {
          timer.cancel();
          _stepTimers[stepIndex] = null;
          _remainingTimes.remove(stepIndex);
          _showTimerCompleteDialog(stepIndex);
        }
      });
    });
  }
  
  void _pauseTimer(int stepIndex) {
    _stepTimers[stepIndex]?.cancel();
    _stepTimers[stepIndex] = null;
  }
  
  void _resetTimer(int stepIndex, Duration duration) {
    _stepTimers[stepIndex]?.cancel();
    _stepTimers[stepIndex] = null;
    _remainingTimes.remove(stepIndex);
  }
  
  void _showTimerCompleteDialog(int stepIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Timer Complete!'),
        content: Text('Step ${stepIndex + 1} timer has finished.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _completedSteps.add(stepIndex);
              });
            },
            child: const Text('Mark Complete'),
          ),
        ],
      ),
    );
  }
  
  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Recipe Complete!'),
        content: Text('Congratulations! You\'ve completed cooking ${widget.recipe.title}.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navigate to rating screen or show rating dialog
            },
            child: const Text('Rate Recipe'),
          ),
        ],
      ),
    );
  }
  
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}