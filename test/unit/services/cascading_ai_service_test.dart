import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/infrastructure/services/cascading_ai_service.dart';
import 'package:chefmind_ai/infrastructure/services/enhanced_mock_service.dart';
import 'package:chefmind_ai/domain/entities/recipe_request.dart';
import 'package:chefmind_ai/domain/services/ai_service_manager.dart';
import 'package:chefmind_ai/domain/entities/recipe.dart';
import 'package:chefmind_ai/domain/enums/difficulty_level.dart';

// Mock service for testing
class MockAIService implements AIServiceManager {
  final String _serviceName;
  final bool _isAvailable;
  final bool _shouldThrow;
  final int _priority;

  MockAIService(
      this._serviceName, this._isAvailable, this._shouldThrow, this._priority);

  @override
  String get serviceName => _serviceName;

  @override
  int get priority => _priority;

  @override
  Future<bool> isServiceAvailable() async => _isAvailable;

  @override
  Future<Recipe> generateRecipe(RecipeRequest request) async {
    if (_shouldThrow) {
      throw Exception('Service $_serviceName failed');
    }

    return Recipe(
      id: 'test-id',
      title: 'Test Recipe from $_serviceName',
      description: 'Test description',
      ingredients: [],
      instructions: [],
      metadata: RecipeMetadata(
        prepTime: 10,
        cookTime: 20,
        servings: request.servings,
        difficulty: DifficultyLevel.easy,
      ),
      tags: [],
      createdAt: DateTime.now(),
      source: _serviceName.toLowerCase(),
    );
  }
}

void main() {
  group('CascadingAIService', () {
    test('should use services in priority order', () async {
      final highPriorityService = MockAIService('HighPriority', true, false, 1);
      final lowPriorityService = MockAIService('LowPriority', true, false, 2);

      final cascadingService = CascadingAIService([
        lowPriorityService,
        highPriorityService,
      ]);

      const request = RecipeRequest(ingredients: ['test'], servings: 4);
      final recipe = await cascadingService.generateRecipe(request);

      expect(recipe.source, 'highpriority');
    });

    test('should fallback to next service when primary fails', () async {
      final failingService = MockAIService('Failing', true, true, 1);
      final workingService = MockAIService('Working', true, false, 2);

      final cascadingService = CascadingAIService([
        failingService,
        workingService,
      ]);

      const request = RecipeRequest(ingredients: ['test'], servings: 4);
      final recipe = await cascadingService.generateRecipe(request);

      expect(recipe.source, 'working');
    });

    test('should skip unavailable services', () async {
      final unavailableService = MockAIService('Unavailable', false, false, 1);
      final availableService = MockAIService('Available', true, false, 2);

      final cascadingService = CascadingAIService([
        unavailableService,
        availableService,
      ]);

      const request = RecipeRequest(ingredients: ['test'], servings: 4);
      final recipe = await cascadingService.generateRecipe(request);

      expect(recipe.source, 'available');
    });

    test('should throw when all services fail', () async {
      final failingService1 = MockAIService('Failing1', true, true, 1);
      final failingService2 = MockAIService('Failing2', true, true, 2);

      final cascadingService = CascadingAIService([
        failingService1,
        failingService2,
      ]);

      const request = RecipeRequest(ingredients: ['test'], servings: 4);

      expect(
        () => cascadingService.generateRecipe(request),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw when all services are unavailable', () async {
      final unavailableService1 =
          MockAIService('Unavailable1', false, false, 1);
      final unavailableService2 =
          MockAIService('Unavailable2', false, false, 2);

      final cascadingService = CascadingAIService([
        unavailableService1,
        unavailableService2,
      ]);

      const request = RecipeRequest(ingredients: ['test'], servings: 4);

      expect(
        () => cascadingService.generateRecipe(request),
        throwsA(isA<Exception>()),
      );
    });

    test('should work with real enhanced mock service', () async {
      final mockService = EnhancedMockService();
      final cascadingService = CascadingAIService([mockService]);

      const request = RecipeRequest(
        ingredients: ['chicken', 'rice'],
        servings: 4,
      );

      final recipe = await cascadingService.generateRecipe(request);

      expect(recipe.id, isNotEmpty);
      expect(recipe.title, isNotEmpty);
      expect(recipe.source, 'enhancedmock');
    });

    test('should have correct service name', () {
      final cascadingService = CascadingAIService([]);
      expect(cascadingService.serviceName, 'CascadingAI');
    });

    test('should report availability based on any service being available',
        () async {
      final unavailableService = MockAIService('Unavailable', false, false, 1);
      final availableService = MockAIService('Available', true, false, 2);

      final cascadingService = CascadingAIService([
        unavailableService,
        availableService,
      ]);

      final isAvailable = await cascadingService.isServiceAvailable();
      expect(isAvailable, isTrue);
    });

    test('should report unavailable when no services are available', () async {
      final unavailableService1 =
          MockAIService('Unavailable1', false, false, 1);
      final unavailableService2 =
          MockAIService('Unavailable2', false, false, 2);

      final cascadingService = CascadingAIService([
        unavailableService1,
        unavailableService2,
      ]);

      final isAvailable = await cascadingService.isServiceAvailable();
      expect(isAvailable, isFalse);
    });
  });
}
