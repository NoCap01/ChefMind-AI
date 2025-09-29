import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/config/firebase_options.dart';
import 'core/config/environment.dart';
import 'domain/entities/pantry_item.dart';
import 'domain/entities/shopping_list_item.dart';
// import 'core/providers/app_providers.dart' as providers;
// import 'core/router/simple_router.dart' as router;
import 'presentation/screens/home/simple_home_screen.dart';
import 'presentation/screens/splash/simple_splash_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/services/local_storage_service.dart';
import 'infrastructure/storage/hive_recipe_storage.dart';
import 'core/analytics/analytics_service.dart';
import 'core/performance/performance_monitor.dart';
import 'core/performance/memory_optimizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize analytics and performance monitoring
  final analytics = AnalyticsService();
  analytics.trackAppStart();

  // Initialize performance monitoring
  PerformanceMonitor().startMonitoring();
  MemoryMonitor.startMonitoring();

  // Initialize environment configuration
  await EnvironmentConfig.initialize();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapters
  if (!Hive.isAdapterRegistered(8)) {
    Hive.registerAdapter(PantryItemAdapter());
  }
  if (!Hive.isAdapterRegistered(9)) {
    Hive.registerAdapter(ShoppingListItemAdapter());
  }
  // Note: MealPlan adapter would be registered here when implemented

  // Track app startup completion
  analytics.trackAppStartComplete();

  runApp(const ProviderScope(child: ChefMindApp()));
}

class ChefMindApp extends ConsumerWidget {
  const ChefMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'ChefMind AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const SimpleSplashScreen(),
    );
  }
}
