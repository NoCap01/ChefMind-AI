import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../domain/entities/nutrition_tracking.dart';

class DailyNutritionChart extends StatelessWidget {
  final NutritionEntry entry;
  final NutritionGoals? goals;

  const DailyNutritionChart({
    super.key,
    required this.entry,
    this.goals,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nutrition Breakdown',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Macronutrient Pie Chart
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        sections: _buildPieChartSections(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLegendItem('Protein', Colors.red, entry.totalNutrition.protein, 'g'),
                        const SizedBox(height: 8),
                        _buildLegendItem('Carbs', Colors.orange, entry.totalNutrition.carbs, 'g'),
                        const SizedBox(height: 8),
                        _buildLegendItem('Fat', Colors.purple, entry.totalNutrition.fat, 'g'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Meal Breakdown
            if (entry.mealBreakdown.isNotEmpty) ...[
              Text(
                'Meals',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              ...entry.mealBreakdown.entries.map((mealEntry) => 
                _buildMealBreakdownItem(mealEntry.key, mealEntry.value),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    final nutrition = entry.totalNutrition;
    
    // Calculate calories from macros
    final proteinCalories = nutrition.protein * 4;
    final carbCalories = nutrition.carbs * 4;
    final fatCalories = nutrition.fat * 9;
    final totalMacroCalories = proteinCalories + carbCalories + fatCalories;
    
    if (totalMacroCalories == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 1,
          title: 'No data',
          radius: 50,
        ),
      ];
    }

    return [
      PieChartSectionData(
        color: Colors.red,
        value: proteinCalories,
        title: '${(proteinCalories / totalMacroCalories * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: carbCalories,
        title: '${(carbCalories / totalMacroCalories * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: fatCalories,
        title: '${(fatCalories / totalMacroCalories * 100).toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildLegendItem(String label, Color color, double value, String unit) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${value.toStringAsFixed(0)} $unit',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMealBreakdownItem(MealType mealType, NutritionInfo nutrition) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            _getMealIcon(mealType),
            size: 16,
            color: _getMealColor(mealType),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getMealName(mealType),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Text(
            '${nutrition.calories.toStringAsFixed(0)} kcal',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
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
}