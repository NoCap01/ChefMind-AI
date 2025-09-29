import 'dart:developer' as developer;

import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_request.dart';
import '../../domain/services/ai_service_manager.dart';

/// AI service that cascades through multiple AI providers
/// Tries services in priority order until one succeeds
class CascadingAIService implements AIServiceManager {
  final List<AIServiceManager> _services;
  
  CascadingAIService(this._services) {
    // Sort services by priority (lower number = higher priority)
    _services.sort((a, b) => a.priority.compareTo(b.priority));
  }

  @override
  String get serviceName => 'CascadingAIService';

  @override
  int get priority => 0; // Highest priority as the main service

  @override
  Future<bool> isServiceAvailable() async {
    // Service is available if at least one underlying service is available
    for (final service in _services) {
      try {
        if (await service.isServiceAvailable()) {
          return true;
        }
      } catch (e) {
        developer.log(
          'Error checking availability for ${service.serviceName}: $e',
          name: 'CascadingAIService',
        );
      }
    }
    return false;
  }

  @override
  Future<Recipe> generateRecipe(RecipeRequest request) async {
    final List<Exception> failures = [];
    
    developer.log(
      'Starting recipe generation with ${_services.length} services',
      name: 'CascadingAIService',
    );

    for (final service in _services) {
      try {
        developer.log(
          'Trying ${service.serviceName} (priority: ${service.priority})',
          name: 'CascadingAIService',
        );

        // Check if service is available before attempting generation
        if (!await service.isServiceAvailable()) {
          developer.log(
            '${service.serviceName} is not available, skipping',
            name: 'CascadingAIService',
          );
          continue;
        }

        // Attempt recipe generation
        final recipe = await service.generateRecipe(request);
        
        developer.log(
          'Successfully generated recipe using ${service.serviceName}',
          name: 'CascadingAIService',
        );
        
        return recipe;
        
      } on AIServiceException catch (e) {
        developer.log(
          'AIServiceException from ${service.serviceName}: ${e.message}',
          name: 'CascadingAIService',
        );
        failures.add(e);
      } catch (e) {
        developer.log(
          'Unexpected error from ${service.serviceName}: $e',
          name: 'CascadingAIService',
        );
        failures.add(Exception('${service.serviceName} failed: $e'));
      }
    }

    // All services failed
    final errorMessages = failures.map((e) => e.toString()).join('; ');
    developer.log(
      'All AI services failed. Errors: $errorMessages',
      name: 'CascadingAIService',
    );
    
    throw AIServiceException(
      'All AI services failed to generate recipe. Last errors: $errorMessages',
      serviceName: serviceName,
    );
  }

  /// Add a new service to the cascade
  void addService(AIServiceManager service) {
    _services.add(service);
    _services.sort((a, b) => a.priority.compareTo(b.priority));
  }

  /// Remove a service from the cascade
  void removeService(String serviceName) {
    _services.removeWhere((service) => service.serviceName == serviceName);
  }

  /// Get list of available services
  Future<List<String>> getAvailableServices() async {
    final available = <String>[];
    
    for (final service in _services) {
      try {
        if (await service.isServiceAvailable()) {
          available.add(service.serviceName);
        }
      } catch (e) {
        // Service check failed, consider it unavailable
      }
    }
    
    return available;
  }

  /// Get service statistics
  Map<String, dynamic> getServiceStats() {
    return {
      'totalServices': _services.length,
      'serviceNames': _services.map((s) => s.serviceName).toList(),
      'servicePriorities': _services.map((s) => {
        'name': s.serviceName,
        'priority': s.priority,
      }).toList(),
    };
  }
}