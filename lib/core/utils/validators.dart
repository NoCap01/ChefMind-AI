import '../security/input_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    final result = InputValidator.validateEmail(value);
    return result.isValid ? null : result.errorMessage;
  }

  static String? validatePassword(String? value) {
    final result = InputValidator.validatePassword(value);
    return result.isValid ? null : result.errorMessage;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    // Sanitize input and check for suspicious patterns
    final sanitized = InputValidator.sanitizeInput(value);
    if (sanitized != value) {
      return '$fieldName contains invalid characters';
    }
    
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    
    return null;
  }

  static String? validateDisplayName(String? value) {
    return validateName(value);
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }
  
  static String? validateIngredient(String? value) {
    final result = InputValidator.validateIngredient(value);
    return result.isValid ? null : result.errorMessage;
  }

  static String? validateServings(String? value) {
    final result = InputValidator.validateServings(value);
    return result.isValid ? null : result.errorMessage;
  }

  static String? validateCookingTime(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Cooking time is optional
    }
    
    final result = InputValidator.validateCookingTime(value);
    return result.isValid ? null : result.errorMessage;
  }

  static String? validateRecipeTitle(String? value) {
    final result = InputValidator.validateRecipeTitle(value);
    return result.isValid ? null : result.errorMessage;
  }

  static String? validateRecipeDescription(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Description is optional
    }
    
    if (value.length > 500) {
      return 'Description must be less than 500 characters';
    }
    
    return null;
  }
}