import 'package:flutter/material.dart';

import '../../../../domain/entities/nutrition_tracking.dart';

class NutritionProgressCard extends StatelessWidget {
  final NutritionProgress progress;
  final NutritionGoal goal;

  const NutritionProgressCard({
    super.key,
    required this.progress,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Daily Progress',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getScoreColor(progress.overallScore),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${progress.overallScore.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Macronutrient Progress
            _buildNutrientProgress(
              'Calories',
              progress.consumed.calories,
              progress.goals.dailyCalories,
              progress.percentageAchieved['calories'] ?? 0,
              Colors.blue,
              'kcal',
            ),
            const SizedBox(height: 12),
            
            _buildNutrientProgress(
              'Protein',
              progress.consumed.protein,
              progress.goals.proteinGrams,
              progress.percentageAchieved['protein'] ?? 0,
              Colors.red,
              'g',
            ),
            const SizedBox(height: 12),
            
            _buildNutrientProgress(
              'Carbs',
              progress.consumed.carbs,
              progress.goals.carbsGrams,
              progress.percentageAchieved['carbs'] ?? 0,
              Colors.orange,
              'g',
            ),
            const SizedBox(height: 12),
            
            _buildNutrientProgress(
              'Fat',
              progress.consumed.fat,
              progress.goals.fatGrams,
              progress.percentageAchieved['fat'] ?? 0,
              Colors.purple,
              'g',
            ),
            const SizedBox(height: 12),
            
            _buildNutrientProgress(
              'Fiber',
              progress.consumed.fiber,
              progress.goals.fiberGrams,
              progress.percentageAchieved['fiber'] ?? 0,
              Colors.green,
              'g',
            ),

            // Deficiencies and Excesses
            if (progress.deficiencies.isNotEmpty || progress.excesses.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              
              if (progress.deficiencies.isNotEmpty) ...[
                Row(
                  children: [
                    const Icon(Icons.trending_down, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Low in:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: progress.deficiencies.map((deficiency) => Chip(
                    label: Text(
                      deficiency.nutrient,
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Colors.orange[100],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
              ],
              
              if (progress.excesses.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.trending_up, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'High in:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: progress.excesses.map((excess) => Chip(
                    label: Text(
                      excess.nutrient,
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Colors.red[100],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientProgress(
    String name,
    double consumed,
    double target,
    double percentage,
    Color color,
    String unit,
  ) {
    final progress = (percentage / 100).clamp(0.0, 1.5);
    final isExcess = percentage > 120;
    final isDeficient = percentage < 80;
    
    Color progressColor = color;
    if (isExcess) {
      progressColor = Colors.red;
    } else if (isDeficient) {
      progressColor = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              '${consumed.toStringAsFixed(0)} / ${target.toStringAsFixed(0)} $unit',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            if (progress > 1.0)
              Positioned(
                right: 0,
                child: Container(
                  height: 8,
                  width: 2,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 85) return Colors.green;
    if (score >= 70) return Colors.orange;
    return Colors.red;
  }
}