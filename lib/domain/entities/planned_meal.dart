class PlannedMeal {
  final String recipeId;
  final int servings;
  final bool isCooked;
  final String notes;
  final DateTime? cookedAt;

  const PlannedMeal({
    required this.recipeId,
    required this.servings,
    required this.isCooked,
    required this.notes,
    this.cookedAt,
  });

  PlannedMeal copyWith({
    String? recipeId,
    int? servings,
    bool? isCooked,
    String? notes,
    DateTime? cookedAt,
  }) {
    return PlannedMeal(
      recipeId: recipeId ?? this.recipeId,
      servings: servings ?? this.servings,
      isCooked: isCooked ?? this.isCooked,
      notes: notes ?? this.notes,
      cookedAt: cookedAt ?? this.cookedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'servings': servings,
      'isCooked': isCooked,
      'notes': notes,
      'cookedAt': cookedAt?.toIso8601String(),
    };
  }

  factory PlannedMeal.fromJson(Map<String, dynamic> json) {
    return PlannedMeal(
      recipeId: json['recipeId'] ?? '',
      servings: json['servings'] ?? 1,
      isCooked: json['isCooked'] ?? false,
      notes: json['notes'] ?? '',
      cookedAt:
          json['cookedAt'] != null ? DateTime.tryParse(json['cookedAt']) : null,
    );
  }
}
