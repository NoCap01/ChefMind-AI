// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => CookingStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      cookingTime: Duration(microseconds: (json['cookingTime'] as num).toInt()),
      prepTime: Duration(microseconds: (json['prepTime'] as num).toInt()),
      difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
      servings: (json['servings'] as num).toInt(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      nutrition:
          NutritionInfo.fromJson(json['nutrition'] as Map<String, dynamic>),
      tips: (json['tips'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      authorId: json['authorId'] as String?,
      cookCount: (json['cookCount'] as num?)?.toInt() ?? 0,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastViewedAt: json['lastViewedAt'] == null
          ? null
          : DateTime.parse(json['lastViewedAt'] as String),
      collections: (json['collections'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'cookingTime': instance.cookingTime.inMicroseconds,
      'prepTime': instance.prepTime.inMicroseconds,
      'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
      'servings': instance.servings,
      'tags': instance.tags,
      'nutrition': instance.nutrition,
      'tips': instance.tips,
      'rating': instance.rating,
      'createdAt': instance.createdAt.toIso8601String(),
      'imageUrl': instance.imageUrl,
      'isFavorite': instance.isFavorite,
      'authorId': instance.authorId,
      'cookCount': instance.cookCount,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastViewedAt': instance.lastViewedAt?.toIso8601String(),
      'collections': instance.collections,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.beginner: 'beginner',
  DifficultyLevel.intermediate: 'intermediate',
  DifficultyLevel.advanced: 'advanced',
  DifficultyLevel.expert: 'expert',
};

_$IngredientImpl _$$IngredientImplFromJson(Map<String, dynamic> json) =>
    _$IngredientImpl(
      name: json['name'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      category: json['category'] as String?,
      isOptional: json['isOptional'] as bool? ?? false,
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$IngredientImplToJson(_$IngredientImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'category': instance.category,
      'isOptional': instance.isOptional,
      'alternatives': instance.alternatives,
    };

_$CookingStepImpl _$$CookingStepImplFromJson(Map<String, dynamic> json) =>
    _$CookingStepImpl(
      stepNumber: (json['stepNumber'] as num).toInt(),
      instruction: json['instruction'] as String,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      imageUrl: json['imageUrl'] as String?,
      tips:
          (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      equipment: (json['equipment'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CookingStepImplToJson(_$CookingStepImpl instance) =>
    <String, dynamic>{
      'stepNumber': instance.stepNumber,
      'instruction': instance.instruction,
      'duration': instance.duration?.inMicroseconds,
      'imageUrl': instance.imageUrl,
      'tips': instance.tips,
      'equipment': instance.equipment,
    };

_$NutritionInfoImpl _$$NutritionInfoImplFromJson(Map<String, dynamic> json) =>
    _$NutritionInfoImpl(
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
      sodium: (json['sodium'] as num).toDouble(),
      vitamins: (json['vitamins'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      minerals: (json['minerals'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      carbohydrates: (json['carbohydrates'] as num?)?.toDouble() ?? 0.0,
      cholesterol: (json['cholesterol'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$NutritionInfoImplToJson(_$NutritionInfoImpl instance) =>
    <String, dynamic>{
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sugar': instance.sugar,
      'sodium': instance.sodium,
      'vitamins': instance.vitamins,
      'minerals': instance.minerals,
      'carbohydrates': instance.carbohydrates,
      'cholesterol': instance.cholesterol,
    };

_$UserPreferencesImpl _$$UserPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$UserPreferencesImpl(
      favoriteCuisines: (json['favoriteCuisines'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dietaryRestrictions: (json['dietaryRestrictions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DietaryRestrictionEnumMap, e))
              .toList() ??
          const [],
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxCookingTimeMinutes:
          (json['maxCookingTimeMinutes'] as num?)?.toInt() ?? 30,
      maxDifficulty: $enumDecodeNullable(
              _$DifficultyLevelEnumMap, json['maxDifficulty']) ??
          DifficultyLevel.intermediate,
      defaultServings: (json['defaultServings'] as num?)?.toInt() ?? 4,
    );

Map<String, dynamic> _$$UserPreferencesImplToJson(
        _$UserPreferencesImpl instance) =>
    <String, dynamic>{
      'favoriteCuisines': instance.favoriteCuisines,
      'dietaryRestrictions': instance.dietaryRestrictions
          .map((e) => _$DietaryRestrictionEnumMap[e]!)
          .toList(),
      'allergies': instance.allergies,
      'maxCookingTimeMinutes': instance.maxCookingTimeMinutes,
      'maxDifficulty': _$DifficultyLevelEnumMap[instance.maxDifficulty]!,
      'defaultServings': instance.defaultServings,
    };

const _$DietaryRestrictionEnumMap = {
  DietaryRestriction.vegetarian: 'vegetarian',
  DietaryRestriction.vegan: 'vegan',
  DietaryRestriction.glutenFree: 'glutenFree',
  DietaryRestriction.dairyFree: 'dairyFree',
  DietaryRestriction.nutFree: 'nutFree',
  DietaryRestriction.keto: 'keto',
  DietaryRestriction.paleo: 'paleo',
  DietaryRestriction.lowCarb: 'lowCarb',
  DietaryRestriction.lowFat: 'lowFat',
  DietaryRestriction.lowSodium: 'lowSodium',
  DietaryRestriction.diabetic: 'diabetic',
  DietaryRestriction.heartHealthy: 'heartHealthy',
  DietaryRestriction.halal: 'halal',
  DietaryRestriction.kosher: 'kosher',
};
