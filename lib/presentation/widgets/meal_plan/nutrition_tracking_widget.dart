import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/meal_plan.dart';
import '../../../application/providers/meal_planner_provider.dart';

class NutritionTrackingWidget extends ConsumerWidget {
  final NutritionSummary? nutritionSummary;
  final bool showDetailed;

  const NutritionTrackingWidget({
    super.key,
    this.nutritionSummary,
    this.showDetailed = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (nutritionSummary == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                Icons.analytics_outlined,
                size: 48,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 8),
              Text(
                'No nutrition data available',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Nutrition Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (!showDetailed)
                  TextButton(
                    onPressed: () => _showDetailedNutrition(context),
                    child: const Text('View Details'),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // Macronutrient overview
            _buildMacronutrientChart(theme),

            const SizedBox(height: 16),

            // Daily averages
            _buildDailyAverages(theme),

            if (showDetailed) ...[
              const SizedBox(height: 16),
              _buildDetailedBreakdown(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMacronutrientChart(ThemeData theme) {
    final totalCalories = nutritionSummary!.dailyAverages['calories'] ?? 0;
    final protein = nutritionSummary!.dailyAverages['protein'] ?? 0;
    final carbs = nutritionSummary!.dailyAverages['carbs'] ?? 0;
    final fat = nutritionSummary!.dailyAverages['fat'] ?? 0;

    // Calculate percentages
    final proteinCalories = protein * 4; // 4 calories per gram
    final carbCalories = carbs * 4; // 4 calories per gram
    final fatCalories = fat * 9; // 9 calories per gram
    final totalMacroCalories = proteinCalories + carbCalories + fatCalories;

    final proteinPercent =
        totalMacroCalories > 0 ? (proteinCalories / totalMacroCalories) : 0;
    final carbPercent =
        totalMacroCalories > 0 ? (carbCalories / totalMacroCalories) : 0;
    final fatPercent =
        totalMacroCalories > 0 ? (fatCalories / totalMacroCalories) : 0;

    return Column(
      children: [
        // Macronutrient bars
        Row(
          children: [
            Expanded(
              flex: (proteinPercent * 100).round(),
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(4)),
                ),
              ),
            ),
            Expanded(
              flex: (carbPercent * 100).round(),
              child: Container(
                height: 8,
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: (fatPercent * 100).round(),
              child: Container(
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(4)),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Legend and values
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMacroItem(
              'Protein',
              '${protein.toInt()}g',
              '${(proteinPercent * 100).toInt()}%',
              Colors.blue,
              theme,
            ),
            _buildMacroItem(
              'Carbs',
              '${carbs.toInt()}g',
              '${(carbPercent * 100).toInt()}%',
              Colors.green,
              theme,
            ),
            _buildMacroItem(
              'Fat',
              '${fat.toInt()}g',
              '${(fatPercent * 100).toInt()}%',
              Colors.orange,
              theme,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroItem(String label, String amount, String percentage,
      Color color, ThemeData theme) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          percentage,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyAverages(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Averages',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildNutritionStat(
                  'Calories',
                  '${nutritionSummary!.dailyAverages['calories']?.toInt() ?? 0}',
                  'kcal',
                  Icons.local_fire_department,
                  Colors.red,
                  theme,
                ),
              ),
              Expanded(
                child: _buildNutritionStat(
                  'Fiber',
                  '${nutritionSummary!.dailyAverages['fiber']?.toInt() ?? 0}',
                  'g',
                  Icons.grass,
                  Colors.green,
                  theme,
                ),
              ),
              Expanded(
                child: _buildNutritionStat(
                  'Sodium',
                  '${(nutritionSummary!.dailyAverages['sodium'] ?? 0).toInt()}',
                  'mg',
                  Icons.opacity,
                  Colors.blue,
                  theme,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionStat(
    String label,
    String value,
    String unit,
    IconData icon,
    Color color,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$label ($unit)',
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDetailedBreakdown(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Totals',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Total Calories',
            '${nutritionSummary!.totalCalories.toInt()} kcal', theme),
        _buildDetailRow('Total Protein',
            '${nutritionSummary!.totalProtein.toInt()} g', theme),
        _buildDetailRow(
            'Total Carbs', '${nutritionSummary!.totalCarbs.toInt()} g', theme),
        _buildDetailRow(
            'Total Fat', '${nutritionSummary!.totalFat.toInt()} g', theme),
        _buildDetailRow(
            'Total Fiber', '${nutritionSummary!.totalFiber.toInt()} g', theme),
        _buildDetailRow('Total Sodium',
            '${nutritionSummary!.totalSodium.toInt()} mg', theme),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailedNutrition(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Detailed Nutrition',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: NutritionTrackingWidget(
                      nutritionSummary: nutritionSummary,
                      showDetailed: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
