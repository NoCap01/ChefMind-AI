import 'package:hive/hive.dart';

part 'shopping_list_item.g.dart';

@HiveType(typeId: 9)
class ShoppingListItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double quantity;

  @HiveField(3)
  String unit;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  String? category;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  @HiveField(8)
  String? notes;

  @HiveField(9)
  String? recipeId;

  @HiveField(10)
  double? estimatedPrice;

  ShoppingListItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.isCompleted = false,
    this.category,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
    this.recipeId,
    this.estimatedPrice,
  });

  factory ShoppingListItem.create({
    required String name,
    required double quantity,
    required String unit,
    String? category,
    String? notes,
    String? recipeId,
    double? estimatedPrice,
  }) {
    final now = DateTime.now();
    return ShoppingListItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      quantity: quantity,
      unit: unit,
      category: category,
      createdAt: now,
      updatedAt: now,
      notes: notes,
      recipeId: recipeId,
      estimatedPrice: estimatedPrice,
    );
  }

  ShoppingListItem copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    bool? isCompleted,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    String? recipeId,
    double? estimatedPrice,
  }) {
    return ShoppingListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      recipeId: recipeId ?? this.recipeId,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
    );
  }

  void toggleCompleted() {
    isCompleted = !isCompleted;
    updatedAt = DateTime.now();
    save();
  }

  @override
  String toString() {
    return 'ShoppingListItem(id: $id, name: $name, quantity: $quantity $unit, completed: $isCompleted)';
  }
}