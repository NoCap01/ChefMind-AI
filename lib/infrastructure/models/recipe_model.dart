import '../../domain/entities/recipe.dart';

class RecipeModel {
  final String id;
  final String title;
  final String description;
  final List<Map<String, dynamic>> ingredients;
  final List<Map<String, dynamic>> instructions;
  final int cookingTimeMinutes;
  final int prepTimeMinutes;
  final String difficulty;
  final int servings;
  final List<String> tags;
  final Map<String, dynamic> nutrition;
  final List<String> tips;
  final double rating;
  final int ratingCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final List<String>? imageUrls;
  final String? videoUrl;
  final String? authorId;
  final String? authorName;
  final String? mealType;
  final String? cuisineType;
  final bool isPublic;
  final bool isFavorite;
  final int cookCount;
  final Map<String, dynamic>? metadata;

  const RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.cookingTimeMinutes,
    required this.prepTimeMinutes,
    required this.difficulty,
    required this.servings,
    required this.tags,
    required this.nutrition,
    this.tips = const [],
    this.rating = 0.0,
    this.ratingCount = 0,
    required this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.imageUrls,
    this.videoUrl,
    this.authorId,
    this.authorName,
    this.mealType,
    this.cuisineType,
    this.isPublic = false,
    this.isFavorite = false,
    this.cookCount = 0,
    this.metadata,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      ingredients: List<Map<String, dynamic>>.from(json['ingredients'] ?? []),
      instructions: List<Map<String, dynamic>>.from(json['instructions'] ?? []),
      cookingTimeMinutes: json['cookingTimeMinutes'] ?? 0,
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      difficulty: json['difficulty'] ?? 'medium',
      servings: json['servings'] ?? 1,
      tags: List<String>.from(json['tags'] ?? []),
      nutrition: Map<String, dynamic>.from(json['nutrition'] ?? {}),
      tips: List<String>.from(json['tips'] ?? []),
      rating: (json['rating'] ?? 0.0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      imageUrl: json['imageUrl'],
      imageUrls: json['imageUrls'] != null
          ? List<String>.from(json['imageUrls'])
          : null,
      videoUrl: json['videoUrl'],
      authorId: json['authorId'],
      authorName: json['authorName'],
      mealType: json['mealType'],
      cuisineType: json['cuisineType'],
      isPublic: json['isPublic'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
      cookCount: json['cookCount'] ?? 0,
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'cookingTimeMinutes': cookingTimeMinutes,
      'prepTimeMinutes': prepTimeMinutes,
      'difficulty': difficulty,
      'servings': servings,
      'tags': tags,
      'nutrition': nutrition,
      'tips': tips,
      'rating': rating,
      'ratingCount': ratingCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'imageUrl': imageUrl,
      'imageUrls': imageUrls,
      'videoUrl': videoUrl,
      'authorId': authorId,
      'authorName': authorName,
      'mealType': mealType,
      'cuisineType': cuisineType,
      'isPublic': isPublic,
      'isFavorite': isFavorite,
      'cookCount': cookCount,
      'metadata': metadata,
    };
  }

  factory RecipeModel.fromDomain(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      ingredients: recipe.ingredients
          .map((ingredient) => {
                'name': ingredient.name,
                'quantity': ingredient.quantity,
                'unit': ingredient.unit,
                'category': ingredient.category,
                'isOptional': ingredient.isOptional,
                // 'alternatives': ingredient.alternatives, // Not available in Ingredient
                'notes': ingredient.notes,
              })
          .toList(),
      instructions: recipe.instructions
          .map((step) => {
                'stepNumber': step.stepNumber,
                'instruction': step.instruction,
                'duration': step.duration, // Already in minutes
                // 'temperature': step.temperature, // Not available in CookingStep
                'tips': step.tips,
                'imageUrl': step.imageUrl,
              })
          .toList(),
      cookingTimeMinutes: recipe.metadata.cookTime,
      prepTimeMinutes: recipe.metadata.prepTime,
      difficulty: recipe.metadata.difficulty.name,
      servings: recipe.metadata.servings,
      tags: recipe.tags,
      nutrition: recipe.nutrition != null ? {
        'calories': recipe.nutrition!.calories,
        'protein': recipe.nutrition!.protein,
        'carbohydrates': recipe.nutrition!.carbs,
        'fat': recipe.nutrition!.fat,
        'fiber': recipe.nutrition!.fiber,
        'sugar': recipe.nutrition!.sugar,
        'sodium': recipe.nutrition!.sodium,
      } : {
        'calories': 0,
        'protein': 0.0,
        'carbohydrates': 0.0,
        'fat': 0.0,
        'fiber': 0.0,
        'sugar': 0.0,
        'sodium': 0,
      },
      // tips: recipe.tips, // Not available in Recipe entity
      rating: recipe.rating ?? 0.0,
      // ratingCount: recipe.ratingCount, // Not available in Recipe entity
      createdAt: recipe.createdAt,
      updatedAt: recipe.updatedAt,
      // imageUrl: recipe.imageUrl, // Not available in Recipe entity
      // imageUrls: recipe.imageUrls, // Not available in Recipe entity
      // videoUrl: recipe.videoUrl, // Not available in Recipe entity
      // authorId: recipe.authorId, // Not available in Recipe entity
      // authorName: recipe.authorName, // Not available in Recipe entity
      mealType: recipe.metadata.mealType?.name,
      // cuisineType: recipe.cuisineType?.name, // Not available in Recipe entity
      // isPublic: recipe.isPublic, // Not available in Recipe entity
      isFavorite: recipe.isFavorite,
      // cookCount: recipe.cookCount, // Not available in Recipe entity
      metadata: recipe.metadata.toJson(),
    );
  }
}
