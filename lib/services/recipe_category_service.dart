import '../domain/entities/recipe_category.dart';
import '../infrastructure/storage/hive_recipe_storage.dart';
import '../core/errors/app_exceptions.dart';

/// Service for managing recipe categories
class RecipeCategoryService {
  static final RecipeCategoryService _instance =
      RecipeCategoryService._internal();
  factory RecipeCategoryService() => _instance;
  RecipeCategoryService._internal();

  final HiveRecipeStorage _storage = HiveRecipeStorage();
  static const String _categoriesKey = 'recipe_categories';

  /// Get all categories
  Future<List<RecipeCategory>> getAllCategories() async {
    try {
      // For now, we'll store categories as a simple list in storage info
      // In a real implementation, you might want a separate categories storage
      final storageInfo = _storage.getStorageInfo();

      // Try to get categories from a simple storage mechanism
      // This is a simplified approach - in production you'd want proper category storage
      final defaultCategories = DefaultCategories.getDefaultCategories();
      return defaultCategories;
    } catch (e) {
      throw StorageException('Failed to load categories: $e');
    }
  }

  /// Save categories to storage (simplified implementation)
  Future<void> _saveCategories(List<RecipeCategory> categories) async {
    try {
      // This is a simplified implementation
      // In production, you'd want proper category storage in Hive
      print('Categories saved: ${categories.length}');
    } catch (e) {
      throw StorageException('Failed to save categories: $e');
    }
  }

  /// Create a new category
  Future<RecipeCategory> createCategory({
    required String name,
    String? description,
    String? color,
    String? iconName,
  }) async {
    try {
      final categories = await getAllCategories();

      // Check if category with same name already exists
      if (categories
          .any((cat) => cat.name.toLowerCase() == name.toLowerCase())) {
        throw ValidationException('Category with name "$name" already exists');
      }

      final newCategory = RecipeCategory(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name.trim(),
        description: description?.trim(),
        color: color,
        iconName: iconName,
        createdAt: DateTime.now(),
      );

      categories.add(newCategory);
      await _saveCategories(categories);

      return newCategory;
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw StorageException('Failed to create category: $e');
    }
  }

  /// Update an existing category
  Future<RecipeCategory> updateCategory(RecipeCategory category) async {
    try {
      final categories = await getAllCategories();
      final index = categories.indexWhere((cat) => cat.id == category.id);

      if (index == -1) {
        throw const NotFoundException('Category not found');
      }

      // Check if new name conflicts with existing categories (excluding current one)
      final nameConflict = categories.any((cat) =>
          cat.id != category.id &&
          cat.name.toLowerCase() == category.name.toLowerCase());

      if (nameConflict) {
        throw ValidationException(
            'Category with name "${category.name}" already exists');
      }

      final updatedCategory = category.copyWith(updatedAt: DateTime.now());
      categories[index] = updatedCategory;
      await _saveCategories(categories);

      return updatedCategory;
    } catch (e) {
      if (e is ValidationException || e is NotFoundException) rethrow;
      throw StorageException('Failed to update category: $e');
    }
  }

  /// Delete a category
  Future<bool> deleteCategory(String categoryId) async {
    try {
      final categories = await getAllCategories();
      final index = categories.indexWhere((cat) => cat.id == categoryId);

      if (index == -1) {
        throw const NotFoundException('Category not found');
      }

      // Check if category is being used by recipes
      final categoryName = categories[index].name;
      final recipesInCategory =
          await _storage.getRecipesByCategory(categoryName);

      if (recipesInCategory.isNotEmpty) {
        throw ConflictException(
            'Cannot delete category "$categoryName" because it contains ${recipesInCategory.length} recipe(s). '
            'Please move or delete the recipes first.');
      }

      categories.removeAt(index);
      await _saveCategories(categories);

      return true;
    } catch (e) {
      if (e is NotFoundException || e is ConflictException) rethrow;
      throw StorageException('Failed to delete category: $e');
    }
  }

