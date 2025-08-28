import '../entities/recipe.dart';\nimport '../entities/recipe_ingredient.dart';\nimport '../entities/instruction.dart';\nimport '../entities/ingredient.dart';\n\n/// Validation result for recipe data\nclass ValidationResult {\n  final bool isValid;\n  final List<ValidationError> errors;\n  final List<ValidationWarning> warnings;\n\n  const ValidationResult({\n    required this.isValid,\n    this.errors = const [],\n    this.warnings = const [],\n  });\n\n  ValidationResult.valid() : this(isValid: true);\n  \n  ValidationResult.invalid(List<ValidationError> errors, [List<ValidationWarning>? warnings])\n      : this(isValid: false, errors: errors, warnings: warnings ?? []);\n}\n\nclass ValidationError {\n  final String field;\n  final String message;\n  final ValidationSeverity severity;\n\n  const ValidationError({\n    required this.field,\n    required this.message,\n    this.severity = ValidationSeverity.error,\n  });\n}\n\nclass ValidationWarning {\n  final String field;\n  final String message;\n  final String suggestion;\n\n  const ValidationWarning({\n    required this.field,\n    required this.message,\n    required this.suggestion,\n  });\n}\n\nenum ValidationSeverity {\n  warning,\n  error,\n  critical,\n}\n\n/// Comprehensive recipe validation\nclass RecipeValidator {\n  static ValidationResult validateRecipe(Recipe recipe) {\n    final errors = <ValidationError>[];\n    final warnings = <ValidationWarning>[];\n\n    // Basic required fields\n    if (recipe.title.trim().isEmpty) {\n      errors.add(const ValidationError(\n        field: 'title',\n        message: 'Recipe title is required',\n        severity: ValidationSeverity.critical,\n      ));\n    } else if (recipe.title.length < 3) {\n      errors.add(const ValidationError(\n        field: 'title',\n        message: 'Recipe title must be at least 3 characters long',\n      ));\n    } else if (recipe.title.length > 100) {\n      warnings.add(const ValidationWarning(\n        field: 'title',\n        message: 'Recipe title is very long',\n        suggestion: 'Consider shortening the title for better readability',\n      ));\n    }\n\n    if (recipe.description.trim().isEmpty) {\n      errors.add(const ValidationError(\n        field: 'description',\n        message: 'Recipe description is required',\n        severity: ValidationSeverity.error,\n      ));\n    } else if (recipe.description.length < 10) {\n      warnings.add(const ValidationWarning(\n        field: 'description',\n        message: 'Recipe description is very short',\n        suggestion: 'Add more details about the recipe to help users understand what they\\'re making',\n      ));\n    }\n\n    if (recipe.authorId.trim().isEmpty) {\n      errors.add(const ValidationError(\n        field: 'authorId',\n        message: 'Recipe must have an author',\n        severity: ValidationSeverity.critical,\n      ));\n    }\n\n    // Servings validation\n    if (recipe.servings <= 0) {\n      errors.add(const ValidationError(\n        field: 'servings',\n        message: 'Recipe must serve at least 1 person',\n      ));\n    } else if (recipe.servings > 100) {\n      warnings.add(const ValidationWarning(\n        field: 'servings',\n        message: 'Recipe serves a very large number of people',\n        suggestion: 'Consider if this serving size is realistic for home cooking',\n      ));\n    }\n\n    // Ingredients validation\n    if (recipe.ingredients.isEmpty) {\n      errors.add(const ValidationError(\n        field: 'ingredients',\n        message: 'Recipe must have at least one ingredient',\n        severity: ValidationSeverity.critical,\n      ));\n    } else {\n      for (int i = 0; i < recipe.ingredients.length; i++) {\n        final ingredientErrors = _validateRecipeIngredient(recipe.ingredients[i], i);\n        errors.addAll(ingredientErrors.errors);\n        warnings.addAll(ingredientErrors.warnings);\n      }\n    }\n\n    // Instructions validation\n    if (recipe.instructions.isEmpty) {\n      errors.add(const ValidationError(\n        field: 'instructions',\n        message: 'Recipe must have at least one instruction',\n        severity: ValidationSeverity.critical,\n      ));\n    } else {\n      for (int i = 0; i < recipe.instructions.length; i++) {\n        final instructionErrors = _validateInstruction(recipe.instructions[i], i);\n        errors.addAll(instructionErrors.errors);\n        warnings.addAll(instructionErrors.warnings);\n      }\n    }\n\n    // Time validation\n    if (recipe.prepTime != null && recipe.prepTime!.isNegative) {\n      errors.add(const ValidationError(\n        field: 'prepTime',\n        message: 'Preparation time cannot be negative',\n      ));\n    }\n\n    if (recipe.cookTime != null && recipe.cookTime!.isNegative) {\n      errors.add(const ValidationError(\n        field: 'cookTime',\n        message: 'Cooking time cannot be negative',\n      ));\n    }\n\n    if (recipe.totalTime != null && recipe.totalTime!.isNegative) {\n      errors.add(const ValidationError(\n        field: 'totalTime',\n        message: 'Total time cannot be negative',\n      ));\n    }\n\n    // Time consistency check\n    if (recipe.prepTime != null && recipe.cookTime != null && recipe.totalTime != null) {\n      final calculatedTotal = recipe.prepTime! + recipe.cookTime!;\n      if (recipe.totalTime! < calculatedTotal) {\n        warnings.add(const ValidationWarning(\n          field: 'totalTime',\n          message: 'Total time is less than prep time + cook time',\n          suggestion: 'Check if times are accurate or if some steps can be done in parallel',\n        ));\n      }\n    }\n\n    // Nutrition validation\n    if (recipe.nutrition != null) {\n      final nutritionErrors = _validateNutritionSummary(recipe.nutrition!);\n      errors.addAll(nutritionErrors.errors);\n      warnings.addAll(nutritionErrors.warnings);\n    }\n\n    // Rating validation\n    if (recipe.rating < 0 || recipe.rating > 5) {\n      errors.add(const ValidationError(\n        field: 'rating',\n        message: 'Rating must be between 0 and 5',\n      ));\n    }\n\n    // Review count consistency\n    if (recipe.rating > 0 && recipe.reviewCount == 0) {\n      warnings.add(const ValidationWarning(\n        field: 'reviewCount',\n        message: 'Recipe has a rating but no reviews',\n        suggestion: 'Ensure rating and review count are consistent',\n      ));\n    }\n\n    return ValidationResult(\n      isValid: errors.isEmpty,\n      errors: errors,\n      warnings: warnings,\n    );\n  }\n\n  static ValidationResult _validateRecipeIngredient(RecipeIngredient ingredient, int index) {\n    final errors = <ValidationError>[];\n    final warnings = <ValidationWarning>[];\n    final fieldPrefix = 'ingredients[$index]';\n\n    if (ingredient.name.trim().isEmpty) {\n      errors.add(ValidationError(\n        field: '$fieldPrefix.name',\n        message: 'Ingredient name is required',\n      ));\n    }\n\n    if (ingredient.quantity <= 0) {\n      errors.add(ValidationError(\n        field: '$fieldPrefix.quantity',\n        message: 'Ingredient quantity must be greater than 0',\n      ));\n    } else if (ingredient.quantity > 10000) {\n      warnings.add(ValidationWarning(\n        field: '$fieldPrefix.quantity',\n        message: 'Very large quantity for ingredient',\n        suggestion: 'Check if the quantity and unit are correct',\n      ));\n    }\n\n    if (ingredient.unit.trim().isEmpty) {\n      errors.add(ValidationError(\n        field: '$fieldPrefix.unit',\n        message: 'Ingredient unit is required',\n      ));\n    }\n\n    return ValidationResult(\n      isValid: errors.isEmpty,\n      errors: errors,\n      warnings: warnings,\n    );\n  }\n\n  static ValidationResult _validateInstruction(Instruction instruction, int index) {\n    final errors = <ValidationError>[];\n    final warnings = <ValidationWarning>[];\n    final fieldPrefix = 'instructions[$index]';\n\n    if (instruction.description.trim().isEmpty) {\n      errors.add(ValidationError(\n        field: '$fieldPrefix.description',\n        message: 'Instruction description is required',\n      ));\n    } else if (instruction.description.length < 10) {\n      warnings.add(ValidationWarning(\n        field: '$fieldPrefix.description',\n        message: 'Instruction description is very short',\n        suggestion: 'Provide more detailed instructions for better clarity',\n      ));\n    }\n\n    if (instruction.stepNumber <= 0) {\n      errors.add(ValidationError(\n        field: '$fieldPrefix.stepNumber',\n        message: 'Step number must be greater than 0',\n      ));\n    }\n\n    if (instruction.duration != null && instruction.duration!.isNegative) {\n      errors.add(ValidationError(\n        field: '$fieldPrefix.duration',\n        message: 'Instruction duration cannot be negative',\n      ));\n    }\n\n    return ValidationResult(\n      isValid: errors.isEmpty,\n      errors: errors,\n      warnings: warnings,\n    );\n  }\n\n  static ValidationResult _validateNutritionSummary(NutritionSummary nutrition) {\n    final errors = <ValidationError>[];\n    final warnings = <ValidationWarning>[];\n\n    if (nutrition.caloriesPerServing < 0) {\n      errors.add(const ValidationError(\n        field: 'nutrition.caloriesPerServing',\n        message: 'Calories per serving cannot be negative',\n      ));\n    } else if (nutrition.caloriesPerServing > 5000) {\n      warnings.add(const ValidationWarning(\n        field: 'nutrition.caloriesPerServing',\n        message: 'Very high calorie count per serving',\n        suggestion: 'Check if the nutritional information is accurate',\n      ));\n    }\n\n    if (nutrition.proteinPerServing < 0) {\n      errors.add(const ValidationError(\n        field: 'nutrition.proteinPerServing',\n        message: 'Protein per serving cannot be negative',\n      ));\n    }\n\n    if (nutrition.carbsPerServing < 0) {\n      errors.add(const ValidationError(\n        field: 'nutrition.carbsPerServing',\n        message: 'Carbohydrates per serving cannot be negative',\n      ));\n    }\n\n    if (nutrition.fatPerServing < 0) {\n      errors.add(const ValidationError(\n        field: 'nutrition.fatPerServing',\n        message: 'Fat per serving cannot be negative',\n      ));\n    }\n\n    return ValidationResult(\n      isValid: errors.isEmpty,\n      errors: errors,\n      warnings: warnings,\n    );\n  }\n}\n/// Ingredie
nt validation
nclass IngredientValidator {
  static ValidationResult validateIngredient(Ingredient ingredient) {
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    if (ingredient.name.trim().isEmpty) {
      errors.add(const ValidationError(
        field: 'name',
        message: 'Ingredient name is required',
        severity: ValidationSeverity.critical,
      ));
    } else if (ingredient.name.length < 2) {
      errors.add(const ValidationError(
        field: 'name',
        message: 'Ingredient name must be at least 2 characters long',
      ));
    }

    if (ingredient.category.trim().isEmpty) {
      errors.add(const ValidationError(
        field: 'category',
        message: 'Ingredient category is required',
      ));
    }

    if (ingredient.shelfLifeDays < 0) {
      errors.add(const ValidationError(
        field: 'shelfLifeDays',
        message: 'Shelf life cannot be negative',
      ));
    } else if (ingredient.shelfLifeDays > 3650) { // 10 years
      warnings.add(const ValidationWarning(
        field: 'shelfLifeDays',
        message: 'Very long shelf life',
        suggestion: 'Check if the shelf life is realistic',
      ));
    }

    if (ingredient.averagePricePerUnit < 0) {
      errors.add(const ValidationError(
        field: 'averagePricePerUnit',
        message: 'Price cannot be negative',
      ));
    }

    if (ingredient.densityGPerMl <= 0) {
      warnings.add(const ValidationWarning(
        field: 'densityGPerMl',
        message: 'Density should be greater than 0 for accurate conversions',
        suggestion: 'Set appropriate density for volume to weight conversions',
      ));
    }

    // Nutrition validation
    if (ingredient.nutritionPer100g != null) {
      final nutritionErrors = _validateNutritionInfo(ingredient.nutritionPer100g!);
      errors.addAll(nutritionErrors.errors);
      warnings.addAll(nutritionErrors.warnings);
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  static ValidationResult _validateNutritionInfo(NutritionInfo nutrition) {
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    if (nutrition.calories < 0) {
      errors.add(const ValidationError(
        field: 'nutrition.calories',
        message: 'Calories cannot be negative',
      ));
    }

    if (nutrition.protein < 0) {
      errors.add(const ValidationError(
        field: 'nutrition.protein',
        message: 'Protein cannot be negative',
      ));
    }

    if (nutrition.carbohydrates < 0) {
      errors.add(const ValidationError(
        field: 'nutrition.carbohydrates',
        message: 'Carbohydrates cannot be negative',
      ));
    }

    if (nutrition.fat < 0) {
      errors.add(const ValidationError(
        field: 'nutrition.fat',
        message: 'Fat cannot be negative',
      ));
    }

    // Logical consistency checks
    final totalMacros = nutrition.protein + nutrition.carbohydrates + nutrition.fat;
    if (totalMacros > 100) {
      warnings.add(const ValidationWarning(
        field: 'nutrition',
        message: 'Total macronutrients exceed 100g per 100g',
        suggestion: 'Check if nutritional values are accurate',
      ));
    }

    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }
}

/// Recipe difficulty calculation utilities
class RecipeDifficultyCalculator {
  /// Calculate recipe difficulty based on various factors
  static RecipeDifficulty calculateDifficulty(Recipe recipe) {
    int difficultyScore = 0;
    
    // Base score from number of ingredients
    if (recipe.ingredients.length > 15) difficultyScore += 2;
    else if (recipe.ingredients.length > 10) difficultyScore += 1;
    
    // Score from number of instructions
    if (recipe.instructions.length > 20) difficultyScore += 2;
    else if (recipe.instructions.length > 10) difficultyScore += 1;
    
    // Score from cooking techniques
    final advancedTechniques = {
      'sous_vide', 'tempering', 'emulsifying', 'clarifying',
      'fermenting', 'curing', 'smoking', 'pressure_cooking'
    };
    
    for (final instruction in recipe.instructions) {
      for (final technique in instruction.techniques) {
        if (advancedTechniques.contains(technique)) {
          difficultyScore += 1;
          break;
        }
      }
    }
    
    // Score from total time
    if (recipe.totalTime != null) {
      final totalMinutes = recipe.totalTime!.inMinutes;
      if (totalMinutes > 240) difficultyScore += 2; // > 4 hours
      else if (totalMinutes > 120) difficultyScore += 1; // > 2 hours
    }
    
    // Score from special equipment
    final specialEquipment = {
      'stand_mixer', 'food_processor', 'immersion_blender',
      'mandoline', 'pasta_machine', 'ice_cream_maker',
      'pressure_cooker', 'sous_vide_machine', 'smoker'
    };
    
    for (final equipment in recipe.equipment) {
      if (specialEquipment.contains(equipment)) {
        difficultyScore += 1;
        break;
      }
    }
    
    // Convert score to difficulty level
    if (difficultyScore >= 8) return RecipeDifficulty.expert;
    if (difficultyScore >= 6) return RecipeDifficulty.hard;
    if (difficultyScore >= 4) return RecipeDifficulty.medium;
    if (difficultyScore >= 2) return RecipeDifficulty.easy;
    return RecipeDifficulty.beginner;
  }
  
  /// Get difficulty description
  static String getDifficultyDescription(RecipeDifficulty difficulty) {
    switch (difficulty) {
      case RecipeDifficulty.beginner:
        return 'Perfect for first-time cooks with basic kitchen skills';
      case RecipeDifficulty.easy:
        return 'Simple recipe with common ingredients and techniques';
      case RecipeDifficulty.medium:
        return 'Moderate complexity requiring some cooking experience';
      case RecipeDifficulty.hard:
        return 'Advanced recipe requiring good cooking skills and techniques';
      case RecipeDifficulty.expert:
        return 'Professional-level recipe requiring expert skills and equipment';
    }
  }
}

/// Nutrition estimation utilities
class NutritionEstimator {
  /// Estimate nutrition for a recipe based on ingredients
  static NutritionSummary estimateNutrition(Recipe recipe) {
    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalSugar = 0;
    double totalSodium = 0;
    
    for (final ingredient in recipe.ingredients) {
      if (ingredient.nutritionInfo != null) {
        final nutrition = ingredient.nutritionInfo!;
        final quantity = _convertToGrams(ingredient.quantity, ingredient.unit);
        final factor = quantity / 100; // nutrition is per 100g
        
        totalCalories += nutrition.calories * factor;
        totalProtein += nutrition.protein * factor;
        totalCarbs += nutrition.carbohydrates * factor;
        totalFat += nutrition.fat * factor;
        totalFiber += nutrition.fiber * factor;
        totalSugar += nutrition.sugar * factor;
        totalSodium += nutrition.sodium * factor;
      }
    }
    
    final servings = recipe.servings > 0 ? recipe.servings : 1;
    
    return NutritionSummary(
      caloriesPerServing: totalCalories / servings,
      proteinPerServing: totalProtein / servings,
      carbsPerServing: totalCarbs / servings,
      fatPerServing: totalFat / servings,
      fiberPerServing: totalFiber / servings,
      sugarPerServing: totalSugar / servings,
      sodiumPerServing: totalSodium / servings,
      healthScore: _calculateHealthScore(
        totalCalories / servings,
        totalProtein / servings,
        totalCarbs / servings,
        totalFat / servings,
        totalFiber / servings,
        totalSodium / servings,
      ),
      isLowCalorie: (totalCalories / servings) < 400,
      isHighProtein: (totalProtein / servings) > 20,
      isLowCarb: (totalCarbs / servings) < 20,
      isLowFat: (totalFat / servings) < 10,
      isHighFiber: (totalFiber / servings) > 5,
    );
  }
  
  static double _convertToGrams(double quantity, String unit) {
    // Simplified conversion - in real app, this would be more comprehensive
    switch (unit.toLowerCase()) {
      case 'kg':
        return quantity * 1000;
      case 'lb':
        return quantity * 453.592;
      case 'oz':
        return quantity * 28.3495;
      case 'cup':
        return quantity * 240; // Approximate for water
      case 'ml':
        return quantity; // Approximate 1:1 for water
      case 'l':
        return quantity * 1000;
      case 'tbsp':
        return quantity * 15;
      case 'tsp':
        return quantity * 5;
      default:
        return quantity; // Assume grams if unknown
    }
  }
  
  static NutritionScore _calculateHealthScore(
    double calories,
    double protein,
    double carbs,
    double fat,
    double fiber,
    double sodium,
  ) {
    int score = 0;
    
    // Positive factors
    if (protein > 15) score += 2;
    else if (protein > 10) score += 1;
    
    if (fiber > 8) score += 2;
    else if (fiber > 5) score += 1;
    
    if (calories < 500) score += 1;
    
    // Negative factors
    if (sodium > 1000) score -= 2;
    else if (sodium > 600) score -= 1;
    
    if (fat > 30) score -= 1;
    if (calories > 800) score -= 1;
    
    if (score >= 4) return NutritionScore.excellent;
    if (score >= 2) return NutritionScore.good;
    if (score >= 0) return NutritionScore.fair;
    return NutritionScore.poor;
  }
}

/// Recipe business rules and constraints
class RecipeBusinessRules {
  /// Check if recipe can be published
  static ValidationResult canPublish(Recipe recipe) {
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];
    
    // Must have basic validation pass
    final basicValidation = RecipeValidator.validateRecipe(recipe);
    if (!basicValidation.isValid) {
      errors.addAll(basicValidation.errors);
    }
    
    // Publishing specific rules
    if (recipe.imageUrls.isEmpty) {
      errors.add(const ValidationError(
        field: 'imageUrls',
        message: 'Published recipes must have at least one image',
      ));
    }
    
    if (recipe.tags.isEmpty) {
      warnings.add(const ValidationWarning(
        field: 'tags',
        message: 'Recipe has no tags',
        suggestion: 'Add relevant tags to improve discoverability',
      ));
    }
    
    if (recipe.cuisineTypes.isEmpty) {
      warnings.add(const ValidationWarning(
        field: 'cuisineTypes',
        message: 'Recipe has no cuisine type specified',
        suggestion: 'Specify cuisine type to help users find relevant recipes',
      ));
    }
    
    if (recipe.mealTypes.isEmpty) {
      warnings.add(const ValidationWarning(
        field: 'mealTypes',
        message: 'Recipe has no meal type specified',
        suggestion: 'Specify when this recipe is typically served',
      ));
    }
    
    return ValidationResult(
      isValid: errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }
  
  /// Check if user can edit recipe
  static bool canEdit(Recipe recipe, String userId) {
    return recipe.authorId == userId || 
           recipe.status == RecipeStatus.draft;
  }
  
  /// Check if recipe can be deleted
  static bool canDelete(Recipe recipe, String userId) {
    return recipe.authorId == userId;
  }
  
  /// Get maximum allowed ingredients
  static int getMaxIngredients() => 50;
  
  /// Get maximum allowed instructions
  static int getMaxInstructions() => 100;
  
  /// Get maximum recipe title length
  static int getMaxTitleLength() => 100;
  
  /// Get maximum description length
  static int getMaxDescriptionLength() => 2000;
}