import 'dart:convert';

/// Comprehensive input validation and sanitization
class InputValidator {
  // Regular expressions for validation
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegex = RegExp(
    r'^\+?[\d\s\-\(\)]{10,}$',
  );

  static final RegExp _alphanumericRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
  static final RegExp _nameRegex = RegExp(r"^[a-zA-Z\s\-'\.]+$");
  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_\-\.]+$');

  // Dangerous patterns to sanitize
  static final RegExp _scriptTagRegex =
      RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false);
  static final RegExp _htmlTagRegex = RegExp(r'<[^>]*>');
  static final RegExp _sqlInjectionRegex = RegExp(
    r'(\b(SELECT|INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|EXEC|UNION|SCRIPT)\b)',
    caseSensitive: false,
  );

  // XSS patterns
  static final List<RegExp> _xssPatterns = [
    RegExp(r'javascript:', caseSensitive: false),
    RegExp(r'vbscript:', caseSensitive: false),
    RegExp(r'onload\s*=', caseSensitive: false),
    RegExp(r'onerror\s*=', caseSensitive: false),
    RegExp(r'onclick\s*=', caseSensitive: false),
    RegExp(r'onmouseover\s*=', caseSensitive: false),
  ];

  /// Validate email address
  static ValidationResult validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ValidationResult(false, 'Email is required');
    }

    if (email.length > 254) {
      return ValidationResult(false, 'Email is too long');
    }

    if (!_emailRegex.hasMatch(email)) {
      return ValidationResult(false, 'Please enter a valid email address');
    }

    return ValidationResult(true, null);
  }

  /// Validate password strength
  static ValidationResult validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ValidationResult(false, 'Password is required');
    }

    if (password.length < 8) {
      return ValidationResult(
          false, 'Password must be at least 8 characters long');
    }

    if (password.length > 128) {
      return ValidationResult(false, 'Password is too long');
    }

    // Check for at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return ValidationResult(
          false, 'Password must contain at least one uppercase letter');
    }

    // Check for at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return ValidationResult(
          false, 'Password must contain at least one lowercase letter');
    }

    // Check for at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return ValidationResult(
          false, 'Password must contain at least one number');
    }

    // Check for at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return ValidationResult(
          false, 'Password must contain at least one special character');
    }

    return ValidationResult(true, null);
  }

  /// Validate phone number
  static ValidationResult validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return ValidationResult(false, 'Phone number is required');
    }

    if (!_phoneRegex.hasMatch(phone)) {
      return ValidationResult(false, 'Please enter a valid phone number');
    }

    return ValidationResult(true, null);
  }

  /// Validate name (first name, last name, etc.)
  static ValidationResult validateName(String? name,
      {String fieldName = 'Name'}) {
    if (name == null || name.isEmpty) {
      return ValidationResult(false, '$fieldName is required');
    }

    if (name.length < 2) {
      return ValidationResult(
          false, '$fieldName must be at least 2 characters long');
    }

    if (name.length > 50) {
      return ValidationResult(false, '$fieldName is too long');
    }

    if (!_nameRegex.hasMatch(name)) {
      return ValidationResult(false, '$fieldName contains invalid characters');
    }

    return ValidationResult(true, null);
  }

  /// Validate username
  static ValidationResult validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return ValidationResult(false, 'Username is required');
    }

    if (username.length < 3) {
      return ValidationResult(
          false, 'Username must be at least 3 characters long');
    }

    if (username.length > 30) {
      return ValidationResult(false, 'Username is too long');
    }

    if (!_usernameRegex.hasMatch(username)) {
      return ValidationResult(false,
          'Username can only contain letters, numbers, dots, hyphens, and underscores');
    }

    return ValidationResult(true, null);
  }

  /// Validate recipe title
  static ValidationResult validateRecipeTitle(String? title) {
    if (title == null || title.isEmpty) {
      return ValidationResult(false, 'Recipe title is required');
    }

    if (title.length < 3) {
      return ValidationResult(
          false, 'Recipe title must be at least 3 characters long');
    }

    if (title.length > 100) {
      return ValidationResult(false, 'Recipe title is too long');
    }

    final sanitized = sanitizeInput(title);
    if (sanitized != title) {
      return ValidationResult(
          false, 'Recipe title contains invalid characters');
    }

    return ValidationResult(true, null);
  }

  /// Validate recipe description
  static ValidationResult validateRecipeDescription(String? description) {
    if (description == null || description.isEmpty) {
      return ValidationResult(false, 'Recipe description is required');
    }

    if (description.length < 10) {
      return ValidationResult(
          false, 'Recipe description must be at least 10 characters long');
    }

    if (description.length > 1000) {
      return ValidationResult(false, 'Recipe description is too long');
    }

    final sanitized = sanitizeInput(description);
    if (sanitized != description) {
      return ValidationResult(
          false, 'Recipe description contains invalid characters');
    }

    return ValidationResult(true, null);
  }

  /// Validate ingredient name
  static ValidationResult validateIngredient(String? ingredient) {
    if (ingredient == null || ingredient.isEmpty) {
      return ValidationResult(false, 'Ingredient name is required');
    }

    if (ingredient.length < 2) {
      return ValidationResult(
          false, 'Ingredient name must be at least 2 characters long');
    }

    if (ingredient.length > 50) {
      return ValidationResult(false, 'Ingredient name is too long');
    }

    final sanitized = sanitizeInput(ingredient);
    if (sanitized != ingredient) {
      return ValidationResult(
          false, 'Ingredient name contains invalid characters');
    }

    return ValidationResult(true, null);
  }

  /// Validate cooking time (in minutes)
  static ValidationResult validateCookingTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) {
      return ValidationResult(false, 'Cooking time is required');
    }

    final time = int.tryParse(timeStr);
    if (time == null) {
      return ValidationResult(false, 'Please enter a valid number');
    }

    if (time < 1) {
      return ValidationResult(false, 'Cooking time must be at least 1 minute');
    }

    if (time > 1440) {
      // 24 hours
      return ValidationResult(false, 'Cooking time cannot exceed 24 hours');
    }

    return ValidationResult(true, null);
  }

  /// Validate servings count
  static ValidationResult validateServings(String? servingsStr) {
    if (servingsStr == null || servingsStr.isEmpty) {
      return ValidationResult(false, 'Number of servings is required');
    }

    final servings = int.tryParse(servingsStr);
    if (servings == null) {
      return ValidationResult(false, 'Please enter a valid number');
    }

    if (servings < 1) {
      return ValidationResult(false, 'Number of servings must be at least 1');
    }

    if (servings > 100) {
      return ValidationResult(false, 'Number of servings cannot exceed 100');
    }

    return ValidationResult(true, null);
  }

  /// Validate API key format
  static ValidationResult validateApiKey(String? apiKey, String service) {
    if (apiKey == null || apiKey.isEmpty) {
      return ValidationResult(false, 'API key is required');
    }

    if (apiKey.length < 10) {
      return ValidationResult(false, 'API key is too short');
    }

    if (apiKey.length > 200) {
      return ValidationResult(false, 'API key is too long');
    }

    // Service-specific validation
    switch (service.toLowerCase()) {
      case 'openai':
        if (!apiKey.startsWith('sk-')) {
          return ValidationResult(
              false, 'OpenAI API key must start with "sk-"');
        }
        break;
      case 'huggingface':
        if (!apiKey.startsWith('hf_')) {
          return ValidationResult(
              false, 'Hugging Face API key must start with "hf_"');
        }
        break;
    }

    // Check for suspicious patterns
    if (containsSuspiciousPatterns(apiKey)) {
      return ValidationResult(false, 'API key contains invalid characters');
    }

    return ValidationResult(true, null);
  }

  /// Sanitize input by removing dangerous content
  static String sanitizeInput(String input) {
    if (input.isEmpty) return input;

    String sanitized = input;

    // Remove script tags
    sanitized = sanitized.replaceAll(_scriptTagRegex, '');

    // Remove HTML tags
    sanitized = sanitized.replaceAll(_htmlTagRegex, '');

    // Remove XSS patterns
    for (final pattern in _xssPatterns) {
      sanitized = sanitized.replaceAll(pattern, '');
    }

    // Remove SQL injection patterns
    sanitized = sanitized.replaceAll(_sqlInjectionRegex, '');

    // Encode special characters
    sanitized = _encodeSpecialCharacters(sanitized);

    // Trim whitespace
    sanitized = sanitized.trim();

    return sanitized;
  }

  /// Check for suspicious patterns that might indicate malicious input
  static bool containsSuspiciousPatterns(String input) {
    // Check for script tags
    if (_scriptTagRegex.hasMatch(input)) return true;

    // Check for XSS patterns
    for (final pattern in _xssPatterns) {
      if (pattern.hasMatch(input)) return true;
    }

    // Check for SQL injection patterns
    if (_sqlInjectionRegex.hasMatch(input)) return true;

    // Check for excessive special characters (potential encoding attack)
    final specialCharCount =
        input.replaceAll(RegExp(r'[a-zA-Z0-9\s]'), '').length;
    if (specialCharCount > input.length * 0.3) return true;

    return false;
  }

  /// Validate JSON input
  static ValidationResult validateJson(String? jsonStr) {
    if (jsonStr == null || jsonStr.isEmpty) {
      return ValidationResult(false, 'JSON data is required');
    }

    try {
      jsonDecode(jsonStr);
      return ValidationResult(true, null);
    } catch (e) {
      return ValidationResult(false, 'Invalid JSON format');
    }
  }

  /// Validate URL
  static ValidationResult validateUrl(String? url) {
    if (url == null || url.isEmpty) {
      return ValidationResult(false, 'URL is required');
    }

    try {
      final uri = Uri.parse(url);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return ValidationResult(
            false, 'URL must start with http:// or https://');
      }
      return ValidationResult(true, null);
    } catch (e) {
      return ValidationResult(false, 'Please enter a valid URL');
    }
  }

  /// Encode special characters to prevent XSS
  static String _encodeSpecialCharacters(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }

  /// Validate file upload
  static ValidationResult validateFileUpload(
      String? fileName, int? fileSize, List<String> allowedExtensions) {
    if (fileName == null || fileName.isEmpty) {
      return ValidationResult(false, 'File name is required');
    }

    if (fileSize == null || fileSize <= 0) {
      return ValidationResult(false, 'Invalid file size');
    }

    // Check file size (max 10MB)
    if (fileSize > 10 * 1024 * 1024) {
      return ValidationResult(false, 'File size cannot exceed 10MB');
    }

    // Check file extension
    final extension = fileName.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return ValidationResult(false,
          'File type not allowed. Allowed types: ${allowedExtensions.join(', ')}');
    }

    // Check for suspicious file names
    if (containsSuspiciousPatterns(fileName)) {
      return ValidationResult(false, 'File name contains invalid characters');
    }

    return ValidationResult(true, null);
  }

  /// Rate limiting validation
  static bool isRateLimited(
      String identifier, int maxRequests, Duration timeWindow) {
    final now = DateTime.now();
    final key = '${identifier}_${timeWindow.inMinutes}';

    // This would typically use a more sophisticated rate limiting mechanism
    // For now, we'll use a simple in-memory approach
    _rateLimitData[key] ??= <DateTime>[];

    // Remove old entries
    _rateLimitData[key]!
        .removeWhere((time) => now.difference(time) > timeWindow);

    // Check if limit exceeded
    if (_rateLimitData[key]!.length >= maxRequests) {
      return true;
    }

    // Add current request
    _rateLimitData[key]!.add(now);
    return false;
  }

  static final Map<String, List<DateTime>> _rateLimitData = {};
}

/// Validation result class
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  ValidationResult(this.isValid, this.errorMessage);

  @override
  String toString() => isValid ? 'Valid' : 'Invalid: $errorMessage';
}

/// Input sanitization utilities
class InputSanitizer {
  /// Remove all HTML tags
  static String stripHtml(String input) {
    return input.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  /// Escape HTML entities
  static String escapeHtml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  /// Clean text for safe display
  static String cleanText(String input) {
    return InputValidator.sanitizeInput(input);
  }

  /// Sanitize for database storage
  static String sanitizeForDatabase(String input) {
    return input
        .replaceAll("'", "''") // Escape single quotes
        .replaceAll(';', '') // Remove semicolons
        .trim();
  }
}
