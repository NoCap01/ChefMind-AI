import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'analytics.freezed.dart';
part 'analytics.g.dart';

@freezed
@HiveType(typeId: 49)
class UserAnalytics with _$UserAnalytics {
  const factory UserAnalytics({
    @HiveField(0) required String userId,
    @HiveField(1) required CookingStatistics cookingStats,
    @HiveField(2) required TasteProfile tasteProfile,
    @HiveField(3) required EfficiencyMetrics efficiency,
    @HiveField(4) required CostAnalysis costAnalysis,
    @HiveField(5) required HealthImpact healthImpact,
    @HiveField(6) required EnvironmentalImpact environmentalImpact,
    @HiveField(7) required DateTime lastUpdated,
    @HiveField(8) @Default({}) Map<String, dynamic> customMetrics,
    @HiveField(9) @Default('weekly') String cookingFrequency,
    @HiveField(10) @Default('intermediate') String preferredDifficulty,
  }) = _UserAnalytics;

  factory UserAnalytics.fromJson(Map<String, dynamic> json) =>
      _$UserAnalyticsFromJson(json);
}

// Rest of your analytics classes remain the same...
@freezed
@HiveType(typeId: 50)
class CookingStatistics with _$CookingStatistics {
  const factory CookingStatistics({
    @HiveField(0) @Default(0) int totalRecipesCooked,
    @HiveField(1) @Default(0) int uniqueRecipesCooked,
    @HiveField(2) @Default(0) int totalCookingTimeMinutes,
    @HiveField(3) @Default(0) int currentStreak,
    @HiveField(4) @Default(0) int longestStreak,
    @HiveField(5) @Default({}) Map<String, int> cuisineFrequency,
    @HiveField(6) @Default({}) Map<String, int> difficultyDistribution,
    @HiveField(7) @Default({}) Map<String, int> cookingMethodFrequency,
    @HiveField(8) @Default({}) Map<String, double> averageRatings,
    @HiveField(9) @Default({}) Map<String, int> monthlyActivity,
    @HiveField(10) DateTime? lastCookingDate,
    @HiveField(11) @Default([]) List<String> favoriteRecipeIds,
    @HiveField(12) @Default([]) List<CookingMilestone> milestones,
  }) = _CookingStatistics;

  factory CookingStatistics.fromJson(Map<String, dynamic> json) =>
      _$CookingStatisticsFromJson(json);
}

// ... (rest of your existing analytics classes remain unchanged)
@freezed
@HiveType(typeId: 51)
class TasteProfile with _$TasteProfile {
  const factory TasteProfile({
    @HiveField(0) @Default({}) Map<String, double> flavorPreferences,
    @HiveField(1) @Default({}) Map<String, double> ingredientFrequency,
    @HiveField(2) @Default({}) Map<String, double> cuisinePreferences,
    @HiveField(3) @Default({}) Map<String, double> spiceLevelDistribution,
    @HiveField(4) @Default({}) Map<String, double> texturePreferences,
    @HiveField(5) @Default({}) Map<String, double> cookingTimePreferences,
    @HiveField(6) @Default([]) List<String> dislikedIngredients,
    @HiveField(7) @Default([]) List<String> allergens,
    @HiveField(8) @Default({}) Map<String, TrendData> preferenceTrends,
    @HiveField(9) DateTime? lastAnalyzed,
  }) = _TasteProfile;

  factory TasteProfile.fromJson(Map<String, dynamic> json) =>
      _$TasteProfileFromJson(json);
}

@freezed
@HiveType(typeId: 52)
class EfficiencyMetrics with _$EfficiencyMetrics {
  const factory EfficiencyMetrics({
    @HiveField(0) @Default(0.0) double averageCookingTime,
    @HiveField(1) @Default(0.0) double averagePrepTime,
    @HiveField(2) @Default(0.0) double successRate,
    @HiveField(3) @Default(0.0) double recipeCompletionRate,
    @HiveField(4) @Default(0.0) double ingredientUtilizationRate,
    @HiveField(5) @Default(0.0) double mealPlanAdherence,
    @HiveField(6) @Default(0.0) double foodWasteReduction,
    @HiveField(7) @Default({}) Map<String, double> skillProgression,
    @HiveField(8) @Default({}) Map<String, int> equipmentUsage,
    @HiveField(9) @Default([]) List<EfficiencyTip> recommendations,
  }) = _EfficiencyMetrics;

