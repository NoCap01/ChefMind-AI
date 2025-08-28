// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnalyticsImpl _$$UserAnalyticsImplFromJson(Map<String, dynamic> json) =>
    _$UserAnalyticsImpl(
      userId: json['userId'] as String,
      cookingStats: CookingStatistics.fromJson(
          json['cookingStats'] as Map<String, dynamic>),
      tasteProfile:
          TasteProfile.fromJson(json['tasteProfile'] as Map<String, dynamic>),
      efficiency: EfficiencyMetrics.fromJson(
          json['efficiency'] as Map<String, dynamic>),
      costAnalysis:
          CostAnalysis.fromJson(json['costAnalysis'] as Map<String, dynamic>),
      healthImpact:
          HealthImpact.fromJson(json['healthImpact'] as Map<String, dynamic>),
      environmentalImpact: EnvironmentalImpact.fromJson(
          json['environmentalImpact'] as Map<String, dynamic>),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      customMetrics: json['customMetrics'] as Map<String, dynamic>? ?? const {},
      cookingFrequency: json['cookingFrequency'] as String? ?? 'weekly',
      preferredDifficulty:
          json['preferredDifficulty'] as String? ?? 'intermediate',
    );

Map<String, dynamic> _$$UserAnalyticsImplToJson(_$UserAnalyticsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'cookingStats': instance.cookingStats,
      'tasteProfile': instance.tasteProfile,
      'efficiency': instance.efficiency,
      'costAnalysis': instance.costAnalysis,
      'healthImpact': instance.healthImpact,
      'environmentalImpact': instance.environmentalImpact,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'customMetrics': instance.customMetrics,
      'cookingFrequency': instance.cookingFrequency,
      'preferredDifficulty': instance.preferredDifficulty,
    };

