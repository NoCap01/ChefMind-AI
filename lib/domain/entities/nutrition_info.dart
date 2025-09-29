class NutritionInfo {
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double fiber;
  final double sugar;
  final double sodium;
  final double? calcium;
  final double? iron;
  final double? vitaminC;
  final double? vitaminA;

  const NutritionInfo({
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
    this.calcium,
    this.iron,
    this.vitaminC,
    this.vitaminA,
  });

  NutritionInfo copyWith({
    double? calories,
    double? protein,
    double? carbohydrates,
    double? fat,
    double? fiber,
    double? sugar,
    double? sodium,
    double? calcium,
    double? iron,
    double? vitaminC,
    double? vitaminA,
  }) {
    return NutritionInfo(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
      calcium: calcium ?? this.calcium,
      iron: iron ?? this.iron,
      vitaminC: vitaminC ?? this.vitaminC,
      vitaminA: vitaminA ?? this.vitaminA,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'fiber': fiber,
      'sugar': sugar,
      'sodium': sodium,
      'calcium': calcium,
      'iron': iron,
      'vitaminC': vitaminC,
      'vitaminA': vitaminA,
    };
  }

  factory NutritionInfo.fromJson(Map<String, dynamic> json) {
    return NutritionInfo(
      calories: (json['calories'] ?? 0.0).toDouble(),
      protein: (json['protein'] ?? 0.0).toDouble(),
      carbohydrates: (json['carbohydrates'] ?? 0.0).toDouble(),
      fat: (json['fat'] ?? 0.0).toDouble(),
      fiber: (json['fiber'] ?? 0.0).toDouble(),
      sugar: (json['sugar'] ?? 0.0).toDouble(),
      sodium: (json['sodium'] ?? 0.0).toDouble(),
      calcium: json['calcium']?.toDouble(),
      iron: json['iron']?.toDouble(),
      vitaminC: json['vitaminC']?.toDouble(),
      vitaminA: json['vitaminA']?.toDouble(),
    );
  }
}
