import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../infrastructure/storage/hive_recipe_storage.dart';
import '../../../core/performance/performance_monitor.dart';
import '../home/simple_home_screen.dart';
import 'animated_splash_screen.dart';
import '../../widgets/common/chefmind_logo.dart';

class SplashScreenManager extends ConsumerStatefulWidget {
  const SplashScreenManager({super.key});

  @override
  ConsumerState<SplashScreenManager> createState() =>
      _SplashScreenManagerState();
}

class _SplashScreenManagerState extends ConsumerState<SplashScreenManager> {
  bool _isInitialized = false;
  String _initializationStatus = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Track app initialization performance
      await PerformanceMonitor().measureAsync('app_initialization', () async {
        // Initialize local storage
        setState(() => _initializationStatus = 'Setting up storage...');
        await LocalStorageService.initialize();
        await Future.delayed(const Duration(milliseconds: 300));

        // Initialize Hive storage
        setState(() => _initializationStatus = 'Preparing recipes...');
        final hiveStorage = HiveRecipeStorage();
        await hiveStorage.initialize();
        await Future.delayed(const Duration(milliseconds: 400));

        // Initialize performance monitoring
        setState(() => _initializationStatus = 'Optimizing performance...');
        PerformanceMonitor().startMonitoring();
        await Future.delayed(const Duration(milliseconds: 300));

        // Preload essential data
        setState(() => _initializationStatus = 'Loading essentials...');
        await _preloadEssentialData();
        await Future.delayed(const Duration(milliseconds: 400));

        // Final setup
        setState(() => _initializationStatus = 'Almost ready...');
        await Future.delayed(const Duration(milliseconds: 300));

        setState(() {
          _isInitialized = true;
          _initializationStatus = 'Ready!';
        });
      });
    } catch (e) {
      // Handle initialization errors gracefully
      debugPrint('Initialization error: $e');
      setState(() {
        _isInitialized = true;
        _initializationStatus = 'Ready!';
      });
    }
  }

  Future<void> _preloadEssentialData() async {
    // Preload any essential data here
    // For example: user preferences, cached recipes, etc.

    // Simulate some essential data loading
    await Future.delayed(const Duration(milliseconds: 200));
  }

  void _onSplashComplete() {
    if (_isInitialized) {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SimpleHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      onAnimationComplete: _onSplashComplete,
    );
  }
}

/// Enhanced splash screen with loading states
class EnhancedSplashScreen extends ConsumerStatefulWidget {
  const EnhancedSplashScreen({super.key});

  @override
  ConsumerState<EnhancedSplashScreen> createState() =>
      _EnhancedSplashScreenState();
}

class _EnhancedSplashScreenState extends ConsumerState<EnhancedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _statusController;
  late Animation<double> _statusOpacity;

  bool _isInitialized = false;
  String _currentStatus = 'Initializing ChefMind AI...';
  double _progress = 0.0;

  final List<String> _loadingMessages = [
    'Warming up the kitchen...',
    'Sharpening the knives...',
    'Organizing ingredients...',
    'Preheating the oven...',
    'Preparing recipes...',
    'Setting the table...',
    'Almost ready to cook!',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialization();
  }

  void _initializeAnimations() {
    _statusController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _statusOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _statusController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> _startInitialization() async {
    for (int i = 0; i < _loadingMessages.length; i++) {
      if (!mounted) return;

      setState(() {
        _currentStatus = _loadingMessages[i];
        _progress = (i + 1) / _loadingMessages.length;
      });

      _statusController.reset();
      _statusController.forward();

      // Simulate initialization steps
      await Future.delayed(Duration(milliseconds: 300 + (i * 100)));
    }

    setState(() {
      _isInitialized = true;
      _currentStatus = 'Welcome to ChefMind AI!';
      _progress = 1.0;
    });

    // Wait a bit before transitioning
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SimpleHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo section
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const SplashChefMindLogo(size: 150),
              ),

              const SizedBox(height: 40),

              // App title
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
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Your AI Cooking Companion',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),

              const Spacer(flex: 3),

              // Loading section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // Progress bar
                    Container(
                      width: double.infinity,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: size.width * _progress * 0.8,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF6B35),
                                  Color(0xFFF7931E),
                                  Color(0xFFFFD23F),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Status text
                    AnimatedBuilder(
                      animation: _statusOpacity,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _statusOpacity.value,
                          child: Text(
                            _currentStatus,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }
}
