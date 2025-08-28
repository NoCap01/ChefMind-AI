import 'package:flutter/material.dart';

import '../../../../domain/entities/nutrition_tracking.dart';

class FoodEntryWidget extends StatelessWidget {
  final FoodEntry foodEntry;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const FoodEntryWidget({
    super.key,
    required this.foodEntry,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Meal Type Icon
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _getMealColor(foodEntry.mealType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _getMealIcon(foodEntry.mealType),
                    size: 16,
                    color: _getMealColor(foodEntry.mealType),
                  ),
                ),
                const SizedBox(width: 8),
                
                // Food Name and Quantity
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        foodEntry.foodName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${foodEntry.quantity} ${foodEntry.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Calories
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${foodEntry.nutrition.calories.toStringAsFixed(0)} kcal',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      _getMealName(foodEntry.mealType),
                      style: TextStyle(
                        fontSize: 10,
                        color: _getMealColor(foodEntry.mealType),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                // Actions
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        onEdit?.call();
                        break;
                      case 'delete':
                        _showDeleteConfirmation(context);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: const Icon(Icons.more_vert, size: 16),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Nutrition Summary
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildNutrientInfo(
                      'Protein',
                      '${foodEntry.nutrition.protein.toStringAsFixed(1)}g',
                      Colors.red,
                    ),
                  ),
                  Expanded(
                    child: _buildNutrientInfo(
                      'Carbs',
                      '${foodEntry.nutrition.carbs.toStringAsFixed(1)}g',
                      Colors.orange,
                    ),
                  ),
                  Expanded(
                    child: _buildNutrientInfo(
                      'Fat',
                      '${foodEntry.nutrition.fat.toStringAsFixed(1)}g',
                      Colors.purple,
                    ),
                  ),
                  if (foodEntry.nutrition.fiber > 0)
                    Expanded(
                      child: _buildNutrientInfo(
                        'Fiber',
                        '${foodEntry.nutrition.fiber.toStringAsFixed(1)}g',
                        Colors.green,
                      ),
                    ),
                ],
              ),
            ),
            
            // Additional Info
            if (foodEntry.brand != null || foodEntry.notes != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  if (foodEntry.brand != null) ...[
                    Icon(Icons.business, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      foodEntry.brand!,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                  if (foodEntry.brand != null && foodEntry.notes != null)
                    const SizedBox(width: 16),
                  if (foodEntry.notes != null) ...[
                    Icon(Icons.note, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        foodEntry.notes!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientInfo(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  IconData _getMealIcon(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Icons.wb_sunny;
      case MealType.lunch:
        return Icons.wb_cloudy;
      case MealType.dinner:
        return Icons.nights_stay;
      case MealType.snack:
        return Icons.local_cafe;
    }
  }

  Color _getMealColor(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Colors.amber;
      case MealType.lunch:
        return Colors.blue;
      case MealType.dinner:
        return Colors.indigo;
      case MealType.snack:
        return Colors.green;
    }
  }

  String _getMealName(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Food Entry'),
        content: Text('Are you sure you want to delete "${foodEntry.foodName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete?.call();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}