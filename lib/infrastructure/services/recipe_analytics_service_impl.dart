import '../../domain/services/recipe_analytics_service.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/analytics.dart';
import '../../domain/exceptions/app_exceptions.dart';
import 'firebase_service.dart';

class RecipeAnalyticsServiceImpl implements IRecipeAnalyticsService {
  final FirebaseService _firebaseService = FirebaseService.instance;

  static final RecipeAnalyticsServiceImpl _instance = RecipeAnalyticsServiceImpl._internal();
  factory RecipeAnalyticsServiceImpl() => _instance;
  RecipeAnalyticsServiceImpl._internal();

  static RecipeAnalyticsServiceImpl get instance => _instance;

  @override
  Future<void> rateRecipe(String recipeId, double rating, String? feedback) async {
    try {
      await _firebaseService.setDocument(
        'recipe_ratings',
        '${recipeId}_${DateTime.now().millisecondsSinceEpoch}',
        {
          'recipeId': recipeId,
          'rating': rating,
          'feedback': feedback,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await _firebaseService.logEvent('recipe_rated', {
        'recipe_id': recipeId,
        'rating': rating,
        'has_feedback': feedback != null,
      });
    } catch (e) {
      throw AnalyticsException('Failed to rate recipe: $e');
    }
  }

  @override
  Future<void> recordRecipeSuccess(String recipeId, bool wasSuccessful, String? notes) async {
    try {
      await _firebaseService.setDocument(
        'recipe_attempts',
        '${recipeId}_${DateTime.now().millisecondsSinceEpoch}',
        {
          'recipeId': recipeId,
          'wasSuccessful': wasSuccessful,
          'notes': notes,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await _firebaseService.logEvent('recipe_cooked', {
        'recipe_id': recipeId,
        'success': wasSuccessful,
        'has_notes': notes != null,
      });
    } catch (e) {
      throw AnalyticsException('Failed to record recipe success: $e');
    }
  }

  @override
  Future<void> recordCookingTime(String recipeId, Duration actualTime) async {
    try {
      await _firebaseService.setDocument(
        'cooking_times',
        '${recipeId}_${DateTime.now().millisecondsSinceEpoch}',
        {
          'recipeId': recipeId,
          'actualTimeMinutes': actualTime.inMinutes,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await _firebaseService.logEvent('cooking_time_recorded', {
        'recipe_id': recipeId,
        'actual_time_minutes': actualTime.inMinutes,
      });
    } catch (e) {
      throw AnalyticsException('Failed to record cooking time: $e');
    }
  }

  @override
  Future<void> recordRecipeView(String recipeId) async {
    try {
      await _firebaseService.setDocument(
        'recipe_views',
        '${recipeId}_${DateTime.now().millisecondsSinceEpoch}',
        {
          'recipeId': recipeId,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await _firebaseService.logEvent('recipe_viewed', {
        'recipe_id': recipeId,
      });
    } catch (e) {
      throw AnalyticsException('Failed to record recipe view: $e');
    }
  }

  @override
  Future<void> recordRecipeShare(String recipeId, String platform) async {
    try {
      await _firebaseService.setDocument(
        'recipe_shares',
        '${recipeId}_${DateTime.now().millisecondsSinceEpoch}',
        {
          'recipeId': recipeId,
          'platform': platform,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      await _firebaseService.logEvent('recipe_shared', {
        'recipe_id': recipeId,
        'platform': platform,
      });
    } catch (e) {
      throw AnalyticsException('Failed to record recipe share: $e');
    }
  }

  @override
  Future<RecipeAnalytics> getRecipeAnalytics(String recipeId) async {
    try {
      // Get ratings
      final ratingsQuery = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      final ratings = ratingsQuery.map((doc) => doc['rating'] as double).toList();
      final averageRating = ratings.isEmpty ? 0.0 : ratings.reduce((a, b) => a + b) / ratings.length;
      
      final ratingDistribution = <int, int>{};
      for (final rating in ratings) {
        final roundedRating = rating.round();
        ratingDistribution[roundedRating] = (ratingDistribution[roundedRating] ?? 0) + 1;
      }

      // Get views
      final viewsQuery = await _firebaseService.queryDocuments(
        'recipe_views',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      // Get cooking attempts
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      final successfulAttempts = attemptsQuery.where((doc) => doc['wasSuccessful'] == true).length;
      final successRate = attemptsQuery.isEmpty ? 0.0 : successfulAttempts / attemptsQuery.length;

      // Get shares
      final sharesQuery = await _firebaseService.queryDocuments(
        'recipe_shares',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      // Get cooking times
      final timesQuery = await _firebaseService.queryDocuments(
        'cooking_times',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      final cookingTimes = timesQuery.map((doc) => doc['actualTimeMinutes'] as int).toList();
      final averageCookingTime = cookingTimes.isEmpty 
          ? const Duration(minutes: 30)
          : Duration(minutes: (cookingTimes.reduce((a, b) => a + b) / cookingTimes.length).round());

      return RecipeAnalytics(
        recipeId: recipeId,
        averageRating: averageRating,
        totalRatings: ratings.length,
        viewCount: viewsQuery.length,
        cookCount: attemptsQuery.length,
        shareCount: sharesQuery.length,
        successRate: successRate,
        averageCookingTime: averageCookingTime,
        ratingDistribution: ratingDistribution,
        commonFeedback: _extractCommonFeedback(ratingsQuery),
        lastCooked: _getLastCookedDate(attemptsQuery),
        lastViewed: _getLastViewedDate(viewsQuery),
      );
    } catch (e) {
      throw AnalyticsException('Failed to get recipe analytics: $e');
    }
  }

  @override
  Future<UserCookingStats> getUserCookingStats(String userId) async {
    try {
      // Get all user's recipe attempts
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      // Get all user's ratings
      final ratingsQuery = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      // Get all user's shares
      final sharesQuery = await _firebaseService.queryDocuments(
        'recipe_shares',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      // Calculate statistics
      final totalRecipesCooked = attemptsQuery.length;
      final totalRecipesShared = sharesQuery.length;
      
      final ratings = ratingsQuery.map((doc) => doc['rating'] as double).toList();
      final averageRating = ratings.isEmpty ? 0.0 : ratings.reduce((a, b) => a + b) / ratings.length;

      // Calculate cooking streak
      final cookingDates = attemptsQuery
          .map((doc) => DateTime.parse(doc['timestamp'] as String))
          .toList()
        ..sort((a, b) => b.compareTo(a));

      final currentStreak = _calculateCurrentStreak(cookingDates);
      final longestStreak = _calculateLongestStreak(cookingDates);

      return UserCookingStats(
        userId: userId,
        totalRecipesCooked: totalRecipesCooked,
        totalRecipesSaved: 0, // TODO: Get from recipe repository
        totalRecipesShared: totalRecipesShared,
        averageRating: averageRating,
        totalCookingTime: const Duration(hours: 0), // TODO: Calculate from cooking times
        averageCookingTime: const Duration(minutes: 30), // TODO: Calculate from cooking times
        difficultyDistribution: {}, // TODO: Calculate from recipes cooked
        cuisineDistribution: {}, // TODO: Calculate from recipes cooked
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        lastCookingDate: cookingDates.isNotEmpty ? cookingDates.first : DateTime.now(),
        currentSkillLevel: SkillLevel.intermediate, // TODO: Calculate based on progress
        skillProgress: 0.5, // TODO: Calculate based on achievements
      );
    } catch (e) {
      throw AnalyticsException('Failed to get user cooking stats: $e');
    }
  }

  @override
  Future<List<Recipe>> getMostCookedRecipes(String userId, {int limit = 10}) async {
    try {
      // Get cooking attempts grouped by recipe
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      final recipeCounts = <String, int>{};
      for (final attempt in attemptsQuery) {
        final recipeId = attempt['recipeId'] as String;
        recipeCounts[recipeId] = (recipeCounts[recipeId] ?? 0) + 1;
      }

      // Sort by count and get top recipes
      final sortedRecipeIds = recipeCounts.entries
          .toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      // TODO: Fetch actual recipe objects from repository
      return [];
    } catch (e) {
      throw AnalyticsException('Failed to get most cooked recipes: $e');
    }
  }

  @override
  Future<List<Recipe>> getHighestRatedRecipes(String userId, {int limit = 10}) async {
    try {
      // Get user's ratings
      final ratingsQuery = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
        orderBy: [
          {'field': 'rating', 'descending': true}
        ],
        limit: limit,
      );

      // TODO: Fetch actual recipe objects from repository
      return [];
    } catch (e) {
      throw AnalyticsException('Failed to get highest rated recipes: $e');
    }
  }

  @override
  Future<Map<String, int>> getCookingFrequencyByDay(String userId) async {
    try {
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      final frequencyByDay = <String, int>{};
      for (final attempt in attemptsQuery) {
        final date = DateTime.parse(attempt['timestamp'] as String);
        final dayName = _getDayName(date.weekday);
        frequencyByDay[dayName] = (frequencyByDay[dayName] ?? 0) + 1;
      }

      return frequencyByDay;
    } catch (e) {
      throw AnalyticsException('Failed to get cooking frequency by day: $e');
    }
  }

  @override
  Future<Map<String, int>> getCuisinePreferences(String userId) async {
    try {
      // TODO: Implement cuisine preference analysis
      return {};
    } catch (e) {
      throw AnalyticsException('Failed to get cuisine preferences: $e');
    }
  }

  @override
  Future<CookingTrends> getCookingTrends(String userId, Duration period) async {
    try {
      final startDate = DateTime.now().subtract(period);
      
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId},
          {'field': 'timestamp', 'operator': '>=', 'value': startDate.toIso8601String()},
        ],
      );

      final ratingsQuery = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId},
          {'field': 'timestamp', 'operator': '>=', 'value': startDate.toIso8601String()},
        ],
      );

      final ratings = ratingsQuery.map((doc) => doc['rating'] as double).toList();
      final averageRating = ratings.isEmpty ? 0.0 : ratings.reduce((a, b) => a + b) / ratings.length;

      return CookingTrends(
        period: period,
        recipesCooked: attemptsQuery.length,
        newRecipesTried: _countUniqueRecipes(attemptsQuery),
        averageRating: averageRating,
        popularCuisines: {}, // TODO: Implement
        difficultyProgression: {}, // TODO: Implement
        emergingPreferences: [], // TODO: Implement
        improvementScore: _calculateImprovementScore(ratingsQuery),
      );
    } catch (e) {
      throw AnalyticsException('Failed to get cooking trends: $e');
    }
  }

  @override
  Future<List<String>> getRecommendedRecipes(String userId, {int limit = 5}) async {
    try {
      // TODO: Implement recommendation algorithm based on user preferences and analytics
      return [];
    } catch (e) {
      throw AnalyticsException('Failed to get recommended recipes: $e');
    }
  }

  @override
  Future<SkillProgressAnalytics> getSkillProgress(String userId) async {
    try {
      // TODO: Implement skill progress tracking
      return const SkillProgressAnalytics(
        currentLevel: SkillLevel.intermediate,
        progressToNextLevel: 0.6,
        masteredTechniques: ['sautéing', 'roasting', 'grilling'],
        recommendedTechniques: ['braising', 'poaching', 'sous vide'],
        skillScores: {
          'knife_skills': 0.7,
          'seasoning': 0.8,
          'timing': 0.6,
          'temperature_control': 0.5,
        },
        recentAchievements: [],
      );
    } catch (e) {
      throw AnalyticsException('Failed to get skill progress: $e');
    }
  }

  @override
  Future<NutritionTrends> getNutritionTrends(String userId, Duration period) async {
    try {
      // TODO: Implement nutrition trend analysis
      return const NutritionTrends(
        period: Duration(days: 30),
        averageCalories: 450.0,
        averageProtein: 25.0,
        averageCarbs: 35.0,
        averageFat: 18.0,
        nutritionGoalProgress: {
          'calories': 0.85,
          'protein': 0.92,
          'carbs': 0.78,
          'fat': 0.65,
        },
        healthyChoices: ['More vegetables', 'Lean proteins'],
        improvementSuggestions: ['Reduce sodium', 'Increase fiber'],
      );
    } catch (e) {
      throw AnalyticsException('Failed to get nutrition trends: $e');
    }
  }

  @override
  Future<double> getRecipeSuccessRate(String recipeId) async {
    try {
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      if (attemptsQuery.isEmpty) return 0.0;

      final successfulAttempts = attemptsQuery.where((doc) => doc['wasSuccessful'] == true).length;
      return successfulAttempts / attemptsQuery.length;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe success rate: $e');
    }
  }

  @override
  Future<double> getUserSuccessRate(String userId) async {
    try {
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      if (attemptsQuery.isEmpty) return 0.0;

      final successfulAttempts = attemptsQuery.where((doc) => doc['wasSuccessful'] == true).length;
      return successfulAttempts / attemptsQuery.length;
    } catch (e) {
      throw AnalyticsException('Failed to get user success rate: $e');
    }
  }

  @override
  Future<List<String>> getCommonFailureReasons(String recipeId) async {
    try {
      final attemptsQuery = await _firebaseService.queryDocuments(
        'recipe_attempts',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId},
          {'field': 'wasSuccessful', 'operator': '==', 'value': false}
        ],
      );

      final failureReasons = attemptsQuery
          .where((doc) => doc['notes'] != null)
          .map((doc) => doc['notes'] as String)
          .toList();

      // TODO: Implement text analysis to extract common themes
      return failureReasons;
    } catch (e) {
      throw AnalyticsException('Failed to get common failure reasons: $e');
    }
  }

  @override
  Future<Map<DifficultyLevel, double>> getSuccessRateByDifficulty(String userId) async {
    try {
      // TODO: Implement success rate analysis by difficulty level
      return {
        DifficultyLevel.beginner: 0.95,
        DifficultyLevel.intermediate: 0.85,
        DifficultyLevel.advanced: 0.70,
        DifficultyLevel.expert: 0.55,
      };
    } catch (e) {
      throw AnalyticsException('Failed to get success rate by difficulty: $e');
    }
  }

  @override
  Future<Duration> getAverageCookingTime(String recipeId) async {
    try {
      final timesQuery = await _firebaseService.queryDocuments(
        'cooking_times',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      if (timesQuery.isEmpty) return const Duration(minutes: 30);

      final times = timesQuery.map((doc) => doc['actualTimeMinutes'] as int).toList();
      final averageMinutes = times.reduce((a, b) => a + b) / times.length;
      
      return Duration(minutes: averageMinutes.round());
    } catch (e) {
      throw AnalyticsException('Failed to get average cooking time: $e');
    }
  }

  @override
  Future<Duration> getUserAverageCookingTime(String userId) async {
    try {
      final timesQuery = await _firebaseService.queryDocuments(
        'cooking_times',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
      );

      if (timesQuery.isEmpty) return const Duration(minutes: 30);

      final times = timesQuery.map((doc) => doc['actualTimeMinutes'] as int).toList();
      final averageMinutes = times.reduce((a, b) => a + b) / times.length;
      
      return Duration(minutes: averageMinutes.round());
    } catch (e) {
      throw AnalyticsException('Failed to get user average cooking time: $e');
    }
  }

  @override
  Future<Map<String, Duration>> getCookingTimeByCategory(String userId) async {
    try {
      // TODO: Implement cooking time analysis by recipe category
      return {
        'breakfast': const Duration(minutes: 15),
        'lunch': const Duration(minutes: 25),
        'dinner': const Duration(minutes: 45),
        'dessert': const Duration(minutes: 35),
      };
    } catch (e) {
      throw AnalyticsException('Failed to get cooking time by category: $e');
    }
  }

  @override
  Future<List<Recipe>> getQuickestRecipes(String userId, {int limit = 10}) async {
    try {
      // TODO: Implement quickest recipes analysis
      return [];
    } catch (e) {
      throw AnalyticsException('Failed to get quickest recipes: $e');
    }
  }

  @override
  Future<int> getRecipeViewCount(String recipeId) async {
    try {
      final viewsQuery = await _firebaseService.queryDocuments(
        'recipe_views',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      return viewsQuery.length;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe view count: $e');
    }
  }

  @override
  Future<int> getRecipeShareCount(String recipeId) async {
    try {
      final sharesQuery = await _firebaseService.queryDocuments(
        'recipe_shares',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
      );

      return sharesQuery.length;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe share count: $e');
    }
  }

  @override
  Future<double> getRecipeEngagementScore(String recipeId) async {
    try {
      final analytics = await getRecipeAnalytics(recipeId);
      
      // Calculate engagement score based on views, ratings, shares, and success rate
      double score = 0.0;
      score += analytics.viewCount * 0.1;
      score += analytics.totalRatings * 0.3;
      score += analytics.shareCount * 0.5;
      score += analytics.successRate * 2.0;
      score += analytics.averageRating * 0.4;
      
      return score.clamp(0.0, 10.0);
    } catch (e) {
      throw AnalyticsException('Failed to get recipe engagement score: $e');
    }
  }

  @override
  Future<List<Recipe>> getTrendingRecipes({int limit = 10}) async {
    try {
      // TODO: Implement trending recipes algorithm
      return [];
    } catch (e) {
      throw AnalyticsException('Failed to get trending recipes: $e');
    }
  }

  // Helper methods
  List<String> _extractCommonFeedback(List<Map<String, dynamic>> ratings) {
    final feedback = ratings
        .where((doc) => doc['feedback'] != null)
        .map((doc) => doc['feedback'] as String)
        .toList();

    // TODO: Implement text analysis to extract common themes
    return feedback.take(5).toList();
  }

  DateTime _getLastCookedDate(List<Map<String, dynamic>> attempts) {
    if (attempts.isEmpty) return DateTime.now();
    
    final dates = attempts
        .map((doc) => DateTime.parse(doc['timestamp'] as String))
        .toList()
      ..sort((a, b) => b.compareTo(a));
    
    return dates.first;
  }

  DateTime _getLastViewedDate(List<Map<String, dynamic>> views) {
    if (views.isEmpty) return DateTime.now();
    
    final dates = views
        .map((doc) => DateTime.parse(doc['timestamp'] as String))
        .toList()
      ..sort((a, b) => b.compareTo(a));
    
    return dates.first;
  }

  int _calculateCurrentStreak(List<DateTime> cookingDates) {
    if (cookingDates.isEmpty) return 0;

    int streak = 0;
    DateTime currentDate = DateTime.now();
    
    for (final date in cookingDates) {
      final daysDifference = currentDate.difference(date).inDays;
      
      if (daysDifference <= 1) {
        streak++;
        currentDate = date;
      } else {
        break;
      }
    }

    return streak;
  }

  int _calculateLongestStreak(List<DateTime> cookingDates) {
    if (cookingDates.isEmpty) return 0;

    int longestStreak = 0;
    int currentStreak = 1;
    
    for (int i = 1; i < cookingDates.length; i++) {
      final daysDifference = cookingDates[i - 1].difference(cookingDates[i]).inDays;
      
      if (daysDifference <= 1) {
        currentStreak++;
      } else {
        longestStreak = longestStreak > currentStreak ? longestStreak : currentStreak;
        currentStreak = 1;
      }
    }

    return longestStreak > currentStreak ? longestStreak : currentStreak;
  }

  int _countUniqueRecipes(List<Map<String, dynamic>> attempts) {
    final uniqueRecipeIds = <String>{};
    for (final attempt in attempts) {
      uniqueRecipeIds.add(attempt['recipeId'] as String);
    }
    return uniqueRecipeIds.length;
  }

  double _calculateImprovementScore(List<Map<String, dynamic>> ratings) {
    if (ratings.length < 2) return 0.0;

    // Sort by timestamp
    ratings.sort((a, b) => DateTime.parse(a['timestamp'] as String)
        .compareTo(DateTime.parse(b['timestamp'] as String)));

    final firstHalf = ratings.take(ratings.length ~/ 2);
    final secondHalf = ratings.skip(ratings.length ~/ 2);

    final firstHalfAverage = firstHalf.isEmpty ? 0.0 : 
        firstHalf.map((doc) => doc['rating'] as double).reduce((a, b) => a + b) / firstHalf.length;
    
    final secondHalfAverage = secondHalf.isEmpty ? 0.0 :
        secondHalf.map((doc) => doc['rating'] as double).reduce((a, b) => a + b) / secondHalf.length;

    return secondHalfAverage - firstHalfAverage;
  }

  String _getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }
}