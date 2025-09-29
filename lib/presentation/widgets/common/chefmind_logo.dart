import 'package:flutter/material.dart';

/// ChefMind logo widget that can be used throughout the app
class ChefMindLogo extends StatelessWidget {
  final double size;
  final Color? color;
  final bool showBackground;
  final Color? backgroundColor;

  const ChefMindLogo({
    super.key,
    this.size = 24,
    this.color,
    this.showBackground = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(
      'assets/icons/app_icon_1024.png',
      width: size,
      height: size,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to restaurant icon if logo fails to load
        return Icon(
          Icons.restaurant_menu,
          size: size,
          color: color ?? Theme.of(context).colorScheme.primary,
        );
      },
    );

    if (showBackground) {
      return Container(
        padding: EdgeInsets.all(size * 0.2),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(size * 0.3),
        ),
        child: logo,
      );
    }

    return logo;
  }
}

/// Animated ChefMind logo with pulsing effect
class AnimatedChefMindLogo extends StatefulWidget {
  final double size;
  final Color? color;
  final bool showBackground;
  final Color? backgroundColor;

  const AnimatedChefMindLogo({
    super.key,
    this.size = 24,
    this.color,
    this.showBackground = false,
    this.backgroundColor,
  });

  @override
  State<AnimatedChefMindLogo> createState() => _AnimatedChefMindLogoState();
}

class _AnimatedChefMindLogoState extends State<AnimatedChefMindLogo>
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
          child: ChefMindLogo(
            size: widget.size,
            color: widget.color,
            showBackground: widget.showBackground,
            backgroundColor: widget.backgroundColor,
          ),
        );
      },
    );
  }
}

/// Enhanced logo for splash screen with cooking-themed animations
class SplashChefMindLogo extends StatefulWidget {
  final double size;

  const SplashChefMindLogo({
    super.key,
    this.size = 120,
  });

  @override
  State<SplashChefMindLogo> createState() => _SplashChefMindLogoState();
}

class _SplashChefMindLogoState extends State<SplashChefMindLogo>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _glowController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));

    _rotationController.repeat();
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationAnimation, _glowAnimation]),
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(_glowAnimation.value * 0.5),
                blurRadius: 30,
                spreadRadius: 10,
              ),
              BoxShadow(
                color: Colors.yellow.withOpacity(_glowAnimation.value * 0.3),
                blurRadius: 50,
                spreadRadius: 20,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating background circle
              Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        Colors.orange.withOpacity(0.1),
                        Colors.yellow.withOpacity(0.2),
                        Colors.red.withOpacity(0.1),
                        Colors.orange.withOpacity(0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Main logo
              Container(
                width: widget.size * 0.7,
                height: widget.size * 0.7,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF6B35),
                      Color(0xFFF7931E),
                      Color(0xFFFFD23F),
                    ],
                  ),
                ),
                child: Icon(
                  Icons.restaurant_menu,
                  size: widget.size * 0.4,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
