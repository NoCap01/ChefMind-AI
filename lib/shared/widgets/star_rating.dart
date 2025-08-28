import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool allowHalfRating;
  final bool isReadOnly;
  final ValueChanged<double>? onRatingChanged;
  final String? semanticLabel;

  const StarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24.0,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.isReadOnly = false,
    this.onRatingChanged,
    this.semanticLabel,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating;
  }

  @override
  void didUpdateWidget(StarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _currentRating = widget.rating;
    }
  }

  void _updateRating(double newRating) {
    if (widget.isReadOnly) return;

    setState(() {
      _currentRating = newRating;
    });

    widget.onRatingChanged?.call(newRating);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final inactiveColor = widget.inactiveColor ?? theme.colorScheme.outline;

    return Semantics(
      label: widget.semanticLabel ?? 'Rating: ${_currentRating.toStringAsFixed(1)} out of ${widget.maxRating} stars',
      value: _currentRating.toString(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.maxRating, (index) {
          return GestureDetector(
            onTap: widget.isReadOnly ? null : () {
              final newRating = (index + 1).toDouble();
              _updateRating(newRating);
            },
            onPanUpdate: widget.isReadOnly ? null : (details) {
              final RenderBox box = context.findRenderObject() as RenderBox;
              final position = box.globalToLocal(details.globalPosition);
              final starWidth = widget.size;
              final starIndex = (position.dx / starWidth).floor();
              
              if (starIndex >= 0 && starIndex < widget.maxRating) {
                double newRating;
                if (widget.allowHalfRating) {
                  final starPosition = (position.dx % starWidth) / starWidth;
                  newRating = starIndex + (starPosition > 0.5 ? 1.0 : 0.5);
                } else {
                  newRating = (starIndex + 1).toDouble();
                }
                
                newRating = newRating.clamp(0.0, widget.maxRating.toDouble());
                if (newRating != _currentRating) {
                  _updateRating(newRating);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              child: _buildStar(index + 1, activeColor, inactiveColor),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStar(int starNumber, Color activeColor, Color inactiveColor) {
    final starValue = starNumber.toDouble();
    
    if (_currentRating >= starValue) {
      // Full star
      return Icon(
        Icons.star,
        size: widget.size,
        color: activeColor,
      );
    } else if (widget.allowHalfRating && _currentRating >= starValue - 0.5) {
      // Half star
      return Stack(
        children: [
          Icon(
            Icons.star_border,
            size: widget.size,
            color: inactiveColor,
          ),
          ClipRect(
            clipper: _HalfStarClipper(),
            child: Icon(
              Icons.star,
              size: widget.size,
              color: activeColor,
            ),
          ),
        ],
      );
    } else {
      // Empty star
      return Icon(
        Icons.star_border,
        size: widget.size,
        color: inactiveColor,
      );
    }
  }
}

class _HalfStarClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

class InteractiveStarRating extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool allowHalfRating;
  final ValueChanged<double> onRatingChanged;
  final String? label;
  final String? description;

  const InteractiveStarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.maxRating = 5,
    this.size = 32.0,
    this.activeColor,
    this.inactiveColor,
    this.allowHalfRating = true,
    this.label,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
        ],
        if (description != null) ...[
          Text(
            description!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: [
            StarRating(
              rating: rating,
              maxRating: maxRating,
              size: size,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              allowHalfRating: allowHalfRating,
              onRatingChanged: onRatingChanged,
            ),
            const SizedBox(width: 8),
            Text(
              rating.toStringAsFixed(1),
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CompactStarRating extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool showRatingText;
  final TextStyle? ratingTextStyle;

  const CompactStarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 16.0,
    this.activeColor,
    this.inactiveColor,
    this.showRatingText = true,
    this.ratingTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StarRating(
          rating: rating,
          maxRating: maxRating,
          size: size,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          isReadOnly: true,
        ),
        if (showRatingText) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: ratingTextStyle ?? theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}