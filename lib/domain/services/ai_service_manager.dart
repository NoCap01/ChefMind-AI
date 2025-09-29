import '../entities/recipe.dart';
import '../entities/recipe_request.dart';

/// Abstract interface for AI recipe generation services
abstract class AIServiceManager {
  /// Generate a recipe based on the provided request
  Future<Recipe> generateRecipe(RecipeRequest request);
  
  /// Check if the service is currently available
  Future<bool> isServiceAvailable();
  
  /// Get the name of this service for logging/debugging
  String get serviceName;
  
  /// Get the priority of this service (lower number = higher priority)
  int get priority;
}

/// Exception thrown when AI service operations fail
class AIServiceException implements Exception {
  final String message;
  final String? serviceName;
  final Exception? originalException;
  
  const AIServiceException(
    this.message, {
    this.serviceName,
    this.originalException,
  });
  
  @override
  String toString() {
    if (serviceName != null) {
      return 'AIServiceException ($serviceName): $message';
    }
    return 'AIServiceException: $message';
  }
}