class ShoppingList {
  final String id;
  final String name;
  final String userId;
  final List<ShoppingItem> items;
  final bool isCompleted;
  final bool isShared;
  final List<String> sharedWithUsers;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;
  final String? notes;

  const ShoppingList({
    required this.id,
    required this.name,
    required this.userId,
    required this.items,
    this.isCompleted = false,
    this.isShared = false,
    this.sharedWithUsers = const [],
    required this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.notes,
  });

  ShoppingList copyWith({
    String? id,
    String? name,
    String? userId,
    List<ShoppingItem>? items,
    bool? isCompleted,
    bool? isShared,
    List<String>? sharedWithUsers,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    String? notes,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      isCompleted: isCompleted ?? this.isCompleted,
      isShared: isShared ?? this.isShared,
      sharedWithUsers: sharedWithUsers ?? this.sharedWithUsers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
    );
  }

  int get totalItems => items.length;
  int get completedItems => items.where((item) => item.isCompleted).length;
  int get remainingItems => totalItems - completedItems;
  double get completionPercentage =>
      totalItems > 0 ? (completedItems / totalItems) * 100 : 0;

  double get estimatedTotalCost => items
      .where((item) => item.estimatedCost != null)
      .fold(0.0, (sum, item) => sum + (item.estimatedCost! * item.quantity));

  Map<String, List<ShoppingItem>> get itemsByCategory {
    final Map<String, List<ShoppingItem>> categorized = {};
    for (final item in items) {
      if (categorized.containsKey(item.category)) {
        categorized[item.category]!.add(item);
      } else {
        categorized[item.category] = [item];
      }
    }
    return categorized;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userId': userId,
        'items': items.map((i) => i.toJson()).toList(),
        'isCompleted': isCompleted,
        'isShared': isShared,
        'sharedWithUsers': sharedWithUsers,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'completedAt': completedAt?.toIso8601String(),
        'notes': notes,
      };

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        userId: json['userId'] ?? '',
        items: (json['items'] as List?)
                ?.map((i) => ShoppingItem.fromJson(i))
                .toList() ??
            [],
        isCompleted: json['isCompleted'] ?? false,
        isShared: json['isShared'] ?? false,
        sharedWithUsers: List<String>.from(json['sharedWithUsers'] ?? []),
        createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'])
            : null,
        completedAt: json['completedAt'] != null
            ? DateTime.tryParse(json['completedAt'])
            : null,
        notes: json['notes'],
      );
}

class ShoppingItem {
  final String id;
  final String name;
  final String category;
  final double quantity;
  final String unit;
  final bool isCompleted;
  final bool isUrgent;
  final double? estimatedCost;
  final String? brand;
  final String? notes;
  final DateTime? addedAt;

  const ShoppingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    this.isCompleted = false,
    this.isUrgent = false,
    this.estimatedCost,
    this.brand,
    this.notes,
    this.addedAt,
  });

  ShoppingItem copyWith({
    String? id,
    String? name,
    String? category,
    double? quantity,
    String? unit,
    bool? isCompleted,
    bool? isUrgent,
    double? estimatedCost,
    String? brand,
    String? notes,
    DateTime? addedAt,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      isCompleted: isCompleted ?? this.isCompleted,
      isUrgent: isUrgent ?? this.isUrgent,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      brand: brand ?? this.brand,
      notes: notes ?? this.notes,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'quantity': quantity,
        'unit': unit,
        'isCompleted': isCompleted,
        'isUrgent': isUrgent,
        'estimatedCost': estimatedCost,
        'brand': brand,
        'notes': notes,
        'addedAt': addedAt?.toIso8601String(),
      };

  factory ShoppingItem.fromJson(Map<String, dynamic> json) => ShoppingItem(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        category: json['category'] ?? '',
        quantity: (json['quantity'] ?? 0.0).toDouble(),
        unit: json['unit'] ?? '',
        isCompleted: json['isCompleted'] ?? false,
        isUrgent: json['isUrgent'] ?? false,
        estimatedCost: json['estimatedCost']?.toDouble(),
        brand: json['brand'],
        notes: json['notes'],
        addedAt:
            json['addedAt'] != null ? DateTime.tryParse(json['addedAt']) : null,
      );
}
