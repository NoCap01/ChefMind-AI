import 'package:flutter/material.dart';

class RecipeRating extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool showReviewCount;
  final double starSize;
  final VoidCallback? onTap;

  const RecipeRating({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.showReviewCount = true,
    this.starSize = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Star rating
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              final starValue = index + 1;
              return Icon(
                starValue <= rating
                    ? Icons.star
                    : starValue - 0.5 <= rating
                        ? Icons.star_half
                        : Icons.star_border,
                color: Colors.amber,
                size: starSize,
              );
            }),
          ),

          const SizedBox(width: 8),

          // Rating value
          Text(
            rating.toStringAsFixed(1),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          // Review count
          if (showReviewCount && reviewCount > 0) ...[
            const SizedBox(width: 4),
            Text(
              '($reviewCount)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class InteractiveRating extends StatefulWidget {
  final double initialRating;
  final ValueChanged<double>? onRatingChanged;
  final double starSize;
  final bool allowHalfRating;

  const InteractiveRating({
    super.key,
    this.initialRating = 0,
    this.onRatingChanged,
    this.starSize = 24,
    this.allowHalfRating = true,
  });

  @override
  State<InteractiveRating> createState() => _InteractiveRatingState();
}

class _InteractiveRatingState extends State<InteractiveRating> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        return GestureDetector(
          onTap: () => _updateRating(starValue.toDouble()),
          onTapDown: widget.allowHalfRating
              ? (details) => _handleTapDown(details, index)
              : null,
          child: Icon(
            starValue <= _rating
                ? Icons.star
                : starValue - 0.5 <= _rating && widget.allowHalfRating
                    ? Icons.star_half
                    : Icons.star_border,
            color: Colors.amber,
            size: widget.starSize,
          ),
        );
      }),
    );
  }

  void _handleTapDown(TapDownDetails details, int starIndex) {
    if (!widget.allowHalfRating) return;

    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final starWidth = widget.starSize;
    final starLeft = starIndex * starWidth;
    final tapPosition = localPosition.dx - starLeft;

    final rating = starIndex + (tapPosition > starWidth / 2 ? 1.0 : 0.5);
    _updateRating(rating);
  }

  void _updateRating(double rating) {
    setState(() => _rating = rating);
    widget.onRatingChanged?.call(rating);
  }
}