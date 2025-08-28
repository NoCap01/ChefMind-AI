import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../domain/entities/recipe.dart';
import '../../../../core/theme/design_tokens.dart';

class RecipeDisplayWidget extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onSave;
  final VoidCallback? onShare;
  final Function(double)? onRate;

  const RecipeDisplayWidget({
    Key? key,
    required this.recipe,
    this.onSave,
    this.onShare,
    this.onRate,
  }) : super(key: key);

  @override
  State<RecipeDisplayWidget> createState() => _RecipeDisplayWidgetState();
}

class _RecipeDisplayWidgetState extends State<RecipeDisplayWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _currentRating = 0.0;
  bool _showRatingDialog = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _currentRating = widget.recipe.rating;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recipe Header
          _buildRecipeHeader(),
          
          // Recipe Tabs
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Ingredients', icon: Icon(Icons.list_alt)),
              Tab(text: 'Instructions', icon: Icon(Icons.receipt_long)),
              Tab(text: 'Details', icon: Icon(Icons.info_outline)),
            ],
          ),
          
          // Tab Content
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildIngredientsTab(),
                _buildInstructionsTab(),
                _buildDetailsTab(),
              ],
            ),
          ),
          
          // Action Buttons
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildRecipeHeader() {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(DesignTokens.radiusLg),
          topRight: Radius.circular(DesignTokens.radiusLg),
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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacingMd,
                  vertical: DesignTokens.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(widget.recipe.difficulty),
                  borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
                ),
                child: Text(
                  widget.recipe.difficulty.displayName,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          if (widget.recipe.description.isNotEmpty) ...[
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              widget.recipe.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
          
          const SizedBox(height: DesignTokens.spacingMd),
          
          // Recipe Stats
          Row(
            children: [
              _buildStatChip(
                icon: Icons.schedule,
                label: '${widget.recipe.cookingTime.inMinutes + widget.recipe.prepTime.inMinutes} min',
                tooltip: 'Total time (prep + cook)',
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              _buildStatChip(
                icon: Icons.people,
                label: '${widget.recipe.servings} servings',
                tooltip: 'Number of servings',
              ),
              const SizedBox(width: DesignTokens.spacingSm),
              if (widget.recipe.rating > 0)
                _buildStatChip(
                  icon: Icons.star,
                  label: widget.recipe.rating.toStringAsFixed(1),
                  tooltip: 'Recipe rating',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip({
    required IconData icon,
    required String label,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingMd,
          vertical: DesignTokens.spacingSm,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: DesignTokens.iconSm,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: DesignTokens.spacingXs),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      itemCount: widget.recipe.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = widget.recipe.ingredients[index];
        return Card(
          margin: const EdgeInsets.only(bottom: DesignTokens.spacingSm),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              ingredient.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${ingredient.quantity} ${ingredient.unit}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            trailing: ingredient.isOptional
                ? Chip(
                    label: const Text('Optional'),
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 12,
                    ),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildInstructionsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      itemCount: widget.recipe.instructions.length,
      itemBuilder: (context, index) {
        final instruction = widget.recipe.instructions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${instruction.stepNumber}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacingMd),
                    if (instruction.duration != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacingSm,
                          vertical: DesignTokens.spacing2xs,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.timer,
                              size: DesignTokens.iconXs,
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: DesignTokens.spacing2xs),
                            Text(
                              '${instruction.duration!.inMinutes} min',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onTertiaryContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spacingMd),
                Text(
                  instruction.instruction,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nutrition Information
          if (widget.recipe.nutrition.calories > 0) ...[
            _buildSectionHeader('Nutrition Information'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(DesignTokens.spacingLg),
                child: Column(
                  children: [
                    _buildNutritionRow('Calories', '${widget.recipe.nutrition.calories.toInt()}', 'kcal'),
                    _buildNutritionRow('Protein', '${widget.recipe.nutrition.protein.toInt()}', 'g'),
                    _buildNutritionRow('Carbs', '${widget.recipe.nutrition.carbs.toInt()}', 'g'),
                    _buildNutritionRow('Fat', '${widget.recipe.nutrition.fat.toInt()}', 'g'),
                    if (widget.recipe.nutrition.fiber > 0)
                      _buildNutritionRow('Fiber', '${widget.recipe.nutrition.fiber.toInt()}', 'g'),
                    if (widget.recipe.nutrition.sodium > 0)
                      _buildNutritionRow('Sodium', '${widget.recipe.nutrition.sodium.toInt()}', 'mg'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingLg),
          ],
          
          // Recipe Tags
          if (widget.recipe.tags.isNotEmpty) ...[
            _buildSectionHeader('Tags'),
            Wrap(
              spacing: DesignTokens.spacingSm,
              runSpacing: DesignTokens.spacingSm,
              children: widget.recipe.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                );
              }).toList(),
            ),
            const SizedBox(height: DesignTokens.spacingLg),
          ],
          
          // Recipe Tips
          if (widget.recipe.tips.isNotEmpty) ...[
            _buildSectionHeader('Tips & Tricks'),
            ...widget.recipe.tips.map((tip) {
              return Card(
                margin: const EdgeInsets.only(bottom: DesignTokens.spacingSm),
                child: ListTile(
                  leading: Icon(
                    Icons.lightbulb_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(tip),
                ),
              );
            }).toList(),
            const SizedBox(height: DesignTokens.spacingLg),
          ],
          
          // Recipe Metadata
          _buildSectionHeader('Recipe Details'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingLg),
              child: Column(
                children: [
                  _buildDetailRow('Prep Time', '${widget.recipe.prepTime.inMinutes} minutes'),
                  _buildDetailRow('Cook Time', '${widget.recipe.cookingTime.inMinutes} minutes'),
                  _buildDetailRow('Total Time', '${widget.recipe.prepTime.inMinutes + widget.recipe.cookingTime.inMinutes} minutes'),
                  _buildDetailRow('Servings', '${widget.recipe.servings}'),
                  _buildDetailRow('Difficulty', widget.recipe.difficulty.displayName),
                  _buildDetailRow('Created', _formatDate(widget.recipe.createdAt)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '$value $unit',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onSave,
              icon: const Icon(Icons.bookmark_add),
              label: const Text('Save Recipe'),
            ),
          ),
          const SizedBox(width: DesignTokens.spacingMd),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onShare,
              icon: const Icon(Icons.share),
              label: const Text('Share'),
            ),
          ),
          const SizedBox(width: DesignTokens.spacingMd),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _showRatingDialog,
              icon: const Icon(Icons.star),
              label: const Text('Rate'),
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rate this Recipe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How would you rate this recipe?'),
            const SizedBox(height: DesignTokens.spacingLg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starValue = index + 1.0;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentRating = starValue;
                    });
                  },
                  child: Icon(
                    starValue <= _currentRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                );
              }),
            ),
            const SizedBox(height: DesignTokens.spacingSm),
            Text(
              _getRatingText(_currentRating),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _currentRating > 0 ? () {
              widget.onRate?.call(_currentRating);
              Navigator.of(context).pop();
            } : null,
            child: const Text('Rate'),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return Colors.green;
      case DifficultyLevel.intermediate:
        return Colors.orange;
      case DifficultyLevel.advanced:
        return Colors.red;
      case DifficultyLevel.expert:
        return Colors.purple;
    }
  }

  String _getRatingText(double rating) {
    if (rating == 0) return 'Tap a star to rate';
    if (rating == 1) return 'Poor';
    if (rating == 2) return 'Fair';
    if (rating == 3) return 'Good';
    if (rating == 4) return 'Very Good';
    if (rating == 5) return 'Excellent';
    return '';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}