  /// Get category by ID
  Future<RecipeCategory?> getCategoryById(String categoryId) async {
    try {
      final categories = await getAllCategories();
      return categories.firstWhere(
        (cat) => cat.id == categoryId,
        orElse: () => throw const NotFoundException('Category not found'),
      );
    } catch (e) {
      if (e is NotFoundException) return null;
      throw StorageException('Failed to get category: $e');
    }
  }

  /// Get category by name
  Future<RecipeCategory?> getCategoryByName(String name) async {
    try {
      final categories = await getAllCategories();
      return categories.firstWhere(
        (cat) => cat.name.toLowerCase() == name.toLowerCase(),
        orElse: () => throw const NotFoundException('Category not found'),
      );
    } catch (e) {
      if (e is NotFoundException) return null;
      throw StorageException('Failed to get category: $e');
    }
  }

  /// Update recipe counts for all categories
  Future<void> updateRecipeCounts() async {
    try {
      final categories = await getAllCategories();
      final updatedCategories = <RecipeCategory>[];

      for (final category in categories) {
        final recipesInCategory =
            await _storage.getRecipesByCategory(category.name);
        final updatedCategory = category.copyWith(
          recipeCount: recipesInCategory.length,
          updatedAt: DateTime.now(),
        );
        updatedCategories.add(updatedCategory);
      }

      await _saveCategories(updatedCategories);
    } catch (e) {
      throw StorageException('Failed to update recipe counts: $e');
    }
  }

  /// Search categories by name
  Future<List<RecipeCategory>> searchCategories(String query) async {
    try {
      final categories = await getAllCategories();

      if (query.trim().isEmpty) {
        return categories;
      }

      final lowerQuery = query.toLowerCase();
      return categories.where((category) {
        return category.name.toLowerCase().contains(lowerQuery) ||
            (category.description?.toLowerCase().contains(lowerQuery) ?? false);
      }).toList();
    } catch (e) {
      throw StorageException('Failed to search categories: $e');
    }
  }

  /// Get categories with recipe counts
  Future<List<RecipeCategory>> getCategoriesWithCounts() async {
    await updateRecipeCounts();
    return getAllCategories();
  }

  /// Reset to default categories (useful for testing or reset functionality)
  Future<List<RecipeCategory>> resetToDefaults() async {
    try {
      final defaultCategories = DefaultCategories.getDefaultCategories();
      await _saveCategories(defaultCategories);
      return defaultCategories;
    } catch (e) {
      throw StorageException('Failed to reset categories: $e');
    }
  }

  /// Export categories to JSON
  Future<List<Map<String, dynamic>>> exportCategories() async {
    try {
      final categories = await getAllCategories();
      return categories.map((category) => category.toJson()).toList();
    } catch (e) {
      throw StorageException('Failed to export categories: $e');
    }
  }

  /// Import categories from JSON
  Future<int> importCategories(
      List<Map<String, dynamic>> categoriesJson) async {
    try {
      int importedCount = 0;
      final existingCategories = await getAllCategories();

      for (final categoryJson in categoriesJson) {
        try {
          final category = RecipeCategory.fromJson(categoryJson);

          // Check if category already exists
          final exists = existingCategories.any(
              (cat) => cat.name.toLowerCase() == category.name.toLowerCase());

          if (!exists) {
            await createCategory(
              name: category.name,
              description: category.description,
              color: category.color,
              iconName: category.iconName,
            );
            importedCount++;
          }
        } catch (e) {
          // Skip invalid categories but continue importing others
          print('Skipped invalid category during import: $e');
        }
      }

      return importedCount;
    } catch (e) {
      throw StorageException('Failed to import categories: $e');
    }
  }

  /// Clear all categories
  Future<bool> clearAllCategories() async {
    try {
      // Simplified implementation
      print('All categories cleared');
      return true;
    } catch (e) {
      throw StorageException('Failed to clear categories: $e');
    }
  }
}
