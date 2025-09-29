import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class CookingSteps extends StatefulWidget {
  final List<Map<String, dynamic>> steps;
  final bool isInteractive;
  final ValueChanged<int>? onStepCompleted;

  const CookingSteps({
    super.key,
    required this.steps,
    this.isInteractive = false,
    this.onStepCompleted,
  });

  @override
  State<CookingSteps> createState() => _CookingStepsState();
}

class _CookingStepsState extends State<CookingSteps> {
  final Set<int> _completedSteps = <int>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        
        ...widget.steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final stepNumber = step['step'] ?? index + 1;
          final isCompleted = _completedSteps.contains(stepNumber);

          return _buildStepCard(
            stepNumber,
            step['instruction'] ?? '',
            step['duration'],
            step['temperature'],
            step['tips'],
            isCompleted,
            theme,
          );
        }),
      ],
    );
  }

  Widget _buildStepCard(
    int stepNumber,
    String instruction,
    dynamic duration,
    String? temperature,
    List<String>? tips,
    bool isCompleted,
    ThemeData theme,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step header
            Row(
              children: [
                // Step number circle
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? Colors.green
                        : theme.colorScheme.primary,
                  ),
                  child: Center(
                    child: widget.isInteractive && isCompleted
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : Text(
                            stepNumber.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                
                Expanded(
                  child: Text(
                    'Step $stepNumber',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),

                // Step metadata
                if (duration != null || temperature != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (duration != null) ...[
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(duration),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                      if (duration != null && temperature != null)
                        const SizedBox(width: 8),
                      if (temperature != null) ...[
                        Icon(
                          Icons.thermostat,
                          size: 16,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          temperature,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ],
                  ),

                // Complete button for interactive mode
                if (widget.isInteractive)
                  IconButton(
                    onPressed: () => _toggleStepCompletion(stepNumber),
                    icon: Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isCompleted ? Colors.green : null,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Step instruction
            Text(
              instruction,
              style: theme.textTheme.bodyMedium?.copyWith(
                decoration: isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: isCompleted
                    ? theme.colorScheme.onSurface.withOpacity(0.6)
                    : null,
              ),
            ),

            // Tips
            if (tips != null && tips.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tips',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ...tips.map((tip) => Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            '• $tip',
                            style: theme.textTheme.bodySmall,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDuration(dynamic duration) {
    if (duration is int) {
      return '${duration}min';
    } else if (duration is String) {
      return duration;
    }
    return '';
  }

  void _toggleStepCompletion(int stepNumber) {
    setState(() {
      if (_completedSteps.contains(stepNumber)) {
        _completedSteps.remove(stepNumber);
      } else {
        _completedSteps.add(stepNumber);
        widget.onStepCompleted?.call(stepNumber);
      }
    });
  }
}

class StepTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback? onComplete;

  const StepTimer({
    super.key,
    required this.duration,
    this.onComplete,
  });

  @override
  State<StepTimer> createState() => _StepTimerState();
}

class _StepTimerState extends State<StepTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final remaining = widget.duration * (1 - _controller.value);
        final minutes = remaining.inMinutes;
        final seconds = remaining.inSeconds % 60;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value: _controller.value,
                  strokeWidth: 2,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _toggleTimer,
                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                iconSize: 20,
              ),
              IconButton(
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh),
                iconSize: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleTimer() {
    setState(() {
      if (_isRunning) {
        _controller.stop();
      } else {
        _controller.forward();
      }
      _isRunning = !_isRunning;
    });
  }

  void _resetTimer() {
    setState(() {
      _controller.reset();
      _isRunning = false;
    });
  }
}