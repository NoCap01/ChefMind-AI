import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../widgets/common/chefmind_logo.dart';

class AnimatedSplashScreen extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const AnimatedSplashScreen({
    super.key,
    required this.onAnimationComplete,
  });

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _mainController;
  late AnimationController _logoController;
  late AnimationController _particleController;
  late AnimationController _textController;
  late AnimationController _progressController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoRotation;
  late Animation<double> _textOpacity;
  late Animation<double> _textSlide;
  late Animation<double> _progressValue;
  late Animation<Color?> _backgroundColor;
  
  final List<CookingParticle> _particles = [];
  Timer? _particleTimer;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
    _generateParticles();
  }

  void _initializeAnimations() {
    // Main controller for overall timing
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Particle system
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Progress indicator
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    // Logo scale with bounce effect
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Logo opacity fade in
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    // Subtle logo rotation
    _logoRotation = Tween<double>(
      begin: -0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));

    // Text animations
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _textSlide = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Progress animation
    _progressValue = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // Background color transition
    _backgroundColor = ColorTween(
      begin: const Color(0xFF1A1A2E),
      end: const Color(0xFF16213E),
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimationSequence() async {
    // Add haptic feedback
    HapticFeedback.lightImpact();
    
    // Start particle system
    _particleController.repeat();
    
    // Sequence of animations
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();
    
    await Future.delayed(const Duration(milliseconds: 500));
    _progressController.forward();
    
    // Start main background animation
    _mainController.forward();
    
    // Complete after all animations
    await Future.delayed(const Duration(milliseconds: 2000));
    
    // Final haptic feedback
    HapticFeedback.mediumImpact();
    
    widget.onAnimationComplete();
  }

  void _generateParticles() {
    _particles.clear();
    final random = math.Random();
    
    for (int i = 0; i < 20; i++) {
      _particles.add(CookingParticle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 4 + 2,
        speed: random.nextDouble() * 0.5 + 0.2,
        opacity: random.nextDouble() * 0.6 + 0.2,
        icon: _getCookingIcon(random.nextInt(6)),
      ));
    }

    _particleTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (mounted) {
        setState(() {
          for (var particle in _particles) {
            particle.update();
          }
        });
      }
    });
  }

  IconData _getCookingIcon(int index) {
    const icons = [
      Icons.restaurant,
      Icons.local_dining,
      Icons.cake,
      Icons.coffee,
      Icons.kitchen,
      Icons.restaurant_menu,
    ];
    return icons[index];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _mainController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _backgroundColor.value ?? const Color(0xFF1A1A2E),
                  const Color(0xFF0F3460),
                  const Color(0xFF533483),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated background particles
                ...._buildParticles(size),
                
                // Floating orbs
                _buildFloatingOrbs(size),
                
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      AnimatedBuilder(
                        animation: _logoController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _logoScale.value,
                            child: Transform.rotate(
                              angle: _logoRotation.value,
                              child: Opacity(
                                opacity: _logoOpacity.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.3),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const SplashChefMindLogo(size: 120),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // App name with slide animation
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _textSlide.value),
                            child: Opacity(
                              opacity: _textOpacity.value,
                              child: Column(
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) => const LinearGradient(
                                      colors: [
                                        Color(0xFFFF6B35),
                                        Color(0xFFF7931E),
                                        Color(0xFFFFD23F),
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      'ChefMind AI',
                                      style: theme.textTheme.headlineLarge?.copyWith(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Your AI Cooking Companion',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 60),
                      
                      // Progress indicator
                      AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          return Column(
                            children: [
                              Container(
                                width: 200,
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 200 * _progressValue.value,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFFF6B35),
                                            Color(0xFFF7931E),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Preparing your kitchen...',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                
                // Cooking utensils animation at bottom
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: _buildCookingUtensils(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildParticles(Size size) {
    return _particles.map((particle) {
      return Positioned(
        left: particle.x * size.width,
        top: particle.y * size.height,
        child: Opacity(
          opacity: particle.opacity,
          child: Icon(
            particle.icon,
            size: particle.size,
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFloatingOrbs(Size size) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: [
            // Large orb
            Positioned(
              left: size.width * 0.1 + math.sin(_particleController.value * 2 * math.pi) * 20,
              top: size.height * 0.2 + math.cos(_particleController.value * 2 * math.pi) * 15,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.orange.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Medium orb
            Positioned(
              right: size.width * 0.15 + math.cos(_particleController.value * 1.5 * math.pi) * 25,
              top: size.height * 0.7 + math.sin(_particleController.value * 1.5 * math.pi) * 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.purple.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCookingUtensils() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return Opacity(
          opacity: _textOpacity.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildUtensil(Icons.restaurant, 0),
              _buildUtensil(Icons.local_dining, 1),
              _buildUtensil(Icons.kitchen, 2),
              _buildUtensil(Icons.cake, 3),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUtensil(IconData icon, int index) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        final offset = math.sin((_particleController.value * 2 * math.pi) + (index * 0.5)) * 5;
        return Transform.translate(
          offset: Offset(0, offset),
          child: Icon(
            icon,
            size: 24,
            color: Colors.white.withOpacity(0.4),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _logoController.dispose();
    _particleController.dispose();
    _textController.dispose();
    _progressController.dispose();
    _particleTimer?.cancel();
    super.dispose();
  }
}

class CookingParticle {
  double x;
  double y;
  final double size;
  final double speed;
  double opacity;
  final IconData icon;

  CookingParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.icon,
  });

  void update() {
    y -= speed * 0.01;
    if (y < -0.1) {
      y = 1.1;
      x = math.Random().nextDouble();
    }
    
    // Slight horizontal drift
    x += (math.Random().nextDouble() - 0.5) * 0.001;
    x = x.clamp(0.0, 1.0);
  }
}