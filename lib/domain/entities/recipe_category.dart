/// Recipe category entity for organizing recipes
class RecipeCategory {
  final String id;
  final String name;
  final String? description;
  final String? color; // Hex color code
  final String? iconName; // Icon name for display
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int recipeCount; // Number of recipes in this category

  const RecipeCategory({
    required this.id,
    required this.name,
    this.description,
    this.color,
    this.iconName,
    required this.createdAt,
    this.updatedAt,
    this.recipeCount = 0,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'color': color,
      'iconName': iconName,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'recipeCount': recipeCount,
    };
  }

  /// Create from JSON
  factory RecipeCategory.fromJson(Map<String, dynamic> json) {
    return RecipeCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      color: json['color'],
      iconName: json['iconName'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: json['updatedAt'] != null 
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      recipeCount: json['recipeCount'] ?? 0,
    );
  }

  /// Create a copy with updated values
  RecipeCategory copyWith({
    String? id,
    String? name,
    String? description,
    String? color,
    String? iconName,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? recipeCount,
  }) {
    return RecipeCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recipeCount: recipeCount ?? this.recipeCount,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'RecipeCategory(id: $id, name: $name, recipeCount: $recipeCount)';
}

/// Predefined recipe categories
class DefaultCategories {
  static const List<Map<String, dynamic>> categories = [
    {
      'name': 'Breakfast',
      'description': 'Morning meals and breakfast dishes',
      'color': '#FF9800',
      'iconName': 'breakfast_dining',
    },
    {
      'name': 'Lunch',
      'description': 'Midday meals and light dishes',
      'color': '#4CAF50',
      'iconName': 'lunch_dining',
    },
    {
      'name': 'Dinner',
      'description': 'Evening meals and hearty dishes',
      'color': '#3F51B5',
      'iconName': 'dinner_dining',
    },
    {
      'name': 'Desserts',
      'description': 'Sweet treats and desserts',
      'color': '#E91E63',
      'iconName': 'cake',
    },
    {
      'name': 'Snacks',
      'description': 'Quick bites and appetizers',
      'color': '#FF5722',
      'iconName': 'fastfood',
    },
    {
      'name': 'Beverages',
      'description': 'Drinks and beverages',
      'color': '#00BCD4',
      'iconName': 'local_drink',
    },
    {
      'name': 'Vegetarian',
      'description': 'Plant-based recipes',
      'color': '#8BC34A',
      'iconName': 'eco',
    },
    {
      'name': 'Vegan',
      'description': 'Completely plant-based recipes',
      'color': '#4CAF50',
      'iconName': 'spa',
    },
    {
      'name': 'Gluten-Free',
      'description': 'Recipes without gluten',
      'color': '#FFC107',
      'iconName': 'no_meals',
    },
    {
      'name': 'Quick & Easy',
      'description': 'Recipes that can be made quickly',
      'color': '#FF9800',
      'iconName': 'timer',
    },
    {
      'name': 'Healthy',
      'description': 'Nutritious and healthy recipes',
      'color': '#4CAF50',
      'iconName': 'favorite',
    },
    {
      'name': 'Comfort Food',
      'description': 'Hearty and comforting dishes',
      'color': '#795548',
      'iconName': 'home',
    },
  ];

  static List<RecipeCategory> getDefaultCategories() {
    return categories.map((categoryData) {
      final id = DateTime.now().millisecondsSinceEpoch.toString() + 
                 categoryData['name'].toString().replaceAll(' ', '').toLowerCase();
      
      return RecipeCategory(
        id: id,
        name: categoryData['name'],
        description: categoryData['description'],
        color: categoryData['color'],
        iconName: categoryData['iconName'],
        createdAt: DateTime.now(),
      );
    }).toList();
  }
}