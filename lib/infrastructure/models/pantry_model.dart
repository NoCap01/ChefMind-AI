import '../../domain/entities/pantry_item.dart';

class PantryModel {
  final String id;
  final String name;
  final String category;
  final double quantity;
  final String unit;
  final DateTime? expiryDate;
  final DateTime? purchaseDate;
  final String? brand;
  final String? location;
  final String? notes;
  final bool isRunningLow;
  final double cost;
  final String? barcode;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PantryModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.unit,
    this.expiryDate,
    this.purchaseDate,
    this.brand,
    this.location,
    this.notes,
    this.isRunningLow = false,
    this.cost = 0.0,
    this.barcode,
    this.imageUrl,
    required this.createdAt,
    this.updatedAt,
  });

  factory PantryModel.fromJson(Map<String, dynamic> json) {
    return PantryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      quantity: (json['quantity'] ?? 0.0).toDouble(),
      unit: json['unit'] ?? '',
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      purchaseDate: json['purchaseDate'] != null
          ? DateTime.parse(json['purchaseDate'])
          : null,
      brand: json['brand'],
      location: json['location'],
      notes: json['notes'],
      isRunningLow: json['isRunningLow'] ?? false,
      cost: (json['cost'] ?? 0.0).toDouble(),
      barcode: json['barcode'],
      imageUrl: json['imageUrl'],
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'unit': unit,
      'expiryDate': expiryDate?.toIso8601String(),
      'purchaseDate': purchaseDate?.toIso8601String(),
      'brand': brand,
      'location': location,
      'notes': notes,
      'isRunningLow': isRunningLow,
      'cost': cost,
      'barcode': barcode,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory PantryModel.fromDomain(PantryItem item) {
    return PantryModel(
      id: item.id,
      name: item.name,
      category: item.category ?? 'Other',
      quantity: item.quantity,
      unit: item.unit,
      expiryDate: item.expirationDate,
      purchaseDate: null, // Not available in PantryItem
      brand: null, // Not available in PantryItem
      location: null, // Not available in PantryItem
      notes: item.notes,
      isRunningLow: item.isLowStock,
      cost: 0.0, // Not available in PantryItem
      barcode: null, // Not available in PantryItem
      imageUrl: null, // Not available in PantryItem
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  PantryItem toDomain() {
    return PantryItem(
      id: id,
      name: name,
      category: category,
      quantity: quantity,
      unit: unit,
      expirationDate: expiryDate ?? DateTime.now(),
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt ?? createdAt,
      isLowStock: isRunningLow,
    );
  }
}
