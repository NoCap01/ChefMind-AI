import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/firebase_service.dart';
import '../services/openai_service.dart';
import '../services/local_storage_service.dart';
import '../services/notification_service.dart';
import '../../domain/services/authentication_service.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/pantry_repository.dart';
import '../../infrastructure/services/firebase_auth_service.dart';
import '../../infrastructure/repositories/firebase_recipe_repository.dart';
import '../../infrastructure/repositories/firebase_user_repository.dart';
import '../../infrastructure/repositories/firebase_pantry_repository.dart';

// Service providers
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final openaiServiceProvider = Provider<OpenAIService>((ref) {
  return OpenAIService();
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// Domain service providers
final authenticationServiceProvider = Provider<AuthenticationService>((ref) {
  return FirebaseAuthService();
});

// Repository providers
final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return FirebaseRecipeRepository();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return FirebaseUserRepository();
});

final pantryRepositoryProvider = Provider<PantryRepository>((ref) {
  return FirebasePantryRepository();
});