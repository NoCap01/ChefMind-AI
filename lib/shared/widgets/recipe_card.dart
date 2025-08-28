import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/design_tokens.dart';

/// A reusable recipe card widget with hero animations and interaction states
class RecipeCard extends StatefulWidget {
  const RecipeCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.cookingTime,
    this.difficulty,
    this.rating,
    this.servings,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.heroTag,
    this.width,
    this.height,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String? subtitle;
  final Duration? cookingTime;
  final String? difficulty;
  final double? rating;
  final int? servings;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final String? heroTag;
  final double? width;
  final double? height;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: DesignTokens.animationFast,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.curveEaseInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: DesignTokens.elevationSm,
      end: DesignTokens.elevationLg,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: DesignTokens.curveEaseOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _animationController.reverse();
  }

  String _formatCookingTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        return Icon(
          starValue <= rating
              ? Icons.star
              : starValue - 0.5 <= rating
                  ? Icons.star_half
                  : Icons.star_border,
          size: DesignTokens.ratingStarSize,
          color: AppColors.ratingGold,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Hero(
            tag: widget.heroTag ?? 'recipe_${widget.id}',
            child: Material(
              elevation: _elevationAnimation.value,
              borderRadius: DesignTokens.radiusExtraLarge,
              shadowColor: colorScheme.shadow,
              surfaceTintColor: colorScheme.surfaceTint,
              child: GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                onTap: widget.onTap,
                child: Container(
                  width: widget.width ?? DesignTokens.recipeCardWidth,
                  height: widget.height ?? DesignTokens.recipeCardHeight,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: DesignTokens.radiusExtraLarge,
                    border: Border.all(
                      color: _isPressed
                          ? colorScheme.primary.withValues(alpha: 0.3)
                          : colorScheme.outlineVariant,
                      width: _isPressed ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image section with favorite button
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            // Recipe image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(DesignTokens.radiusXl),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: colorScheme.surfaceContainerHighest,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.restaurant,
                                    size: DesignTokens.icon2xl,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                            
                            // Favorite button
                            if (widget.onFavoriteToggle != null)
                              Positioned(
                                top: DesignTokens.spacingSm,
                                right: DesignTokens.spacingSm,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: widget.onFavoriteToggle,
                                    borderRadius: BorderRadius.circular(
                                      DesignTokens.radiusFull,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                        DesignTokens.spacingSm,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.surface.withValues(
                                          alpha: 0.9,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: DesignTokens.shadowSmall,
                                      ),
                                      child: Icon(
                                        widget.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: DesignTokens.iconMd,
                                        color: widget.isFavorite
                                            ? AppColors.spiceRed
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Difficulty badge
                            if (widget.difficulty != null)
                              Positioned(
                                bottom: DesignTokens.spacingSm,
                                left: DesignTokens.spacingSm,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: DesignTokens.spacingSm,
                                    vertical: DesignTokens.spacing2xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.getDifficultyColor(
                                      widget.difficulty!,
                                    ).withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(
                                      DesignTokens.radiusFull,
                                    ),
                                  ),
                                  child: Text(
                                    widget.difficulty!.toUpperCase(),
                                    style: AppTypography.chipText.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Content section
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: DesignTokens.cardPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                widget.title,
                                style: AppTypography.cardTitle.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Subtitle
                              if (widget.subtitle != null) ...[
                                const SizedBox(height: DesignTokens.spacing2xs),
                                Text(
                                  widget.subtitle!,
                                  style: AppTypography.cardSubtitle.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],

                              const Spacer(),

                              // Rating
                              if (widget.rating != null) ...[
                                Row(
                                  children: [
                                    _buildRatingStars(widget.rating!),
                                    const SizedBox(width: DesignTokens.spacingXs),
                                    Text(
                                      widget.rating!.toStringAsFixed(1),
                                      style: AppTypography.captionText.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: DesignTokens.spacingXs),
                              ],

                              // Meta information row
                              Row(
                                children: [
                                  // Cooking time
                                  if (widget.cookingTime != null) ...[
                                    Icon(
                                      Icons.access_time,
                                      size: DesignTokens.iconSm,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: DesignTokens.spacing2xs),
                                    Text(
                                      _formatCookingTime(widget.cookingTime!),
                                      style: AppTypography.captionText.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],

                                  // Servings
                                  if (widget.servings != null) ...[
                                    if (widget.cookingTime != null)
                                      const SizedBox(width: DesignTokens.spacingMd),
                                    Icon(
                                      Icons.people,
                                      size: DesignTokens.iconSm,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    const SizedBox(width: DesignTokens.spacing2xs),
                                    Text(
                                      '${widget.servings}',
                                      style: AppTypography.captionText.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Compact version of RecipeCard for list views
class RecipeCardCompact extends StatelessWidget {
  const RecipeCardCompact({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    this.subtitle,
    this.cookingTime,
    this.difficulty,
    this.rating,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.heroTag,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String? subtitle;
  final Duration? cookingTime;
  final String? difficulty;
  final double? rating;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final String? heroTag;

  String _formatCookingTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Hero(
      tag: heroTag ?? 'recipe_compact_$id',
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spacingLg,
          vertical: DesignTokens.spacingSm,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: DesignTokens.radiusExtraLarge,
          child: Padding(
            padding: DesignTokens.cardPadding,
            child: Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: DesignTokens.radiusLarge,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.restaurant,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.restaurant,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: DesignTokens.spacingLg),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.textTheme.titleMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      if (subtitle != null) ...[
                        const SizedBox(height: DesignTokens.spacing2xs),
                        Text(
                          subtitle!,
                          style: AppTypography.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      const SizedBox(height: DesignTokens.spacingSm),

                      // Meta row
                      Row(
                        children: [
                          if (cookingTime != null) ...[
                            Icon(
                              Icons.access_time,
                              size: DesignTokens.iconSm,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: DesignTokens.spacing2xs),
                            Text(
                              _formatCookingTime(cookingTime!),
                              style: AppTypography.captionText.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],

                          if (difficulty != null) ...[
                            if (cookingTime != null)
                              const SizedBox(width: DesignTokens.spacingMd),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: DesignTokens.spacingSm,
                                vertical: DesignTokens.spacing2xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.getDifficultyColor(difficulty!),
                                borderRadius: BorderRadius.circular(
                                  DesignTokens.radiusFull,
                                ),
                              ),
                              child: Text(
                                difficulty!.toUpperCase(),
                                style: AppTypography.captionText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],

                          if (rating != null) ...[
                            const Spacer(),
                            Icon(
                              Icons.star,
                              size: DesignTokens.iconSm,
                              color: AppColors.ratingGold,
                            ),
                            const SizedBox(width: DesignTokens.spacing2xs),
                            Text(
                              rating!.toStringAsFixed(1),
                              style: AppTypography.captionText.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Favorite button
                if (onFavoriteToggle != null)
                  IconButton(
                    onPressed: onFavoriteToggle,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? AppColors.spiceRed
                          : colorScheme.onSurfaceVariant,
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