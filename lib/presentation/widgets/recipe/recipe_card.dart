import 'package:flutter/material.dart';
import '../../../core/performance/image_cache_manager.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;
  final bool isFavorite;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.onFavorite,
    this.onShare,
    this.onDelete,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image with optimized loading
            SizedBox(
              height: 160,
              width: double.infinity,
              child: ImageCacheManager.instance.buildOptimizedImage(
                recipe['imageUrl'],
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
                placeholder: Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.restaurant,
                    size: 48,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                cacheTtl: const Duration(days: 7),
              ),
            ),

            // Recipe details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and action buttons
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe['title'] ?? 'Untitled Recipe',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onFavorite != null)
                        IconButton(
                          onPressed: onFavorite,
                          icon: Icon(
                            (recipe['isFavorite'] ?? isFavorite)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: (recipe['isFavorite'] ?? isFavorite)
                                ? Colors.red
                                : null,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      if (onDelete != null)
                        PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'delete') {
                              onDelete?.call();
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.delete, color: Colors.red),
                                title: Text('Delete'),
                              ),
                            ),
                          ],
                          child: const Icon(Icons.more_vert),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Description
                  if (recipe['description'] != null)
                    Text(
                      recipe['description'],
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 12),

                  // Recipe metadata
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      // Cooking time
                      if (recipe['cookingTime'] != null)
                        _buildMetadataChip(
                          Icons.schedule,
                          _formatTime(recipe['cookingTime']),
                          theme,
                        ),

                      // Servings
                      if (recipe['servings'] != null)
                        _buildMetadataChip(
                          Icons.people,
                          '${recipe['servings']} servings',
                          theme,
                        ),

                      // Difficulty
                      if (recipe['difficulty'] != null)
                        _buildMetadataChip(
                          Icons.bar_chart,
                          recipe['difficulty'].toString(),
                          theme,
                          color: _getDifficultyColor(recipe['difficulty']),
                        ),

                      // Rating
                      if (recipe['rating'] != null)
                        _buildMetadataChip(
                          Icons.star,
                          '${recipe['rating']}/5',
                          theme,
                          color: Colors.amber,
                        ),

                      // Cuisine
                      if (recipe['cuisine'] != null)
                        _buildMetadataChip(
                          Icons.public,
                          recipe['cuisine'],
                          theme,
                        ),
                    ],
                  ),

                  // Tags
                  if (recipe['tags'] != null &&
                      (recipe['tags'] as List).isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: (recipe['tags'] as List)
                          .take(3)
                          .map<Widget>(
                            (tag) => Chip(
                              label: Text(
                                tag.toString(),
                                style: theme.textTheme.bodySmall,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          )
                          .toList(),
                    ),
                  ],

                  // Action buttons
                  if (onShare != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: onShare,
                          icon: const Icon(Icons.share, size: 16),
                          label: const Text('Share'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataChip(IconData icon, String text, ThemeData theme,
      {Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: color ?? theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  String _formatTime(dynamic time) {
    if (time is Duration) {
      final hours = time.inHours;
      final minutes = time.inMinutes % 60;
      if (hours > 0) {
        return '${hours}h ${minutes}m';
      } else {
        return '${minutes}m';
      }
    } else if (time is int) {
      final hours = time ~/ 60;
      final minutes = time % 60;
      if (hours > 0) {
        return '${hours}h ${minutes}m';
      } else {
        return '${minutes}m';
      }
    }
    return time.toString();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
      case 'easy':
        return Colors.green;
      case 'medium':
      case 'intermediate':
        return Colors.orange;
      case 'hard':
      case 'expert':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// Compact recipe card for lists
class CompactRecipeCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const CompactRecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 56,
            height: 56,
            child: ImageCacheManager.instance.buildOptimizedImage(
              recipe['imageUrl'],
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              placeholder: Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.restaurant,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              cacheTtl: const Duration(days: 7),
            ),
          ),
        ),
        title: Text(
          recipe['title'] ?? 'Untitled Recipe',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recipe['description'] != null)
              Text(
                recipe['description'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (recipe['cookingTime'] != null) ...[
                  const Icon(Icons.schedule, size: 12),
                  const SizedBox(width: 2),
                  Text(
                    _formatDuration(recipe['cookingTime']),
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(width: 8),
                ],
                if (recipe['servings'] != null) ...[
                  const Icon(Icons.people, size: 12),
                  const SizedBox(width: 2),
                  Text(
                    '${recipe['servings']}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: onFavorite != null
            ? IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              )
            : null,
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
