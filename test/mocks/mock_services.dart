import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../lib/domain/services/recipe_generation_service.dart';
import '../../lib/domain/entities/user_profile.dart';
import '../../lib/domain/entities/recipe.dart';
import '../../lib/domain/repositories/pantry_repository.dart';
import '../../lib/domain/services/pantry_service.dart';
import '../../lib/infrastructure/services/barcode_scanner_service.dart';
import '../../lib/domain/repositories/shopping_list_repository.dart';
import '../../lib/domain/services/shopping_list_service.dart';
import '../../lib/domain/repositories/nutrition_repository.dart';
import '../../lib/domain/services/nutrition_service.dart';

// Generate mocks
@GenerateMocks([
  IRecipeGenerationService,
  UserPreferences,
  IPantryRepository,
  IPantryService,
  IBarcodeScannerService,
  IShoppingListRepository,
  IShoppingListService,
  INutritionRepository,
  INutritionService,
])
class MockRecipeGenerationService extends Mock implements IRecipeGenerationService {}

class MockPantryRepository extends Mock implements IPantryRepository {}

class MockPantryService extends Mock implements IPantryService {}

class MockBarcodeScannerService extends Mock implements IBarcodeScannerService {}

class MockShoppingListRepository extends Mock implements IShoppingListRepository {}

class MockShoppingListService extends Mock implements IShoppingListService {}

class MockNutritionRepository extends Mock implements INutritionRepository {}

class MockNutritionService extends Mock implements INutritionService {}

class MockUserPreferences extends Mock implements UserPreferences {
  @override
  int get maxCookingTimeMinutes => 60;
  
  @override
  DifficultyLevel get maxDifficulty => DifficultyLevel.intermediate;
  
  @override
  int get defaultServings => 4;
  
  @override
  List<DietaryRestriction> get dietaryRestrictions => [];
  
  @override
  List<String> get allergies => [];
  
  @override
  SkillLevel get skillLevel => SkillLevel.intermediate;
  
  @override
  List<KitchenEquipment> get availableEquipment => [];
}

// Mock data helpers
class MockDataHelper {
  static Recipe createMockRecipe({
    String? id,
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<CookingStep>? instructions,
    Duration? cookingTime,
    Duration? prepTime,
    DifficultyLevel? difficulty,
    int? servings,
    List<String>? tags,
    NutritionInfo? nutrition,
    List<String>? tips,
    double? rating,
  }) {
    return Recipe(
      id: id ?? 'mock-recipe-1',
      title: title ?? 'Mock Recipe',
      description: description ?? 'A delicious mock recipe',
      ingredients: ingredients ?? [
        const Ingredient(name: 'Mock Ingredient 1', quantity: 1, unit: 'cup'),
        const Ingredient(name: 'Mock Ingredient 2', quantity: 2, unit: 'tbsp'),
      ],
      instructions: instructions ?? [
        const CookingStep(stepNumber: 1, instruction: 'Mock instruction 1'),
        const CookingStep(stepNumber: 2, instruction: 'Mock instruction 2'),
      ],
      cookingTime: cookingTime ?? const Duration(minutes: 30),
      prepTime: prepTime ?? const Duration(minutes: 15),
      difficulty: difficulty ?? DifficultyLevel.intermediate,
      servings: servings ?? 4,
      tags: tags ?? ['mock', 'test'],
      nutrition: nutrition ?? const NutritionInfo(
        calories: 300,
        protein: 20,
        carbs: 25,
        fat: 10,
        fiber: 3,
        sugar: 5,
        sodium: 500,
      ),
      tips: tips ?? ['Mock tip 1', 'Mock tip 2'],
      rating: rating ?? 0.0,
      createdAt: DateTime.now(),
    );
  }

  static List<Recipe> createMockRecipeList({int count = 3}) {
    return List.generate(count, (index) => createMockRecipe(
      id: 'mock-recipe-${index + 1}',
      title: 'Mock Recipe ${index + 1}',
      rating: (index + 1) * 1.0,
    ));
  }

  static UserPreferences createMockUserPreferences({
    int? maxCookingTimeMinutes,
    DifficultyLevel? maxDifficulty,
    int? defaultServings,
    List<DietaryRestriction>? dietaryRestrictions,
    List<String>? allergies,
    SkillLevel? skillLevel,
  }) {
    final mock = MockUserPreferences();
    
    when(mock.maxCookingTimeMinutes).thenReturn(maxCookingTimeMinutes ?? 60);
    when(mock.maxDifficulty).thenReturn(maxDifficulty ?? DifficultyLevel.intermediate);
    when(mock.defaultServings).thenReturn(defaultServings ?? 4);
    when(mock.dietaryRestrictions).thenReturn(dietaryRestrictions ?? []);
    when(mock.allergies).thenReturn(allergies ?? []);
    when(mock.skillLevel).thenReturn(skillLevel ?? SkillLevel.intermediate);
    when(mock.availableEquipment).thenReturn([]);
    
    return mock;
  }
}