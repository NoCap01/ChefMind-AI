import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/meal_plan.dart';
import '../../../domain/enums/meal_type.dart';
import '../../../application/providers/meal_planner_provider.dart';
import '../../../application/providers/recipe_book_provider.dart';

// Create a simple recipes provider for the meal slot widget
final recipesProvider = FutureProvider<List<dynamic>>((ref) async {
  final recipeBookState = ref.watch(recipeBookProvider);
  return recipeBookState.maybeWhen(
    loaded: (recipes, _, __, ___) => recipes,
    orElse: () => <dynamic>[],
  );
});
import '../../screens/recipe_book/recipe_book_screen.dart';

class MealSlotWidget extends ConsumerWidget {
  final DateTime date;
  final MealType mealType;
  final PlannedMeal? plannedMeal;
  final VoidCallback? onTap;

  const MealSlotWidget({
    super.key,
    required this.date,
    required this.mealType,
    this.plannedMeal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        _assignRecipeToSlot(ref, details.data);
      },
      builder: (context, candidateData, rejectedData) {
        final isHighlighted = candidateData.isNotEmpty;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: onTap ?? () => _showMealOptions(context, ref),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isHighlighted 
                    ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                    : theme.colorScheme.surface,
                border: Border.all(
                  color: isHighlighted 
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline.withValues(alpha: 0.3),
                  width: isHighlighted ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (isHighlighted)
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getMealTypeColor(mealType).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getMealTypeIcon(mealType),
                      color: _getMealTypeColor(mealType),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _getMealTypeName(mealType),
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (plannedMeal?.isCooked == true) ...[
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          plannedMeal?.recipeName ?? 'No meal planned',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: plannedMeal != null
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                        if (plannedMeal?.servings != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            '${plannedMeal!.servings} serving${plannedMeal!.servings! > 1 ? 's' : ''}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                        if (plannedMeal?.notes?.isNotEmpty == true) ...[
                          const SizedBox(height: 2),
                          Text(
                            plannedMeal!.notes!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (plannedMeal != null) ...[
                    IconButton(
                      icon: Icon(
                        plannedMeal!.isCooked
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: plannedMeal!.isCooked ? Colors.green : null,
                      ),
                      onPressed: () => _toggleMealCooked(ref),
                      tooltip: plannedMeal!.isCooked ? 'Mark as not cooked' : 'Mark as cooked',
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) => _handleMenuAction(context, ref, value),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit Meal'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'remove',
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Remove Meal'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'duplicate',
                          child: ListTile(
                            leading: Icon(Icons.copy),
                            title: Text('Duplicate to Tomorrow'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ] else
                    Icon(
                      Icons.add,
                      color: theme.colorScheme.primary,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _assignRecipeToSlot(WidgetRef ref, String recipeId) {
    final mealPlannerNotifier = ref.read(mealPlannerProvider.notifier);
    mealPlannerNotifier.assignMealToSlot(
      date: date,
      mealType: mealType,
      recipeId: recipeId,
      servings: 1,
    );
  }

  void _toggleMealCooked(WidgetRef ref) {
    if (plannedMeal == null) return;
    
    final mealPlannerNotifier = ref.read(mealPlannerProvider.notifier);
    mealPlannerNotifier.markMealAsCooked(
      date: date,
      mealType: mealType,
      isCooked: !plannedMeal!.isCooked,
    );
  }

  void _showMealOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Select Recipe for ${_getMealTypeName(mealType)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RecipeSelectionView(
                  onRecipeSelected: (recipe) {
                    Navigator.pop(context);
                    _assignRecipeToSlot(ref, recipe.id);
                  },
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, WidgetRef ref, String action) {
    final mealPlannerNotifier = ref.read(mealPlannerProvider.notifier);
    
    switch (action) {
      case 'edit':
        _showEditMealDialog(context, ref);
        break;
      case 'remove':
        mealPlannerNotifier.removeMealFromSlot(
          date: date,
          mealType: mealType,
        );
        break;
      case 'duplicate':
        if (plannedMeal?.recipeId != null) {
          mealPlannerNotifier.assignMealToSlot(
            date: date.add(const Duration(days: 1)),
            mealType: mealType,
            recipeId: plannedMeal!.recipeId!,
            servings: plannedMeal!.servings ?? 1,
            notes: plannedMeal!.notes,
          );
        }
        break;
    }
  }

  void _showEditMealDialog(BuildContext context, WidgetRef ref) {
    if (plannedMeal == null) return;

    final servingsController = TextEditingController(
      text: plannedMeal!.servings?.toString() ?? '1',
    );
    final notesController = TextEditingController(text: plannedMeal!.notes ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${_getMealTypeName(mealType)}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: servingsController,
              decoration: const InputDecoration(
                labelText: 'Servings',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final servings = int.tryParse(servingsController.text) ?? 1;
              final notes = notesController.text.trim();
              
              final mealPlannerNotifier = ref.read(mealPlannerProvider.notifier);
              mealPlannerNotifier.assignMealToSlot(
                date: date,
                mealType: mealType,
                recipeId: plannedMeal!.recipeId!,
                servings: servings,
                notes: notes.isEmpty ? null : notes,
              );
              
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  IconData _getMealTypeIcon(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Icons.free_breakfast;
      case MealType.lunch:
        return Icons.lunch_dining;
      case MealType.dinner:
        return Icons.dinner_dining;
      case MealType.snack:
        return Icons.cookie;
    }
  }

  Color _getMealTypeColor(MealType mealType) {
    switch (mealType) {
      case MealType.breakfast:
        return Colors.orange;
      case MealType.lunch:
        return Colors.green;
      case MealType.dinner:
        return Colors.blue;
      case MealType.snack:
        return Colors.purple;
    }
  }

  String _getMealTypeName(MealType mealType) {
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

// Recipe selection view for the bottom sheet
class RecipeSelectionView extends ConsumerWidget {
  final Function(dynamic) onRecipeSelected;
  final ScrollController scrollController;

  const RecipeSelectionView({
    super.key,
    required this.onRecipeSelected,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(recipesProvider);

    return recipesAsync.when(
      data: (recipes) {
        if (recipes.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No recipes available'),
                Text('Create some recipes first to add them to your meal plan'),
              ],
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return Draggable<String>(
              data: recipe.id,
              feedback: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    recipe.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              child: Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.restaurant_menu,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(recipe.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (recipe.description.isNotEmpty)
                        Text(
                          recipe.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (recipe.prepTime > 0) ...[
                            Icon(Icons.timer, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              '${recipe.prepTime + recipe.cookTime} min',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                          if (recipe.servings > 0) ...[
                            const SizedBox(width: 12),
                            Icon(Icons.people, size: 14, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              '${recipe.servings} servings',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.drag_handle),
                  onTap: () => onRecipeSelected(recipe),
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading recipes: $error'),
          ],
        ),
      ),
    );
  }
}