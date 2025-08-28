import 'dart:math';

import '../../domain/entities/nutrition_tracking.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../../domain/services/nutrition_service.dart';
import '../../domain/exceptions/app_exceptions.dart';

class NutritionServiceImpl implements INutritionService {
  final INutritionRepository _repository;

  NutritionServiceImpl(this._repository);

  @override
  Future<NutritionGoals> calculateNutritionGoals({
    required double weightKg,
    required double heightCm,
    required int age,
    required Gender gender,
    required ActivityLevel activityLevel,
    required GoalType goalType,
    double? targetWeightKg,
  }) async {
    try {
      // Calculate BMR and TDEE
      final bmr = NutritionCalculator.calculateBMR(
        weightKg: weightKg,
        heightCm: heightCm,
        age: age,
        gender: gender,
      );

      final tdee = NutritionCalculator.calculateTDEE(
        bmr: bmr,
        activityLevel: activityLevel,
      );

      // Calculate calorie goal
      final calorieGoal = NutritionCalculator.calculateCalorieGoal(
        tdee: tdee,
        goalType: goalType,
      );

      // Calculate macronutrient distribution
      final macros = NutritionCalculator.calculateMacros(
        calories: calorieGoal,
        goalType: goalType,
      );

      // Calculate water goal
      final waterGoal = NutritionCalculator.calculateWaterGoal(
        weightKg: weightKg,
        activityLevel: activityLevel,
      );

      // Calculate fiber goal (14g per 1000 calories)
      final fiberGoal = (calorieGoal / 1000) * 14;

      return NutritionGoals(
        dailyCalories: calorieGoal,
        proteinGrams: macros['protein']!,
        carbsGrams: macros['carbs']!,
        fatGrams: macros['fat']!,
        fiberGrams: fiberGoal,
        sodiumMg: 2300, // Standard recommendation
        sugarGrams: calorieGoal * 0.10 / 4, // 10% of calories from added sugar
      );
    } catch (e) {
      throw ServiceException('Failed to calculate nutrition goals: $e');
    }
  }

  @override
  Future<NutritionAnalysis> analyzeNutritionEntry(
    NutritionEntry entry,
    NutritionGoals goals,
  ) async {
    try {
      final consumed = entry.totalNutrition;
      
      // Calculate overall score
      final overallScore = NutritionCalculator.calculateNutritionScore(
        consumed: consumed,
        goals: goals,
      );

      // Calculate individual nutrient scores
      final nutrientScores = <String, double>{
        'calories': _calculateNutrientScore(consumed.calories, goals.dailyCalories),
        'protein': _calculateNutrientScore(consumed.protein, goals.proteinGrams),
        'carbs': _calculateNutrientScore(consumed.carbs, goals.carbsGrams),
        'fat': _calculateNutrientScore(consumed.fat, goals.fatGrams),
        'fiber': _calculateNutrientScore(consumed.fiber, goals.fiberGrams),
        'sodium': _calculateSodiumScore(consumed.sodium, goals.sodiumMg),
      };

      // Identify deficiencies and excesses
      final deficiencies = <NutritionDeficiency>[];
      final excesses = <NutritionExcess>[];

      _analyzeNutrient('Protein', consumed.protein, goals.proteinGrams, deficiencies, excesses);
      _analyzeNutrient('Fiber', consumed.fiber, goals.fiberGrams, deficiencies, excesses);
      _analyzeSodium(consumed.sodium, goals.sodiumMg, excesses);

      // Generate positive aspects and improvement areas
      final positiveAspects = <String>[];
      final improvementAreas = <String>[];

      if (nutrientScores['protein']! >= 80) {
        positiveAspects.add('Good protein intake');
      } else {
        improvementAreas.add('Increase protein intake');
      }

      if (nutrientScores['fiber']! >= 80) {
        positiveAspects.add('Excellent fiber intake');
      } else {
        improvementAreas.add('Add more fiber-rich foods');
      }

      // Determine overall quality
      final quality = _determineNutritionQuality(overallScore);

      return NutritionAnalysis(
        overallScore: overallScore,
        nutrientScores: nutrientScores,
        deficiencies: deficiencies,
        excesses: excesses,
        positiveAspects: positiveAspects,
        improvementAreas: improvementAreas,
        quality: quality,
      );
    } catch (e) {
      throw ServiceException('Failed to analyze nutrition entry: $e');
    }
  }

