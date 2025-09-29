import 'package:flutter/material.dart';
import '../../../domain/entities/recipe.dart';

class RecipeDetailDialog extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onSave;
  final VoidCallback? onFavorite;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isFavorite;

  const RecipeDetailDialog({
    super.key,
    required this.recipe,
    this.onSave,
    this.onFavorite,
    this.onEdit,
    this.onDelete,
    this.isFavorite = false,
  });

  @override
  State<RecipeDetailDialog> createState() => _RecipeDetailDialogState();
}

class _RecipeDetailDialogState extends State<RecipeDetailDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: screenSize.width * 0.9,
        height: screenSize.height * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.surface,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.recipe.title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      if (widget.onEdit != null)
                        IconButton(
                          onPressed: widget.onEdit,
                          icon: Icon(
                            Icons.edit,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      IconButton(
                        onPressed: widget.onFavorite,
                        icon: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorite
                              ? Colors.red
                              : theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.close,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipe.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer
                          .withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Recipe metadata
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _buildMetadataChip(
                        icon: Icons.schedule,
                        label: '${widget.recipe.totalTime} min',
                        theme: theme,
                      ),
                      _buildMetadataChip(
                        icon: Icons.people,
                        label: '${widget.recipe.metadata.servings} servings',
                        theme: theme,
                      ),
                      _buildMetadataChip(
                        icon: Icons.bar_chart,
                        label: widget.recipe.metadata.difficulty.displayName,
                        theme: theme,
                      ),
                      if (widget.recipe.nutrition != null &&
                          widget.recipe.nutrition!.calories > 0)
                        _buildMetadataChip(
                          icon: Icons.local_fire_department,
                          label: '${widget.recipe.nutrition!.calories} cal',
                          theme: theme,
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab bar
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Ingredients', icon: Icon(Icons.list_alt)),
                Tab(
                    text: 'Instructions',
                    icon: Icon(Icons.format_list_numbered)),
                Tab(text: 'Nutrition', icon: Icon(Icons.analytics)),
              ],
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildIngredientsTab(theme),
                  _buildInstructionsTab(theme),
                  _buildNutritionTab(theme),
                ],
              ),
            ),

            // Action buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: widget.onSave,
                      icon: const Icon(Icons.bookmark),
                      label: const Text('Save Recipe'),
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

  Widget _buildMetadataChip({
    required IconData icon,
    required String label,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsTab(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.recipe.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = widget.recipe.ingredients[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              ingredient.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('${ingredient.quantity} ${ingredient.unit}'),
            trailing: ingredient.isOptional
                ? Chip(
                    label: const Text('Optional'),
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    labelStyle: TextStyle(
                      color: theme.colorScheme.onSecondaryContainer,
                      fontSize: 12,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildInstructionsTab(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.recipe.instructions.length,
      itemBuilder: (context, index) {
        final step = widget.recipe.instructions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          '${step.stepNumber}',
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (step.duration != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer,
                              size: 14,
                              color: theme.colorScheme.onSecondaryContainer,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${step.duration!} min',
                              style: TextStyle(
                                color: theme.colorScheme.onSecondaryContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  step.instruction,
                  style: theme.textTheme.bodyMedium,
                ),
                if (step.tips != null && step.tips!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
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
                              'Tips:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.tips!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNutritionTab(ThemeData theme) {
    final nutrition = widget.recipe.nutrition;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main nutrition facts
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutrition Facts',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Per serving',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const Divider(height: 24),
                  _buildNutritionRow(
                      'Calories', '${nutrition?.calories ?? 0}', 'kcal', theme),
                  _buildNutritionRow(
                      'Protein',
                      nutrition?.protein.toStringAsFixed(1) ?? '0.0',
                      'g',
                      theme),
                  _buildNutritionRow('Carbohydrates',
                      nutrition?.carbs.toStringAsFixed(1) ?? '0.0', 'g', theme),
                  _buildNutritionRow('Fat',
                      nutrition?.fat.toStringAsFixed(1) ?? '0.0', 'g', theme),
                  _buildNutritionRow('Fiber',
                      nutrition?.fiber.toStringAsFixed(1) ?? '0.0', 'g', theme),
                  _buildNutritionRow('Sugar',
                      nutrition?.sugar.toStringAsFixed(1) ?? '0.0', 'g', theme),
                  _buildNutritionRow(
                      'Sodium', '${nutrition?.sodium ?? 0}', 'mg', theme),
                ],
              ),
            ),
          ),

          // Additional nutrition info
          if (nutrition?.vitamins != null &&
              nutrition!.vitamins!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vitamins',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...nutrition.vitamins!.entries.map(
                      (entry) => _buildNutritionRow(
                        entry.key,
                        entry.value.toStringAsFixed(1),
                        'mg',
                        theme,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (nutrition?.minerals != null &&
              nutrition!.minerals!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Minerals',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...nutrition.minerals!.entries.map(
                      (entry) => _buildNutritionRow(
                        entry.key,
                        entry.value.toStringAsFixed(1),
                        'mg',
                        theme,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Recipe tips from cooking steps
          Builder(
            builder: (context) {
              final allTips = widget.recipe.instructions
                  .where((step) => step.tips != null && step.tips!.isNotEmpty)
                  .map((step) => step.tips!)
                  .expand((tips) => [tips])
                  .toList();

              if (allTips.isEmpty) return const SizedBox.shrink();

              return Column(
                children: [
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Recipe Tips',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...allTips.map(
                            (tip) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('💡 ',
                                      style: theme.textTheme.bodyMedium),
                                  Expanded(
                                    child: Text(tip,
                                        style: theme.textTheme.bodyMedium),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(
      String label, String value, String unit, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(
            '$value $unit',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
