import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/repositories/meal_plan_repository.dart';
import '../models/meal_plan_model.dart';
import '../../core/config/api_constants.dart';
import '../../core/errors/app_exceptions.dart';

class FirebaseMealPlanRepository implements MealPlanRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveMealPlan(MealPlan mealPlan) async {
    try {
      final model = MealPlanModel.fromDomain(mealPlan);
      await _firestore
          .collection(ApiConstants.mealPlansCollection)
          .doc(mealPlan.id)
          .set(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to save meal plan');
    }
  }

  @override
  Future<MealPlan?> getMealPlan(String mealPlanId) async {
    try {
      final doc = await _firestore
          .collection(ApiConstants.mealPlansCollection)
          .doc(mealPlanId)
          .get();

      if (doc.exists && doc.data() != null) {
        final model = MealPlanModel.fromJson(doc.data()!);
        return model.toDomain();
      }
      return null;
    } catch (e) {
      throw const DatabaseException('Failed to get meal plan');
    }
  }

  @override
  Future<List<MealPlan>> getUserMealPlans(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(ApiConstants.mealPlansCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final model = MealPlanModel.fromJson(doc.data());
        return model.toDomain();
      }).toList();
    } catch (e) {
      throw const DatabaseException('Failed to get user meal plans');
    }
  }

  @override
  Future<void> updateMealPlan(MealPlan mealPlan) async {
    try {
      final model = MealPlanModel.fromDomain(mealPlan);
      await _firestore
          .collection(ApiConstants.mealPlansCollection)
          .doc(mealPlan.id)
          .update(model.toJson());
    } catch (e) {
      throw const DatabaseException('Failed to update meal plan');
    }
  }

  @override
  Future<void> deleteMealPlan(String mealPlanId) async {
    try {
      await _firestore
          .collection(ApiConstants.mealPlansCollection)
          .doc(mealPlanId)
          .delete();
    } catch (e) {
      throw const DatabaseException('Failed to delete meal plan');
    }
  }

  // Fixed method signature: (String userId, DateTime startDate, int days)
  @override
  Future<MealPlan> generateMealPlan(
      String userId, DateTime startDate, int days) async {
    // Create placeholder meal plan with correct parameters
    return MealPlan(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      name: 'Generated Meal Plan - $days days',
      startDate: startDate,
      endDate: startDate.add(Duration(days: days)),
      dailyPlans: [],
      notes: [],
      isActive: false,
      createdAt: DateTime.now(),
    );
  }

  // Fixed method signature: (String mealPlanId, DateTime date, String mealType)
  @override
  Future<void> markMealAsCooked(
      String mealPlanId, DateTime date, String mealType) async {
    try {
      await _firestore
          .collection(ApiConstants.mealPlansCollection)
          .doc(mealPlanId)
          .update({
        'lastCooked': FieldValue.serverTimestamp(),
        'cookedMeal': {
          'date': date.toIso8601String(),
          'mealType': mealType,
        }
      });
    } catch (e) {
      throw const DatabaseException('Failed to mark meal as cooked');
    }
  }

  // Added missing watchUserMealPlans method
  @override
  Stream<List<MealPlan>> watchUserMealPlans(String userId) {
    return _firestore
        .collection(ApiConstants.mealPlansCollection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final model = MealPlanModel.fromJson(doc.data());
        return model.toDomain();
      }).toList();
    });
  }
}