  factory EfficiencyMetrics.fromJson(Map<String, dynamic> json) =>
      _$EfficiencyMetricsFromJson(json);
}

@freezed
@HiveType(typeId: 53)
class CostAnalysis with _$CostAnalysis {
  const factory CostAnalysis({
    @HiveField(0) @Default(0.0) double totalSpent,
    @HiveField(1) @Default(0.0) double averageMealCost,
    @HiveField(2) @Default(0.0) double averageIngredientCost,
    @HiveField(3) @Default({}) Map<String, double> monthlySpending,
    @HiveField(4) @Default({}) Map<String, double> categorySpending,
    @HiveField(5) @Default({}) Map<String, double> costPerCuisine,
    @HiveField(6) @Default(0.0) double budgetAdherence,
    @HiveField(7) @Default(0.0) double savingsFromMealPlanning,
    @HiveField(8) @Default([]) List<CostSavingTip> savingsTips,
    @HiveField(9) @Default({}) Map<String, PriceHistory> priceHistory,
  }) = _CostAnalysis;

  factory CostAnalysis.fromJson(Map<String, dynamic> json) =>
      _$CostAnalysisFromJson(json);
}

@freezed
@HiveType(typeId: 54)
class HealthImpact with _$HealthImpact {
  const factory HealthImpact({
    @HiveField(0) @Default({}) Map<String, double> nutritionTrends,
    @HiveField(1) @Default(0.0) double averageDailyCalories,
    @HiveField(2) @Default({}) Map<String, double> macroDistribution,
    @HiveField(3) @Default({}) Map<String, double> micronutrientIntake,
    @HiveField(4) @Default(0.0) double dietaryGoalProgress,
    @HiveField(5) @Default(0.0) double nutritionScore,
    @HiveField(6) @Default([]) List<HealthInsight> insights,
    @HiveField(7) @Default({}) Map<String, TrendData> healthTrends,
    @HiveField(8) DateTime? lastNutritionAnalysis,
  }) = _HealthImpact;

  factory HealthImpact.fromJson(Map<String, dynamic> json) =>
      _$HealthImpactFromJson(json);
}

@freezed
@HiveType(typeId: 55)
class EnvironmentalImpact with _$EnvironmentalImpact {
  const factory EnvironmentalImpact({
    @HiveField(0) @Default(0.0) double carbonFootprint,
    @HiveField(1) @Default(0.0) double waterUsage,
    @HiveField(2) @Default(0.0) double foodWasteReduction,
    @HiveField(3) @Default(0.0) double localIngredientPercentage,
    @HiveField(4) @Default(0.0) double seasonalIngredientPercentage,
    @HiveField(5) @Default(0.0) double sustainabilityScore,
    @HiveField(6) @Default([]) List<SustainabilityTip> tips,
    @HiveField(7) @Default({}) Map<String, double> impactByCategory,
    @HiveField(8) @Default({}) Map<String, TrendData> environmentalTrends,
  }) = _EnvironmentalImpact;

  factory EnvironmentalImpact.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentalImpactFromJson(json);
}

@freezed
@HiveType(typeId: 56)
class TrendData with _$TrendData {
  const factory TrendData({
    @HiveField(0) required List<DataPoint> dataPoints,
    @HiveField(1) required TrendDirection direction,
    @HiveField(2) required double changePercentage,
    @HiveField(3) required String timeframe,
  }) = _TrendData;

  factory TrendData.fromJson(Map<String, dynamic> json) =>
      _$TrendDataFromJson(json);
}

@freezed
@HiveType(typeId: 57)
class DataPoint with _$DataPoint {
  const factory DataPoint({
    @HiveField(0) required DateTime timestamp,
    @HiveField(1) required double value,
    @HiveField(2) String? label,
  }) = _DataPoint;

  factory DataPoint.fromJson(Map<String, dynamic> json) =>
      _$DataPointFromJson(json);
}

@freezed
@HiveType(typeId: 58)
class CookingMilestone with _$CookingMilestone {
  const factory CookingMilestone({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required DateTime achievedAt,
    @HiveField(4) required MilestoneType type,
    @HiveField(5) String? badgeUrl,
    @HiveField(6) @Default(0) int points,
  }) = _CookingMilestone;

