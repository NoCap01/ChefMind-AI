import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';

class RecipeCollectionWidget extends StatelessWidget {
  final String title;
  final int recipeCount;
  final List<dynamic> recipes;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const RecipeCollectionWidget({
    Key? key,
    required this.title,
    required this.recipeCount,
    required this.recipes,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(DesignTokens.spacingMd),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    ),
                    child: Icon(
                      Icons.folder,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: DesignTokens.iconLg,
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spacingXs),
                        Text(
                          '$recipeCount ${recipeCount == 1 ? 'recipe' : 'recipes'}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          onEdit?.call();
                          break;
                        case 'delete':
                          onDelete?.call();
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text('Delete', style: TextStyle(color: Colors.red)),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              if (recipes.isNotEmpty) ...[
                const SizedBox(height: DesignTokens.spacingLg),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return Container(
                        width: 80,
                        margin: EdgeInsets.only(
                          right: index < recipes.length - 1 ? DesignTokens.spacingSm : 0,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                child: recipe.imageUrl != null
                                    ? Image.network(
                                        recipe.imageUrl!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(
                                          width: 60,
                                          height: 60,
                                          color: Theme.of(context).colorScheme.surfaceVariant,
                                          child: Icon(
                                            Icons.restaurant_menu,
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                            size: DesignTokens.iconMd,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 60,
                                        height: 60,
                                        color: Theme.of(context).colorScheme.surfaceVariant,
                                        child: Icon(
                                          Icons.restaurant_menu,
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          size: DesignTokens.iconMd,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: DesignTokens.spacingXs),
                            Text(
                              recipe.title,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
              
              const SizedBox(height: DesignTokens.spacingMd),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: DesignTokens.iconSm,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: DesignTokens.spacingXs),
                  Text(
                    'Updated ${_getRelativeTime(DateTime.now())}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: DesignTokens.iconSm,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}