_$CookingStatisticsImpl _$$CookingStatisticsImplFromJson(
        Map<String, dynamic> json) =>
    _$CookingStatisticsImpl(
      totalRecipesCooked: (json['totalRecipesCooked'] as num?)?.toInt() ?? 0,
      uniqueRecipesCooked: (json['uniqueRecipesCooked'] as num?)?.toInt() ?? 0,
      totalCookingTimeMinutes:
          (json['totalCookingTimeMinutes'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      cuisineFrequency:
          (json['cuisineFrequency'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      difficultyDistribution:
          (json['difficultyDistribution'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      cookingMethodFrequency:
          (json['cookingMethodFrequency'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      averageRatings: (json['averageRatings'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      monthlyActivity: (json['monthlyActivity'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      lastCookingDate: json['lastCookingDate'] == null
          ? null
          : DateTime.parse(json['lastCookingDate'] as String),
      favoriteRecipeIds: (json['favoriteRecipeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => CookingMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CookingStatisticsImplToJson(
        _$CookingStatisticsImpl instance) =>
    <String, dynamic>{
      'totalRecipesCooked': instance.totalRecipesCooked,
      'uniqueRecipesCooked': instance.uniqueRecipesCooked,
      'totalCookingTimeMinutes': instance.totalCookingTimeMinutes,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'cuisineFrequency': instance.cuisineFrequency,
      'difficultyDistribution': instance.difficultyDistribution,
      'cookingMethodFrequency': instance.cookingMethodFrequency,
      'averageRatings': instance.averageRatings,
      'monthlyActivity': instance.monthlyActivity,
      'lastCookingDate': instance.lastCookingDate?.toIso8601String(),
      'favoriteRecipeIds': instance.favoriteRecipeIds,
      'milestones': instance.milestones,
    };

_$TasteProfileImpl _$$TasteProfileImplFromJson(Map<String, dynamic> json) =>
    _$TasteProfileImpl(
      flavorPreferences:
          (json['flavorPreferences'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      ingredientFrequency:
          (json['ingredientFrequency'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      cuisinePreferences:
          (json['cuisinePreferences'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      spiceLevelDistribution:
          (json['spiceLevelDistribution'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      texturePreferences:
          (json['texturePreferences'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      cookingTimePreferences:
          (json['cookingTimePreferences'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      dislikedIngredients: (json['dislikedIngredients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      allergens: (json['allergens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferenceTrends:
          (json['preferenceTrends'] as Map<String, dynamic>?)?.map(
                (k, e) =>
                    MapEntry(k, TrendData.fromJson(e as Map<String, dynamic>)),
              ) ??
              const {},
      lastAnalyzed: json['lastAnalyzed'] == null
          ? null
          : DateTime.parse(json['lastAnalyzed'] as String),
    );

Map<String, dynamic> _$$TasteProfileImplToJson(_$TasteProfileImpl instance) =>
    <String, dynamic>{
      'flavorPreferences': instance.flavorPreferences,
      'ingredientFrequency': instance.ingredientFrequency,
      'cuisinePreferences': instance.cuisinePreferences,
      'spiceLevelDistribution': instance.spiceLevelDistribution,
      'texturePreferences': instance.texturePreferences,
      'cookingTimePreferences': instance.cookingTimePreferences,
      'dislikedIngredients': instance.dislikedIngredients,
      'allergens': instance.allergens,
      'preferenceTrends': instance.preferenceTrends,
      'lastAnalyzed': instance.lastAnalyzed?.toIso8601String(),
    };

_$EfficiencyMetricsImpl _$$EfficiencyMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$EfficiencyMetricsImpl(
      averageCookingTime:
          (json['averageCookingTime'] as num?)?.toDouble() ?? 0.0,
      averagePrepTime: (json['averagePrepTime'] as num?)?.toDouble() ?? 0.0,
      successRate: (json['successRate'] as num?)?.toDouble() ?? 0.0,
      recipeCompletionRate:
          (json['recipeCompletionRate'] as num?)?.toDouble() ?? 0.0,
      ingredientUtilizationRate:
          (json['ingredientUtilizationRate'] as num?)?.toDouble() ?? 0.0,
      mealPlanAdherence: (json['mealPlanAdherence'] as num?)?.toDouble() ?? 0.0,
      foodWasteReduction:
          (json['foodWasteReduction'] as num?)?.toDouble() ?? 0.0,
      skillProgression:
          (json['skillProgression'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      equipmentUsage: (json['equipmentUsage'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) => EfficiencyTip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$EfficiencyMetricsImplToJson(
        _$EfficiencyMetricsImpl instance) =>
    <String, dynamic>{
      'averageCookingTime': instance.averageCookingTime,
      'averagePrepTime': instance.averagePrepTime,
      'successRate': instance.successRate,
      'recipeCompletionRate': instance.recipeCompletionRate,
      'ingredientUtilizationRate': instance.ingredientUtilizationRate,
      'mealPlanAdherence': instance.mealPlanAdherence,
      'foodWasteReduction': instance.foodWasteReduction,
      'skillProgression': instance.skillProgression,
      'equipmentUsage': instance.equipmentUsage,
      'recommendations': instance.recommendations,
    };

_$CostAnalysisImpl _$$CostAnalysisImplFromJson(Map<String, dynamic> json) =>
    _$CostAnalysisImpl(
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
      averageMealCost: (json['averageMealCost'] as num?)?.toDouble() ?? 0.0,
      averageIngredientCost:
          (json['averageIngredientCost'] as num?)?.toDouble() ?? 0.0,
      monthlySpending: (json['monthlySpending'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      categorySpending:
          (json['categorySpending'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      costPerCuisine: (json['costPerCuisine'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      budgetAdherence: (json['budgetAdherence'] as num?)?.toDouble() ?? 0.0,
      savingsFromMealPlanning:
          (json['savingsFromMealPlanning'] as num?)?.toDouble() ?? 0.0,
      savingsTips: (json['savingsTips'] as List<dynamic>?)
              ?.map((e) => CostSavingTip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      priceHistory: (json['priceHistory'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, PriceHistory.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$CostAnalysisImplToJson(_$CostAnalysisImpl instance) =>
    <String, dynamic>{
      'totalSpent': instance.totalSpent,
      'averageMealCost': instance.averageMealCost,
      'averageIngredientCost': instance.averageIngredientCost,
      'monthlySpending': instance.monthlySpending,
      'categorySpending': instance.categorySpending,
      'costPerCuisine': instance.costPerCuisine,
      'budgetAdherence': instance.budgetAdherence,
      'savingsFromMealPlanning': instance.savingsFromMealPlanning,
      'savingsTips': instance.savingsTips,
      'priceHistory': instance.priceHistory,
    };

_$HealthImpactImpl _$$HealthImpactImplFromJson(Map<String, dynamic> json) =>
    _$HealthImpactImpl(
      nutritionTrends: (json['nutritionTrends'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      averageDailyCalories:
          (json['averageDailyCalories'] as num?)?.toDouble() ?? 0.0,
      macroDistribution:
          (json['macroDistribution'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      micronutrientIntake:
          (json['micronutrientIntake'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      dietaryGoalProgress:
          (json['dietaryGoalProgress'] as num?)?.toDouble() ?? 0.0,
      nutritionScore: (json['nutritionScore'] as num?)?.toDouble() ?? 0.0,
      insights: (json['insights'] as List<dynamic>?)
              ?.map((e) => HealthInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      healthTrends: (json['healthTrends'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, TrendData.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      lastNutritionAnalysis: json['lastNutritionAnalysis'] == null
          ? null
          : DateTime.parse(json['lastNutritionAnalysis'] as String),
    );

Map<String, dynamic> _$$HealthImpactImplToJson(_$HealthImpactImpl instance) =>
    <String, dynamic>{
      'nutritionTrends': instance.nutritionTrends,
      'averageDailyCalories': instance.averageDailyCalories,
      'macroDistribution': instance.macroDistribution,
      'micronutrientIntake': instance.micronutrientIntake,
      'dietaryGoalProgress': instance.dietaryGoalProgress,
      'nutritionScore': instance.nutritionScore,
      'insights': instance.insights,
      'healthTrends': instance.healthTrends,
      'lastNutritionAnalysis':
          instance.lastNutritionAnalysis?.toIso8601String(),
    };

_$EnvironmentalImpactImpl _$$EnvironmentalImpactImplFromJson(
        Map<String, dynamic> json) =>
    _$EnvironmentalImpactImpl(
      carbonFootprint: (json['carbonFootprint'] as num?)?.toDouble() ?? 0.0,
      waterUsage: (json['waterUsage'] as num?)?.toDouble() ?? 0.0,
      foodWasteReduction:
          (json['foodWasteReduction'] as num?)?.toDouble() ?? 0.0,
      localIngredientPercentage:
          (json['localIngredientPercentage'] as num?)?.toDouble() ?? 0.0,
      seasonalIngredientPercentage:
          (json['seasonalIngredientPercentage'] as num?)?.toDouble() ?? 0.0,
      sustainabilityScore:
          (json['sustainabilityScore'] as num?)?.toDouble() ?? 0.0,
      tips: (json['tips'] as List<dynamic>?)
              ?.map(
                  (e) => SustainabilityTip.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      impactByCategory:
          (json['impactByCategory'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      environmentalTrends:
          (json['environmentalTrends'] as Map<String, dynamic>?)?.map(
                (k, e) =>
                    MapEntry(k, TrendData.fromJson(e as Map<String, dynamic>)),
              ) ??
              const {},
    );

Map<String, dynamic> _$$EnvironmentalImpactImplToJson(
        _$EnvironmentalImpactImpl instance) =>
    <String, dynamic>{
      'carbonFootprint': instance.carbonFootprint,
      'waterUsage': instance.waterUsage,
      'foodWasteReduction': instance.foodWasteReduction,
      'localIngredientPercentage': instance.localIngredientPercentage,
      'seasonalIngredientPercentage': instance.seasonalIngredientPercentage,
      'sustainabilityScore': instance.sustainabilityScore,
      'tips': instance.tips,
      'impactByCategory': instance.impactByCategory,
      'environmentalTrends': instance.environmentalTrends,
    };

_$TrendDataImpl _$$TrendDataImplFromJson(Map<String, dynamic> json) =>
    _$TrendDataImpl(
      dataPoints: (json['dataPoints'] as List<dynamic>)
          .map((e) => DataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      direction: $enumDecode(_$TrendDirectionEnumMap, json['direction']),
      changePercentage: (json['changePercentage'] as num).toDouble(),
      timeframe: json['timeframe'] as String,
    );

Map<String, dynamic> _$$TrendDataImplToJson(_$TrendDataImpl instance) =>
    <String, dynamic>{
      'dataPoints': instance.dataPoints,
      'direction': _$TrendDirectionEnumMap[instance.direction]!,
      'changePercentage': instance.changePercentage,
      'timeframe': instance.timeframe,
    };

const _$TrendDirectionEnumMap = {
  TrendDirection.increasing: 'increasing',
  TrendDirection.decreasing: 'decreasing',
  TrendDirection.stable: 'stable',
  TrendDirection.volatile: 'volatile',
};

_$DataPointImpl _$$DataPointImplFromJson(Map<String, dynamic> json) =>
    _$DataPointImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      value: (json['value'] as num).toDouble(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$$DataPointImplToJson(_$DataPointImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'value': instance.value,
      'label': instance.label,
    };

_$CookingMilestoneImpl _$$CookingMilestoneImplFromJson(
        Map<String, dynamic> json) =>
    _$CookingMilestoneImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      achievedAt: DateTime.parse(json['achievedAt'] as String),
      type: $enumDecode(_$MilestoneTypeEnumMap, json['type']),
      badgeUrl: json['badgeUrl'] as String?,
      points: (json['points'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CookingMilestoneImplToJson(
        _$CookingMilestoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'achievedAt': instance.achievedAt.toIso8601String(),
      'type': _$MilestoneTypeEnumMap[instance.type]!,
      'badgeUrl': instance.badgeUrl,
      'points': instance.points,
    };

const _$MilestoneTypeEnumMap = {
  MilestoneType.recipeCount: 'recipeCount',
  MilestoneType.streak: 'streak',
  MilestoneType.skill: 'skill',
  MilestoneType.cuisine: 'cuisine',
  MilestoneType.difficulty: 'difficulty',
  MilestoneType.social: 'social',
  MilestoneType.efficiency: 'efficiency',
};

_$EfficiencyTipImpl _$$EfficiencyTipImplFromJson(Map<String, dynamic> json) =>
    _$EfficiencyTipImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$TipCategoryEnumMap, json['category']),
      potentialImprovement: (json['potentialImprovement'] as num).toDouble(),
      priority: $enumDecodeNullable(_$TipPriorityEnumMap, json['priority']) ??
          TipPriority.medium,
    );

Map<String, dynamic> _$$EfficiencyTipImplToJson(_$EfficiencyTipImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': _$TipCategoryEnumMap[instance.category]!,
      'potentialImprovement': instance.potentialImprovement,
      'priority': _$TipPriorityEnumMap[instance.priority]!,
    };

const _$TipCategoryEnumMap = {
  TipCategory.time: 'time',
  TipCategory.cost: 'cost',
  TipCategory.health: 'health',
  TipCategory.sustainability: 'sustainability',
  TipCategory.skill: 'skill',
  TipCategory.equipment: 'equipment',
};

const _$TipPriorityEnumMap = {
  TipPriority.low: 'low',
  TipPriority.medium: 'medium',
  TipPriority.high: 'high',
  TipPriority.urgent: 'urgent',
};

_$CostSavingTipImpl _$$CostSavingTipImplFromJson(Map<String, dynamic> json) =>
    _$CostSavingTipImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      potentialSavings: (json['potentialSavings'] as num).toDouble(),
      category: $enumDecode(_$TipCategoryEnumMap, json['category']),
      priority: $enumDecodeNullable(_$TipPriorityEnumMap, json['priority']) ??
          TipPriority.medium,
    );

Map<String, dynamic> _$$CostSavingTipImplToJson(_$CostSavingTipImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'potentialSavings': instance.potentialSavings,
      'category': _$TipCategoryEnumMap[instance.category]!,
      'priority': _$TipPriorityEnumMap[instance.priority]!,
    };

_$HealthInsightImpl _$$HealthInsightImplFromJson(Map<String, dynamic> json) =>
    _$HealthInsightImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$InsightTypeEnumMap, json['type']),
      impact: (json['impact'] as num).toDouble(),
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HealthInsightImplToJson(_$HealthInsightImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$InsightTypeEnumMap[instance.type]!,
      'impact': instance.impact,
      'recommendations': instance.recommendations,
    };

const _$InsightTypeEnumMap = {
  InsightType.nutrition: 'nutrition',
  InsightType.calories: 'calories',
  InsightType.macros: 'macros',
  InsightType.vitamins: 'vitamins',
  InsightType.minerals: 'minerals',
  InsightType.dietary: 'dietary',
};

_$SustainabilityTipImpl _$$SustainabilityTipImplFromJson(
        Map<String, dynamic> json) =>
    _$SustainabilityTipImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      environmentalImpact: (json['environmentalImpact'] as num).toDouble(),
      category: $enumDecode(_$TipCategoryEnumMap, json['category']),
      priority: $enumDecodeNullable(_$TipPriorityEnumMap, json['priority']) ??
          TipPriority.medium,
    );

Map<String, dynamic> _$$SustainabilityTipImplToJson(
        _$SustainabilityTipImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'environmentalImpact': instance.environmentalImpact,
      'category': _$TipCategoryEnumMap[instance.category]!,
      'priority': _$TipPriorityEnumMap[instance.priority]!,
    };

_$PriceHistoryImpl _$$PriceHistoryImplFromJson(Map<String, dynamic> json) =>
    _$PriceHistoryImpl(
      itemName: json['itemName'] as String,
      pricePoints: (json['pricePoints'] as List<dynamic>)
          .map((e) => PricePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      averagePrice: (json['averagePrice'] as num).toDouble(),
      lowestPrice: (json['lowestPrice'] as num).toDouble(),
      highestPrice: (json['highestPrice'] as num).toDouble(),
      priceTrend: $enumDecode(_$TrendDirectionEnumMap, json['priceTrend']),
    );

Map<String, dynamic> _$$PriceHistoryImplToJson(_$PriceHistoryImpl instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'pricePoints': instance.pricePoints,
      'averagePrice': instance.averagePrice,
      'lowestPrice': instance.lowestPrice,
      'highestPrice': instance.highestPrice,
      'priceTrend': _$TrendDirectionEnumMap[instance.priceTrend]!,
    };

_$PricePointImpl _$$PricePointImplFromJson(Map<String, dynamic> json) =>
    _$PricePointImpl(
      date: DateTime.parse(json['date'] as String),
      price: (json['price'] as num).toDouble(),
      store: json['store'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$PricePointImplToJson(_$PricePointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'price': instance.price,
      'store': instance.store,
      'location': instance.location,
    };
