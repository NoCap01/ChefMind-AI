import 'package:freezed_annotation/freezed_annotation.dart';
import 'recipe.dart';

part 'nutrition_tracking.freezed.dart';
part 'nutrition_tracking.g.dart';

@freezed
class NutritionEntry with _$NutritionEntry {
  const factory NutritionEntry({
    required String id,
    required String userId,
    required DateTime date,
    required List<FoodEntry> foods,
    required NutritionInfo totalNutrition,
    required Map<MealType, NutritionInfo> mealBreakdown,
    NutritionGoals? dailyGoals,
    @Default(0.0) double waterIntakeMl,
    @Default([]) List<String> notes,
    @Default([]) List<String> symptoms,
    @Default(0.0) double exerciseCaloriesBurned,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _NutritionEntry;

  factory NutritionEntry.fromJson(Map<String, dynamic> json) => _$NutritionEntryFromJson(json);
}

@freezed
class FoodEntry with _$FoodEntry {
  const factory FoodEntry({
    required String id,
    required String foodName,
    required double quantity,
    required String unit,
    required NutritionInfo nutrition,
    required MealType mealType,
    required DateTime consumedAt,
    String? recipeId,
    String? recipeName,
    String? brand,
    String? barcode,
    @Default([]) List<String> tags,
    String? notes,
    String? imageUrl,
  }) = _FoodEntry;

  factory FoodEntry.fromJson(Map<String, dynamic> json) => _$FoodEntryFromJson(json);
}

@freezed
class NutritionGoal with _$NutritionGoal {
  const factory NutritionGoal({
    required String id,
    required String userId,
    required String name,
    required NutritionGoals targets,
    required GoalType goalType,
    required DateTime startDate,
    DateTime? endDate,
    @Default(true) bool isActive,
    @Default([]) List<DietaryRestriction> dietaryRestrictions,
    @Default([]) List<String> allergies,
    String? description,
    @Default(0.0) double targetWeight,
    @Default(0.0) double currentWeight,
    ActivityLevel? activityLevel,
    Gender? gender,
    int? age,
    @Default(170.0) double heightCm,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _NutritionGoal;

  factory NutritionGoal.fromJson(Map<String, dynamic> json) => _$NutritionGoalFromJson(json);
}

enum GoalType {
  weightLoss,
  weightGain,
  maintenance,
  muscleGain,
  athletic,
  health,
  custom,
}

enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extraActive,
}

enum Gender {
  male,
  female,
  other,
}

extension GoalTypeExtension on GoalType {
  String get displayName {
    switch (this) {
      case GoalType.weightLoss:
        return 'Weight Loss';
      case GoalType.weightGain:
        return 'Weight Gain';
      case GoalType.maintenance:
        return 'Weight Maintenance';
      case GoalType.muscleGain:
        return 'Muscle Gain';
      case GoalType.athletic:
        return 'Athletic Performance';
      case GoalType.health:
        return 'General Health';
      case GoalType.custom:
        return 'Custom Goal';
    }
  }

  String get description {
    switch (this) {
      case GoalType.weightLoss:
        return 'Lose weight in a healthy and sustainable way';
      case GoalType.weightGain:
        return 'Gain weight and build muscle mass';
      case GoalType.maintenance:
        return 'Maintain current weight and health';
      case GoalType.muscleGain:
        return 'Build lean muscle mass';
      case GoalType.athletic:
        return 'Optimize nutrition for athletic performance';
      case GoalType.health:
        return 'Improve overall health and wellness';
      case GoalType.custom:
        return 'Personalized nutrition goals';
    }
  }
}

@freezed
class NutritionProgress with _$NutritionProgress {
  const factory NutritionProgress({
    required String userId,
    required DateTime date,
    required NutritionGoals goals,
    required NutritionInfo consumed,
    required Map<String, double> percentageAchieved,
    required List<NutritionDeficiency> deficiencies,
    required List<NutritionExcess> excesses,
    required double overallScore,
    @Default([]) List<String> recommendations,
    @Default(0.0) double waterIntakeGoal,
    @Default(0.0) double waterIntakeActual,
    @Default(0.0) double exerciseCaloriesGoal,
    @Default(0.0) double exerciseCaloriesActual,
  }) = _NutritionProgress;

  factory NutritionProgress.fromJson(Map<String, dynamic> json) => _$NutritionProgressFromJson(json);
}

@freezed
class WeeklyNutritionSummary with _$WeeklyNutritionSummary {
  const factory WeeklyNutritionSummary({
    required String userId,
    required DateTime weekStartDate,
    required List<NutritionEntry> dailyEntries,
    required NutritionInfo averageDaily,
    required NutritionInfo weeklyTotal,
    required Map<String, double> goalAchievementRates,
    required List<NutritionTrend> trends,
    @Default(0.0) double averageWaterIntake,
    @Default(0.0) double totalExerciseCalories,
    @Default(0.0) double weightChange,
    required double overallScore,
  }) = _WeeklyNutritionSummary;

  factory WeeklyNutritionSummary.fromJson(Map<String, dynamic> json) => _$WeeklyNutritionSummaryFromJson(json);
}

@freezed
class NutritionTrend with _$NutritionTrend {
  const factory NutritionTrend({
    required String nutrient,
    required TrendDirection direction,
    required double changePercentage,
    required String description,
    required TrendSignificance significance,
  }) = _NutritionTrend;

  factory NutritionTrend.fromJson(Map<String, dynamic> json) => _$NutritionTrendFromJson(json);
}

enum TrendDirection {
  increasing,
  decreasing,
  stable,
}

enum TrendSignificance {
  low,
  moderate,
  high,
  critical,
}

@freezed
class FoodDatabase with _$FoodDatabase {
  const factory FoodDatabase({
    required String id,
    required String name,
    required String brand,
    required NutritionInfo nutritionPer100g,
    @Default([]) List<String> categories,
    @Default([]) List<String> allergens,
    String? barcode,
    String? imageUrl,
    @Default(false) bool isVerified,
    @Default(0) int usageCount,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _FoodDatabase;

  factory FoodDatabase.fromJson(Map<String, dynamic> json) => _$FoodDatabaseFromJson(json);
}

@freezed
class NutritionAnalytics with _$NutritionAnalytics {
  const factory NutritionAnalytics({
    required String userId,
    required DateTime periodStart,
    required DateTime periodEnd,
    required Map<String, double> averageNutrients,
    required Map<String, List<double>> nutrientTrends,
    required Map<String, double> goalAchievementRates,
    required List<String> topFoods,
    required List<String> frequentDeficiencies,
    required Map<MealType, NutritionInfo> mealTypeBreakdown,
    required double averageCalorieIntake,
    required double averageWaterIntake,
    required int totalDaysTracked,
    required double consistencyScore,
  }) = _NutritionAnalytics;

  factory NutritionAnalytics.fromJson(Map<String, dynamic> json) => _$NutritionAnalyticsFromJson(json);
}

@freezed
class NutritionRecommendation with _$NutritionRecommendation {
  const factory NutritionRecommendation({
    required String id,
    required String title,
    required String description,
    required RecommendationType type,
    required RecommendationPriority priority,
    required List<String> suggestedFoods,
    required List<String> suggestedRecipes,
    @Default([]) List<String> avoidFoods,
    String? reasoning,
    @Default([]) List<String> benefits,
    DateTime? expiresAt,
    @Default(false) bool isDismissed,
    required DateTime createdAt,
  }) = _NutritionRecommendation;

  factory NutritionRecommendation.fromJson(Map<String, dynamic> json) => _$NutritionRecommendationFromJson(json);
}

enum RecommendationType {
  nutrientDeficiency,
  nutrientExcess,
  mealTiming,
  hydration,
  exercise,
  general,
}

enum RecommendationPriority {
  low,
  medium,
  high,
  urgent,
}

@freezed
class NutritionFilter with _$NutritionFilter {
  const factory NutritionFilter({
    DateTime? startDate,
    DateTime? endDate,
    @Default([]) List<MealType> mealTypes,
    @Default([]) List<String> foodCategories,
    @Default([]) List<String> tags,
    String? searchQuery,
    @Default(false) bool showOnlyDeficiencies,
    @Default(false) bool showOnlyExcesses,
    double? minCalories,
    double? maxCalories,
  }) = _NutritionFilter;

  factory NutritionFilter.fromJson(Map<String, dynamic> json) => _$NutritionFilterFromJson(json);
}

enum NutritionSortOption {
  date,
  calories,
  protein,
  carbs,
  fat,
  fiber,
  mealType,
}

extension NutritionSortOptionExtension on NutritionSortOption {
  String get displayName {
    switch (this) {
      case NutritionSortOption.date:
        return 'Date';
      case NutritionSortOption.calories:
        return 'Calories';
      case NutritionSortOption.protein:
        return 'Protein';
      case NutritionSortOption.carbs:
        return 'Carbohydrates';
      case NutritionSortOption.fat:
        return 'Fat';
      case NutritionSortOption.fiber:
        return 'Fiber';
      case NutritionSortOption.mealType:
        return 'Meal Type';
    }
  }
}

// Nutrition calculation utilities
class NutritionCalculator {
  /// Calculate BMR (Basal Metabolic Rate) using Mifflin-St Jeor Equation
  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
  }) {
    double bmr = 10 * weightKg + 6.25 * heightCm - 5 * age;
    
    switch (gender) {
      case Gender.male:
        bmr += 5;
        break;
      case Gender.female:
        bmr -= 161;
        break;
      case Gender.other:
        bmr -= 78; // Average of male and female
        break;
    }
    
    return bmr;
  }

  /// Calculate TDEE (Total Daily Energy Expenditure)
  static double calculateTDEE({
    required double bmr,
    required ActivityLevel activityLevel,
  }) {
    double multiplier;
    
    switch (activityLevel) {
      case ActivityLevel.sedentary:
        multiplier = 1.2;
        break;
      case ActivityLevel.lightlyActive:
        multiplier = 1.375;
        break;
      case ActivityLevel.moderatelyActive:
        multiplier = 1.55;
        break;
      case ActivityLevel.veryActive:
        multiplier = 1.725;
        break;
      case ActivityLevel.extraActive:
        multiplier = 1.9;
        break;
    }
    
    return bmr * multiplier;
  }

  /// Calculate calorie goal based on goal type
  static double calculateCalorieGoal({
    required double tdee,
    required GoalType goalType,
    double? customDeficit,
  }) {
    switch (goalType) {
      case GoalType.weightLoss:
        return tdee - 500; // 1 lb per week loss
      case GoalType.weightGain:
        return tdee + 300; // Moderate weight gain
      case GoalType.muscleGain:
        return tdee + 200; // Lean muscle gain
      case GoalType.maintenance:
        return tdee;
      case GoalType.athletic:
        return tdee + 100; // Slight surplus for performance
      case GoalType.health:
        return tdee;
      case GoalType.custom:
        return tdee + (customDeficit ?? 0);
    }
  }

  /// Calculate macronutrient distribution
  static Map<String, double> calculateMacros({
    required double calories,
    required GoalType goalType,
  }) {
    double proteinPercentage;
    double fatPercentage;
    double carbPercentage;

    switch (goalType) {
      case GoalType.weightLoss:
        proteinPercentage = 0.30;
        fatPercentage = 0.25;
        carbPercentage = 0.45;
        break;
      case GoalType.muscleGain:
        proteinPercentage = 0.25;
        fatPercentage = 0.25;
        carbPercentage = 0.50;
        break;
      case GoalType.athletic:
        proteinPercentage = 0.20;
        fatPercentage = 0.25;
        carbPercentage = 0.55;
        break;
      default:
        proteinPercentage = 0.20;
        fatPercentage = 0.30;
        carbPercentage = 0.50;
    }

    return {
      'protein': (calories * proteinPercentage) / 4, // 4 calories per gram
      'fat': (calories * fatPercentage) / 9, // 9 calories per gram
      'carbs': (calories * carbPercentage) / 4, // 4 calories per gram
    };
  }

  /// Calculate water intake goal
  static double calculateWaterGoal({
    required double weightKg,
    required ActivityLevel activityLevel,
  }) {
    double baseWater = weightKg * 35; // 35ml per kg body weight
    
    // Adjust for activity level
    switch (activityLevel) {
      case ActivityLevel.sedentary:
        break; // No adjustment
      case ActivityLevel.lightlyActive:
        baseWater *= 1.1;
        break;
      case ActivityLevel.moderatelyActive:
        baseWater *= 1.2;
        break;
      case ActivityLevel.veryActive:
        baseWater *= 1.3;
        break;
      case ActivityLevel.extraActive:
        baseWater *= 1.4;
        break;
    }
    
    return baseWater;
  }

  /// Calculate nutrition score (0-100)
  static double calculateNutritionScore({
    required NutritionInfo consumed,
    required NutritionGoals goals,
  }) {
    final scores = <double>[];
    
    // Calorie score (closer to goal is better)
    final calorieRatio = consumed.calories / goals.dailyCalories;
    final calorieScore = calorieRatio > 1.2 || calorieRatio < 0.8 
        ? 50 - (calorieRatio - 1).abs() * 100
        : 100 - (calorieRatio - 1).abs() * 50;
    scores.add(calorieScore.clamp(0, 100));
    
    // Protein score
    final proteinRatio = consumed.protein / goals.proteinGrams;
    scores.add((proteinRatio * 100).clamp(0, 100));
    
    // Fiber score
    final fiberRatio = consumed.fiber / goals.fiberGrams;
    scores.add((fiberRatio * 100).clamp(0, 100));
    
    // Sodium score (lower is better)
    final sodiumRatio = consumed.sodium / goals.sodiumMg;
    final sodiumScore = sodiumRatio > 1 ? 100 - (sodiumRatio - 1) * 100 : 100;
    scores.add(sodiumScore.clamp(0, 100));
    
    return scores.reduce((a, b) => a + b) / scores.length;
  }
}

@freezed
class NutritionDeficiency with _$NutritionDeficiency {
  const factory NutritionDeficiency({
    required String nutrient,
    required double currentAmount,
    required double targetAmount,
    required double deficitPercentage,
    required List<String> suggestedFoods,
    @Default(DeficiencySeverity.moderate) DeficiencySeverity severity,
    String? healthImpact,
    @Default([]) List<String> symptoms,
  }) = _NutritionDeficiency;

  factory NutritionDeficiency.fromJson(Map<String, dynamic> json) => _$NutritionDeficiencyFromJson(json);
}

@freezed
class NutritionExcess with _$NutritionExcess {
  const factory NutritionExcess({
    required String nutrient,
    required double currentAmount,
    required double targetAmount,
    required double excessPercentage,
    required List<String> reductionSuggestions,
    @Default(ExcessSeverity.moderate) ExcessSeverity severity,
    String? healthImpact,
    @Default([]) List<String> risks,
  }) = _NutritionExcess;

  factory NutritionExcess.fromJson(Map<String, dynamic> json) => _$NutritionExcessFromJson(json);
}

enum DeficiencySeverity {
  mild,
  moderate,
  severe,
  critical,
}

enum ExcessSeverity {
  mild,
  moderate,
  severe,
  dangerous,
}