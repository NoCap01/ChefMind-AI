import '../../domain/repositories/recipe_rating_repository.dart';
import '../../domain/entities/recipe_rating.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebaseRecipeRatingRepository implements IRecipeRatingRepository {
  final FirebaseService _firebaseService = FirebaseService.instance;

  static final FirebaseRecipeRatingRepository _instance = FirebaseRecipeRatingRepository._internal();
  factory FirebaseRecipeRatingRepository() => _instance;
  FirebaseRecipeRatingRepository._internal();

  static FirebaseRecipeRatingRepository get instance => _instance;

  @override
  Future<void> saveRating(RecipeRating rating) async {
    try {
      await _firebaseService.setDocument(
        'recipe_ratings',
        rating.id,
        rating.toJson(),
      );

      // Update recipe analytics
      await _updateRecipeAnalyticsOnRating(rating);
    } catch (e) {
      throw AnalyticsException('Failed to save rating: $e');
    }
  }

  @override
  Future<RecipeRating?> getRating(String ratingId) async {
    try {
      final doc = await _firebaseService.getDocument('recipe_ratings', ratingId);
      return doc != null ? RecipeRating.fromJson(doc) : null;
    } catch (e) {
      throw AnalyticsException('Failed to get rating: $e');
    }
  }

  @override
  Future<List<RecipeRating>> getRecipeRatings(String recipeId) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
        orderBy: [
          {'field': 'createdAt', 'descending': true}
        ],
      );

      return docs.map((doc) => RecipeRating.fromJson(doc)).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get recipe ratings: $e');
    }
  }

  @override
  Future<List<RecipeRating>> getUserRatings(String userId) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
        orderBy: [
          {'field': 'createdAt', 'descending': true}
        ],
      );

      return docs.map((doc) => RecipeRating.fromJson(doc)).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get user ratings: $e');
    }
  }

  @override
  Future<RecipeRating?> getUserRecipeRating(String userId, String recipeId) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'recipe_ratings',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId},
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
        limit: 1,
      );

      return docs.isNotEmpty ? RecipeRating.fromJson(docs.first) : null;
    } catch (e) {
      throw AnalyticsException('Failed to get user recipe rating: $e');
    }
  }

  @override
  Future<void> updateRating(RecipeRating rating) async {
    try {
      await _firebaseService.updateDocument(
        'recipe_ratings',
        rating.id,
        rating.copyWith(updatedAt: DateTime.now()).toJson(),
      );

      // Update recipe analytics
      await _updateRecipeAnalyticsOnRating(rating);
    } catch (e) {
      throw AnalyticsException('Failed to update rating: $e');
    }
  }

  @override
  Future<void> deleteRating(String ratingId) async {
    try {
      final rating = await getRating(ratingId);
      if (rating != null) {
        await _firebaseService.deleteDocument('recipe_ratings', ratingId);
        // Update recipe analytics after deletion
        await _recalculateRecipeAnalytics(rating.recipeId);
      }
    } catch (e) {
      throw AnalyticsException('Failed to delete rating: $e');
    }
  }

  @override
  Future<void> recordHistory(RecipeHistory history) async {
    try {
      await _firebaseService.setDocument(
        'recipe_history',
        history.id,
        history.toJson(),
      );

      // Update analytics based on action
      await _updateAnalyticsOnHistoryAction(history);
    } catch (e) {
      throw AnalyticsException('Failed to record history: $e');
    }
  }

  @override
  Future<List<RecipeHistory>> getRecipeHistory(String recipeId) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'recipe_history',
        where: [
          {'field': 'recipeId', 'operator': '==', 'value': recipeId}
        ],
        orderBy: [
          {'field': 'timestamp', 'descending': true}
        ],
      );

      return docs.map((doc) => RecipeHistory.fromJson(doc)).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get recipe history: $e');
    }
  }

  @override
  Future<List<RecipeHistory>> getUserHistory(String userId, {RecipeHistoryAction? action}) async {
    try {
      final whereConditions = [
        {'field': 'userId', 'operator': '==', 'value': userId}
      ];

      if (action != null) {
        whereConditions.add({
          'field': 'action',
          'operator': '==',
          'value': action.name
        });
      }

      final docs = await _firebaseService.queryDocuments(
        'recipe_history',
        where: whereConditions,
        orderBy: [
          {'field': 'timestamp', 'descending': true}
        ],
      );

      return docs.map((doc) => RecipeHistory.fromJson(doc)).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get user history: $e');
    }
  }

  @override
  Future<List<RecipeHistory>> getRecentHistory(String userId, {int limit = 20}) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'recipe_history',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
        orderBy: [
          {'field': 'timestamp', 'descending': true}
        ],
        limit: limit,
      );

      return docs.map((doc) => RecipeHistory.fromJson(doc)).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get recent history: $e');
    }
  }

  @override
  Future<void> startCookingSession(CookingSession session) async {
    try {
      await _firebaseService.setDocument(
        'cooking_sessions',
        session.id,
        session.toJson(),
      );
    } catch (e) {
      throw AnalyticsException('Failed to start cooking session: $e');
    }
  }

  @override
  Future<void> updateCookingSession(CookingSession session) async {
    try {
      await _firebaseService.updateDocument(
        'cooking_sessions',
        session.id,
        session.toJson(),
      );
    } catch (e) {
      throw AnalyticsException('Failed to update cooking session: $e');
    }
  }

  @override
  Future<void> endCookingSession(String sessionId, {double? rating, bool? wasSuccessful}) async {
    try {
      final session = await getCookingSession(sessionId);
      if (session != null) {
        final updatedSession = session.copyWith(
          endTime: DateTime.now(),
          status: CookingSessionStatus.completed,
          finalRating: rating,
          wasSuccessful: wasSuccessful,
        );

        await updateCookingSession(updatedSession);

        // Record cooking history
        await recordHistory(RecipeHistory(
          id: '${session.recipeId}_${session.userId}_${DateTime.now().millisecondsSinceEpoch}',
          recipeId: session.recipeId,
          userId: session.userId,
          action: RecipeHistoryAction.cooked,
          timestamp: DateTime.now(),
          metadata: {
            'sessionId': sessionId,
            'duration': updatedSession.endTime!.difference(session.startTime).inMinutes,
            'wasSuccessful': wasSuccessful,
            'rating': rating,
          },
        ));
      }
    } catch (e) {
      throw AnalyticsException('Failed to end cooking session: $e');
    }
  }

  @override
  Future<CookingSession?> getCookingSession(String sessionId) async {
    try {
      final doc = await _firebaseService.getDocument('cooking_sessions', sessionId);
      return doc != null ? CookingSession.fromJson(doc) : null;
    } catch (e) {
      throw AnalyticsException('Failed to get cooking session: $e');
    }
  }

  @override
  Future<List<CookingSession>> getUserCookingSessions(String userId) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'cooking_sessions',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId}
        ],
        orderBy: [
          {'field': 'startTime', 'descending': true}
        ],
      );

      return docs.map((doc) => CookingSession.fromJson(doc)).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get user cooking sessions: $e');
    }
  }

  @override
  Future<CookingSession?> getActiveCookingSession(String userId, String recipeId) async {
    try {
      final docs = await _firebaseService.queryDocuments(
        'cooking_sessions',
        where: [
          {'field': 'userId', 'operator': '==', 'value': userId},
          {'field': 'recipeId', 'operator': '==', 'value': recipeId},
          {'field': 'status', 'operator': '==', 'value': CookingSessionStatus.inProgress.name}
        ],
        limit: 1,
      );

      return docs.isNotEmpty ? CookingSession.fromJson(docs.first) : null;
    } catch (e) {
      throw AnalyticsException('Failed to get active cooking session: $e');
    }
  }

  @override
  Future<void> updateRecipeAnalytics(String recipeId, RecipeAnalyticsData analytics) async {
    try {
      await _firebaseService.setDocument(
        'recipe_analytics',
        recipeId,
        analytics.toJson(),
      );
    } catch (e) {
      throw AnalyticsException('Failed to update recipe analytics: $e');
    }
  }

  @override
  Future<RecipeAnalyticsData?> getRecipeAnalytics(String recipeId) async {
    try {
      final doc = await _firebaseService.getDocument('recipe_analytics', recipeId);
      return doc != null ? RecipeAnalyticsData.fromJson(doc) : null;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe analytics: $e');
    }
  }

  @override
  Future<Map<String, RecipeAnalyticsData>> getBulkRecipeAnalytics(List<String> recipeIds) async {
    try {
      final result = <String, RecipeAnalyticsData>{};
      
      // Firebase doesn't support 'in' queries with more than 10 items, so batch them
      for (int i = 0; i < recipeIds.length; i += 10) {
        final batch = recipeIds.skip(i).take(10).toList();
        final docs = await _firebaseService.queryDocuments(
          'recipe_analytics',
          where: [
            {'field': '__name__', 'operator': 'in', 'value': batch}
          ],
        );

        for (final doc in docs) {
          final analytics = RecipeAnalyticsData.fromJson(doc);
          result[analytics.recipeId] = analytics;
        }
      }

      return result;
    } catch (e) {
      throw AnalyticsException('Failed to get bulk recipe analytics: $e');
    }
  }

  @override
  Future<double> getAverageRating(String recipeId) async {
    try {
      final ratings = await getRecipeRatings(recipeId);
      if (ratings.isEmpty) return 0.0;

      final sum = ratings.fold<double>(0.0, (sum, rating) => sum + rating.rating);
      return sum / ratings.length;
    } catch (e) {
      throw AnalyticsException('Failed to get average rating: $e');
    }
  }

  @override
  Future<Map<int, int>> getRatingDistribution(String recipeId) async {
    try {
      final ratings = await getRecipeRatings(recipeId);
      final distribution = <int, int>{};

      for (final rating in ratings) {
        final roundedRating = rating.rating.round();
        distribution[roundedRating] = (distribution[roundedRating] ?? 0) + 1;
      }

      return distribution;
    } catch (e) {
      throw AnalyticsException('Failed to get rating distribution: $e');
    }
  }

  @override
  Future<int> getRecipeViewCount(String recipeId) async {
    try {
      final history = await getRecipeHistory(recipeId);
      return history.where((h) => h.action == RecipeHistoryAction.viewed).length;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe view count: $e');
    }
  }

  @override
  Future<int> getRecipeCookCount(String recipeId) async {
    try {
      final history = await getRecipeHistory(recipeId);
      return history.where((h) => h.action == RecipeHistoryAction.cooked).length;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe cook count: $e');
    }
  }

  @override
  Future<List<String>> getMostCookedRecipes(String userId, {int limit = 10}) async {
    try {
      final history = await getUserHistory(userId, action: RecipeHistoryAction.cooked);
      
      final recipeCounts = <String, int>{};
      for (final entry in history) {
        recipeCounts[entry.recipeId] = (recipeCounts[entry.recipeId] ?? 0) + 1;
      }

      final sortedRecipes = recipeCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedRecipes.take(limit).map((e) => e.key).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get most cooked recipes: $e');
    }
  }

  @override
  Future<List<String>> getHighestRatedRecipes(String userId, {int limit = 10}) async {
    try {
      final ratings = await getUserRatings(userId);
      ratings.sort((a, b) => b.rating.compareTo(a.rating));
      
      return ratings.take(limit).map((r) => r.recipeId).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get highest rated recipes: $e');
    }
  }

  @override
  Future<List<String>> getRecentlyViewedRecipes(String userId, {int limit = 10}) async {
    try {
      final history = await getUserHistory(userId, action: RecipeHistoryAction.viewed);
      
      // Remove duplicates while preserving order
      final seenRecipes = <String>{};
      final uniqueRecipes = <String>[];
      
      for (final entry in history) {
        if (!seenRecipes.contains(entry.recipeId)) {
          seenRecipes.add(entry.recipeId);
          uniqueRecipes.add(entry.recipeId);
          if (uniqueRecipes.length >= limit) break;
        }
      }

      return uniqueRecipes;
    } catch (e) {
      throw AnalyticsException('Failed to get recently viewed recipes: $e');
    }
  }

  @override
  Future<Map<String, int>> getCookingFrequencyByDay(String userId) async {
    try {
      final history = await getUserHistory(userId, action: RecipeHistoryAction.cooked);
      
      final frequencyByDay = <String, int>{};
      for (final entry in history) {
        final dayName = _getDayName(entry.timestamp.weekday);
        frequencyByDay[dayName] = (frequencyByDay[dayName] ?? 0) + 1;
      }

      return frequencyByDay;
    } catch (e) {
      throw AnalyticsException('Failed to get cooking frequency by day: $e');
    }
  }

  @override
  Future<Map<String, int>> getCookingFrequencyByMonth(String userId) async {
    try {
      final history = await getUserHistory(userId, action: RecipeHistoryAction.cooked);
      
      final frequencyByMonth = <String, int>{};
      for (final entry in history) {
        final monthKey = '${entry.timestamp.year}-${entry.timestamp.month.toString().padLeft(2, '0')}';
        frequencyByMonth[monthKey] = (frequencyByMonth[monthKey] ?? 0) + 1;
      }

      return frequencyByMonth;
    } catch (e) {
      throw AnalyticsException('Failed to get cooking frequency by month: $e');
    }
  }

  @override
  Future<double> getRecipeSuccessRate(String recipeId) async {
    try {
      final ratings = await getRecipeRatings(recipeId);
      if (ratings.isEmpty) return 0.0;

      final successfulCooks = ratings.where((r) => r.wasSuccessful).length;
      return successfulCooks / ratings.length;
    } catch (e) {
      throw AnalyticsException('Failed to get recipe success rate: $e');
    }
  }

  @override
  Future<double> getUserSuccessRate(String userId) async {
    try {
      final ratings = await getUserRatings(userId);
      if (ratings.isEmpty) return 0.0;

      final successfulCooks = ratings.where((r) => r.wasSuccessful).length;
      return successfulCooks / ratings.length;
    } catch (e) {
      throw AnalyticsException('Failed to get user success rate: $e');
    }
  }

  @override
  Future<List<String>> getCommonFailureReasons(String recipeId) async {
    try {
      final ratings = await getRecipeRatings(recipeId);
      final failureReasons = ratings
          .where((r) => !r.wasSuccessful && r.notes != null)
          .map((r) => r.notes!)
          .toList();

      // TODO: Implement text analysis to extract common themes
      return failureReasons.take(5).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get common failure reasons: $e');
    }
  }

  @override
  Future<Duration> getAverageCookingTime(String recipeId) async {
    try {
      final ratings = await getRecipeRatings(recipeId);
      final cookingTimes = ratings
          .where((r) => r.actualCookingTime != null)
          .map((r) => r.actualCookingTime!)
          .toList();

      if (cookingTimes.isEmpty) return const Duration(minutes: 30);

      final totalMinutes = cookingTimes.fold<int>(0, (sum, duration) => sum + duration.inMinutes);
      return Duration(minutes: (totalMinutes / cookingTimes.length).round());
    } catch (e) {
      throw AnalyticsException('Failed to get average cooking time: $e');
    }
  }

  @override
  Future<Duration> getUserAverageCookingTime(String userId) async {
    try {
      final ratings = await getUserRatings(userId);
      final cookingTimes = ratings
          .where((r) => r.actualCookingTime != null)
          .map((r) => r.actualCookingTime!)
          .toList();

      if (cookingTimes.isEmpty) return const Duration(minutes: 30);

      final totalMinutes = cookingTimes.fold<int>(0, (sum, duration) => sum + duration.inMinutes);
      return Duration(minutes: (totalMinutes / cookingTimes.length).round());
    } catch (e) {
      throw AnalyticsException('Failed to get user average cooking time: $e');
    }
  }

  @override
  Future<Map<String, double>> getRatingTrends(String recipeId, Duration period) async {
    try {
      final startDate = DateTime.now().subtract(period);
      final ratings = await getRecipeRatings(recipeId);
      
      final recentRatings = ratings
          .where((r) => r.createdAt.isAfter(startDate))
          .toList();

      final trends = <String, double>{};
      
      // Group by month and calculate average
      final monthlyRatings = <String, List<double>>{};
      for (final rating in recentRatings) {
        final monthKey = '${rating.createdAt.year}-${rating.createdAt.month.toString().padLeft(2, '0')}';
        monthlyRatings.putIfAbsent(monthKey, () => []).add(rating.rating);
      }

      for (final entry in monthlyRatings.entries) {
        final average = entry.value.reduce((a, b) => a + b) / entry.value.length;
        trends[entry.key] = average;
      }

      return trends;
    } catch (e) {
      throw AnalyticsException('Failed to get rating trends: $e');
    }
  }

  @override
  Future<Map<String, int>> getCookingTrends(String userId, Duration period) async {
    try {
      final startDate = DateTime.now().subtract(period);
      final history = await getUserHistory(userId, action: RecipeHistoryAction.cooked);
      
      final recentHistory = history
          .where((h) => h.timestamp.isAfter(startDate))
          .toList();

      final trends = <String, int>{};
      
      // Group by month and count
      for (final entry in recentHistory) {
        final monthKey = '${entry.timestamp.year}-${entry.timestamp.month.toString().padLeft(2, '0')}';
        trends[monthKey] = (trends[monthKey] ?? 0) + 1;
      }

      return trends;
    } catch (e) {
      throw AnalyticsException('Failed to get cooking trends: $e');
    }
  }

  @override
  Future<List<String>> getPopularRecipeTags(String userId) async {
    try {
      final ratings = await getUserRatings(userId);
      final tagCounts = <String, int>{};

      for (final rating in ratings) {
        for (final tag in rating.tags) {
          tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
        }
      }

      final sortedTags = tagCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedTags.take(10).map((e) => e.key).toList();
    } catch (e) {
      throw AnalyticsException('Failed to get popular recipe tags: $e');
    }
  }

  @override
  Future<Map<String, double>> getSkillProgressMetrics(String userId) async {
    try {
      final ratings = await getUserRatings(userId);
      
      // Calculate skill metrics based on ratings and success rates
      final metrics = <String, double>{};
      
      if (ratings.isNotEmpty) {
        final averageRating = ratings.fold<double>(0.0, (sum, r) => sum + r.rating) / ratings.length;
        final successRate = ratings.where((r) => r.wasSuccessful).length / ratings.length;
        
        metrics['average_rating'] = averageRating;
        metrics['success_rate'] = successRate;
        metrics['total_recipes'] = ratings.length.toDouble();
        metrics['skill_score'] = (averageRating * 0.4 + successRate * 0.6) * 20; // Scale to 0-100
      }

      return metrics;
    } catch (e) {
      throw AnalyticsException('Failed to get skill progress metrics: $e');
    }
  }

  // Helper methods
  Future<void> _updateRecipeAnalyticsOnRating(RecipeRating rating) async {
    try {
      await _recalculateRecipeAnalytics(rating.recipeId);
    } catch (e) {
      // Log error but don't throw to avoid breaking the main operation
      print('Failed to update recipe analytics: $e');
    }
  }

  Future<void> _updateAnalyticsOnHistoryAction(RecipeHistory history) async {
    try {
      final analytics = await getRecipeAnalytics(history.recipeId) ?? 
          RecipeAnalyticsData(recipeId: history.recipeId);

      RecipeAnalyticsData updatedAnalytics;
      
      switch (history.action) {
        case RecipeHistoryAction.viewed:
          updatedAnalytics = analytics.copyWith(
            viewCount: analytics.viewCount + 1,
            lastViewed: history.timestamp,
          );
          break;
        case RecipeHistoryAction.cooked:
          updatedAnalytics = analytics.copyWith(
            cookCount: analytics.cookCount + 1,
            lastCooked: history.timestamp,
          );
          break;
        case RecipeHistoryAction.shared:
          updatedAnalytics = analytics.copyWith(
            shareCount: analytics.shareCount + 1,
          );
          break;
        case RecipeHistoryAction.saved:
          updatedAnalytics = analytics.copyWith(
            saveCount: analytics.saveCount + 1,
          );
          break;
        default:
          return; // No analytics update needed for other actions
      }

      await updateRecipeAnalytics(
        history.recipeId,
        updatedAnalytics.copyWith(lastUpdated: DateTime.now()),
      );
    } catch (e) {
      // Log error but don't throw to avoid breaking the main operation
      print('Failed to update analytics on history action: $e');
    }
  }

  Future<void> _recalculateRecipeAnalytics(String recipeId) async {
    try {
      final ratings = await getRecipeRatings(recipeId);
      final averageRating = ratings.isEmpty ? 0.0 : 
          ratings.fold<double>(0.0, (sum, r) => sum + r.rating) / ratings.length;

      final ratingDistribution = <int, int>{};
      for (final rating in ratings) {
        final roundedRating = rating.rating.round();
        ratingDistribution[roundedRating] = (ratingDistribution[roundedRating] ?? 0) + 1;
      }

      final successfulCooks = ratings.where((r) => r.wasSuccessful).length;
      final successRate = ratings.isEmpty ? 0.0 : successfulCooks / ratings.length;

      final cookingTimes = ratings
          .where((r) => r.actualCookingTime != null)
          .map((r) => r.actualCookingTime!)
          .toList();

      final averageCookingTime = cookingTimes.isEmpty 
          ? null
          : Duration(minutes: (cookingTimes.fold<int>(0, (sum, d) => sum + d.inMinutes) / cookingTimes.length).round());

      final existingAnalytics = await getRecipeAnalytics(recipeId);
      
      final updatedAnalytics = RecipeAnalyticsData(
        recipeId: recipeId,
        viewCount: existingAnalytics?.viewCount ?? 0,
        cookCount: existingAnalytics?.cookCount ?? 0,
        shareCount: existingAnalytics?.shareCount ?? 0,
        saveCount: existingAnalytics?.saveCount ?? 0,
        averageRating: averageRating,
        totalRatings: ratings.length,
        ratingDistribution: ratingDistribution,
        successRate: successRate,
        averageCookingTime: averageCookingTime,
        lastViewed: existingAnalytics?.lastViewed,
        lastCooked: existingAnalytics?.lastCooked,
        lastUpdated: DateTime.now(),
      );

      await updateRecipeAnalytics(recipeId, updatedAnalytics);
    } catch (e) {
      print('Failed to recalculate recipe analytics: $e');
    }
  }

  String _getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }
}