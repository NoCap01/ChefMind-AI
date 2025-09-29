import 'package:flutter/material.dart';

/// Custom kitchen tools icon widget for the home screen - crossed knife and spoon
class KitchenToolsIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const KitchenToolsIcon({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Colors.white;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: CrossedKnifeSpoonPainter(color: iconColor),
        size: Size(size, size),
      ),
    );
  }
}

/// Custom painter for crossed knife and spoon icon
class CrossedKnifeSpoonPainter extends CustomPainter {
  final Color color;

  CrossedKnifeSpoonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;

    // Draw knife (left diagonal)
    _drawKnife(canvas, paint, center, radius, size);

    // Draw spoon (right diagonal)
    _drawSpoon(canvas, paint, center, radius, size);
  }

  void _drawKnife(
      Canvas canvas, Paint paint, Offset center, double radius, Size size) {
    // Knife blade (top-left to bottom-right)
    final bladeStart = Offset(
      center.dx - radius * 0.7,
      center.dy - radius * 0.7,
    );
    final bladeEnd = Offset(
      center.dx + radius * 0.2,
      center.dy + radius * 0.2,
    );

    // Draw blade
    final bladePath = Path();
    bladePath.moveTo(bladeStart.dx, bladeStart.dy);
    bladePath.lineTo(
        bladeStart.dx + size.width * 0.08, bladeStart.dy - size.width * 0.02);
    bladePath.lineTo(
        bladeEnd.dx + size.width * 0.08, bladeEnd.dy - size.width * 0.02);
    bladePath.lineTo(bladeEnd.dx, bladeEnd.dy);
    bladePath.close();

    canvas.drawPath(bladePath, paint);

    // Draw handle
    final handleStart = bladeEnd;
    final handleEnd = Offset(
      center.dx + radius * 0.7,
      center.dy + radius * 0.7,
    );

    paint.strokeWidth = size.width * 0.06;
    canvas.drawLine(handleStart, handleEnd, paint);
  }

  void _drawSpoon(
      Canvas canvas, Paint paint, Offset center, double radius, Size size) {
    // Spoon bowl (top-right)
    final bowlCenter = Offset(
      center.dx + radius * 0.5,
      center.dy - radius * 0.5,
    );

    canvas.drawOval(
      Rect.fromCenter(
        center: bowlCenter,
        width: size.width * 0.15,
        height: size.width * 0.2,
      ),
      paint,
    );

    // Spoon handle (to bottom-left)
    final handleStart = Offset(
      bowlCenter.dx - size.width * 0.05,
      bowlCenter.dy + size.width * 0.08,
    );
    final handleEnd = Offset(
      center.dx - radius * 0.7,
      center.dy + radius * 0.7,
    );

    paint.strokeWidth = size.width * 0.06;
    canvas.drawLine(handleStart, handleEnd, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Animated kitchen tools icon with pulsing effect
class AnimatedKitchenToolsIcon extends StatefulWidget {
  final double size;
  final Color? color;

  const AnimatedKitchenToolsIcon({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  State<AnimatedKitchenToolsIcon> createState() =>
      _AnimatedKitchenToolsIconState();
}

class _AnimatedKitchenToolsIconState extends State<AnimatedKitchenToolsIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: KitchenToolsIcon(
            size: widget.size,
            color: widget.color,
          ),
        );
      },
    );
  }
}
