// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      dietaryRestrictions: (json['dietaryRestrictions'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$DietaryRestrictionEnumMap, e))
              .toList() ??
          const [],
      allergies: (json['allergies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      skillLevel:
          $enumDecodeNullable(_$SkillLevelEnumMap, json['skillLevel']) ??
              SkillLevel.beginner,
      equipment: (json['equipment'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$KitchenEquipmentEnumMap, e))
              .toList() ??
          const [],
      preferences: CookingPreferences.fromJson(
          json['preferences'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      profileImageUrl: json['profileImageUrl'] as String?,
      totalRecipesCooked: (json['totalRecipesCooked'] as num?)?.toInt() ?? 0,
      favoriteRecipesCount:
          (json['favoriteRecipesCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'dietaryRestrictions': instance.dietaryRestrictions
          .map((e) => _$DietaryRestrictionEnumMap[e]!)
          .toList(),
      'allergies': instance.allergies,
      'skillLevel': _$SkillLevelEnumMap[instance.skillLevel]!,
      'equipment':
          instance.equipment.map((e) => _$KitchenEquipmentEnumMap[e]!).toList(),
      'preferences': instance.preferences,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'profileImageUrl': instance.profileImageUrl,
      'totalRecipesCooked': instance.totalRecipesCooked,
      'favoriteRecipesCount': instance.favoriteRecipesCount,
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

const _$SkillLevelEnumMap = {
  SkillLevel.beginner: 'beginner',
  SkillLevel.intermediate: 'intermediate',
  SkillLevel.advanced: 'advanced',
  SkillLevel.expert: 'expert',
};

const _$KitchenEquipmentEnumMap = {
  KitchenEquipment.oven: 'oven',
  KitchenEquipment.stovetop: 'stovetop',
  KitchenEquipment.microwave: 'microwave',
  KitchenEquipment.airFryer: 'airFryer',
  KitchenEquipment.slowCooker: 'slowCooker',
  KitchenEquipment.pressureCooker: 'pressureCooker',
  KitchenEquipment.grill: 'grill',
  KitchenEquipment.blender: 'blender',
  KitchenEquipment.foodProcessor: 'foodProcessor',
  KitchenEquipment.standMixer: 'standMixer',
  KitchenEquipment.riceCooker: 'riceCooker',
  KitchenEquipment.toaster: 'toaster',
  KitchenEquipment.dishwasher: 'dishwasher',
};

_$CookingPreferencesImpl _$$CookingPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$CookingPreferencesImpl(
      favoriteCuisines: (json['favoriteCuisines'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maxCookingTimeMinutes:
          (json['maxCookingTimeMinutes'] as num?)?.toInt() ?? 30,
      maxDifficulty: $enumDecodeNullable(
              _$DifficultyLevelEnumMap, json['maxDifficulty']) ??
          DifficultyLevel.intermediate,
      defaultServings: (json['defaultServings'] as num?)?.toInt() ?? 4,
      preferQuickMeals: json['preferQuickMeals'] as bool? ?? false,
      preferHealthyOptions: json['preferHealthyOptions'] as bool? ?? false,
      dislikedIngredients: (json['dislikedIngredients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      spicePreference:
          $enumDecodeNullable(_$SpiceLevelEnumMap, json['spicePreference']) ??
              SpiceLevel.medium,
    );

Map<String, dynamic> _$$CookingPreferencesImplToJson(
        _$CookingPreferencesImpl instance) =>
    <String, dynamic>{
      'favoriteCuisines': instance.favoriteCuisines,
      'maxCookingTimeMinutes': instance.maxCookingTimeMinutes,
      'maxDifficulty': _$DifficultyLevelEnumMap[instance.maxDifficulty]!,
      'defaultServings': instance.defaultServings,
      'preferQuickMeals': instance.preferQuickMeals,
      'preferHealthyOptions': instance.preferHealthyOptions,
      'dislikedIngredients': instance.dislikedIngredients,
      'spicePreference': _$SpiceLevelEnumMap[instance.spicePreference]!,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.beginner: 'beginner',
  DifficultyLevel.intermediate: 'intermediate',
  DifficultyLevel.advanced: 'advanced',
  DifficultyLevel.expert: 'expert',
};

const _$SpiceLevelEnumMap = {
  SpiceLevel.mild: 'mild',
  SpiceLevel.medium: 'medium',
  SpiceLevel.hot: 'hot',
  SpiceLevel.extraHot: 'extraHot',
};