  factory CookingMilestone.fromJson(Map<String, dynamic> json) =>
      _$CookingMilestoneFromJson(json);
}

@freezed
@HiveType(typeId: 59)
class EfficiencyTip with _$EfficiencyTip {
  const factory EfficiencyTip({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required TipCategory category,
    @HiveField(4) required double potentialImprovement,
    @HiveField(5) @Default(TipPriority.medium) TipPriority priority,
  }) = _EfficiencyTip;

  factory EfficiencyTip.fromJson(Map<String, dynamic> json) =>
      _$EfficiencyTipFromJson(json);
}

@freezed
@HiveType(typeId: 60)
class CostSavingTip with _$CostSavingTip {
  const factory CostSavingTip({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required double potentialSavings,
    @HiveField(4) required TipCategory category,
    @HiveField(5) @Default(TipPriority.medium) TipPriority priority,
  }) = _CostSavingTip;

  factory CostSavingTip.fromJson(Map<String, dynamic> json) =>
      _$CostSavingTipFromJson(json);
}

@freezed
@HiveType(typeId: 61)
class HealthInsight with _$HealthInsight {
  const factory HealthInsight({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required InsightType type,
    @HiveField(4) required double impact,
    @HiveField(5) @Default([]) List<String> recommendations,
  }) = _HealthInsight;

  factory HealthInsight.fromJson(Map<String, dynamic> json) =>
      _$HealthInsightFromJson(json);
}

@freezed
@HiveType(typeId: 62)
class SustainabilityTip with _$SustainabilityTip {
  const factory SustainabilityTip({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String description,
    @HiveField(3) required double environmentalImpact,
    @HiveField(4) required TipCategory category,
    @HiveField(5) @Default(TipPriority.medium) TipPriority priority,
  }) = _SustainabilityTip;

  factory SustainabilityTip.fromJson(Map<String, dynamic> json) =>
      _$SustainabilityTipFromJson(json);
}

@freezed
@HiveType(typeId: 63)
class PriceHistory with _$PriceHistory {
  const factory PriceHistory({
    @HiveField(0) required String itemName,
    @HiveField(1) required List<PricePoint> pricePoints,
    @HiveField(2) required double averagePrice,
    @HiveField(3) required double lowestPrice,
    @HiveField(4) required double highestPrice,
    @HiveField(5) required TrendDirection priceTrend,
  }) = _PriceHistory;

  factory PriceHistory.fromJson(Map<String, dynamic> json) =>
      _$PriceHistoryFromJson(json);
}

@freezed
@HiveType(typeId: 64)
class PricePoint with _$PricePoint {
  const factory PricePoint({
    @HiveField(0) required DateTime date,
    @HiveField(1) required double price,
    @HiveField(2) String? store,
    @HiveField(3) String? location,
  }) = _PricePoint;

  factory PricePoint.fromJson(Map<String, dynamic> json) =>
      _$PricePointFromJson(json);
}

@HiveType(typeId: 65)
enum TrendDirection {
  @HiveField(0)
  increasing,
  @HiveField(1)
  decreasing,
  @HiveField(2)
  stable,
  @HiveField(3)
  volatile,
}

@HiveType(typeId: 66)
enum MilestoneType {
  @HiveField(0)
  recipeCount,
  @HiveField(1)
  streak,
  @HiveField(2)
  skill,
  @HiveField(3)
  cuisine,
  @HiveField(4)
  difficulty,
  @HiveField(5)
  social,
  @HiveField(6)
  efficiency,
}

@HiveType(typeId: 67)
enum TipCategory {
  @HiveField(0)
  time,
  @HiveField(1)
  cost,
  @HiveField(2)
  health,
  @HiveField(3)
  sustainability,
  @HiveField(4)
  skill,
  @HiveField(5)
  equipment,
}

@HiveType(typeId: 68)
enum TipPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
  @HiveField(3)
  urgent,
}

@HiveType(typeId: 69)
enum InsightType {
  @HiveField(0)
  nutrition,
  @HiveField(1)
  calories,
  @HiveField(2)
  macros,
  @HiveField(3)
  vitamins,
  @HiveField(4)
  minerals,
  @HiveField(5)
  dietary,
}
