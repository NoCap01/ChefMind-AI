import 'package:hive/hive.dart';

part 'pantry_item.g.dart';

@HiveType(typeId: 8)
class PantryItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double quantity;

  @HiveField(3)
  String unit;

  @HiveField(4)
  DateTime? expirationDate;

  @HiveField(5)
  String? category;

  @HiveField(6)
  double? minStockLevel;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  DateTime updatedAt;

  @HiveField(9)
  String? notes;

  @HiveField(10)
  bool isLowStock;

  @HiveField(11)
  String? location;

  PantryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.expirationDate,
    this.category,
    this.minStockLevel,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
    this.isLowStock = false,
    this.location,
  });

  factory PantryItem.create({
    required String name,
    required double quantity,
    required String unit,
    DateTime? expirationDate,
    String? category,
    double? minStockLevel,
    String? notes,
    String? location,
  }) {
    final now = DateTime.now();
    return PantryItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      quantity: quantity,
      unit: unit,
      expirationDate: expirationDate,
      category: category,
      minStockLevel: minStockLevel,
      createdAt: now,
      updatedAt: now,
      notes: notes,
      isLowStock: minStockLevel != null ? quantity <= minStockLevel : false,
      location: location,
    );
  }

  PantryItem copyWith({
    String? id,
    String? name,
    double? quantity,
    String? unit,
    DateTime? expirationDate,
    String? category,
    double? minStockLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? notes,
    bool? isLowStock,
    String? location,
  }) {
    return PantryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      expirationDate: expirationDate ?? this.expirationDate,
      category: category ?? this.category,
      minStockLevel: minStockLevel ?? this.minStockLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      isLowStock: isLowStock ?? this.isLowStock,
      location: location ?? this.location,
    );
  }

  bool get isExpiringSoon {
    if (expirationDate == null) return false;
    final daysUntilExpiration =
        expirationDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiration <= 3 && daysUntilExpiration >= 0;
  }

  bool get isExpired {
    if (expirationDate == null) return false;
    return expirationDate!.isBefore(DateTime.now());
  }

  void updateQuantity(double newQuantity) {
    quantity = newQuantity;
    updatedAt = DateTime.now();
    if (minStockLevel != null) {
      isLowStock = quantity <= minStockLevel!;
    }
    save();
  }

  void updateStock(double changeAmount) {
    updateQuantity(quantity + changeAmount);
  }

  @override
  String toString() {
    return 'PantryItem(id: $id, name: $name, quantity: $quantity $unit)';
  }
}
