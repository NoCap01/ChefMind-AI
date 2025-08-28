import 'package:hive/hive.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/pantry.dart';
import '../../domain/entities/community.dart';
import '../../domain/entities/analytics.dart';

// Recipe Adapters
class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 0;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      ingredients: (fields[3] as List).cast<Ingredient>(),
      instructions: (fields[4] as List).cast<CookingStep>(),
      cookingTime: Duration(minutes: fields[5] as int),
      prepTime: Duration(minutes: fields[6] as int),
      difficulty: DifficultyLevel.values[fields[7] as int],
      servings: fields[8] as int,
      tags: (fields[9] as List).cast<String>(),
      nutrition: fields[10] as NutritionInfo,
      tips: (fields[11] as List).cast<String>(),
      rating: fields[12] as double,
      createdAt: DateTime.fromMillisecondsSinceEpoch(fields[13] as int),
      imageUrl: fields[14] as String?,
      isFavorite: fields[15] as bool? ?? false,
      authorId: fields[16] as String?,
      cookCount: fields[17] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.ingredients)
      ..writeByte(4)
      ..write(obj.instructions)
      ..writeByte(5)
      ..write(obj.cookingTime.inMinutes)
      ..writeByte(6)
      ..write(obj.prepTime.inMinutes)
      ..writeByte(7)
      ..write(obj.difficulty.index)
      ..writeByte(8)
      ..write(obj.servings)
      ..writeByte(9)
      ..write(obj.tags)
      ..writeByte(10)
      ..write(obj.nutrition)
      ..writeByte(11)
      ..write(obj.tips)
      ..writeByte(12)
      ..write(obj.rating)
      ..writeByte(13)
      ..write(obj.createdAt.millisecondsSinceEpoch)
      ..writeByte(14)
      ..write(obj.imageUrl)
      ..writeByte(15)
      ..write(obj.isFavorite)
      ..writeByte(16)
      ..write(obj.authorId)
      ..writeByte(17)
      ..write(obj.cookCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = 1;

  @override
  Ingredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ingredient(
      name: fields[0] as String,
      quantity: fields[1] as double,
      unit: fields[2] as String,
      category: fields[3] as String?,
      isOptional: fields[4] as bool? ?? false,
      alternatives: (fields[5] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  void write(BinaryWriter writer, Ingredient obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isOptional)
      ..writeByte(5)
      ..write(obj.alternatives);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CookingStepAdapter extends TypeAdapter<CookingStep> {
  @override
  final int typeId = 2;

  @override
  CookingStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CookingStep(
      stepNumber: fields[0] as int,
      instruction: fields[1] as String,
      duration: fields[2] != null ? Duration(minutes: fields[2] as int) : null,
      imageUrl: fields[3] as String?,
      tips: (fields[4] as List?)?.cast<String>() ?? [],
    );
  }

  @override
  void write(BinaryWriter writer, CookingStep obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.stepNumber)
      ..writeByte(1)
      ..write(obj.instruction)
      ..writeByte(2)
      ..write(obj.duration?.inMinutes)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.tips);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookingStepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NutritionInfoAdapter extends TypeAdapter<NutritionInfo> {
  @override
  final int typeId = 3;

  @override
  NutritionInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionInfo(
      calories: fields[0] as double,
      protein: fields[1] as double,
      carbs: fields[2] as double,
      fat: fields[3] as double,
      fiber: fields[4] as double,
      sugar: fields[5] as double,
      sodium: fields[6] as double,
      vitamins: (fields[7] as Map?)?.cast<String, double>() ?? {},
      minerals: (fields[8] as Map?)?.cast<String, double>() ?? {},
    );
  }

  @override
  void write(BinaryWriter writer, NutritionInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.protein)
      ..writeByte(2)
      ..write(obj.carbs)
      ..writeByte(3)
      ..write(obj.fat)
      ..writeByte(4)
      ..write(obj.fiber)
      ..writeByte(5)
      ..write(obj.sugar)
      ..writeByte(6)
      ..write(obj.sodium)
      ..writeByte(7)
      ..write(obj.vitamins)
      ..writeByte(8)
      ..write(obj.minerals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// Enum Adapters
class DifficultyLevelAdapter extends TypeAdapter<DifficultyLevel> {
  @override
  final int typeId = 4;

  @override
  DifficultyLevel read(BinaryReader reader) {
    return DifficultyLevel.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, DifficultyLevel obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultyLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// User Profile Adapters
class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 5;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      dietaryRestrictions: (fields[3] as List?)?.cast<DietaryRestriction>() ?? [],
      allergies: (fields[4] as List?)?.cast<String>() ?? [],
      skillLevel: fields[5] as SkillLevel? ?? SkillLevel.beginner,
      equipment: (fields[6] as List?)?.cast<KitchenEquipment>() ?? [],
      preferences: fields[7] as CookingPreferences,
      createdAt: DateTime.fromMillisecondsSinceEpoch(fields[8] as int),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(fields[9] as int),
      profileImageUrl: fields[10] as String?,
      totalRecipesCooked: fields[11] as int? ?? 0,
      favoriteRecipesCount: fields[12] as int? ?? 0,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.dietaryRestrictions)
      ..writeByte(4)
      ..write(obj.allergies)
      ..writeByte(5)
      ..write(obj.skillLevel)
      ..writeByte(6)
      ..write(obj.equipment)
      ..writeByte(7)
      ..write(obj.preferences)
      ..writeByte(8)
      ..write(obj.createdAt.millisecondsSinceEpoch)
      ..writeByte(9)
      ..write(obj.lastUpdated.millisecondsSinceEpoch)
      ..writeByte(10)
      ..write(obj.profileImageUrl)
      ..writeByte(11)
      ..write(obj.totalRecipesCooked)
      ..writeByte(12)
      ..write(obj.favoriteRecipesCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CookingPreferencesAdapter extends TypeAdapter<CookingPreferences> {
  @override
  final int typeId = 6;

  @override
  CookingPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CookingPreferences(
      favoriteCuisines: (fields[0] as List?)?.cast<String>() ?? [],
      maxCookingTimeMinutes: fields[1] as int? ?? 30,
      maxDifficulty: fields[2] as DifficultyLevel? ?? DifficultyLevel.intermediate,
      defaultServings: fields[3] as int? ?? 4,
      preferQuickMeals: fields[4] as bool? ?? false,
      preferHealthyOptions: fields[5] as bool? ?? false,
      dislikedIngredients: (fields[6] as List?)?.cast<String>() ?? [],
      spicePreference: fields[7] as SpiceLevel? ?? SpiceLevel.medium,
    );
  }

  @override
  void write(BinaryWriter writer, CookingPreferences obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.favoriteCuisines)
      ..writeByte(1)
      ..write(obj.maxCookingTimeMinutes)
      ..writeByte(2)
      ..write(obj.maxDifficulty)
      ..writeByte(3)
      ..write(obj.defaultServings)
      ..writeByte(4)
      ..write(obj.preferQuickMeals)
      ..writeByte(5)
      ..write(obj.preferHealthyOptions)
      ..writeByte(6)
      ..write(obj.dislikedIngredients)
      ..writeByte(7)
      ..write(obj.spicePreference);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookingPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// Enum Adapters for User Profile
class DietaryRestrictionAdapter extends TypeAdapter<DietaryRestriction> {
  @override
  final int typeId = 7;

  @override
  DietaryRestriction read(BinaryReader reader) {
    return DietaryRestriction.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, DietaryRestriction obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryRestrictionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SkillLevelAdapter extends TypeAdapter<SkillLevel> {
  @override
  final int typeId = 8;

  @override
  SkillLevel read(BinaryReader reader) {
    return SkillLevel.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, SkillLevel obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KitchenEquipmentAdapter extends TypeAdapter<KitchenEquipment> {
  @override
  final int typeId = 9;

  @override
  KitchenEquipment read(BinaryReader reader) {
    return KitchenEquipment.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, KitchenEquipment obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KitchenEquipmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpiceLevelAdapter extends TypeAdapter<SpiceLevel> {
  @override
  final int typeId = 10;

  @override
  SpiceLevel read(BinaryReader reader) {
    return SpiceLevel.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, SpiceLevel obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpiceLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// Cache-specific models
@HiveType(typeId: 100)
class CachedData extends HiveObject {
  @HiveField(0)
  String key;

  @HiveField(1)
  String jsonData;

  @HiveField(2)
  DateTime cachedAt;

  @HiveField(3)
  DateTime? expiresAt;

  @HiveField(4)
  String? etag;

  CachedData({
    required this.key,
    required this.jsonData,
    required this.cachedAt,
    this.expiresAt,
    this.etag,
  });
}

class CachedDataAdapter extends TypeAdapter<CachedData> {
  @override
  final int typeId = 100;

  @override
  CachedData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedData(
      key: fields[0] as String,
      jsonData: fields[1] as String,
      cachedAt: DateTime.fromMillisecondsSinceEpoch(fields[2] as int),
      expiresAt: fields[3] != null 
          ? DateTime.fromMillisecondsSinceEpoch(fields[3] as int) 
          : null,
      etag: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CachedData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.jsonData)
      ..writeByte(2)
      ..write(obj.cachedAt.millisecondsSinceEpoch)
      ..writeByte(3)
      ..write(obj.expiresAt?.millisecondsSinceEpoch)
      ..writeByte(4)
      ..write(obj.etag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// Helper class to register all adapters
class HiveAdapterRegistry {
  static void registerAdapters() {
    // Recipe adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(RecipeAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(IngredientAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CookingStepAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(NutritionInfoAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(DifficultyLevelAdapter());
    }

    // User profile adapters
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(UserProfileAdapter());
    }
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(CookingPreferencesAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(DietaryRestrictionAdapter());
    }
    if (!Hive.isAdapterRegistered(8)) {
      Hive.registerAdapter(SkillLevelAdapter());
    }
    if (!Hive.isAdapterRegistered(9)) {
      Hive.registerAdapter(KitchenEquipmentAdapter());
    }
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(SpiceLevelAdapter());
    }

    // Cache adapters
    if (!Hive.isAdapterRegistered(100)) {
      Hive.registerAdapter(CachedDataAdapter());
    }
  }
}