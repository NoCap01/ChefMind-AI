import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/domain/entities/nutrition_tracking.dart';
import '../../lib/domain/entities/recipe.dart';
import '../../lib/infrastructure/services/nutrition_service_impl.dart';
import '../mocks/mock_services.dart';

void main() {
  group('Nutrition Calculations Unit Tests', () {
    late MockNutritionRepository mockRepository;
    late NutritionServiceImpl nutritionService;

    setUp(() {
      mockRepository = MockNutritionRepository();
      nutritionService = NutritionServiceImpl(mockRepository);
    });

    group('BMR Calculations', () {
      test('should calculate BMR correctly for male', () {
        // Arrange
        const weightKg = 80.0;
        const heightCm = 180.0;
        const age = 30;
        const gender = Gender.male;

        // Act
        final bmr = NutritionCalculator.calculateBMR(
          weightKg: weightKg,
          heightCm: heightCm,
          age: age,
          gender: gender,
        );

        // Assert
        // Expected: 10 * 80 + 6.25 * 180 - 5 * 30 + 5 = 800 + 1125 - 150 + 5 = 1780
        expect(bmr, equals(1780.0));
      });

      test('should calculate BMR correctly for female', () {
        // Arrange
        const weightKg = 65.0;
        const heightCm = 165.0;
        const age = 25;
        const gender = Gender.female;

        // Act
        final bmr = NutritionCalculator.calculateBMR(
          weightKg: weightKg,
          heightCm: heightCm,
          age: age,
          gender: gender,
        );

        // Assert
        // Expected: 10 * 65 + 6.25 * 165 - 5 * 25 - 161 = 650 + 1031.25 - 125 - 161 = 1395.25
        expect(bmr, equals(1395.25));
      });
    });

    group('TDEE Calculations', () {
      test('should calculate TDEE correctly for sedentary activity', () {
        // Arrange
        const bmr = 1500.0;
        const activityLevel = ActivityLevel.sedentary;

        // Act
        final tdee = NutritionCalculator.calculateTDEE(
          bmr: bmr,
          activityLevel: activityLevel,
        );

        // Assert
        // Expected: 1500 * 1.2 = 1800
        expect(tdee, equals(1800.0));
      });

      test('should calculate TDEE correctly for very active', () {
        // Arrange
        const bmr = 1800.0;
        const activityLevel = ActivityLevel.veryActive;

        // Act
        final tdee = NutritionCalculator.calculateTDEE(
          bmr: bmr,
          activityLevel: activityLevel,
        );

        // Assert
        // Expected: 1800 * 1.725 = 3105
        expect(tdee, equals(3105.0));
      });
    });

    group('Calorie Goal Calculations', () {
      test('should calculate weight loss calorie goal correctly', () {
        // Arrange
        const tdee = 2000.0;
        const goalType = GoalType.weightLoss;

        // Act
        final calorieGoal = NutritionCalculator.calculateCalorieGoal(
          tdee: tdee,
          goalType: goalType,
        );

        // Assert
        // Expected: 2000 - 500 = 1500
        expect(calorieGoal, equals(1500.0));
      });

      test('should calculate weight gain calorie goal correctly', () {
        // Arrange
        const tdee = 2200.0;
        const goalType = GoalType.weightGain;

        // Act
        final calorieGoal = NutritionCalculator.calculateCalorieGoal(
          tdee: tdee,
          goalType: goalType,
        );

        // Assert
        // Expected: 2200 + 300 = 2500
        expect(calorieGoal, equals(2500.0));
      });

      test('should calculate maintenance calorie goal correctly', () {
        // Arrange
        const tdee = 1800.0;
        const goalType = GoalType.maintenance;

        // Act
        final calorieGoal = NutritionCalculator.calculateCalorieGoal(
          tdee: tdee,
          goalType: goalType,
        );

        // Assert
        // Expected: 1800 (no change)
        expect(calorieGoal, equals(1800.0));
      });
    });

    group('Macronutrient Calculations', () {
      test('should calculate macros for weight loss correctly', () {
        // Arrange
        const calories = 1500.0;
        const goalType = GoalType.weightLoss;

        // Act
        final macros = NutritionCalculator.calculateMacros(
          calories: calories,
          goalType: goalType,
        );

        // Assert
        // Expected protein: 1500 * 0.30 / 4 = 112.5g
        // Expected fat: 1500 * 0.25 / 9 = 41.67g
        // Expected carbs: 1500 * 0.45 / 4 = 168.75g
        expect(macros['protein'], closeTo(112.5, 0.1));
        expect(macros['fat'], closeTo(41.67, 0.1));
        expect(macros['carbs'], closeTo(168.75, 0.1));
      });

      test('should calculate macros for muscle gain correctly', () {
        // Arrange
        const calories = 2500.0;
        const goalType = GoalType.muscleGain;

        // Act
        final macros = NutritionCalculator.calculateMacros(
          calories: calories,
          goalType: goalType,
        );

        // Assert
        // Expected protein: 2500 * 0.25 / 4 = 156.25g
        // Expected fat: 2500 * 0.25 / 9 = 69.44g
        // Expected carbs: 2500 * 0.50 / 4 = 312.5g
        expect(macros['protein'], closeTo(156.25, 0.1));
        expect(macros['fat'], closeTo(69.44, 0.1));
        expect(macros['carbs'], closeTo(312.5, 0.1));
      });
    });

    group('Water Goal Calculations', () {
      test('should calculate water goal for sedentary person correctly', () {
        // Arrange
        const weightKg = 70.0;
        const activityLevel = ActivityLevel.sedentary;

        // Act
        final waterGoal = NutritionCalculator.calculateWaterGoal(
          weightKg: weightKg,
          activityLevel: activityLevel,
        );

        // Assert
        // Expected: 70 * 35 = 2450ml
        expect(waterGoal, equals(2450.0));
      });

      test('should calculate water goal for very active person correctly', () {
        // Arrange
        const weightKg = 80.0;
        const activityLevel = ActivityLevel.veryActive;

        // Act
        final waterGoal = NutritionCalculator.calculateWaterGoal(
          weightKg: weightKg,
          activityLevel: activityLevel,
        );

        // Assert
        // Expected: 80 * 35 * 1.3 = 3640ml
        expect(waterGoal, equals(3640.0));
      });
    });

    group('Nutrition Score Calculations', () {
      test('should calculate perfect nutrition score', () {
        // Arrange
        const consumed = NutritionInfo(
          calories: 2000,
          protein: 150,
          carbs: 250,
          fat: 65,
          fiber: 25,
          sugar: 50,
          sodium: 2000,
        );

        const goals = NutritionGoals(
          dailyCalories: 2000,
          proteinGrams: 150,
          carbsGrams: 250,
          fatGrams: 65,
          fiberGrams: 25,
          sodiumMg: 2300,
          sugarGrams: 50,
        );

        // Act
        final score = NutritionCalculator.calculateNutritionScore(
          consumed: consumed,
          goals: goals,
        );

        // Assert
        expect(score, greaterThan(90)); // Should be a high score for perfect match
      });

      test('should calculate lower score for poor nutrition', () {
        // Arrange
        const consumed = NutritionInfo(
          calories: 3000, // Too high
          protein: 50, // Too low
          carbs: 400, // Too high
          fat: 100, // Too high
          fiber: 5, // Too low
          sugar: 100, // Too high
          sodium: 4000, // Too high
        );

        const goals = NutritionGoals(
          dailyCalories: 2000,
          proteinGrams: 150,
          carbsGrams: 250,
          fatGrams: 65,
          fiberGrams: 25,
          sodiumMg: 2300,
          sugarGrams: 50,
        );

        // Act
        final score = NutritionCalculator.calculateNutritionScore(
          consumed: consumed,
          goals: goals,
        );

        // Assert
        expect(score, lessThan(50)); // Should be a low score for poor nutrition
      });
    });

    group('Nutrition Goals Generation', () {
      test('should generate appropriate goals for weight loss', () async {
        // Arrange
        const weightKg = 80.0;
        const heightCm = 175.0;
        const age = 30;
        const gender = Gender.male;
        const activityLevel = ActivityLevel.moderatelyActive;
        const goalType = GoalType.weightLoss;

        // Act
        final goals = await nutritionService.calculateNutritionGoals(
          weightKg: weightKg,
          heightCm: heightCm,
          age: age,
          gender: gender,
          activityLevel: activityLevel,
          goalType: goalType,
        );

        // Assert
        expect(goals.dailyCalories, lessThan(2500)); // Should be in deficit
        expect(goals.proteinGrams, greaterThan(100)); // Adequate protein for weight loss
        expect(goals.fiberGrams, greaterThan(20)); // Good fiber intake
        expect(goals.sodiumMg, equals(2300)); // Standard sodium recommendation
      });

      test('should generate appropriate goals for muscle gain', () async {
        // Arrange
        const weightKg = 70.0;
        const heightCm = 180.0;
        const age = 25;
        const gender = Gender.male;
        const activityLevel = ActivityLevel.veryActive;
        const goalType = GoalType.muscleGain;

        // Act
        final goals = await nutritionService.calculateNutritionGoals(
          weightKg: weightKg,
          heightCm: heightCm,
          age: age,
          gender: gender,
          activityLevel: activityLevel,
          goalType: goalType,
        );

        // Assert
        expect(goals.dailyCalories, greaterThan(2000)); // Should be in surplus
        expect(goals.proteinGrams, greaterThan(120)); // High protein for muscle gain
        expect(goals.carbsGrams, greaterThan(200)); // Adequate carbs for energy
      });
    });

    group('Nutrition Analysis', () {
      test('should analyze nutrition entry and identify deficiencies', () async {
        // Arrange
        const goals = NutritionGoals(
          dailyCalories: 2000,
          proteinGrams: 150,
          carbsGrams: 250,
          fatGrams: 65,
          fiberGrams: 25,
          sodiumMg: 2300,
          sugarGrams: 50,
        );

        final entry = NutritionEntry(
          id: 'test_entry',
          userId: 'test_user',
          date: DateTime.now(),
          foods: [],
          totalNutrition: const NutritionInfo(
            calories: 1500, // Low
            protein: 80, // Low
            carbs: 200,
            fat: 50,
            fiber: 10, // Very low
            sugar: 30,
            sodium: 1800,
          ),
          mealBreakdown: {},
          createdAt: DateTime.now(),
        );

        // Act
        final analysis = await nutritionService.analyzeNutritionEntry(entry, goals);

        // Assert
        expect(analysis.overallScore, lessThan(80)); // Should be lower due to deficiencies
        expect(analysis.deficiencies.length, greaterThan(0)); // Should identify deficiencies
        expect(analysis.improvementAreas.isNotEmpty, isTrue);
        
        // Should identify protein and fiber deficiencies
        final hasProteinDeficiency = analysis.deficiencies.any((d) => d.nutrient == 'Protein');
        final hasFiberDeficiency = analysis.deficiencies.any((d) => d.nutrient == 'Fiber');
        expect(hasProteinDeficiency, isTrue);
        expect(hasFiberDeficiency, isTrue);
      });

      test('should analyze nutrition entry and identify excesses', () async {
        // Arrange
        const goals = NutritionGoals(
          dailyCalories: 2000,
          proteinGrams: 150,
          carbsGrams: 250,
          fatGrams: 65,
          fiberGrams: 25,
          sodiumMg: 2300,
          sugarGrams: 50,
        );

        final entry = NutritionEntry(
          id: 'test_entry',
          userId: 'test_user',
          date: DateTime.now(),
          foods: [],
          totalNutrition: const NutritionInfo(
            calories: 2000,
            protein: 150,
            carbs: 250,
            fat: 65,
            fiber: 25,
            sugar: 50,
            sodium: 4000, // Very high
          ),
          mealBreakdown: {},
          createdAt: DateTime.now(),
        );

        // Act
        final analysis = await nutritionService.analyzeNutritionEntry(entry, goals);

        // Assert
        expect(analysis.excesses.length, greaterThan(0)); // Should identify sodium excess
        
        // Should identify sodium excess
        final hasSodiumExcess = analysis.excesses.any((e) => e.nutrient == 'Sodium');
        expect(hasSodiumExcess, isTrue);
      });
    });

    group('Food Suggestions', () {
      test('should suggest appropriate foods for breakfast protein needs', () async {
        // Arrange
        const goals = NutritionGoals(
          dailyCalories: 2000,
          proteinGrams: 150,
          carbsGrams: 250,
          fatGrams: 65,
          fiberGrams: 25,
          sodiumMg: 2300,
          sugarGrams: 50,
        );

        const currentIntake = NutritionInfo(
          calories: 0,
          protein: 0, // No protein yet
          carbs: 0,
          fat: 0,
          fiber: 0,
          sugar: 0,
          sodium: 0,
        );

        // Act
        final suggestions = await nutritionService.suggestFoodsForGoals(
          goals,
          currentIntake,
          MealType.breakfast,
        );

        // Assert
        expect(suggestions.isNotEmpty, isTrue);
        
        // Should suggest high-protein breakfast foods
        final hasProteinFoods = suggestions.any((s) => 
          s.foodName.toLowerCase().contains('yogurt') || 
          s.foodName.toLowerCase().contains('egg'));
        expect(hasProteinFoods, isTrue);
        
        // Should have reasonable priorities
        for (final suggestion in suggestions) {
          expect(suggestion.priority, greaterThan(0));
          expect(suggestion.priority, lessThanOrEqualTo(1));
        }
      });
    });

    group('Micronutrient Analysis', () {
      test('should analyze micronutrients correctly', () async {
        // Arrange
        final entries = [
          NutritionEntry(
            id: 'entry1',
            userId: 'test_user',
            date: DateTime.now().subtract(const Duration(days: 1)),
            foods: [
              FoodEntry(
                id: 'food1',
                foodName: 'Spinach Salad',
                quantity: 100,
                unit: 'g',
                nutrition: const NutritionInfo(
                  calories: 50, protein: 3, carbs: 8, fat: 1,
                  fiber: 3, sugar: 2, sodium: 20,
                ),
                mealType: MealType.lunch,
                consumedAt: DateTime.now(),
              ),
              FoodEntry(
                id: 'food2',
                foodName: 'Salmon Fillet',
                quantity: 150,
                unit: 'g',
                nutrition: const NutritionInfo(
                  calories: 250, protein: 35, carbs: 0, fat: 12,
                  fiber: 0, sugar: 0, sodium: 80,
                ),
                mealType: MealType.dinner,
                consumedAt: DateTime.now(),
              ),
            ],
            totalNutrition: const NutritionInfo(
              calories: 300, protein: 38, carbs: 8, fat: 13,
              fiber: 3, sugar: 2, sodium: 100,
            ),
            mealBreakdown: {},
            createdAt: DateTime.now(),
          ),
        ];

        // Act
        final analysis = await nutritionService.analyzeMicronutrients(entries, 1);

        // Assert
        expect(analysis.vitamins.isNotEmpty, isTrue);
        expect(analysis.minerals.isNotEmpty, isTrue);
        expect(analysis.overallScore, greaterThanOrEqualTo(0));
        expect(analysis.overallScore, lessThanOrEqualTo(100));
        
        // Should have vitamin and mineral data
        expect(analysis.vitamins.containsKey('Vitamin D'), isTrue);
        expect(analysis.vitamins.containsKey('Folate'), isTrue);
        expect(analysis.minerals.containsKey('Iron'), isTrue);
      });

      test('should identify micronutrient deficiencies', () async {
        // Arrange - entries with limited variety
        final entries = [
          NutritionEntry(
            id: 'entry1',
            userId: 'test_user',
            date: DateTime.now(),
            foods: [
              FoodEntry(
                id: 'food1',
                foodName: 'White Rice',
                quantity: 200,
                unit: 'g',
                nutrition: const NutritionInfo(
                  calories: 200, protein: 4, carbs: 45, fat: 1,
                  fiber: 1, sugar: 0, sodium: 5,
                ),
                mealType: MealType.lunch,
                consumedAt: DateTime.now(),
              ),
            ],
            totalNutrition: const NutritionInfo(
              calories: 200, protein: 4, carbs: 45, fat: 1,
              fiber: 1, sugar: 0, sodium: 5,
            ),
            mealBreakdown: {},
            createdAt: DateTime.now(),
          ),
        ];

        // Act
        final analysis = await nutritionService.analyzeMicronutrients(entries, 1);

        // Assert
        expect(analysis.deficiencies.isNotEmpty, isTrue);
        expect(analysis.overallScore, lessThan(80)); // Should be lower due to limited variety
      });
    });

    group('Dietary Restriction Validation', () {
      test('should validate vegetarian diet correctly', () async {
        // Arrange
        final foods = [
          FoodEntry(
            id: 'food1',
            foodName: 'Grilled Vegetables',
            quantity: 200,
            unit: 'g',
            nutrition: const NutritionInfo(
              calories: 100, protein: 3, carbs: 20, fat: 2,
              fiber: 5, sugar: 8, sodium: 10,
            ),
            mealType: MealType.lunch,
            consumedAt: DateTime.now(),
          ),
          FoodEntry(
            id: 'food2',
            foodName: 'Chicken Breast', // Violates vegetarian
            quantity: 150,
            unit: 'g',
            nutrition: const NutritionInfo(
              calories: 250, protein: 35, carbs: 0, fat: 12,
              fiber: 0, sugar: 0, sodium: 80,
            ),
            mealType: MealType.dinner,
            consumedAt: DateTime.now(),
          ),
        ];

        const restrictions = [DietaryRestriction.vegetarian];
        const allergies = <String>[];

        // Act
        final validation = await nutritionService.validateDietaryRestrictions(
          foods, restrictions, allergies,
        );

        // Assert
        expect(validation.isValid, isFalse);
        expect(validation.violations.length, equals(1));
        expect(validation.violations.first.foodName, equals('Chicken Breast'));
        expect(validation.violations.first.restriction, equals(DietaryRestriction.vegetarian));
        expect(validation.complianceScore, lessThan(100));
      });

      test('should validate allergen restrictions correctly', () async {
        // Arrange
        final foods = [
          FoodEntry(
            id: 'food1',
            foodName: 'Peanut Butter Sandwich',
            quantity: 1,
            unit: 'serving',
            nutrition: const NutritionInfo(
              calories: 350, protein: 15, carbs: 30, fat: 20,
              fiber: 4, sugar: 8, sodium: 400,
            ),
            mealType: MealType.lunch,
            consumedAt: DateTime.now(),
          ),
        ];

        const restrictions = <DietaryRestriction>[];
        const allergies = ['nuts'];

        // Act
        final validation = await nutritionService.validateDietaryRestrictions(
          foods, restrictions, allergies,
        );

        // Assert
        expect(validation.isValid, isFalse);
        expect(validation.allergenAlerts.length, equals(1));
        expect(validation.allergenAlerts.first.allergen, equals('nuts'));
        expect(validation.allergenAlerts.first.severity, equals(AlertSeverity.high));
      });

      test('should pass validation for compliant foods', () async {
        // Arrange
        final foods = [
          FoodEntry(
            id: 'food1',
            foodName: 'Quinoa Salad',
            quantity: 200,
            unit: 'g',
            nutrition: const NutritionInfo(
              calories: 180, protein: 8, carbs: 30, fat: 4,
              fiber: 6, sugar: 3, sodium: 15,
            ),
            mealType: MealType.lunch,
            consumedAt: DateTime.now(),
          ),
        ];

        const restrictions = [DietaryRestriction.vegetarian, DietaryRestriction.glutenFree];
        const allergies = <String>[];

        // Act
        final validation = await nutritionService.validateDietaryRestrictions(
          foods, restrictions, allergies,
        );

        // Assert
        expect(validation.isValid, isTrue);
        expect(validation.violations.isEmpty, isTrue);
        expect(validation.allergenAlerts.isEmpty, isTrue);
        expect(validation.complianceScore, equals(100));
      });
    });

    group('Progress Tracking', () {
      test('should track nutrition progress correctly', () async {
        // Arrange
        const userId = 'test_user';
        final startDate = DateTime.now().subtract(const Duration(days: 7));
        final endDate = DateTime.now();

        // Mock repository to return entries
        when(mockRepository.getUserNutritionEntries(
          userId,
          startDate: startDate,
          endDate: endDate,
        )).thenAnswer((_) async => [
          NutritionEntry(
            id: 'entry1',
            userId: userId,
            date: DateTime.now().subtract(const Duration(days: 1)),
            foods: [],
            totalNutrition: const NutritionInfo(
              calories: 1800, protein: 120, carbs: 200, fat: 60,
              fiber: 20, sugar: 40, sodium: 2000,
            ),
            mealBreakdown: {},
            createdAt: DateTime.now(),
          ),
        ]);

        when(mockRepository.getActiveNutritionGoal(userId))
            .thenAnswer((_) async => NutritionGoal(
          id: 'goal1',
          userId: userId,
          name: 'Weight Loss',
          targets: const NutritionGoals(
            dailyCalories: 1800,
            proteinGrams: 120,
            carbsGrams: 200,
            fatGrams: 60,
            fiberGrams: 25,
            sodiumMg: 2300,
            sugarGrams: 50,
          ),
          goalType: GoalType.weightLoss,
          startDate: startDate,
          createdAt: DateTime.now(),
        ));

        // Act
        final progress = await nutritionService.trackNutritionProgress(
          userId, startDate, endDate,
        );

        // Assert
        expect(progress.userId, equals(userId));
        expect(progress.metrics.isNotEmpty, isTrue);
        expect(progress.overallProgress, greaterThanOrEqualTo(0));
        expect(progress.overallProgress, lessThanOrEqualTo(100));
        expect(progress.insights.isNotEmpty, isTrue);
        
        // Should have key metrics
        expect(progress.metrics.containsKey('calories'), isTrue);
        expect(progress.metrics.containsKey('protein'), isTrue);
        expect(progress.metrics.containsKey('fiber'), isTrue);
      });

      test('should handle empty progress data gracefully', () async {
        // Arrange
        const userId = 'test_user';
        final startDate = DateTime.now().subtract(const Duration(days: 7));
        final endDate = DateTime.now();

        when(mockRepository.getUserNutritionEntries(
          userId,
          startDate: startDate,
          endDate: endDate,
        )).thenAnswer((_) async => []);

        // Act
        final progress = await nutritionService.trackNutritionProgress(
          userId, startDate, endDate,
        );

        // Assert
        expect(progress.userId, equals(userId));
        expect(progress.metrics.isEmpty, isTrue);
        expect(progress.overallProgress, equals(0));
        expect(progress.insights.first, contains('Start tracking'));
      });
    });
  });
}