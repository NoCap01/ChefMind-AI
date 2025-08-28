import '../entities/nutrition_tracking.dart';
import '../entities/recipe.dart';

abstract class INutritionService {
  /// Calculate nutrition goals based on user profile
  Future<NutritionGoals> calculateNutritionGoals({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
    required GoalType goalType,
    double? targetWeightKg,
  });

  /// Analyze nutrition entry and provide feedback
  Future<NutritionAnalysis> analyzeNutritionEntry(
    NutritionEntry entry,
    NutritionGoals goals,
  );

  /// Generate nutrition recommendations
  Future<List<NutritionRecommendation>> generateRecommendations(
    String userId,
    List<NutritionEntry> recentEntries,
    NutritionGoals goals,
  );

  /// Calculate nutrition from recipe
  Future<NutritionInfo> calculateRecipeNutrition(
    Recipe recipe,
    int servings,
  );

  /// Suggest foods to meet nutrition goals
  Future<List<FoodSuggestion>> suggestFoodsForGoals(
    NutritionGoals goals,
    NutritionInfo currentIntake,
    MealType targetMealType,
  );

  /// Analyze nutrition trends
  Future<List<NutritionTrend>> analyzeNutritionTrends(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Calculate meal timing optimization
  Future<MealTimingRecommendation> optimizeMealTiming(
    List<NutritionEntry> entries,
    ActivityLevel activityLevel,
  );

  /// Generate nutrition report
  Future<NutritionReport> generateNutritionReport(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Validate dietary restrictions
  Future<DietaryValidation> validateDietaryRestrictions(
    List<FoodEntry> foods,
    List<DietaryRestriction> restrictions,
    List<String> allergies,
  );

  /// Calculate hydration needs
  Future<HydrationRecommendation> calculateHydrationNeeds(
    double weightKg,
    ActivityLevel activityLevel,
    double exerciseMinutes,
    double environmentTemperature,
  );

  /// Analyze micronutrient status
  Future<MicronutrientAnalysis> analyzeMicronutrients(
    List<NutritionEntry> entries,
    int daysAnalyzed,
  );

  /// Generate meal suggestions for nutrition goals
  Future<List<MealSuggestion>> generateMealSuggestions(
    NutritionGoals goals,
    NutritionInfo currentDayIntake,
    MealType mealType,
    List<DietaryRestriction> restrictions,
  );

  /// Calculate supplement recommendations
  Future<List<SupplementRecommendation>> calculateSupplementRecommendations(
    MicronutrientAnalysis analysis,
    List<DietaryRestriction> restrictions,
  );

  /// Optimize nutrition for exercise
  Future<ExerciseNutritionPlan> optimizeForExercise(
    NutritionGoals baseGoals,
    ExerciseType exerciseType,
    Duration exerciseDuration,
    DateTime exerciseTime,
  );

  /// Track nutrition progress
  Future<NutritionProgressSummary> trackNutritionProgress(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Generate nutrition insights
  Future<List<NutritionInsight>> generateNutritionInsights(
    String userId,
    List<NutritionEntry> entries,
  );
}

class NutritionAnalysis {
  final double overallScore;
  final Map<String, double> nutrientScores;
  final List<NutritionDeficiency> deficiencies;
  final List<NutritionExcess> excesses;
  final List<String> positiveAspects;
  final List<String> improvementAreas;
  final NutritionQuality quality;

  const NutritionAnalysis({
    required this.overallScore,
    required this.nutrientScores,
    required this.deficiencies,
    required this.excesses,
    required this.positiveAspects,
    required this.improvementAreas,
    required this.quality,
  });
}

enum NutritionQuality {
  excellent,
  good,
  fair,
  poor,
}

class FoodSuggestion {
  final String foodName;
  final double quantity;
  final String unit;
  final NutritionInfo nutrition;
  final String reason;
  final double priority;
  final List<String> alternatives;

  const FoodSuggestion({
    required this.foodName,
    required this.quantity,
    required this.unit,
    required this.nutrition,
    required this.reason,
    required this.priority,
    required this.alternatives,
  });
}

class MealTimingRecommendation {
  final Map<MealType, TimeRange> optimalTimes;
  final List<String> recommendations;
  final PreWorkoutNutrition? preWorkout;
  final PostWorkoutNutrition? postWorkout;

  const MealTimingRecommendation({
    required this.optimalTimes,
    required this.recommendations,
    this.preWorkout,
    this.postWorkout,
  });
}

class TimeRange {
  final DateTime start;
  final DateTime end;

  const TimeRange({
    required this.start,
    required this.end,
  });
}

class PreWorkoutNutrition {
  final Duration timingBeforeWorkout;
  final double recommendedCarbs;
  final double recommendedProtein;
  final List<String> suggestedFoods;

  const PreWorkoutNutrition({
    required this.timingBeforeWorkout,
    required this.recommendedCarbs,
    required this.recommendedProtein,
    required this.suggestedFoods,
  });
}

class PostWorkoutNutrition {
  final Duration timingAfterWorkout;
  final double recommendedProtein;
  final double recommendedCarbs;
  final List<String> suggestedFoods;

  const PostWorkoutNutrition({
    required this.timingAfterWorkout,
    required this.recommendedProtein,
    required this.recommendedCarbs,
    required this.suggestedFoods,
  });
}

class NutritionReport {
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final NutritionSummary summary;
  final List<NutritionTrend> trends;
  final List<NutritionAchievement> achievements;
  final List<NutritionRecommendation> recommendations;
  final Map<String, dynamic> charts;

  const NutritionReport({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.summary,
    required this.trends,
    required this.achievements,
    required this.recommendations,
    required this.charts,
  });
}

class NutritionSummary {
  final NutritionInfo averageDaily;
  final NutritionInfo totalPeriod;
  final Map<String, double> goalAchievementRates;
  final double overallScore;
  final int daysTracked;
  final double consistencyScore;

  const NutritionSummary({
    required this.averageDaily,
    required this.totalPeriod,
    required this.goalAchievementRates,
    required this.overallScore,
    required this.daysTracked,
    required this.consistencyScore,
  });
}

class NutritionAchievement {
  final String id;
  final String title;
  final String description;
  final AchievementType type;
  final DateTime achievedAt;
  final Map<String, dynamic> data;

  const NutritionAchievement({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.achievedAt,
    required this.data,
  });
}

enum AchievementType {
  streak,
  goal,
  improvement,
  consistency,
  milestone,
}

class DietaryValidation {
  final bool isValid;
  final List<DietaryViolation> violations;
  final List<AllergenAlert> allergenAlerts;
  final double complianceScore;

  const DietaryValidation({
    required this.isValid,
    required this.violations,
    required this.allergenAlerts,
    required this.complianceScore,
  });
}

class DietaryViolation {
  final String foodName;
  final DietaryRestriction restriction;
  final String reason;
  final ViolationSeverity severity;

  const DietaryViolation({
    required this.foodName,
    required this.restriction,
    required this.reason,
    required this.severity,
  });
}

enum ViolationSeverity {
  minor,
  moderate,
  major,
}

class AllergenAlert {
  final String foodName;
  final String allergen;
  final AlertSeverity severity;
  final List<String> alternatives;

  const AllergenAlert({
    required this.foodName,
    required this.allergen,
    required this.severity,
    required this.alternatives,
  });
}

enum AlertSeverity {
  low,
  medium,
  high,
  critical,
}

class HydrationRecommendation {
  final double dailyGoalMl;
  final double preExerciseMl;
  final double duringExerciseMl;
  final double postExerciseMl;
  final List<String> tips;
  final Map<String, double> hourlyDistribution;

  const HydrationRecommendation({
    required this.dailyGoalMl,
    required this.preExerciseMl,
    required this.duringExerciseMl,
    required this.postExerciseMl,
    required this.tips,
    required this.hourlyDistribution,
  });
}

class MicronutrientAnalysis {
  final Map<String, MicronutrientStatus> vitamins;
  final Map<String, MicronutrientStatus> minerals;
  final List<String> deficiencies;
  final List<String> excesses;
  final double overallScore;

  const MicronutrientAnalysis({
    required this.vitamins,
    required this.minerals,
    required this.deficiencies,
    required this.excesses,
    required this.overallScore,
  });
}

class MicronutrientStatus {
  final String name;
  final double averageIntake;
  final double recommendedIntake;
  final double percentageOfRDA;
  final MicronutrientLevel level;
  final List<String> foodSources;

  const MicronutrientStatus({
    required this.name,
    required this.averageIntake,
    required this.recommendedIntake,
    required this.percentageOfRDA,
    required this.level,
    required this.foodSources,
  });
}

enum MicronutrientLevel {
  deficient,
  low,
  adequate,
  high,
  excessive,
}

class MealSuggestion {
  final String mealName;
  final List<String> ingredients;
  final NutritionInfo nutrition;
  final int prepTimeMinutes;
  final String reason;
  final double matchScore;

  const MealSuggestion({
    required this.mealName,
    required this.ingredients,
    required this.nutrition,
    required this.prepTimeMinutes,
    required this.reason,
    required this.matchScore,
  });
}

class SupplementRecommendation {
  final String supplementName;
  final double dosage;
  final String unit;
  final String timing;
  final String reason;
  final SupplementPriority priority;
  final List<String> interactions;
  final List<String> alternatives;

  const SupplementRecommendation({
    required this.supplementName,
    required this.dosage,
    required this.unit,
    required this.timing,
    required this.reason,
    required this.priority,
    required this.interactions,
    required this.alternatives,
  });
}

enum SupplementPriority {
  low,
  medium,
  high,
  essential,
}

class ExerciseNutritionPlan {
  final NutritionGoals adjustedGoals;
  final PreWorkoutNutrition preWorkout;
  final PostWorkoutNutrition postWorkout;
  final HydrationRecommendation hydration;
  final List<String> recommendations;

  const ExerciseNutritionPlan({
    required this.adjustedGoals,
    required this.preWorkout,
    required this.postWorkout,
    required this.hydration,
    required this.recommendations,
  });
}

enum ExerciseType {
  cardio,
  strength,
  hiit,
  endurance,
  flexibility,
  sports,
}

class NutritionProgressSummary {
  final String userId;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, ProgressMetric> metrics;
  final List<ProgressMilestone> milestones;
  final double overallProgress;
  final List<String> insights;

  const NutritionProgressSummary({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.metrics,
    required this.milestones,
    required this.overallProgress,
    required this.insights,
  });
}

class ProgressMetric {
  final String name;
  final double startValue;
  final double currentValue;
  final double targetValue;
  final double progressPercentage;
  final TrendDirection trend;

  const ProgressMetric({
    required this.name,
    required this.startValue,
    required this.currentValue,
    required this.targetValue,
    required this.progressPercentage,
    required this.trend,
  });
}

class ProgressMilestone {
  final String title;
  final String description;
  final DateTime? achievedAt;
  final bool isAchieved;
  final double targetValue;
  final String metric;

  const ProgressMilestone({
    required this.title,
    required this.description,
    this.achievedAt,
    required this.isAchieved,
    required this.targetValue,
    required this.metric,
  });
}