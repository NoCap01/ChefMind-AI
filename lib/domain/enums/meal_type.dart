enum MealType {
  breakfast,
  brunch,
  lunch,
  dinner,
  snack,
  dessert,
  appetizer,
  side,
  drink;

  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.brunch:
        return 'Brunch';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
      case MealType.dessert:
        return 'Dessert';
      case MealType.appetizer:
        return 'Appetizer';
      case MealType.side:
        return 'Side Dish';
      case MealType.drink:
        return 'Drink';
    }
  }

  String get emoji {
    switch (this) {
      case MealType.breakfast:
        return '🍳';
      case MealType.brunch:
        return '🥐';
      case MealType.lunch:
        return '🥪';
      case MealType.dinner:
        return '🍽️';
      case MealType.snack:
        return '🍿';
      case MealType.dessert:
        return '🍰';
      case MealType.appetizer:
        return '🥗';
      case MealType.side:
        return '🥖';
      case MealType.drink:
        return '🥤';
    }
  }

  /// Typical time of day for this meal type
  List<int> get typicalHours {
    switch (this) {
      case MealType.breakfast:
        return [6, 7, 8, 9, 10];
      case MealType.brunch:
        return [10, 11, 12];
      case MealType.lunch:
        return [11, 12, 13, 14];
      case MealType.dinner:
        return [17, 18, 19, 20, 21];
      case MealType.snack:
        return [10, 15, 21];
      case MealType.dessert:
        return [20, 21, 22];
      case MealType.appetizer:
        return [17, 18, 19];
      case MealType.side:
        return [11, 12, 17, 18, 19, 20];
      case MealType.drink:
        return List.generate(24, (index) => index);
    }
  }
}