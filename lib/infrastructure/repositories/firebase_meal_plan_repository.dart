import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/meal_plan.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../../domain/exceptions/app_exceptions.dart';
import '../services/firebase_service.dart';

class FirebaseMealPlanRepository implements IMealPlanRepository {
  static final FirebaseMealPlanRepository _instance = FirebaseMealPlanRepository._internal();
  static FirebaseMealPlanRepository get instance => _instance;
  
  FirebaseMealPlanRepository._internal();

  final FirebaseService _firebaseService = FirebaseService.instance;
  
  FirebaseFirestore get _firestore => _firebaseService.firestore;
  String? get _currentUserId => _firebaseService.currentUserId;

  @override
  Future<MealPlan> createMealPlan(MealPlan mealPlan) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'mealPlans')
          .doc(mealPlan.id)
          .set(mealPlan.toJson());
      
      await _firebaseService.logEvent('meal_plan_created', {
        'plan_name': mealPlan.name,
        'duration_days': mealPlan.endDate.difference(mealPlan.startDate).inDays,
      });
      
      return mealPlan;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<MealPlan?> getMealPlanById(String mealPlanId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final doc = await _firebaseService.userCollection(_currentUserId!, 'mealPlans')
          .doc(mealPlanId)
          .get();
      
      if (doc.exists && doc.data() != null) {
        return MealPlan.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<MealPlan>> getUserMealPlans(String userId) async {
    try {
      final querySnapshot = await _firebaseService.userCollection(userId, 'mealPlans')
          .orderBy('startDate', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => MealPlan.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Additional methods will be implemented as needed
  @override
  Future<MealPlan> updateMealPlan(MealPlan mealPlan) async {
    // Implementation placeholder
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMealPlan(String mealPlanId) async {
    // Implementation placeholder
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> updateMealPlan(MealPlan mealPlan) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      final updatedPlan = mealPlan.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _firebaseService.userCollection(_currentUserId!, 'mealPlans')
          .doc(mealPlan.id)
          .update(updatedPlan.toJson());
      
      return updatedPlan;
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<void> deleteMealPlan(String mealPlanId) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      await _firebaseService.userCollection(_currentUserId!, 'mealPlans')
          .doc(mealPlanId)
          .delete();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<MealPlan> addMealToPlan(String mealPlanId, DateTime date, PlannedMeal meal) async {
    try {
      if (_currentUserId == null) throw const UserNotSignedInException();
      
      return await _firestore.runTransaction((transaction) async {
        final planRef = _firebaseService.userCollection(_currentUserId!, 'mealPlans').doc(mealPlanId);
        final doc = await transaction.get(planRef);
        
        if (!doc.exists) {
          throw const NotFoundException('Meal plan not found');
        }
        
        final mealPlan = MealPlan.fromJson(doc.data()!);
        final updatedDays = List<MealPlanDay>.from(mealPlan.days);
        
        // Find or create the day
        final dayIndex = updatedDays.indexWhere((day) => 
          day.date.year == date.year && 
          day.date.month == date.month && 
          day.date.day == date.day);
        
        if (dayIndex >= 0) {
          // Update existing day
          final existingDay = updatedDays[dayIndex];
          final updatedMeals = [...existingDay.meals, meal];
          updatedDays[dayIndex] = existingDay.copyWith(meals: updatedMeals);
        } else {
          // Create new day
          final newDay = MealPlanDay(
            date: date,
            meals: [meal],
          );
          updatedDays.add(newDay);
        }
        
        final updatedPlan = mealPlan.copyWith(
          days: updatedDays,
          updatedAt: DateTime.now(),
        );
        
        transaction.update(planRef, updatedPlan.toJson());
        return updatedPlan;
      });
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<MealPlan>> getActiveMealPlans(String userId) async {
    try {
      final now = DateTime.now();
      final querySnapshot = await _firebaseService.userCollection(userId, 'mealPlans')
          .where('startDate', isLessThanOrEqualTo: Timestamp.fromDate(now))
          .where('endDate', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
          .orderBy('startDate')
          .get();
      
      return querySnapshot.docs
          .map((doc) => MealPlan.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<List<MealPlanTemplate>> getMealPlanTemplates() async {
    try {
      final querySnapshot = await _firestore.collection('mealPlanTemplates')
          .where('isPublic', isEqualTo: true)
          .orderBy('usageCount', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => MealPlanTemplate.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  @override
  Future<MealPlan> createFromTemplate(String templateId, String userId, DateTime startDate) async {
    try {
      final templateDoc = await _firestore.collection('mealPlanTemplates')
          .doc(templateId)
          .get();
      
      if (!templateDoc.exists) {
        throw const NotFoundException('Template not found');
      }
      
      final template = MealPlanTemplate.fromJson(templateDoc.data()!);
      final endDate = startDate.add(Duration(days: template.durationDays - 1));
      
      final mealPlan = MealPlan(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: template.name,
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        days: _generateDaysFromTemplate(template.templateDays, startDate),
        createdAt: DateTime.now(),
        nutritionGoals: template.targetNutrition,
      );
      
      return await createMealPlan(mealPlan);
    } catch (e) {
      throw _firebaseService.handleFirebaseException(e);
    }
  }

  // Placeholder implementations for remaining methods
  @override
  Future<MealPlan> updateMealInPlan(String mealPlanId, DateTime date, PlannedMeal meal) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> removeMealFromPlan(String mealPlanId, DateTime date, String mealId) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> markMealCompleted(String mealPlanId, DateTime date, String mealId) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> markMealPrepared(String mealPlanId, DateTime date, String mealId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MealPlan>> getMealPlansByDateRange(String userId, DateTime startDate, DateTime endDate) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MealPlan>> getSharedMealPlans(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> shareMealPlan(String mealPlanId, List<String> userIds) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> unshareMealPlan(String mealPlanId, List<String> userIds) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlanTemplate> saveAsTemplate(String mealPlanId, String templateName, String description) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlanStats> getMealPlanStats(String mealPlanId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MealPlan>> searchMealPlans(String userId, String query) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MealPlan>> getRecentMealPlans(String userId, {int limit = 10}) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> duplicateMealPlan(String mealPlanId, DateTime newStartDate) async {
    throw UnimplementedError();
  }

  @override
  Future<void> archiveMealPlan(String mealPlanId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<MealPlan>> getArchivedMealPlans(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlan> restoreMealPlan(String mealPlanId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<BatchCookingSession>> getBatchCookingSessions(String mealPlanId) async {
    throw UnimplementedError();
  }

  @override
  Future<BatchCookingSession> createBatchCookingSession(BatchCookingSession session) async {
    throw UnimplementedError();
  }

  @override
  Future<BatchCookingSession> updateBatchCookingSession(BatchCookingSession session) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionSummary> getNutritionSummary(String mealPlanId, DateTime startDate, DateTime endDate) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlanPreferences?> getMealPlanPreferences(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPlanPreferences> updateMealPlanPreferences(String userId, MealPlanPreferences preferences) async {
    throw UnimplementedError();
  }

  @override
  Future<List<PlannedMeal>> getMealSuggestions(String userId, DateTime date, MealType mealType) async {
    throw UnimplementedError();
  }

  @override
  Future<void> trackMealPrepTime(String mealPlanId, String mealId, Duration actualTime) async {
    throw UnimplementedError();
  }

  @override
  Future<MealPrepAnalytics> getMealPrepAnalytics(String userId, {DateTime? since}) async {
    throw UnimplementedError();
  }

  // Helper methods
  List<MealPlanDay> _generateDaysFromTemplate(List<MealPlanDay> templateDays, DateTime startDate) {
    final days = <MealPlanDay>[];
    
    for (int i = 0; i < templateDays.length; i++) {
      final templateDay = templateDays[i];
      final actualDate = startDate.add(Duration(days: i));
      
      days.add(templateDay.copyWith(date: actualDate));
    }
    
    return days;
  }
}