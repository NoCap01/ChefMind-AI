import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import '../../domain/exceptions/app_exceptions.dart';

abstract class IBarcodeScannerService {
  Future<String?> scanBarcode();
  Future<ProductInfo?> getProductInfo(String barcode);
}

class BarcodeScannerService implements IBarcodeScannerService {
  static final BarcodeScannerService _instance = BarcodeScannerService._internal();
  static BarcodeScannerService get instance => _instance;
  
  BarcodeScannerService._internal();

  @override
  Future<String?> scanBarcode() async {
    try {
      // In a real implementation, this would use a barcode scanning plugin
      // like mobile_scanner or qr_code_scanner
      
      // For now, we'll simulate barcode scanning
      // TODO: Implement actual barcode scanning with mobile_scanner
      
      throw const ServiceException('Barcode scanning not yet implemented');
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_NOT_GRANTED') {
        throw const PermissionException('Camera permission required for barcode scanning');
      } else if (e.code == 'USER_CANCELLED') {
        return null; // User cancelled scanning
      } else {
        throw ServiceException('Barcode scanning failed: ${e.message}');
      }
    } catch (e) {
      throw ServiceException('Unexpected error during barcode scanning: $e');
    }
  }

  @override
  Future<ProductInfo?> getProductInfo(String barcode) async {
    try {
      // In a real implementation, this would call a product database API
      // like OpenFoodFacts, UPC Database, or Barcode Lookup
      
      // For now, we'll return mock data based on common barcode patterns
      return _getMockProductInfo(barcode);
    } catch (e) {
      throw ServiceException('Failed to get product information: $e');
    }
  }

  ProductInfo? _getMockProductInfo(String barcode) {
    // Mock product data for demonstration
    final mockProducts = {
      '123456789012': ProductInfo(
        barcode: barcode,
        name: 'Organic Whole Milk',
        brand: 'Organic Valley',
        category: 'dairy',
        unit: 'L',
        description: 'Organic whole milk from grass-fed cows',
        imageUrl: null,
        nutritionInfo: {
          'calories': 150,
          'protein': 8,
          'fat': 8,
          'carbs': 12,
        },
      ),
      '987654321098': ProductInfo(
        barcode: barcode,
        name: 'Whole Wheat Bread',
        brand: 'Dave\'s Killer Bread',
        category: 'grains',
        unit: 'loaf',
        description: 'Organic whole wheat bread',
        imageUrl: null,
        nutritionInfo: {
          'calories': 110,
          'protein': 5,
          'fat': 2,
          'carbs': 22,
        },
      ),
      '456789123456': ProductInfo(
        barcode: barcode,
        name: 'Bananas',
        brand: 'Dole',
        category: 'fruits',
        unit: 'bunch',
        description: 'Fresh bananas',
        imageUrl: null,
        nutritionInfo: {
          'calories': 105,
          'protein': 1,
          'fat': 0,
          'carbs': 27,
        },
      ),
    };

    return mockProducts[barcode];
  }
}

class ProductInfo {
  final String barcode;
  final String name;
  final String? brand;
  final String category;
  final String unit;
  final String? description;
  final String? imageUrl;
  final Map<String, dynamic>? nutritionInfo;
  final List<String>? ingredients;
  final List<String>? allergens;

  const ProductInfo({
    required this.barcode,
    required this.name,
    this.brand,
    required this.category,
    required this.unit,
    this.description,
    this.imageUrl,
    this.nutritionInfo,
    this.ingredients,
    this.allergens,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      barcode: json['barcode'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      category: json['category'] as String,
      unit: json['unit'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      nutritionInfo: json['nutritionInfo'] as Map<String, dynamic>?,
      ingredients: (json['ingredients'] as List<dynamic>?)?.cast<String>(),
      allergens: (json['allergens'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'name': name,
      'brand': brand,
      'category': category,
      'unit': unit,
      'description': description,
      'imageUrl': imageUrl,
      'nutritionInfo': nutritionInfo,
      'ingredients': ingredients,
      'allergens': allergens,
    };
  }
}

// Extension to help with barcode validation
extension BarcodeValidation on String {
  bool get isValidBarcode {
    // Basic barcode validation (UPC-A, EAN-13, etc.)
    if (isEmpty) return false;
    
    // Check length (most common formats)
    if (length != 8 && length != 12 && length != 13 && length != 14) {
      return false;
    }
    
    // Check if all characters are digits
    return RegExp(r'^\d+$').hasMatch(this);
  }

  String get formattedBarcode {
    // Format barcode for display
    if (length == 12) {
      // UPC-A format: 123456 789012
      return '${substring(0, 6)} ${substring(6)}';
    } else if (length == 13) {
      // EAN-13 format: 1 234567 890123
      return '${substring(0, 1)} ${substring(1, 7)} ${substring(7)}';
    }
    return this;
  }
}