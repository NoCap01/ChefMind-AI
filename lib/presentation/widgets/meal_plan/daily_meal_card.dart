import 'package:flutter/material.dart';

class DailyMealCard extends StatelessWidget {
  final DateTime date;
  final List<Map<String, dynamic>> meals;
  final Function(String)? onAddMeal;
  final Function(String, int)? onEditMeal;
  final Function(String, int)? onDeleteMeal;
  final VoidCallback? onViewDay;

  const DailyMealCard({
    super.key,
    required this.date,
    required this.meals,
    this.onAddMeal,
    this.onEditMeal,
    this.onDeleteMeal,
    this.onViewDay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isToday = _isToday(date);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isToday
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(date),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isToday
                              ? theme.colorScheme.onPrimaryContainer
                              : null,
                        ),
                      ),
                      if (isToday)
                        Text(
                          'Today',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                if (onViewDay != null)
                  IconButton(
                    onPressed: onViewDay,
                    icon: const Icon(Icons.open_in_new),
                  ),
              ],
            ),
          ),

          // Meals
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildMealSection(context, 'Breakfast', 'breakfast',
                    Icons.wb_sunny, Colors.orange),
                const SizedBox(height: 12),
                _buildMealSection(
                    context, 'Lunch', 'lunch', Icons.wb_cloudy, Colors.green),
                const SizedBox(height: 12),
                _buildMealSection(context, 'Dinner', 'dinner',
                    Icons.nightlight_round, Colors.blue),

                // Total nutrition summary
                const SizedBox(height: 16),
                _buildNutritionSummary(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSection(BuildContext context, String title, String type,
      IconData icon, Color color) {
    final theme = Theme.of(context);
    final mealItems = meals.where((meal) => meal['type'] == type).toList();

    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Meal type header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const Spacer(),
                if (onAddMeal != null)
                  IconButton(
                    onPressed: () => onAddMeal!(type),
                    icon: const Icon(Icons.add, size: 16),
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 24, minHeight: 24),
                  ),
              ],
            ),
          ),

          // Meal items
          if (mealItems.isNotEmpty)
            ...mealItems.asMap().entries.map((entry) {
              final index = entry.key;
              final meal = entry.value;
              return _buildMealItem(context, meal, type, index);
            })
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No ${title.toLowerCase()} planned',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMealItem(
      BuildContext context, Map<String, dynamic> meal, String type, int index) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          // Meal image/icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: meal['image'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      meal['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.restaurant, size: 20),
                    ),
                  )
                : const Icon(Icons.restaurant, size: 20),
          ),

          const SizedBox(width: 12),

          // Meal info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['name'] ?? 'Untitled Meal',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (meal['calories'] != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    '${meal['calories']} calories',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onEditMeal != null)
                IconButton(
                  onPressed: () => onEditMeal!(type, index),
                  icon: const Icon(Icons.edit, size: 16),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              if (onDeleteMeal != null)
                IconButton(
                  onPressed: () => onDeleteMeal!(type, index),
                  icon: const Icon(Icons.delete, size: 16),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionSummary(BuildContext context) {
    final theme = Theme.of(context);

    final totalCalories = meals.fold<int>(
      0,
      (sum, meal) => sum + ((meal['calories'] ?? 0) as num).toInt(),
    );

    final totalProtein = meals.fold<int>(
      0,
      (sum, meal) => sum + ((meal['protein'] ?? 0) as num).toInt(),
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNutritionItem(
              context, 'Calories', totalCalories.toString(), 'kcal'),
          _buildNutritionItem(context, 'Protein', totalProtein.toString(), 'g'),
          _buildNutritionItem(context, 'Meals', meals.length.toString(), ''),
        ],
      ),
    );
  }

  Widget _buildNutritionItem(
      BuildContext context, String label, String value, String unit) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          '$value$unit',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return '${weekdays[date.weekday % 7]} ${months[date.month - 1]} ${date.day}';
  }
}
