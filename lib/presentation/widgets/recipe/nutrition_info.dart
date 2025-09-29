import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';

class NutritionInfo extends StatelessWidget {
  final Map<String, dynamic> nutrition;
  final bool showDetailed;

  const NutritionInfo({
    super.key,
    required this.nutrition,
    this.showDetailed = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrition Information',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                // Main macros
                Row(
                  children: [
                    Expanded(
                      child: _buildNutritionItem(
                        'Calories',
                        '${nutrition['calories'] ?? 0}',
                        'kcal',
                        Colors.orange,
                      ),
                    ),
                    Expanded(
                      child: _buildNutritionItem(
                        'Protein',
                        '${nutrition['protein'] ?? 0}',
                        'g',
                        Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                Row(
                  children: [
                    Expanded(
                      child: _buildNutritionItem(
                        'Carbs',
                        '${nutrition['carbs'] ?? 0}',
                        'g',
                        Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: _buildNutritionItem(
                        'Fat',
                        '${nutrition['fat'] ?? 0}',
                        'g',
                        Colors.green,
                      ),
                    ),
                  ],
                ),

                if (showDetailed) ...[
                  const SizedBox(height: AppConstants.defaultPadding),
                  const Divider(),
                  const SizedBox(height: AppConstants.defaultPadding),

                  // Additional nutrients
                  if (nutrition['fiber'] != null)
                    _buildDetailedNutritionRow(
                        'Fiber', '${nutrition['fiber']}g'),
                  if (nutrition['sugar'] != null)
                    _buildDetailedNutritionRow(
                        'Sugar', '${nutrition['sugar']}g'),
                  if (nutrition['sodium'] != null)
                    _buildDetailedNutritionRow(
                        'Sodium', '${nutrition['sodium']}mg'),
                  if (nutrition['cholesterol'] != null)
                    _buildDetailedNutritionRow(
                        'Cholesterol', '${nutrition['cholesterol']}mg'),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionItem(
      String label, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class NutritionChart extends StatelessWidget {
  final Map<String, dynamic> nutrition;
  final double size;

  const NutritionChart({
    super.key,
    required this.nutrition,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalMacros = (nutrition['protein'] ?? 0) +
        (nutrition['carbs'] ?? 0) +
        (nutrition['fat'] ?? 0);

    if (totalMacros == 0) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.surfaceContainerHighest,
        ),
        child: const Center(
          child: Text('No data'),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Pie chart would go here - simplified for now
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Colors.red.withOpacity(0.7),
                  Colors.blue.withOpacity(0.7),
                  Colors.green.withOpacity(0.7),
                ],
                stops: [
                  (nutrition['protein'] ?? 0) / totalMacros,
                  ((nutrition['protein'] ?? 0) + (nutrition['carbs'] ?? 0)) /
                      totalMacros,
                  1.0,
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: size * 0.6,
              height: size * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${nutrition['calories'] ?? 0}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'kcal',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