  @override
  Future<List<NutritionRecommendation>> generateRecommendations(
    String userId,
    List<NutritionEntry> recentEntries,
    NutritionGoals goals,
  ) async {
    try {
      final recommendations = <NutritionRecommendation>[];

      if (recentEntries.isEmpty) {
        recommendations.add(NutritionRecommendation(
          id: _generateId(),
          title: 'Start Tracking Your Nutrition',
          description: 'Begin logging your meals to get personalized recommendations',
          type: RecommendationType.general,
          priority: RecommendationPriority.high,
          suggestedFoods: [],
          suggestedRecipes: [],
          createdAt: DateTime.now(),
        ));
        return recommendations;
      }

      // Analyze recent nutrition patterns
      final avgNutrition = _calculateAverageNutrition(recentEntries);

      // Check for protein deficiency
      if (avgNutrition.protein < goals.proteinGrams * 0.8) {
        recommendations.add(NutritionRecommendation(
          id: _generateId(),
          title: 'Increase Protein Intake',
          description: 'Your protein intake is below recommended levels',
          type: RecommendationType.nutrientDeficiency,
          priority: RecommendationPriority.high,
          suggestedFoods: ['chicken breast', 'eggs', 'greek yogurt', 'lentils'],
          suggestedRecipes: ['Grilled Chicken Salad', 'Protein Smoothie'],
          reasoning: 'Adequate protein is essential for muscle maintenance and satiety',
          benefits: ['Better muscle recovery', 'Increased satiety', 'Improved metabolism'],
          createdAt: DateTime.now(),
        ));
      }

      // Check for fiber deficiency
      if (avgNutrition.fiber < goals.fiberGrams * 0.7) {
        recommendations.add(NutritionRecommendation(
          id: _generateId(),
          title: 'Add More Fiber',
          description: 'Increase your fiber intake for better digestive health',
          type: RecommendationType.nutrientDeficiency,
          priority: RecommendationPriority.medium,
          suggestedFoods: ['oats', 'berries', 'broccoli', 'beans'],
          suggestedRecipes: ['Overnight Oats', 'Vegetable Stir Fry'],
          reasoning: 'Fiber supports digestive health and helps maintain stable blood sugar',
          benefits: ['Better digestion', 'Stable blood sugar', 'Heart health'],
          createdAt: DateTime.now(),
        ));
      }

      // Check for excessive sodium
      if (avgNutrition.sodium > goals.sodiumMg * 1.2) {
        recommendations.add(NutritionRecommendation(
          id: _generateId(),
          title: 'Reduce Sodium Intake',
          description: 'Your sodium intake is higher than recommended',
          type: RecommendationType.nutrientExcess,
          priority: RecommendationPriority.medium,
          suggestedFoods: ['fresh herbs', 'lemon juice', 'garlic'],
          suggestedRecipes: ['Herb-Crusted Fish', 'Fresh Vegetable Salad'],
          avoidFoods: ['processed foods', 'canned soups', 'deli meats'],
          reasoning: 'High sodium intake can contribute to high blood pressure',
          benefits: ['Better heart health', 'Reduced bloating'],
          createdAt: DateTime.now(),
        ));
      }

      return recommendations;
    } catch (e) {
      throw ServiceException('Failed to generate recommendations: $e');
    }
  }

  @override
  Future<NutritionInfo> calculateRecipeNutrition(
    Recipe recipe,
    int servings,
  ) async {
    try {
      // Use the recipe's existing nutrition info if available
      if (recipe.nutrition != null) {
        final nutrition = recipe.nutrition!;
        final servingRatio = servings / recipe.servings;
        
        return NutritionInfo(
          calories: nutrition.calories * servingRatio,
          protein: nutrition.protein * servingRatio,
          carbs: nutrition.carbs * servingRatio,
          fat: nutrition.fat * servingRatio,
          fiber: nutrition.fiber * servingRatio,
          sugar: nutrition.sugar * servingRatio,
          sodium: nutrition.sodium * servingRatio,
        );
      }

      // If no nutrition info, estimate based on ingredients
      return _estimateNutritionFromIngredients(recipe.ingredients, servings);
    } catch (e) {
      throw ServiceException('Failed to calculate recipe nutrition: $e');
    }
  }

  @override
  Future<List<FoodSuggestion>> suggestFoodsForGoals(
    NutritionGoals goals,
    NutritionInfo currentIntake,
    MealType targetMealType,
  ) async {
    try {
      final suggestions = <FoodSuggestion>[];
      
      // Calculate remaining needs
      final remainingCalories = goals.dailyCalories - currentIntake.calories;
      final remainingProtein = goals.proteinGrams - currentIntake.protein;
      final remainingFiber = goals.fiberGrams - currentIntake.fiber;

      // Suggest foods based on meal type and remaining needs
      if (targetMealType == MealType.breakfast) {
        if (remainingProtein > 10) {
          suggestions.add(FoodSuggestion(
            foodName: 'Greek Yogurt',
            quantity: 150,
            unit: 'g',
            nutrition: const NutritionInfo(
              calories: 100, protein: 15, carbs: 6, fat: 0,
              fiber: 0, sugar: 6, sodium: 50,
            ),
            reason: 'High protein breakfast option',
            priority: 0.9,
            alternatives: ['Cottage Cheese', 'Protein Smoothie'],
          ));
        }

        if (remainingFiber > 5) {
          suggestions.add(FoodSuggestion(
            foodName: 'Oatmeal with Berries',
            quantity: 1,
            unit: 'cup',
            nutrition: const NutritionInfo(
              calories: 150, protein: 5, carbs: 30, fat: 3,
              fiber: 8, sugar: 12, sodium: 5,
            ),
            reason: 'Excellent source of fiber',
            priority: 0.8,
            alternatives: ['Chia Pudding', 'Whole Grain Toast'],
          ));
        }
      }

      // Sort by priority
      suggestions.sort((a, b) => b.priority.compareTo(a.priority));
      
      return suggestions.take(5).toList();
    } catch (e) {
      throw ServiceException('Failed to suggest foods for goals: $e');
    }
  }

