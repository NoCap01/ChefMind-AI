import 'package:flutter/material.dart';

import '../../../../domain/entities/recipe.dart';
import '../../../../core/theme/design_tokens.dart';

class RecipeNutritionSection extends StatelessWidget {
  final Recipe recipe;
  final int servings;

  const RecipeNutritionSection({
    Key? key,
    required this.recipe,
    required this.servings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scalingFactor = servings / recipe.servings;
    final nutrition = recipe.nutrition;
    
    if (nutrition == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(DesignTokens.spacingLg),
          child: Text(
            'Nutrition information not available for this recipe.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Text(
            'Nutrition Information',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingSm),
          
          Text(
            'Per serving (${servings} servings total)',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Calories Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.local_fire_department,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingLg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Calories',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(nutrition.calories * scalingFactor / servings).round()} kcal',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Macronutrients
          Text(
            'Macronutrients',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          Row(
            children: [
              Expanded(
                child: _buildMacroCard(
                  context,
                  'Protein',
                  '${(nutrition.protein * scalingFactor / servings).toStringAsFixed(1)}g',
                  Colors.red,
                  Icons.fitness_center,
                ),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: _buildMacroCard(
                  context,
                  'Carbs',
                  '${(nutrition.carbohydrates * scalingFactor / servings).toStringAsFixed(1)}g',
                  Colors.orange,
                  Icons.grain,
                ),
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              Expanded(
                child: _buildMacroCard(
                  context,
                  'Fat',
                  '${(nutrition.fat * scalingFactor / servings).toStringAsFixed(1)}g',
                  Colors.yellow.shade700,
                  Icons.opacity,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Detailed Nutrition
          Text(
            'Detailed Nutrition',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                children: [
                  _buildNutritionRow(
                    context,
                    'Fiber',
                    '${(nutrition.fiber * scalingFactor / servings).toStringAsFixed(1)}g',
                    Icons.eco,
                  ),
                  const Divider(),
                  _buildNutritionRow(
                    context,
                    'Sugar',
                    '${(nutrition.sugar * scalingFactor / servings).toStringAsFixed(1)}g',
                    Icons.cake,
                  ),
                  const Divider(),
                  _buildNutritionRow(
                    context,
                    'Sodium',
                    '${(nutrition.sodium * scalingFactor / servings).toStringAsFixed(0)}mg',
                    Icons.water_drop,
                  ),
                  const Divider(),
                  _buildNutritionRow(
                    context,
                    'Cholesterol',
                    '${(nutrition.cholesterol * scalingFactor / servings).toStringAsFixed(0)}mg',
                    Icons.favorite,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Vitamins & Minerals (if available)
          if (nutrition.vitamins != null && nutrition.vitamins!.isNotEmpty) ...[
            Text(
              'Vitamins & Minerals',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: DesignTokens.spacingMd),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacingLg),
                child: Column(
                  children: nutrition.vitamins!.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing2xs),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_pharmacy,
                            size: DesignTokens.iconSm,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: DesignTokens.spacingSm),
                          Expanded(
                            child: Text(
                              entry.key,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Text(
                            '${(entry.value * scalingFactor / servings).toStringAsFixed(1)}mg',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            const SizedBox(height: DesignTokens.spacingLg),
          ],
          
          // Nutrition Notes
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: DesignTokens.spacingSm),
                      Text(
                        'Nutrition Notes',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  Text(
                    '• Values are approximate and may vary based on specific ingredients used\n'
                    '• Nutrition information is calculated per serving\n'
                    '• Daily values are based on a 2000 calorie diet',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: DesignTokens.spacingLg),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _exportNutritionInfo(context),
                  icon: const Icon(Icons.download),
                  label: const Text('Export'),
                ),
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _shareNutritionInfo(context),
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildMacroCard(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNutritionRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacing2xs),
      child: Row(
        children: [
          Icon(
            icon,
            size: DesignTokens.iconSm,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: DesignTokens.spacingSm),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
  
  void _exportNutritionInfo(BuildContext context) {
    // TODO: Implement export functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export functionality coming soon!'),
      ),
    );
  }
  
  void _shareNutritionInfo(BuildContext context) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon!'),
      ),
    );
  }
}