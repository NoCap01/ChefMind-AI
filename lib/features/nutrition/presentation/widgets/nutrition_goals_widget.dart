import 'package:flutter/material.dart';

import '../../../../domain/entities/nutrition_tracking.dart';

class NutritionGoalsWidget extends StatelessWidget {
  final NutritionGoal? activeGoal;
  final List<NutritionGoal> allGoals;
  final VoidCallback onCreateGoal;
  final Function(NutritionGoal) onUpdateGoal;
  final Function(String) onSetActive;
  final Function(String) onDeleteGoal;

  const NutritionGoalsWidget({
    super.key,
    this.activeGoal,
    required this.allGoals,
    required this.onCreateGoal,
    required this.onUpdateGoal,
    required this.onSetActive,
    required this.onDeleteGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Active Goal Card
        if (activeGoal != null)
          _buildActiveGoalCard(context, activeGoal!)
        else
          _buildNoActiveGoalCard(context),
        
        const SizedBox(height: 16),
        
        // All Goals List
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'All Goals',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onCreateGoal,
                      icon: const Icon(Icons.add),
                      label: const Text('Create Goal'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                if (allGoals.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('No nutrition goals created yet'),
                    ),
                  )
                else
                  ...allGoals.map((goal) => _buildGoalListItem(context, goal)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveGoalCard(BuildContext context, NutritionGoal goal) {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flag,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Active Goal',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        onUpdateGoal(goal);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(context, goal);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            Text(
              goal.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            
            Text(
              goal.goalType.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            
            // Goal Targets
            _buildGoalTargets(context, goal.targets),
            
            const SizedBox(height: 16),
            
            // Goal Info
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Started ${_formatDate(goal.startDate)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                if (goal.targetWeight > 0) ...[
                  Icon(Icons.monitor_weight, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Target: ${goal.targetWeight.toStringAsFixed(1)} kg',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoActiveGoalCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.flag_outlined,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No Active Goal',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Set a nutrition goal to track your progress and get personalized recommendations.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onCreateGoal,
              icon: const Icon(Icons.add),
              label: const Text('Create Goal'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalListItem(BuildContext context, NutritionGoal goal) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: goal.isActive 
              ? Theme.of(context).primaryColor 
              : Colors.grey[300],
          child: Icon(
            _getGoalTypeIcon(goal.goalType),
            color: goal.isActive ? Colors.white : Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(goal.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(goal.goalType.displayName),
            Text(
              '${goal.targets.dailyCalories.toStringAsFixed(0)} kcal/day',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!goal.isActive)
              TextButton(
                onPressed: () => onSetActive(goal.id),
                child: const Text('Set Active'),
              ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    onUpdateGoal(goal);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, goal);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildGoalTargets(BuildContext context, NutritionGoals targets) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTargetItem(
                  'Calories',
                  '${targets.dailyCalories.toStringAsFixed(0)} kcal',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildTargetItem(
                  'Protein',
                  '${targets.proteinGrams.toStringAsFixed(0)} g',
                  Icons.fitness_center,
                  Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildTargetItem(
                  'Carbs',
                  '${targets.carbsGrams.toStringAsFixed(0)} g',
                  Icons.grain,
                  Colors.orange,
                ),
              ),
              Expanded(
                child: _buildTargetItem(
                  'Fat',
                  '${targets.fatGrams.toStringAsFixed(0)} g',
                  Icons.opacity,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetItem(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getGoalTypeIcon(GoalType goalType) {
    switch (goalType) {
      case GoalType.weightLoss:
        return Icons.trending_down;
      case GoalType.weightGain:
        return Icons.trending_up;
      case GoalType.maintenance:
        return Icons.trending_flat;
      case GoalType.muscleGain:
        return Icons.fitness_center;
      case GoalType.athletic:
        return Icons.sports;
      case GoalType.health:
        return Icons.favorite;
      case GoalType.custom:
        return Icons.tune;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'today';
    } else if (difference == 1) {
      return 'yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else {
      final months = (difference / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    }
  }

  void _showDeleteConfirmation(BuildContext context, NutritionGoal goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Goal'),
        content: Text('Are you sure you want to delete "${goal.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDeleteGoal(goal.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}