  @override
  Future<List<NutritionTrend>> analyzeNutritionTrends(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final entries = await _repository.getUserNutritionEntries(
        userId,
        startDate: startDate,
        endDate: endDate,
      );

      if (entries.length < 7) {
        return []; // Need at least a week of data for trends
      }

      final trends = <NutritionTrend>[];
      
      // Analyze calorie trend
      final calorieTrend = _analyzeTrend(
        entries.map((e) => e.totalNutrition.calories).toList(),
        'Calories',
      );
      trends.add(calorieTrend);

      // Analyze protein trend
      final proteinTrend = _analyzeTrend(
        entries.map((e) => e.totalNutrition.protein).toList(),
        'Protein',
      );
      trends.add(proteinTrend);

      // Analyze fiber trend
      final fiberTrend = _analyzeTrend(
        entries.map((e) => e.totalNutrition.fiber).toList(),
        'Fiber',
      );
      trends.add(fiberTrend);

      return trends;
    } catch (e) {
      throw ServiceException('Failed to analyze nutrition trends: $e');
    }
  }

  // Placeholder implementations for remaining methods
  @override
  Future<MealTimingRecommendation> optimizeMealTiming(
    List<NutritionEntry> entries,
    ActivityLevel activityLevel,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionReport> generateNutritionReport(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<DietaryValidation> validateDietaryRestrictions(
    List<FoodEntry> foods,
    List<DietaryRestriction> restrictions,
    List<String> allergies,
  ) async {
    try {
      final violations = <DietaryViolation>[];
      final allergenAlerts = <AllergenAlert>[];
      
      for (final food in foods) {
        // Check dietary restrictions
        for (final restriction in restrictions) {
          final violation = _checkDietaryRestriction(food, restriction);
          if (violation != null) {
            violations.add(violation);
          }
        }
        
        // Check allergens
        for (final allergen in allergies) {
          final alert = _checkAllergen(food, allergen);
          if (alert != null) {
            allergenAlerts.add(alert);
          }
        }
      }
      
      final isValid = violations.isEmpty && allergenAlerts.isEmpty;
      final complianceScore = _calculateComplianceScore(foods.length, violations.length, allergenAlerts.length);
      
      return DietaryValidation(
        isValid: isValid,
        violations: violations,
        allergenAlerts: allergenAlerts,
        complianceScore: complianceScore,
      );
    } catch (e) {
      throw ServiceException('Failed to validate dietary restrictions: $e');
    }
  }

  @override
  Future<HydrationRecommendation> calculateHydrationNeeds(
    double weightKg,
    ActivityLevel activityLevel,
    double exerciseMinutes,
    double environmentTemperature,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<MicronutrientAnalysis> analyzeMicronutrients(
    List<NutritionEntry> entries,
    int daysAnalyzed,
  ) async {
    try {
      if (entries.isEmpty) {
        return const MicronutrientAnalysis(
          vitamins: {},
          minerals: {},
          deficiencies: [],
          excesses: [],
          overallScore: 0,
        );
      }

      // Calculate average daily intake for each micronutrient
      final vitaminIntakes = <String, double>{};
      final mineralIntakes = <String, double>{};

      // Simulate micronutrient data (in real app, this would come from food database)
      for (final entry in entries) {
        for (final food in entry.foods) {
          _addMicronutrientsFromFood(food, vitaminIntakes, mineralIntakes);
        }
      }

      // Calculate averages
      final avgVitamins = <String, double>{};
      final avgMinerals = <String, double>{};

      vitaminIntakes.forEach((vitamin, total) {
        avgVitamins[vitamin] = total / daysAnalyzed;
      });

      mineralIntakes.forEach((mineral, total) {
        avgMinerals[mineral] = total / daysAnalyzed;
      });

      // Analyze vitamin status
      final vitaminStatus = <String, MicronutrientStatus>{};
      final mineralStatus = <String, MicronutrientStatus>{};
      final deficiencies = <String>[];
      final excesses = <String>[];

      // Analyze vitamins
      _analyzeVitamins(avgVitamins, vitaminStatus, deficiencies, excesses);
      
      // Analyze minerals
      _analyzeMinerals(avgMinerals, mineralStatus, deficiencies, excesses);

      // Calculate overall score
      final allStatuses = [...vitaminStatus.values, ...mineralStatus.values];
      final overallScore = allStatuses.isEmpty 
          ? 0.0 
          : allStatuses.map((s) => s.percentageOfRDA).reduce((a, b) => a + b) / allStatuses.length;

      return MicronutrientAnalysis(
        vitamins: vitaminStatus,
        minerals: mineralStatus,
        deficiencies: deficiencies,
        excesses: excesses,
        overallScore: (overallScore * 100).clamp(0, 100),
      );
    } catch (e) {
      throw ServiceException('Failed to analyze micronutrients: $e');
    }
  }

  @override
  Future<List<MealSuggestion>> generateMealSuggestions(
    NutritionGoals goals,
    NutritionInfo currentDayIntake,
    MealType mealType,
    List<DietaryRestriction> restrictions,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<List<SupplementRecommendation>> calculateSupplementRecommendations(
    MicronutrientAnalysis analysis,
    List<DietaryRestriction> restrictions,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<ExerciseNutritionPlan> optimizeForExercise(
    NutritionGoals baseGoals,
    ExerciseType exerciseType,
    Duration exerciseDuration,
    DateTime exerciseTime,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<NutritionProgressSummary> trackNutritionProgress(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final entries = await _repository.getUserNutritionEntries(
        userId,
        startDate: startDate,
        endDate: endDate,
      );
      
      if (entries.isEmpty) {
        return NutritionProgressSummary(
          userId: userId,
          startDate: startDate,
          endDate: endDate,
          metrics: {},
          milestones: [],
          overallProgress: 0,
          insights: ['Start tracking your nutrition to see progress'],
        );
      }
      
      final activeGoal = await _repository.getActiveNutritionGoal(userId);
      if (activeGoal == null) {
        return NutritionProgressSummary(
          userId: userId,
          startDate: startDate,
          endDate: endDate,
          metrics: {},
          milestones: [],
          overallProgress: 0,
          insights: ['Set nutrition goals to track progress'],
        );
      }
      
      // Calculate progress metrics
      final metrics = _calculateProgressMetrics(entries, activeGoal.targets);
      
      // Generate milestones
      final milestones = _generateProgressMilestones(activeGoal, entries);
      
      // Calculate overall progress
      final overallProgress = metrics.values
          .map((m) => m.progressPercentage)
          .reduce((a, b) => a + b) / metrics.length;
      
      // Generate insights
      final insights = _generateProgressInsights(metrics, entries);
      
      return NutritionProgressSummary(
        userId: userId,
        startDate: startDate,
        endDate: endDate,
        metrics: metrics,
        milestones: milestones,
        overallProgress: overallProgress.clamp(0, 100),
        insights: insights,
      );
    } catch (e) {
      throw ServiceException('Failed to track nutrition progress: $e');
    }
  }

  @override
  Future<List<NutritionInsight>> generateNutritionInsights(
    String userId,
    List<NutritionEntry> entries,
  ) async {
    throw UnimplementedError();
  }

  // Helper methods
  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           Random().nextInt(1000).toString();
  }

  double _calculateNutrientScore(double consumed, double target) {
    if (target == 0) return 100;
    
    final ratio = consumed / target;
    
    // Optimal range is 80-120% of target
    if (ratio >= 0.8 && ratio <= 1.2) {
      return 100 - (ratio - 1).abs() * 50;
    } else if (ratio < 0.8) {
      return ratio * 100;
    } else {
      return 100 - (ratio - 1.2) * 100;
    }
  }

  double _calculateSodiumScore(double consumed, double target) {
    final ratio = consumed / target;
    
    // Lower sodium is better
    if (ratio <= 1.0) {
      return 100;
    } else {
      return (100 - (ratio - 1) * 100).clamp(0, 100);
    }
  }

  void _analyzeNutrient(
    String name,
    double consumed,
    double target,
    List<NutritionDeficiency> deficiencies,
    List<NutritionExcess> excesses,
  ) {
    final ratio = consumed / target;
    
    if (ratio < 0.7) {
      deficiencies.add(NutritionDeficiency(
        nutrient: name,
        currentAmount: consumed,
        targetAmount: target,
        deficitPercentage: (1 - ratio) * 100,
        suggestedFoods: _getSuggestedFoodsForNutrient(name),
      ));
    } else if (ratio > 1.5) {
      excesses.add(NutritionExcess(
        nutrient: name,
        currentAmount: consumed,
        targetAmount: target,
        excessPercentage: (ratio - 1) * 100,
        reductionSuggestions: _getReductionSuggestions(name),
      ));
    }
  }

  void _analyzeSodium(
    double consumed,
    double target,
    List<NutritionExcess> excesses,
  ) {
    final ratio = consumed / target;
    
    if (ratio > 1.2) {
      excesses.add(NutritionExcess(
        nutrient: 'Sodium',
        currentAmount: consumed,
        targetAmount: target,
        excessPercentage: (ratio - 1) * 100,
        reductionSuggestions: [
          'Choose fresh foods over processed',
          'Use herbs and spices instead of salt',
          'Read nutrition labels carefully',
        ],
      ));
    }
  }

  List<String> _getSuggestedFoodsForNutrient(String nutrient) {
    switch (nutrient.toLowerCase()) {
      case 'protein':
        return ['chicken breast', 'eggs', 'greek yogurt', 'lentils', 'quinoa'];
      case 'fiber':
        return ['oats', 'berries', 'broccoli', 'beans', 'apples'];
      default:
        return [];
    }
  }

  List<String> _getReductionSuggestions(String nutrient) {
    switch (nutrient.toLowerCase()) {
      case 'sodium':
        return ['Choose fresh foods', 'Use herbs instead of salt', 'Read labels'];
      case 'sugar':
        return ['Limit sugary drinks', 'Choose whole fruits', 'Read labels'];
      default:
        return ['Moderate portion sizes'];
    }
  }

  NutritionQuality _determineNutritionQuality(double score) {
    if (score >= 85) return NutritionQuality.excellent;
    if (score >= 70) return NutritionQuality.good;
    if (score >= 50) return NutritionQuality.fair;
    return NutritionQuality.poor;
  }

  NutritionInfo _calculateAverageNutrition(List<NutritionEntry> entries) {
    if (entries.isEmpty) {
      return const NutritionInfo(
        calories: 0, protein: 0, carbs: 0, fat: 0,
        fiber: 0, sugar: 0, sodium: 0,
      );
    }

    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSugar = 0;
    double totalSodium = 0;

    for (final entry in entries) {
      totalCalories += entry.totalNutrition.calories;
      totalProtein += entry.totalNutrition.protein;
      totalCarbs += entry.totalNutrition.carbs;
      totalFat += entry.totalNutrition.fat;
      totalFiber += entry.totalNutrition.fiber;
      totalSugar += entry.totalNutrition.sugar;
      totalSodium += entry.totalNutrition.sodium;
    }

    final count = entries.length;
    return NutritionInfo(
      calories: totalCalories / count,
      protein: totalProtein / count,
      carbs: totalCarbs / count,
      fat: totalFat / count,
      fiber: totalFiber / count,
      sugar: totalSugar / count,
      sodium: totalSodium / count,
    );
  }

  NutritionInfo _estimateNutritionFromIngredients(List<Ingredient> ingredients, int servings) {
    // Basic estimation - in a real app, this would use a comprehensive food database
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;

    for (final ingredient in ingredients) {
      // Basic calorie estimation based on ingredient type
      final calories = _estimateIngredientCalories(ingredient);
      totalCalories += calories;
      
      // Rough macro distribution
      totalProtein += calories * 0.15 / 4; // 15% protein
      totalCarbs += calories * 0.50 / 4; // 50% carbs
      totalFat += calories * 0.35 / 9; // 35% fat
      totalFiber += calories * 0.02; // 2% fiber
    }

    final servingRatio = servings / 4.0; // Assume recipe serves 4 by default
    
    return NutritionInfo(
      calories: totalCalories * servingRatio,
      protein: totalProtein * servingRatio,
      carbs: totalCarbs * servingRatio,
      fat: totalFat * servingRatio,
      fiber: totalFiber * servingRatio,
      sugar: totalCarbs * 0.3 * servingRatio, // Estimate 30% of carbs as sugar
      sodium: totalCalories * 2 * servingRatio, // Rough sodium estimate
    );
  }

  double _estimateIngredientCalories(Ingredient ingredient) {
    // Very basic calorie estimation - would be replaced with database lookup
    final name = ingredient.name.toLowerCase();
    
    if (name.contains('oil') || name.contains('butter')) {
      return ingredient.quantity * 120; // High fat
    } else if (name.contains('meat') || name.contains('chicken') || name.contains('fish')) {
      return ingredient.quantity * 25; // Protein
    } else if (name.contains('rice') || name.contains('pasta') || name.contains('bread')) {
      return ingredient.quantity * 35; // Carbs
    } else if (name.contains('vegetable') || name.contains('fruit')) {
      return ingredient.quantity * 5; // Low calorie
    }
    
    return ingredient.quantity * 15; // Default estimate
  }

  NutritionTrend _analyzeTrend(List<double> values, String nutrient) {
    if (values.length < 2) {
      return NutritionTrend(
        nutrient: nutrient,
        direction: TrendDirection.stable,
        changePercentage: 0,
        description: 'Insufficient data for trend analysis',
        significance: TrendSignificance.low,
      );
    }

    final firstHalf = values.take(values.length ~/ 2).toList();
    final secondHalf = values.skip(values.length ~/ 2).toList();
    
    final firstAvg = firstHalf.reduce((a, b) => a + b) / firstHalf.length;
    final secondAvg = secondHalf.reduce((a, b) => a + b) / secondHalf.length;
    
    final changePercentage = ((secondAvg - firstAvg) / firstAvg) * 100;
    
    TrendDirection direction;
    if (changePercentage > 5) {
      direction = TrendDirection.increasing;
    } else if (changePercentage < -5) {
      direction = TrendDirection.decreasing;
    } else {
      direction = TrendDirection.stable;
    }
    
    final significance = changePercentage.abs() > 20 
        ? TrendSignificance.high
        : changePercentage.abs() > 10
            ? TrendSignificance.moderate
            : TrendSignificance.low;
    
    return NutritionTrend(
      nutrient: nutrient,
      direction: direction,
      changePercentage: changePercentage,
      description: _getTrendDescription(nutrient, direction, changePercentage),
      significance: significance,
    );
  }

  String _getTrendDescription(String nutrient, TrendDirection direction, double changePercentage) {
    final change = changePercentage.abs().toStringAsFixed(1);
    
    switch (direction) {
      case TrendDirection.increasing:
        return '$nutrient intake has increased by $change% over the period';
      case TrendDirection.decreasing:
        return '$nutrient intake has decreased by $change% over the period';
      case TrendDirection.stable:
        return '$nutrient intake has remained stable';
    }
  }

  // Micronutrient analysis helper methods
  void _addMicronutrientsFromFood(
    FoodEntry food,
    Map<String, double> vitaminIntakes,
    Map<String, double> mineralIntakes,
  ) {
    // Simulate micronutrient content based on food type
    final foodName = food.foodName.toLowerCase();
    final quantity = food.quantity;
    
    // Vitamins (in mcg or mg)
    if (foodName.contains('orange') || foodName.contains('citrus')) {
      vitaminIntakes['Vitamin C'] = (vitaminIntakes['Vitamin C'] ?? 0) + (quantity * 50);
    }
    if (foodName.contains('carrot') || foodName.contains('sweet potato')) {
      vitaminIntakes['Vitamin A'] = (vitaminIntakes['Vitamin A'] ?? 0) + (quantity * 800);
    }
    if (foodName.contains('spinach') || foodName.contains('leafy')) {
      vitaminIntakes['Folate'] = (vitaminIntakes['Folate'] ?? 0) + (quantity * 200);
      vitaminIntakes['Vitamin K'] = (vitaminIntakes['Vitamin K'] ?? 0) + (quantity * 150);
    }
    if (foodName.contains('fish') || foodName.contains('salmon')) {
      vitaminIntakes['Vitamin D'] = (vitaminIntakes['Vitamin D'] ?? 0) + (quantity * 10);
      vitaminIntakes['Vitamin B12'] = (vitaminIntakes['Vitamin B12'] ?? 0) + (quantity * 2.5);
    }
    
    // Minerals (in mg)
    if (foodName.contains('dairy') || foodName.contains('milk') || foodName.contains('cheese')) {
      mineralIntakes['Calcium'] = (mineralIntakes['Calcium'] ?? 0) + (quantity * 120);
    }
    if (foodName.contains('meat') || foodName.contains('beef') || foodName.contains('chicken')) {
      mineralIntakes['Iron'] = (mineralIntakes['Iron'] ?? 0) + (quantity * 2.5);
      mineralIntakes['Zinc'] = (mineralIntakes['Zinc'] ?? 0) + (quantity * 3);
    }
    if (foodName.contains('banana') || foodName.contains('potato')) {
      mineralIntakes['Potassium'] = (mineralIntakes['Potassium'] ?? 0) + (quantity * 400);
    }
  }

  void _analyzeVitamins(
    Map<String, double> avgVitamins,
    Map<String, MicronutrientStatus> vitaminStatus,
    List<String> deficiencies,
    List<String> excesses,
  ) {
    final vitaminRDAs = {
      'Vitamin C': 90.0, // mg
      'Vitamin A': 900.0, // mcg
      'Vitamin D': 15.0, // mcg
      'Vitamin B12': 2.4, // mcg
      'Folate': 400.0, // mcg
      'Vitamin K': 120.0, // mcg
    };

    avgVitamins.forEach((vitamin, intake) {
      final rda = vitaminRDAs[vitamin] ?? 100.0;
      final percentage = (intake / rda) * 100;
      
      MicronutrientLevel level;
      if (percentage < 50) {
        level = MicronutrientLevel.deficient;
        deficiencies.add(vitamin);
      } else if (percentage < 80) {
        level = MicronutrientLevel.low;
      } else if (percentage <= 150) {
        level = MicronutrientLevel.adequate;
      } else if (percentage <= 300) {
        level = MicronutrientLevel.high;
      } else {
        level = MicronutrientLevel.excessive;
        excesses.add(vitamin);
      }

      vitaminStatus[vitamin] = MicronutrientStatus(
        name: vitamin,
        averageIntake: intake,
        recommendedIntake: rda,
        percentageOfRDA: percentage,
        level: level,
        foodSources: _getVitaminSources(vitamin),
      );
    });
  }

  void _analyzeMinerals(
    Map<String, double> avgMinerals,
    Map<String, MicronutrientStatus> mineralStatus,
    List<String> deficiencies,
    List<String> excesses,
  ) {
    final mineralRDAs = {
      'Calcium': 1000.0, // mg
      'Iron': 18.0, // mg
      'Zinc': 11.0, // mg
      'Potassium': 3500.0, // mg
      'Magnesium': 400.0, // mg
    };

    avgMinerals.forEach((mineral, intake) {
      final rda = mineralRDAs[mineral] ?? 100.0;
      final percentage = (intake / rda) * 100;
      
      MicronutrientLevel level;
      if (percentage < 50) {
        level = MicronutrientLevel.deficient;
        deficiencies.add(mineral);
      } else if (percentage < 80) {
        level = MicronutrientLevel.low;
      } else if (percentage <= 150) {
        level = MicronutrientLevel.adequate;
      } else if (percentage <= 300) {
        level = MicronutrientLevel.high;
      } else {
        level = MicronutrientLevel.excessive;
        excesses.add(mineral);
      }

      mineralStatus[mineral] = MicronutrientStatus(
        name: mineral,
        averageIntake: intake,
        recommendedIntake: rda,
        percentageOfRDA: percentage,
        level: level,
        foodSources: _getMineralSources(mineral),
      );
    });
  }

  List<String> _getVitaminSources(String vitamin) {
    switch (vitamin) {
      case 'Vitamin C':
        return ['oranges', 'strawberries', 'bell peppers', 'broccoli'];
      case 'Vitamin A':
        return ['carrots', 'sweet potatoes', 'spinach', 'liver'];
      case 'Vitamin D':
        return ['fatty fish', 'fortified milk', 'egg yolks', 'sunlight'];
      case 'Vitamin B12':
        return ['meat', 'fish', 'dairy', 'fortified cereals'];
      case 'Folate':
        return ['leafy greens', 'legumes', 'fortified grains', 'asparagus'];
      case 'Vitamin K':
        return ['leafy greens', 'broccoli', 'brussels sprouts', 'cabbage'];
      default:
        return [];
    }
  }

  List<String> _getMineralSources(String mineral) {
    switch (mineral) {
      case 'Calcium':
        return ['dairy products', 'leafy greens', 'sardines', 'almonds'];
      case 'Iron':
        return ['red meat', 'spinach', 'lentils', 'fortified cereals'];
      case 'Zinc':
        return ['meat', 'shellfish', 'legumes', 'seeds'];
      case 'Potassium':
        return ['bananas', 'potatoes', 'beans', 'spinach'];
      case 'Magnesium':
        return ['nuts', 'seeds', 'whole grains', 'leafy greens'];
      default:
        return [];
    }
  }

  // Dietary restriction validation helper methods
  DietaryViolation? _checkDietaryRestriction(FoodEntry food, DietaryRestriction restriction) {
    final foodName = food.foodName.toLowerCase();
    
    switch (restriction) {
      case DietaryRestriction.vegetarian:
        if (_containsMeat(foodName)) {
          return DietaryViolation(
            foodName: food.foodName,
            restriction: restriction,
            reason: 'Contains meat products',
            severity: ViolationSeverity.major,
          );
        }
        break;
      case DietaryRestriction.vegan:
        if (_containsAnimalProducts(foodName)) {
          return DietaryViolation(
            foodName: food.foodName,
            restriction: restriction,
            reason: 'Contains animal products',
            severity: ViolationSeverity.major,
          );
        }
        break;
      case DietaryRestriction.glutenFree:
        if (_containsGluten(foodName)) {
          return DietaryViolation(
            foodName: food.foodName,
            restriction: restriction,
            reason: 'Contains gluten',
            severity: ViolationSeverity.major,
          );
        }
        break;
      case DietaryRestriction.dairyFree:
        if (_containsDairy(foodName)) {
          return DietaryViolation(
            foodName: food.foodName,
            restriction: restriction,
            reason: 'Contains dairy products',
            severity: ViolationSeverity.major,
          );
        }
        break;
      case DietaryRestriction.keto:
        if (food.nutrition.carbs > 5) {
          return DietaryViolation(
            foodName: food.foodName,
            restriction: restriction,
            reason: 'High carbohydrate content (${food.nutrition.carbs.toStringAsFixed(1)}g)',
            severity: ViolationSeverity.moderate,
          );
        }
        break;
      case DietaryRestriction.lowSodium:
        if (food.nutrition.sodium > 140) {
          return DietaryViolation(
            foodName: food.foodName,
            restriction: restriction,
            reason: 'High sodium content (${food.nutrition.sodium.toStringAsFixed(0)}mg)',
            severity: ViolationSeverity.moderate,
          );
        }
        break;
    }
    
    return null;
  }

  AllergenAlert? _checkAllergen(FoodEntry food, String allergen) {
    final foodName = food.foodName.toLowerCase();
    final allergenLower = allergen.toLowerCase();
    
    if (_foodContainsAllergen(foodName, allergenLower)) {
      return AllergenAlert(
        foodName: food.foodName,
        allergen: allergen,
        severity: AlertSeverity.high,
        alternatives: _getAllergenAlternatives(allergen),
      );
    }
    
    return null;
  }

  bool _containsMeat(String foodName) {
    final meatKeywords = ['beef', 'pork', 'chicken', 'turkey', 'lamb', 'fish', 'seafood', 'meat'];
    return meatKeywords.any((keyword) => foodName.contains(keyword));
  }

  bool _containsAnimalProducts(String foodName) {
    final animalKeywords = ['beef', 'pork', 'chicken', 'turkey', 'lamb', 'fish', 'seafood', 'meat', 
                           'milk', 'cheese', 'yogurt', 'butter', 'cream', 'egg', 'honey'];
    return animalKeywords.any((keyword) => foodName.contains(keyword));
  }

  bool _containsGluten(String foodName) {
    final glutenKeywords = ['wheat', 'barley', 'rye', 'bread', 'pasta', 'flour', 'cereal'];
    return glutenKeywords.any((keyword) => foodName.contains(keyword));
  }

  bool _containsDairy(String foodName) {
    final dairyKeywords = ['milk', 'cheese', 'yogurt', 'butter', 'cream', 'dairy'];
    return dairyKeywords.any((keyword) => foodName.contains(keyword));
  }

  bool _foodContainsAllergen(String foodName, String allergen) {
    return foodName.contains(allergen) || 
           _getAllergenKeywords(allergen).any((keyword) => foodName.contains(keyword));
  }

  List<String> _getAllergenKeywords(String allergen) {
    switch (allergen.toLowerCase()) {
      case 'nuts':
        return ['almond', 'walnut', 'pecan', 'cashew', 'pistachio', 'hazelnut'];
      case 'shellfish':
        return ['shrimp', 'crab', 'lobster', 'oyster', 'clam', 'mussel'];
      case 'soy':
        return ['soybean', 'tofu', 'tempeh', 'miso', 'soy sauce'];
      default:
        return [allergen];
    }
  }

  List<String> _getAllergenAlternatives(String allergen) {
    switch (allergen.toLowerCase()) {
      case 'nuts':
        return ['seeds', 'coconut', 'avocado'];
      case 'dairy':
        return ['plant-based milk', 'coconut yogurt', 'nutritional yeast'];
      case 'gluten':
        return ['rice', 'quinoa', 'gluten-free oats'];
      case 'eggs':
        return ['flax eggs', 'chia seeds', 'applesauce'];
      default:
        return [];
    }
  }

  double _calculateComplianceScore(int totalFoods, int violations, int allergenAlerts) {
    if (totalFoods == 0) return 100.0;
    
    final totalIssues = violations + allergenAlerts;
    final complianceRate = (totalFoods - totalIssues) / totalFoods;
    return (complianceRate * 100).clamp(0, 100);
  }

  // Progress tracking helper methods
  Map<String, ProgressMetric> _calculateProgressMetrics(
    List<NutritionEntry> entries,
    NutritionGoals goals,
  ) {
    if (entries.isEmpty) return {};
    
    final metrics = <String, ProgressMetric>{};
    
    // Calculate average nutrition over the period
    final avgNutrition = _calculateAverageNutrition(entries);
    
    // Calories metric
    metrics['calories'] = ProgressMetric(
      name: 'Daily Calories',
      startValue: entries.last.totalNutrition.calories,
      currentValue: avgNutrition.calories,
      targetValue: goals.dailyCalories,
      progressPercentage: (avgNutrition.calories / goals.dailyCalories * 100).clamp(0, 100),
      trend: _calculateTrend(entries.map((e) => e.totalNutrition.calories).toList()),
    );
    
    // Protein metric
    metrics['protein'] = ProgressMetric(
      name: 'Daily Protein',
      startValue: entries.last.totalNutrition.protein,
      currentValue: avgNutrition.protein,
      targetValue: goals.proteinGrams,
      progressPercentage: (avgNutrition.protein / goals.proteinGrams * 100).clamp(0, 100),
      trend: _calculateTrend(entries.map((e) => e.totalNutrition.protein).toList()),
    );
    
    // Fiber metric
    metrics['fiber'] = ProgressMetric(
      name: 'Daily Fiber',
      startValue: entries.last.totalNutrition.fiber,
      currentValue: avgNutrition.fiber,
      targetValue: goals.fiberGrams,
      progressPercentage: (avgNutrition.fiber / goals.fiberGrams * 100).clamp(0, 100),
      trend: _calculateTrend(entries.map((e) => e.totalNutrition.fiber).toList()),
    );
    
    return metrics;
  }

  TrendDirection _calculateTrend(List<double> values) {
    if (values.length < 2) return TrendDirection.stable;
    
    final firstHalf = values.take(values.length ~/ 2).toList();
    final secondHalf = values.skip(values.length ~/ 2).toList();
    
    final firstAvg = firstHalf.reduce((a, b) => a + b) / firstHalf.length;
    final secondAvg = secondHalf.reduce((a, b) => a + b) / secondHalf.length;
    
    final changePercentage = ((secondAvg - firstAvg) / firstAvg) * 100;
    
    if (changePercentage > 5) {
      return TrendDirection.increasing;
    } else if (changePercentage < -5) {
      return TrendDirection.decreasing;
    } else {
      return TrendDirection.stable;
    }
  }

  List<ProgressMilestone> _generateProgressMilestones(
    NutritionGoal goal,
    List<NutritionEntry> entries,
  ) {
    final milestones = <ProgressMilestone>[];
    final daysSinceStart = DateTime.now().difference(goal.startDate).inDays;
    
    // 7-day tracking milestone
    milestones.add(ProgressMilestone(
      title: '7-Day Streak',
      description: 'Track nutrition for 7 consecutive days',
      isAchieved: entries.length >= 7,
      achievedAt: entries.length >= 7 ? entries[6].date : null,
      targetValue: 7,
      metric: 'days',
    ));
    
    // 30-day tracking milestone
    milestones.add(ProgressMilestone(
      title: '30-Day Streak',
      description: 'Track nutrition for 30 consecutive days',
      isAchieved: entries.length >= 30,
      achievedAt: entries.length >= 30 ? entries[29].date : null,
      targetValue: 30,
      metric: 'days',
    ));
    
    // Goal achievement milestone
    final avgNutrition = _calculateAverageNutrition(entries);
    final calorieGoalAchieved = (avgNutrition.calories / goal.targets.dailyCalories).abs() <= 0.1;
    
    milestones.add(ProgressMilestone(
      title: 'Calorie Goal Achieved',
      description: 'Maintain calorie target within 10% for a week',
      isAchieved: calorieGoalAchieved && entries.length >= 7,
      achievedAt: calorieGoalAchieved && entries.length >= 7 ? DateTime.now() : null,
      targetValue: goal.targets.dailyCalories,
      metric: 'calories',
    ));
    
    return milestones;
  }

  List<String> _generateProgressInsights(
    Map<String, ProgressMetric> metrics,
    List<NutritionEntry> entries,
  ) {
    final insights = <String>[];
    
    if (entries.isEmpty) {
      insights.add('Start tracking your nutrition to see progress insights');
      return insights;
    }
    
    // Analyze trends
    metrics.forEach((key, metric) {
      switch (metric.trend) {
        case TrendDirection.increasing:
          if (key == 'calories' && metric.progressPercentage > 110) {
            insights.add('Your calorie intake is trending upward - consider portion control');
          } else if (key == 'protein' && metric.progressPercentage < 100) {
            insights.add('Great job increasing your protein intake!');
          }
          break;
        case TrendDirection.decreasing:
          if (key == 'fiber' && metric.progressPercentage < 80) {
            insights.add('Your fiber intake is decreasing - add more fruits and vegetables');
          }
          break;
        case TrendDirection.stable:
          if (metric.progressPercentage >= 90 && metric.progressPercentage <= 110) {
            insights.add('Excellent consistency with your ${metric.name.toLowerCase()}!');
          }
          break;
      }
    });
    
    // Consistency insights
    final consistentDays = entries.where((e) => e.foods.isNotEmpty).length;
    final totalDays = entries.length;
    final consistencyRate = consistentDays / totalDays;
    
    if (consistencyRate >= 0.9) {
      insights.add('Outstanding tracking consistency! Keep it up!');
    } else if (consistencyRate >= 0.7) {
      insights.add('Good tracking consistency - aim for daily logging');
    } else {
      insights.add('Try to log your meals more consistently for better insights');
    }
    
    return insights;
  }
}