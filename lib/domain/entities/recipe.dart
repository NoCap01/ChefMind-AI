import '../enums/difficulty_level.dart';
import '../enums/meal_type.dart';

/// Complete recipe entity with all necessary information
class Recipe {
  final String id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<CookingStep> instructions;
  final RecipeMetadata metadata;
  final NutritionInfo? nutrition;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String source; // 'openai', 'huggingface', 'mock', 'user'
  final bool isFavorite;
  final double? rating;
  final int? timesCooked;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.metadata,
    this.nutrition,
    this.tags = const [],
    required this.createdAt,
    this.updatedAt,
    required this.source,
    this.isFavorite = false,
    this.rating,
    this.timesCooked,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'instructions': instructions.map((e) => e.toJson()).toList(),
      'metadata': metadata.toJson(),
      'nutrition': nutrition?.toJson(),
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'source': source,
      'isFavorite': isFavorite,
      'rating': rating,
      'timesCooked': timesCooked,
    };
  }

  /// Create from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e))
          .toList() ?? [],
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => CookingStep.fromJson(e))
          .toList() ?? [],
      metadata: RecipeMetadata.fromJson(json['metadata'] ?? {}),
      nutrition: json['nutrition'] != null 
          ? NutritionInfo.fromJson(json['nutrition'])
          : null,
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      source: json['source'] ?? 'unknown',
      isFavorite: json['isFavorite'] ?? false,
      rating: json['rating']?.toDouble(),
      timesCooked: json['timesCooked'],
    );
  }

  /// Create a copy with updated values
  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<CookingStep>? instructions,
    RecipeMetadata? metadata,
    NutritionInfo? nutrition,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? source,
    bool? isFavorite,
    double? rating,
    int? timesCooked,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      metadata: metadata ?? this.metadata,
      nutrition: nutrition ?? this.nutrition,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      source: source ?? this.source,
      isFavorite: isFavorite ?? this.isFavorite,
      rating: rating ?? this.rating,
      timesCooked: timesCooked ?? this.timesCooked,
    );
  }

  /// Get total cooking time (prep + cook)
  int get totalTime => metadata.prepTime + metadata.cookTime;

  /// Check if recipe matches dietary restrictions
  bool matchesDietaryRestrictions(List<String> restrictions) {
    // Simple implementation - can be enhanced
    return tags.any((tag) => restrictions.contains(tag.toLowerCase()));
  }
}

/// Recipe ingredient with quantity and unit
class Ingredient {
  final String name;
  final double quantity;
  final String unit;
  final String? category;
  final bool isOptional;
  final String? notes;

  const Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    this.category,
    this.isOptional = false,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'category': category,
      'isOptional': isOptional,
      'notes': notes,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      unit: json['unit'] ?? '',
      category: json['category'],
      isOptional: json['isOptional'] ?? false,
      notes: json['notes'],
    );
  }

  @override
  String toString() {
    final quantityStr = quantity == quantity.toInt() 
        ? quantity.toInt().toString()
        : quantity.toString();
    return '$quantityStr $unit $name${isOptional ? ' (optional)' : ''}';
  }
}

/// Cooking step with instructions and timing
class CookingStep {
  final int stepNumber;
  final String instruction;
  final int? duration; // in minutes
  final String? technique;
  final List<String>? requiredTools;
  final String? tips;
  final String? imageUrl;

  const CookingStep({
    required this.stepNumber,
    required this.instruction,
    this.duration,
    this.technique,
    this.requiredTools,
    this.tips,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'instruction': instruction,
      'duration': duration,
      'technique': technique,
      'requiredTools': requiredTools,
      'tips': tips,
      'imageUrl': imageUrl,
    };
  }

  factory CookingStep.fromJson(Map<String, dynamic> json) {
    return CookingStep(
      stepNumber: json['stepNumber'] ?? 0,
      instruction: json['instruction'] ?? '',
      duration: json['duration'],
      technique: json['technique'],
      requiredTools: json['requiredTools'] != null 
          ? List<String>.from(json['requiredTools'])
          : null,
      tips: json['tips'],
      imageUrl: json['imageUrl'],
    );
  }
}

/// Recipe metadata including timing and difficulty
class RecipeMetadata {
  final int prepTime; // in minutes
  final int cookTime; // in minutes
  final int servings;
  final DifficultyLevel difficulty;
  final String? cuisine;
  final MealType? mealType;
  final List<String>? equipment;
  final String? sourceUrl;

  const RecipeMetadata({
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    this.cuisine,
    this.mealType,
    this.equipment,
    this.sourceUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'prepTime': prepTime,
      'cookTime': cookTime,
      'servings': servings,
      'difficulty': difficulty.name,
      'cuisine': cuisine,
      'mealType': mealType?.name,
      'equipment': equipment,
      'sourceUrl': sourceUrl,
    };
  }

  factory RecipeMetadata.fromJson(Map<String, dynamic> json) {
    return RecipeMetadata(
      prepTime: json['prepTime'] ?? 0,
      cookTime: json['cookTime'] ?? 0,
      servings: json['servings'] ?? 4,
      difficulty: DifficultyLevel.values.firstWhere(
        (e) => e.name == json['difficulty'],
        orElse: () => DifficultyLevel.medium,
      ),
      cuisine: json['cuisine'],
      mealType: json['mealType'] != null 
          ? MealType.values.firstWhere((e) => e.name == json['mealType'])
          : null,
      equipment: json['equipment'] != null 
          ? List<String>.from(json['equipment'])
          : null,
      sourceUrl: json['sourceUrl'],
    );
  }
}

/// Nutritional information for the recipe
class NutritionInfo {
  final int calories;
  final double protein; // in grams
  final double carbs; // in grams
  final double fat; // in grams
  final double fiber; // in grams
  final double sugar; // in grams
  final int sodium; // in mg
  final Map<String, double>? vitamins;
  final Map<String, double>? minerals;

  const NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    this.vitamins,
    this.minerals,
  });

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'vitamins': vitamins,
      'minerals': minerals,
    };
  }

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: json['calories'] ?? 0,
      protein: (json['protein'] ?? 0).toDouble(),
      carbs: (json['carbs'] ?? 0).toDouble(),
      fat: (json['fat'] ?? 0).toDouble(),
      fiber: (json['fiber'] ?? 0).toDouble(),
      sugar: (json['sugar'] ?? 0).toDouble(),
      sodium: json['sodium'] ?? 0,
      vitamins: json['vitamins'] != null 
          ? Map<String, double>.from(json['vitamins'])
          : null,
      minerals: json['minerals'] != null 
          ? Map<String, double>.from(json['minerals'])
          : null,
    );
  }

  /// Calculate calories per serving
  double caloriesPerServing(int servings) => calories / servings;
}