class Ingredient {
  final String name;
  final double quantity;
  final String unit;
  final String? category;
  final bool isOptional;
  final List<String> alternatives;
  final String? notes;

  const Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
    this.category,
    this.isOptional = false,
    this.alternatives = const [],
    this.notes,
  });

  Ingredient copyWith({
    String? name,
    double? quantity,
    String? unit,
    String? category,
    bool? isOptional,
    List<String>? alternatives,
    String? notes,
  }) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      category: category ?? this.category,
      isOptional: isOptional ?? this.isOptional,
      alternatives: alternatives ?? this.alternatives,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'unit': unit,
        'category': category,
        'isOptional': isOptional,
        'alternatives': alternatives,
        'notes': notes,
      };

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        name: json['name'] ?? '',
        quantity: (json['quantity'] ?? 0).toDouble(),
        unit: json['unit'] ?? '',
        category: json['category'],
        isOptional: json['isOptional'] ?? false,
        alternatives: List<String>.from(json['alternatives'] ?? []),
        notes: json['notes'],
      );
}

class NutritionInfo {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;
  final Map<String, double>? vitamins;
  final Map<String, double>? minerals;

  const NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    this.vitamins,
    this.minerals,
  });

  NutritionInfo copyWith({
    double? calories,
    double? protein,
    double? carbohydrates,
    double? fat,
    double? fiber,
    double? sugar,
    double? sodium,
    Map<String, double>? vitamins,
    Map<String, double>? minerals,
  }) {
    return NutritionInfo(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
      vitamins: vitamins ?? this.vitamins,
      minerals: minerals ?? this.minerals,
    );
  }

  Map<String, dynamic> toJson() => {
        'calories': calories,
        'protein': protein,
        'carbohydrates': carbohydrates,
        'fat': fat,
        'fiber': fiber,
        'sugar': sugar,
        'sodium': sodium,
        'vitamins': vitamins,
        'minerals': minerals,
      };

  factory NutritionInfo.fromJson(Map<String, dynamic> json) => NutritionInfo(
        calories: (json['calories'] ?? 0).toDouble(),
        protein: (json['protein'] ?? 0).toDouble(),
        carbohydrates: (json['carbohydrates'] ?? 0).toDouble(),
        fat: (json['fat'] ?? 0).toDouble(),
        fiber: (json['fiber'] ?? 0).toDouble(),
        sugar: (json['sugar'] ?? 0).toDouble(),
        sodium: (json['sodium'] ?? 0).toDouble(),
        vitamins: json['vitamins'] != null
            ? Map<String, double>.from(json['vitamins'])
            : null,
        minerals: json['minerals'] != null
            ? Map<String, double>.from(json['minerals'])
            : null,
      );
}

class CookingStep {
  final int stepNumber;
  final String instruction;
  final Duration? duration;
  final String? temperature;
  final List<String>? tips;
  final String? imageUrl;

  const CookingStep({
    required this.stepNumber,
    required this.instruction,
    this.duration,
    this.temperature,
    this.tips,
    this.imageUrl,
  });

  CookingStep copyWith({
    int? stepNumber,
    String? instruction,
    Duration? duration,
    String? temperature,
    List<String>? tips,
    String? imageUrl,
  }) {
    return CookingStep(
      stepNumber: stepNumber ?? this.stepNumber,
      instruction: instruction ?? this.instruction,
      duration: duration ?? this.duration,
      temperature: temperature ?? this.temperature,
      tips: tips ?? this.tips,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'stepNumber': stepNumber,
        'instruction': instruction,
        'duration': duration?.inMinutes,
        'temperature': temperature,
        'tips': tips,
        'imageUrl': imageUrl,
      };

  factory CookingStep.fromJson(Map<String, dynamic> json) => CookingStep(
        stepNumber: json['stepNumber'] ?? 0,
        instruction: json['instruction'] ?? '',
        duration: json['duration'] != null
            ? Duration(minutes: json['duration'])
            : null,
        temperature: json['temperature'],
        tips: json['tips'] != null ? List<String>.from(json['tips']) : null,
        imageUrl: json['imageUrl'],
      );
}
