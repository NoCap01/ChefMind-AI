import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/nutrition_tracking.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebaseNutritionRepository implements INutritionRepository {
  static final FirebaseNutritionRepository _instance = FirebaseNutritionRepository._internal();
  static FirebaseNutritionRepository get instance => _instance;
  
  FirebaseNutritionRepository._internal();

  final FirebaseService _firebaseService = FirebaseService.instance;
  
  FirebaseFirestore get _firestore => _firebaseService.firestore;
  String? get _currentUserId => _firebaseService.currentUserId;

  @override
  Future<List<NutritionEntry>> getUserNutritionEntries(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      var query = _firebaseService.userCollection(userId, 'nutritionEntries')
          .orderBy('date', descending: true);

      if (startDate != null) {
        query = query.where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate));
      }

      if (endDate != null) {
        query = query.where('date', isLessThanOrEqualTo: Timestamp.fromDate(endDate));
      }

      final querySnapshot = await query.get();
      
      return querySnapshot.docs
          .map((doc) => NutritionEntry.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<NutritionEntry?> getNutritionEntryByDate(String userId, DateTime date) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final querySnapshot = await _firebaseService.userCollection(userId, 'nutritionEntries')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('date', isLessThan: Timestamp.fromDate(endOfDay))
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return NutritionEntry.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<NutritionEntry> saveNutritionEntry(NutritionEntry entry) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final updatedEntry = entry.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _firebaseService.userCollection(_currentUserId!, 'nutritionEntries')
          .doc(entry.id)
          .set(updatedEntry.toJson());
      
      await _firebaseService.logEvent('nutrition_entry_saved', {
        'date': entry.date.toIso8601String(),
        'total_calories': entry.totalNutrition.calories,
        'food_count': entry.foods.length,
      });
      
      return updatedEntry;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteNutritionEntry(String entryId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'nutritionEntries')
          .doc(entryId)
          .delete();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<NutritionEntry> addFoodEntry(String userId, DateTime date, FoodEntry foodEntry) async {
    try {
      return await _firestore.runTransaction((transaction) async {
        // Get or create nutrition entry for the date
        var nutritionEntry = await getNutritionEntryByDate(userId, date);
        
        if (nutritionEntry == null) {
          nutritionEntry = NutritionEntry(
            id: _generateEntryId(date),
            userId: userId,
            date: date,
            foods: [],
            totalNutrition: const NutritionInfo(
              calories: 0, protein: 0, carbs: 0, fat: 0,
              fiber: 0, sugar: 0, sodium: 0,
            ),
            mealBreakdown: {},
            createdAt: DateTime.now(),
          );
        }

        // Add the food entry
        final updatedFoods = [...nutritionEntry.foods, foodEntry];
        
        // Recalculate totals
        final updatedEntry = nutritionEntry.copyWith(
          foods: updatedFoods,
          totalNutrition: _calculateTotalNutrition(updatedFoods),
          mealBreakdown: _calculateMealBreakdown(updatedFoods),
          updatedAt: DateTime.now(),
        );

        // Save to Firestore
        final docRef = _firebaseService.userCollection(userId, 'nutritionEntries').doc(updatedEntry.id);
        transaction.set(docRef, updatedEntry.toJson());
        
        return updatedEntry;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<NutritionGoal>> getUserNutritionGoals(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'nutritionGoals')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => NutritionGoal.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<NutritionGoal?> getActiveNutritionGoal(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'nutritionGoals')
          .where('isActive', isEqualTo: true)
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        return NutritionGoal.fromJson(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<NutritionGoal> createNutritionGoal(NutritionGoal goal) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'nutritionGoals')
          .doc(goal.id)
          .set(goal.toJson());
      
      return goal;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<FoodDatabase>> searchFoodDatabase(String query, {int limit = 20}) async {
    try {
      // In a real implementation, this would search a comprehensive food database
      // For now, return mock results
      final mockFoods = _getMockFoodDatabase();
      
      final filteredFoods = mockFoods.where((food) =>
        food.name.toLowerCase().contains(query.toLowerCase()) ||
        food.brand.toLowerCase().contains(query.toLowerCase())
      ).take(limit).toList();
      
      return filteredFoods;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<NutritionRecommendation>> getNutritionRecommendations(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'nutritionRecommendations')
          .where('isDismissed', isEqualTo: false)
          .orderBy('priority', descending: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();
      
      return querySnapshot.docs
          .map((doc) => NutritionRecommendation.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Placeholder implementations for remaining methods
  @override
  Future<NutritionEntry> updateFoodEntry(String userId, DateTime date, FoodEntry foodEntry) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionEntry> removeFoodEntry(String userId, DateTime date, String foodEntryId) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionGoal> updateNutritionGoal(NutritionGoal goal) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final updatedGoal = goal.copyWith(updatedAt: DateTime.now());
      
      await _firebaseService.userCollection(_currentUserId!, 'nutritionGoals')
          .doc(goal.id)
          .update(updatedGoal.toJson());
      
      return updatedGoal;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteNutritionGoal(String goalId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> setActiveNutritionGoal(String userId, String goalId) async {
    try {
      await _firestore.runTransaction((transaction) async {
        // Deactivate all existing goals
        final existingGoalsQuery = await _firebaseService.userCollection(userId, 'nutritionGoals')
            .where('isActive', isEqualTo: true)
            .get();
        
        for (final doc in existingGoalsQuery.docs) {
          transaction.update(doc.reference, {'isActive': false});
        }
        
        // Activate the selected goal
        final goalRef = _firebaseService.userCollection(userId, 'nutritionGoals').doc(goalId);
        transaction.update(goalRef, {'isActive': true});
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<NutritionProgress>> getNutritionProgress(String userId, DateTime startDate, DateTime endDate) async {
    throw UnimplementedError();
  }

  @override
  Future<WeeklyNutritionSummary> getWeeklyNutritionSummary(String userId, DateTime weekStartDate) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionAnalytics> getNutritionAnalytics(String userId, DateTime startDate, DateTime endDate) async {
    throw UnimplementedError();
  }

  @override
  Future<FoodDatabase?> getFoodByBarcode(String barcode) async {
    throw UnimplementedError();
  }

  @override
  Future<FoodDatabase> addCustomFood(FoodDatabase food) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionRecommendation> createNutritionRecommendation(NutritionRecommendation recommendation) async {
    throw UnimplementedError();
  }

  @override
  Future<void> dismissNutritionRecommendation(String recommendationId) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionEntry> updateWaterIntake(String userId, DateTime date, double waterMl) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionEntry> updateExerciseCalories(String userId, DateTime date, double calories) async {
    throw UnimplementedError();
  }

  @override
  Future<List<NutritionTrend>> getNutritionTrends(String userId, String nutrient, DateTime startDate, DateTime endDate) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<MealType, NutritionInfo>> getMealTypeBreakdown(String userId, DateTime startDate, DateTime endDate) async {
    throw UnimplementedError();
  }

  @override
  Future<List<FoodEntry>> getFrequentFoods(String userId, {int limit = 10}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<FoodEntry>> getRecentFoods(String userId, {int limit = 10}) async {
    throw UnimplementedError();
  }

  @override
  Future<String> exportNutritionData(String userId, DateTime startDate, DateTime endDate, ExportFormat format) async {
    throw UnimplementedError();
  }

  @override
  Future<List<NutritionEntry>> importNutritionData(String userId, String data, ImportFormat format) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionStreaks> getNutritionStreaks(String userId) async {
    try {
      final entries = await getUserNutritionEntries(userId);
      
      if (entries.isEmpty) {
        return const NutritionStreaks(
          currentStreak: 0,
          longestStreak: 0,
          totalDaysTracked: 0,
          consistencyPercentage: 0,
          milestones: [],
        );
      }
      
      // Sort entries by date
      entries.sort((a, b) => a.date.compareTo(b.date));
      
      // Calculate streaks
      int currentStreak = 0;
      int longestStreak = 0;
      int tempStreak = 0;
      DateTime? lastDate;
      
      for (final entry in entries.reversed) {
        if (entry.foods.isNotEmpty) {
          if (lastDate == null || 
              lastDate.difference(entry.date).inDays == 1) {
            tempStreak++;
            if (lastDate == null) currentStreak = tempStreak;
          } else if (lastDate.difference(entry.date).inDays > 1) {
            longestStreak = math.max(longestStreak, tempStreak);
            tempStreak = 1;
            currentStreak = 0;
          }
          lastDate = entry.date;
        } else {
          longestStreak = math.max(longestStreak, tempStreak);
          tempStreak = 0;
          currentStreak = 0;
        }
      }
      
      longestStreak = math.max(longestStreak, tempStreak);
      
      // Calculate consistency
      final totalDaysTracked = entries.where((e) => e.foods.isNotEmpty).length;
      final daysSinceStart = DateTime.now().difference(entries.first.date).inDays + 1;
      final consistencyPercentage = (totalDaysTracked / daysSinceStart * 100).clamp(0, 100);
      
      // Generate milestones
      final milestones = _generateStreakMilestones(currentStreak, longestStreak);
      
      return NutritionStreaks(
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        totalDaysTracked: totalDaysTracked,
        consistencyPercentage: consistencyPercentage,
        lastTrackedDate: entries.isNotEmpty ? entries.first.date : null,
        milestones: milestones,
      );
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<double> calculateNutritionScore(String userId, DateTime date) async {
    throw UnimplementedError();
  }

  @override
  Future<List<NutritionInsight>> getNutritionInsights(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'nutritionInsights')
          .orderBy('priority', descending: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();
      
      return querySnapshot.docs
          .map((doc) => NutritionInsight.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Helper methods
  String _generateEntryId(DateTime date) {
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
  }

  NutritionInfo _calculateTotalNutrition(List<FoodEntry> foods) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSugar = 0;
    double totalSodium = 0;

    for (final food in foods) {
      totalCalories += food.nutrition.calories;
      totalProtein += food.nutrition.protein;
      totalCarbs += food.nutrition.carbs;
      totalFat += food.nutrition.fat;
      totalFiber += food.nutrition.fiber;
      totalSugar += food.nutrition.sugar;
      totalSodium += food.nutrition.sodium;
    }

    return NutritionInfo(
      calories: totalCalories,
      protein: totalProtein,
      carbs: totalCarbs,
      fat: totalFat,
      fiber: totalFiber,
      sugar: totalSugar,
      sodium: totalSodium,
    );
  }

  Map<MealType, NutritionInfo> _calculateMealBreakdown(List<FoodEntry> foods) {
    final breakdown = <MealType, NutritionInfo>{};
    
    for (final mealType in MealType.values) {
      final mealFoods = foods.where((food) => food.mealType == mealType).toList();
      if (mealFoods.isNotEmpty) {
        breakdown[mealType] = _calculateTotalNutrition(mealFoods);
      }
    }
    
    return breakdown;
  }

  List<FoodDatabase> _getMockFoodDatabase() {
    return [
      FoodDatabase(
        id: 'apple',
        name: 'Apple',
        brand: 'Generic',
        nutritionPer100g: const NutritionInfo(
          calories: 52,
          protein: 0.3,
          carbs: 14,
          fat: 0.2,
          fiber: 2.4,
          sugar: 10,
          sodium: 1,
        ),
        categories: ['fruits'],
        isVerified: true,
        createdAt: DateTime.now(),
      ),
      FoodDatabase(
        id: 'chicken_breast',
        name: 'Chicken Breast',
        brand: 'Generic',
        nutritionPer100g: const NutritionInfo(
          calories: 165,
          protein: 31,
          carbs: 0,
          fat: 3.6,
          fiber: 0,
          sugar: 0,
          sodium: 74,
        ),
        categories: ['meat', 'protein'],
        isVerified: true,
        createdAt: DateTime.now(),
      ),
      FoodDatabase(
        id: 'brown_rice',
        name: 'Brown Rice',
        brand: 'Generic',
        nutritionPer100g: const NutritionInfo(
          calories: 111,
          protein: 2.6,
          carbs: 23,
          fat: 0.9,
          fiber: 1.8,
          sugar: 0.4,
          sodium: 5,
        ),
        categories: ['grains', 'carbs'],
        isVerified: true,
        createdAt: DateTime.now(),
      ),
    ];
  }

  List<StreakMilestone> _generateStreakMilestones(int currentStreak, int longestStreak) {
    final milestones = <StreakMilestone>[];
    final streakTargets = [3, 7, 14, 30, 60, 90, 180, 365];
    
    for (final target in streakTargets) {
      final isAchieved = longestStreak >= target;
      milestones.add(StreakMilestone(
        days: target,
        title: '$target Day${target == 1 ? '' : 's'} Streak',
        description: 'Track nutrition for $target consecutive day${target == 1 ? '' : 's'}',
        isAchieved: isAchieved,
        achievedAt: isAchieved ? DateTime.now().subtract(Duration(days: longestStreak - target)) : null,
      ));
    }
    
    return milestones;
  }
}