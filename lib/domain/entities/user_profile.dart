import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'recipe.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
@HiveType(typeId: 15) // Changed from 5 to avoid conflict with recipe.dart
class UserProfile with _$UserProfile {
  const factory UserProfile({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String email,
    @HiveField(3) @Default([]) List<DietaryRestriction> dietaryRestrictions,
    @HiveField(4) @Default([]) List<String> allergies,
    @HiveField(5) @Default(SkillLevel.beginner) SkillLevel skillLevel,
    @HiveField(6) @Default([]) List<KitchenEquipment> equipment,
    @HiveField(7) required CookingPreferences preferences,
    @HiveField(8) required DateTime createdAt,
    @HiveField(9) required DateTime lastUpdated,
    @HiveField(10) String? profileImageUrl,
    @HiveField(11) @Default(0) int totalRecipesCooked,
    @HiveField(12) @Default(0) int favoriteRecipesCount,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
@HiveType(typeId: 16) // Changed from 6 to avoid conflict
class CookingPreferences with _$CookingPreferences {
  const factory CookingPreferences({
    @HiveField(0) @Default([]) List<String> favoriteCuisines,
    @HiveField(1) @Default(30) int maxCookingTimeMinutes,
    @HiveField(2)
    @Default(DifficultyLevel.intermediate)
    DifficultyLevel maxDifficulty,
    @HiveField(3) @Default(4) int defaultServings,
    @HiveField(4) @Default(false) bool preferQuickMeals,
    @HiveField(5) @Default(false) bool preferHealthyOptions,
    @HiveField(6) @Default([]) List<String> dislikedIngredients,
    @HiveField(7) @Default(SpiceLevel.medium) SpiceLevel spicePreference,
  }) = _CookingPreferences;

  factory CookingPreferences.fromJson(Map<String, dynamic> json) =>
      _$CookingPreferencesFromJson(json);
}

// Remove duplicate DietaryRestriction enum - use the one from recipe.dart

@HiveType(typeId: 18) // Changed from 8
enum SkillLevel {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
  @HiveField(3)
  expert,
}

@HiveType(typeId: 19) // Changed from 9
enum KitchenEquipment {
  @HiveField(0)
  oven,
  @HiveField(1)
  stovetop,
  @HiveField(2)
  microwave,
  @HiveField(3)
  airFryer,
  @HiveField(4)
  slowCooker,
  @HiveField(5)
  pressureCooker,
  @HiveField(6)
  grill,
  @HiveField(7)
  blender,
  @HiveField(8)
  foodProcessor,
  @HiveField(9)
  standMixer,
  @HiveField(10)
  riceCooker,
  @HiveField(11)
  toaster,
  @HiveField(12)
  dishwasher,
}

@HiveType(typeId: 20) // Changed from 10
enum SpiceLevel {
  @HiveField(0)
  mild,
  @HiveField(1)
  medium,
  @HiveField(2)
  hot,
  @HiveField(3)
  extraHot,
}

extension SkillLevelExtension on SkillLevel {
  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }
}

extension KitchenEquipmentExtension on KitchenEquipment {
  String get displayName {
    switch (this) {
      case KitchenEquipment.oven:
        return 'Oven';
      case KitchenEquipment.stovetop:
        return 'Stovetop';
      case KitchenEquipment.microwave:
        return 'Microwave';
      case KitchenEquipment.airFryer:
        return 'Air Fryer';
      case KitchenEquipment.slowCooker:
        return 'Slow Cooker';
      case KitchenEquipment.pressureCooker:
        return 'Pressure Cooker';
      case KitchenEquipment.grill:
        return 'Grill';
      case KitchenEquipment.blender:
        return 'Blender';
      case KitchenEquipment.foodProcessor:
        return 'Food Processor';
      case KitchenEquipment.standMixer:
        return 'Stand Mixer';
      case KitchenEquipment.riceCooker:
        return 'Rice Cooker';
      case KitchenEquipment.toaster:
        return 'Toaster';
      case KitchenEquipment.dishwasher:
        return 'Dishwasher';
    }
  }

  // Add the 'name' property that OpenAI service expects
  String get name => displayName;
}
