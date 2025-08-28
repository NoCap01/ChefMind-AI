import '../entities/nutrition_tracking.dart';

abstract class INutritionRepository {
  /// Get nutrition entries for a user
  Future<List<NutritionEntry>> getUserNutritionEntries(String userId, {DateTime? startDate, DateTime? endDate});

  /// Get nutrition entry for a specific date
  Future<NutritionEntry?> getNutritionEntryByDate(String userId, DateTime date);

  /// Create or update nutrition entry
  Future<NutritionEntry> saveNutritionEntry(NutritionEntry entry);

  /// Delete nutrition entry
  Future<void> deleteNutritionEntry(String entryId);

  /// Add food entry to a date
  Future<NutritionEntry> addFoodEntry(String userId, DateTime date, FoodEntry foodEntry);

  /// Update food entry
  Future<NutritionEntry> updateFoodEntry(String userId, DateTime date, FoodEntry foodEntry);

  /// Remove food entry
  Future<NutritionEntry> removeFoodEntry(String userId, DateTime date, String foodEntryId);

  /// Get nutrition goals for user
  Future<List<NutritionGoal>> getUserNutritionGoals(String userId);

  /// Get active nutrition goal
  Future<NutritionGoal?> getActiveNutritionGoal(String userId);

  /// Create nutrition goal
  Future<NutritionGoal> createNutritionGoal(NutritionGoal goal);

  /// Update nutrition goal
  Future<NutritionGoal> updateNutritionGoal(NutritionGoal goal);

  /// Delete nutrition goal
  Future<void> deleteNutritionGoal(String goalId);

  /// Set active nutrition goal
  Future<void> setActiveNutritionGoal(String userId, String goalId);

  /// Get nutrition progress for date range
  Future<List<NutritionProgress>> getNutritionProgress(String userId, DateTime startDate, DateTime endDate);

  /// Get weekly nutrition summary
  Future<WeeklyNutritionSummary> getWeeklyNutritionSummary(String userId, DateTime weekStartDate);

  /// Get nutrition analytics
  Future<NutritionAnalytics> getNutritionAnalytics(String userId, DateTime startDate, DateTime endDate);

  /// Search food database
  Future<List<FoodDatabase>> searchFoodDatabase(String query, {int limit = 20});

  /// Get food by barcode
  Future<FoodDatabase?> getFoodByBarcode(String barcode);

  /// Add custom food to database
  Future<FoodDatabase> addCustomFood(FoodDatabase food);

  /// Get nutrition recommendations
  Future<List<NutritionRecommendation>> getNutritionRecommendations(String userId);

  /// Create nutrition recommendation
  Future<NutritionRecommendation> createNutritionRecommendation(NutritionRecommendation recommendation);

  /// Dismiss nutrition recommendation
  Future<void> dismissNutritionRecommendation(String recommendationId);

  /// Track water intake
  Future<NutritionEntry> updateWaterIntake(String userId, DateTime date, double waterMl);

  /// Track exercise calories
  Future<NutritionEntry> updateExerciseCalories(String userId, DateTime date, double calories);

  /// Get nutrition trends
  Future<List<NutritionTrend>> getNutritionTrends(String userId, String nutrient, DateTime startDate, DateTime endDate);

  /// Get meal type breakdown
  Future<Map<MealType, NutritionInfo>> getMealTypeBreakdown(String userId, DateTime startDate, DateTime endDate);

  /// Get frequent foods
  Future<List<FoodEntry>> getFrequentFoods(String userId, {int limit = 10});

  /// Get recent foods
  Future<List<FoodEntry>> getRecentFoods(String userId, {int limit = 10});

  /// Export nutrition data
  Future<String> exportNutritionData(String userId, DateTime startDate, DateTime endDate, ExportFormat format);

  /// Import nutrition data
  Future<List<NutritionEntry>> importNutritionData(String userId, String data, ImportFormat format);

  /// Get nutrition streaks
  Future<NutritionStreaks> getNutritionStreaks(String userId);

  /// Calculate nutrition score
  Future<double> calculateNutritionScore(String userId, DateTime date);

  /// Get nutrition insights
  Future<List<NutritionInsight>> getNutritionInsights(String userId);
}

enum ExportFormat {
  csv,
  json,
  pdf,
}

enum ImportFormat {
  csv,
  json,
  myFitnessPal,
  cronometer,
}

class NutritionStreaks {
  final int currentStreak;
  final int longestStreak;
  final int totalDaysTracked;
  final double consistencyPercentage;
  final DateTime? lastTrackedDate;
  final List<StreakMilestone> milestones;

  const NutritionStreaks({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalDaysTracked,
    required this.consistencyPercentage,
    this.lastTrackedDate,
    required this.milestones,
  });

  factory NutritionStreaks.fromJson(Map<String, dynamic> json) {
    return NutritionStreaks(
      currentStreak: json['currentStreak'] as int,
      longestStreak: json['longestStreak'] as int,
      totalDaysTracked: json['totalDaysTracked'] as int,
      consistencyPercentage: (json['consistencyPercentage'] as num).toDouble(),
      lastTrackedDate: json['lastTrackedDate'] != null 
          ? DateTime.parse(json['lastTrackedDate'] as String)
          : null,
      milestones: (json['milestones'] as List<dynamic>)
          .map((e) => StreakMilestone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'totalDaysTracked': totalDaysTracked,
      'consistencyPercentage': consistencyPercentage,
      'lastTrackedDate': lastTrackedDate?.toIso8601String(),
      'milestones': milestones.map((e) => e.toJson()).toList(),
    };
  }
}

class StreakMilestone {
  final int days;
  final String title;
  final String description;
  final bool isAchieved;
  final DateTime? achievedAt;

  const StreakMilestone({
    required this.days,
    required this.title,
    required this.description,
    required this.isAchieved,
    this.achievedAt,
  });

  factory StreakMilestone.fromJson(Map<String, dynamic> json) {
    return StreakMilestone(
      days: json['days'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      isAchieved: json['isAchieved'] as bool,
      achievedAt: json['achievedAt'] != null 
          ? DateTime.parse(json['achievedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'title': title,
      'description': description,
      'isAchieved': isAchieved,
      'achievedAt': achievedAt?.toIso8601String(),
    };
  }
}

class NutritionInsight {
  final String id;
  final String title;
  final String description;
  final InsightType type;
  final InsightPriority priority;
  final Map<String, dynamic> data;
  final List<String> actionItems;
  final DateTime createdAt;

  const NutritionInsight({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.data,
    required this.actionItems,
    required this.createdAt,
  });

  factory NutritionInsight.fromJson(Map<String, dynamic> json) {
    return NutritionInsight(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: InsightType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      priority: InsightPriority.values.firstWhere(
        (e) => e.toString().split('.').last == json['priority'],
      ),
      data: Map<String, dynamic>.from(json['data'] as Map),
      actionItems: List<String>.from(json['actionItems'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'data': data,
      'actionItems': actionItems,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum InsightType {
  pattern,
  deficiency,
  excess,
  trend,
  achievement,
  warning,
}

enum InsightPriority {
  low,
  medium,
  high,
  critical,
}