import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SimplePersistenceService {
  static const String _mealPlanKey = 'meal_plan_data';

  static Future<void> saveMealPlan(Map<String, dynamic> mealPlanData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(mealPlanData);
      await prefs.setString(_mealPlanKey, jsonString);
    } catch (e) {
      print('Error saving meal plan: $e');
    }
  }

  static Future<Map<String, dynamic>?> loadMealPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_mealPlanKey);
      if (jsonString != null) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error loading meal plan: $e');
    }
    return null;
  }

  static Future<void> clearMealPlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_mealPlanKey);
    } catch (e) {
      print('Error clearing meal plan: $e');
    }
  }
}
