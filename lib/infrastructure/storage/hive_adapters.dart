import 'package:hive/hive.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/enums/difficulty_level.dart';
import '../../domain/enums/meal_type.dart';

// Type IDs for Hive adapters
const int recipeTypeId = 0;
const int ingredientTypeId = 1;
const int cookingStepTypeId = 2;
const int recipeMetadataTypeId = 3;
const int nutritionInfoTypeId = 4;
const int difficultyLevelTypeId = 5;
const int mealTypeTypeId = 6;

/// Hive adapter for Recipe entity
class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = recipeTypeId;

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
      metadata: fields[5] as RecipeMetadata,
      nutrition: fields[6] as NutritionInfo?,
      tags: (fields[7] as List).cast<String>(),
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime?,
      source: fields[10] as String,
      isFavorite: fields[11] as bool? ?? false,
      rating: fields[12] as double?,
      timesCooked: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.metadata)
      ..writeByte(6)
      ..write(obj.nutrition)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.source)
      ..writeByte(11)
      ..write(obj.isFavorite)
      ..writeByte(12)
      ..write(obj.rating)
      ..writeByte(13)
      ..write(obj.timesCooked);
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

/// Hive adapter for Ingredient entity
class IngredientAdapter extends TypeAdapter<Ingredient> {
  @override
  final int typeId = ingredientTypeId;

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
      notes: fields[5] as String?,
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
      ..write(obj.notes);
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

/// Hive adapter for CookingStep entity
class CookingStepAdapter extends TypeAdapter<CookingStep> {
  @override
  final int typeId = cookingStepTypeId;

  @override
  CookingStep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return CookingStep(
      stepNumber: fields[0] as int,
      instruction: fields[1] as String,
      duration: fields[2] as int?,
      technique: fields[3] as String?,
      requiredTools: (fields[4] as List?)?.cast<String>(),
      tips: fields[5] as String?,
      imageUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CookingStep obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.stepNumber)
      ..writeByte(1)
      ..write(obj.instruction)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.technique)
      ..writeByte(4)
      ..write(obj.requiredTools)
      ..writeByte(5)
      ..write(obj.tips)
      ..writeByte(6)
      ..write(obj.imageUrl);
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

/// Hive adapter for RecipeMetadata entity
class RecipeMetadataAdapter extends TypeAdapter<RecipeMetadata> {
  @override
  final int typeId = recipeMetadataTypeId;

  @override
  RecipeMetadata read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return RecipeMetadata(
      prepTime: fields[0] as int,
      cookTime: fields[1] as int,
      servings: fields[2] as int,
      difficulty: fields[3] as DifficultyLevel,
      cuisine: fields[4] as String?,
      mealType: fields[5] as MealType?,
      equipment: (fields[6] as List?)?.cast<String>(),
      sourceUrl: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeMetadata obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.prepTime)
      ..writeByte(1)
      ..write(obj.cookTime)
      ..writeByte(2)
      ..write(obj.servings)
      ..writeByte(3)
      ..write(obj.difficulty)
      ..writeByte(4)
      ..write(obj.cuisine)
      ..writeByte(5)
      ..write(obj.mealType)
      ..writeByte(6)
      ..write(obj.equipment)
      ..writeByte(7)
      ..write(obj.sourceUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeMetadataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

/// Hive adapter for NutritionInfo entity
class NutritionInfoAdapter extends TypeAdapter<NutritionInfo> {
  @override
  final int typeId = nutritionInfoTypeId;

  @override
  NutritionInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return NutritionInfo(
      calories: fields[0] as int,
      protein: fields[1] as double,
      carbs: fields[2] as double,
      fat: fields[3] as double,
      fiber: fields[4] as double,
      sugar: fields[5] as double,
      sodium: fields[6] as int,
      vitamins: (fields[7] as Map?)?.cast<String, double>(),
      minerals: (fields[8] as Map?)?.cast<String, double>(),
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

/// Hive adapter for DifficultyLevel enum
class DifficultyLevelAdapter extends TypeAdapter<DifficultyLevel> {
  @override
  final int typeId = difficultyLevelTypeId;

  @override
  DifficultyLevel read(BinaryReader reader) {
    final index = reader.readByte();
    return DifficultyLevel.values[index];
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

/// Hive adapter for MealType enum
class MealTypeAdapter extends TypeAdapter<MealType> {
  @override
  final int typeId = mealTypeTypeId;

  @override
  MealType read(BinaryReader reader) {
    final index = reader.readByte();
    return MealType.values[index];
  }

  @override
  void write(BinaryWriter writer, MealType obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
