import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../../../../domain/entities/recipe.dart';
import '../../../../core/theme/design_tokens.dart';

class CookingModeWidget extends StatefulWidget {
  final Recipe recipe;
  final int servings;
  final VoidCallback onExitCookingMode;

  const CookingModeWidget({
    Key? key,
    required this.recipe,
    required this.servings,
    required this.onExitCookingMode,
  }) : super(key: key);

  @override
  State<CookingModeWidget> createState() => _CookingModeWidgetState();
}

class _CookingModeWidgetState extends State<CookingModeWidget> {
  late PageController _pageController;
  int _currentStep = 0;
  bool _isTimerRunning = false;
  Timer? _stepTimer;
  int _remainingTime = 0;
  bool _keepScreenOn = true;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    // Keep screen on during cooking mode
    if (_keepScreenOn) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }
  
  @override
  void dispose() {
    _stepTimer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showExitDialog(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cooking Mode',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.recipe.title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Step indicator
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                      vertical: DesignTokens.spacingSm,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                    ),
                    child: Text(
                      '${_currentStep + 1}/${widget.recipe.instructions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Progress Bar
            LinearProgressIndicator(
              value: widget.recipe.instructions.isEmpty 
                  ? 0.0 
                  : (_currentStep + 1) / widget.recipe.instructions.length,
              backgroundColor: Colors.grey.shade800,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            
            // Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                    _stopTimer();
                  });
                },
                itemCount: widget.recipe.instructions.length,
                itemBuilder: (context, index) {
                  final instruction = widget.recipe.instructions[index];
                  return _buildStepContent(instruction, index);
                },
              ),
            ),
            
            // Navigation Controls
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Previous Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _currentStep > 0 ? _previousStep : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingMd),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: DesignTokens.spacingMd),
                  
                  // Timer Button (if step has timer)
                  if (widget.recipe.instructions[_currentStep].duration != null)
                    ElevatedButton.icon(
                      onPressed: _isTimerRunning ? _stopTimer : _startTimer,
                      icon: Icon(_isTimerRunning ? Icons.pause : Icons.play_arrow),
                      label: Text(_isTimerRunning ? 'Pause' : 'Timer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isTimerRunning ? Colors.orange : Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacingLg,
                          vertical: DesignTokens.spacingMd,
                        ),
                      ),
                    ),
                  
                  if (widget.recipe.instructions[_currentStep].duration != null)
                    const SizedBox(width: DesignTokens.spacingMd),
                  
                  // Next Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _currentStep < widget.recipe.instructions.length - 1 
                          ? _nextStep 
                          : _completeRecipe,
                      icon: Icon(
                        _currentStep < widget.recipe.instructions.length - 1 
                            ? Icons.arrow_forward 
                            : Icons.check,
                      ),
                      label: Text(
                        _currentStep < widget.recipe.instructions.length - 1 
                            ? 'Next' 
                            : 'Complete',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingMd),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStepContent(Instruction instruction, int stepIndex) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Number
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${instruction.stepNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Timer Display (if running)
          if (_isTimerRunning && stepIndex == _currentStep)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              margin: const EdgeInsets.only(bottom: DesignTokens.spacingLg),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.orange,
                    size: 48,
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  Text(
                    _formatTime(_remainingTime),
                    style: const TextStyle(
                      color: Colors.orange,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'Timer Running',
                    style: TextStyle(
                      color: Colors.orange.shade300,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          
          // Instruction Text
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spacingLg),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
            ),
            child: Text(
              instruction.instruction,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Duration Info
          if (instruction.duration != null)
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(color: Colors.blue.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule, color: Colors.blue),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Text(
                    'Estimated time: ${instruction.duration!.inMinutes} minutes',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          
          // Equipment Info
          if (instruction.equipment != null && instruction.equipment!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: DesignTokens.spacingMd),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacingMd),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(color: Colors.green.withOpacity(0.5)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.kitchen, color: Colors.green),
                    const SizedBox(width: DesignTokens.spacingSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Equipment needed:',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing2xs),
                          Text(
                            instruction.equipment!.join(', '),
                            style: TextStyle(
                              color: Colors.green.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: DesignTokens.spacingXl),
          
          // Quick Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showIngredients(),
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Ingredients'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _toggleScreenOn(),
                  icon: Icon(_keepScreenOn ? Icons.screen_lock_portrait : Icons.screen_lock_rotation),
                  label: Text(_keepScreenOn ? 'Screen On' : 'Screen Off'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _nextStep() {
    if (_currentStep < widget.recipe.instructions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _startTimer() {
    final instruction = widget.recipe.instructions[_currentStep];
    if (instruction.duration != null) {
      setState(() {
        _isTimerRunning = true;
        _remainingTime = instruction.duration!.inSeconds;
      });
      
      _stepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            _stopTimer();
            _showTimerCompleteDialog();
          }
        });
      });
    }
  }
  
  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _stepTimer?.cancel();
    _stepTimer = null;
  }
  
  void _completeRecipe() {
    _stopTimer();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Recipe Complete!'),
        content: Text('Congratulations! You\'ve completed cooking ${widget.recipe.title}.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onExitCookingMode();
            },
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onExitCookingMode();
              // TODO: Navigate to rating screen
            },
            child: const Text('Rate Recipe'),
          ),
        ],
      ),
    );
  }
  
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Cooking Mode?'),
        content: const Text('Are you sure you want to exit cooking mode? Any running timers will be stopped.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onExitCookingMode();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
  
  void _showTimerCompleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⏰ Timer Complete!'),
        content: Text('Step ${_currentStep + 1} timer has finished.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          if (_currentStep < widget.recipe.instructions.length - 1)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _nextStep();
              },
              child: const Text('Next Step'),
            ),
        ],
      ),
    );
  }
  
  void _showIngredients() {
    final scalingFactor = widget.servings / widget.recipe.servings;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      builder: (context) => Container(
        padding: const EdgeInsets.all(DesignTokens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ingredients (${widget.servings} servings)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = widget.recipe.ingredients[index];
                  final scaledQuantity = ingredient.quantity * scalingFactor;
                  
                  return ListTile(
                    leading: const Icon(Icons.circle, color: Colors.white, size: 8),
                    title: Text(
                      ingredient.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      '${scaledQuantity.toStringAsFixed(1)} ${ingredient.unit}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _toggleScreenOn() {
    setState(() {
      _keepScreenOn = !_keepScreenOn;
    });
    
    if (_keepScreenOn) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }
  
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}