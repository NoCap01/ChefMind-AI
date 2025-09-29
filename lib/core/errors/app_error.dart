/// Base class for all application errors
abstract class AppError implements Exception {
  const AppError({
    required this.message,
    required this.code,
    this.details,
    this.stackTrace,
  });

  final String message;
  final String code;
  final String? details;
  final StackTrace? stackTrace;

  /// User-friendly message to display to the user
  String get userMessage => message;

  /// Whether this error should be retried
  bool get isRetryable => false;

  /// Whether this error should be logged
  bool get shouldLog => true;

  /// Error severity level
  ErrorSeverity get severity => ErrorSeverity.error;

  @override
  String toString() => 'AppError($code): $message';
}

/// Error severity levels
enum ErrorSeverity {
  info,
  warning,
  error,
  critical,
}

/// Network-related errors
class NetworkError extends AppError {
  const NetworkError({
    required super.message,
    required super.code,
    super.details,
    super.stackTrace,
    this.statusCode,
  });

  final int? statusCode;

  @override
  bool get isRetryable => true;

  @override
  String get userMessage {
    switch (code) {
      case 'connection_timeout':
        return 'Connection timed out. Please check your internet connection and try again.';
      case 'no_internet':
        return 'No internet connection. Please check your network settings.';
      case 'server_error':
        return 'Server is temporarily unavailable. Please try again later.';
      default:
        return 'Network error occurred. Please try again.';
    }
  }
}

/// API-related errors
class ApiError extends AppError {
  const ApiError({
    required super.message,
    required super.code,
    super.details,
    super.stackTrace,
    this.statusCode,
    this.endpoint,
  });

  final int? statusCode;
  final String? endpoint;

  @override
  bool get isRetryable {
    if (statusCode == null) return false;
    return statusCode! >= 500 || statusCode == 429; // Server errors and rate limits
  }

  @override
  String get userMessage {
    switch (code) {
      case 'rate_limit_exceeded':
        return 'Too many requests. Please wait a moment and try again.';
      case 'api_key_invalid':
        return 'API configuration error. Please check your settings.';
      case 'service_unavailable':
        return 'AI service is temporarily unavailable. Trying alternative service...';
      case 'quota_exceeded':
        return 'API quota exceeded. Please try again later or check your subscription.';
      default:
        return 'Service error occurred. Please try again.';
    }
  }
}

/// Validation errors
class ValidationError extends AppError {
  const ValidationError({
    required super.message,
    required super.code,
    super.details,
    super.stackTrace,
    this.field,
  });

  final String? field;

  @override
  bool get isRetryable => false;

  @override
  ErrorSeverity get severity => ErrorSeverity.warning;

  @override
  String get userMessage {
    switch (code) {
      case 'required_field':
        return field != null ? '$field is required' : 'Required field is missing';
      case 'invalid_format':
        return field != null ? 'Invalid $field format' : 'Invalid input format';
      case 'value_too_long':
        return field != null ? '$field is too long' : 'Input is too long';
      case 'value_too_short':
        return field != null ? '$field is too short' : 'Input is too short';
      default:
        return message;
    }
  }
}

/// Storage-related errors
class StorageError extends AppError {
  const StorageError({
    required super.message,
    required super.code,
    super.details,
    super.stackTrace,
  });

  @override
  bool get isRetryable => code != 'insufficient_space';

  @override
  String get userMessage {
    switch (code) {
      case 'insufficient_space':
        return 'Not enough storage space. Please free up some space and try again.';
      case 'database_error':
        return 'Database error occurred. Please restart the app and try again.';
      case 'file_not_found':
        return 'Required file not found. Please try again.';
      default:
        return 'Storage error occurred. Please try again.';
    }
  }
}

/// Parsing-related errors
class ParsingError extends AppError {
  const ParsingError({
    required super.message,
    required super.code,
    super.details,
    super.stackTrace,
  });

  @override
  bool get isRetryable => false;

  @override
  String get userMessage {
    switch (code) {
      case 'invalid_json':
        return 'Invalid data format received. Please try again.';
      case 'missing_required_field':
        return 'Incomplete data received. Please try again.';
      case 'invalid_recipe_format':
        return 'Recipe data is in an invalid format. Please try generating again.';
      default:
        return 'Data parsing error occurred. Please try again.';
    }
  }
}

/// Authentication errors
class AuthError extends AppError {
  const AuthError({
    required super.message,
    required super.code,
    super.details,
    super.stackTrace,
  });

  @override
  bool get isRetryable => false;

  @override
  String get userMessage {
    switch (code) {
      case 'unauthorized':
        return 'Authentication required. Please log in again.';
      case 'token_expired':
        return 'Session expired. Please log in again.';
      case 'invalid_credentials':
        return 'Invalid credentials. Please check your login information.';
      default:
        return 'Authentication error occurred. Please log in again.';
    }
  }
}

/// Unknown or unexpected errors
class UnknownError extends AppError {
  const UnknownError({
    required super.message,
    super.code = 'unknown_error',
    super.details,
    super.stackTrace,
  });

  @override
  bool get isRetryable => true;

  @override
  ErrorSeverity get severity => ErrorSeverity.critical;

  @override
  String get userMessage => 'An unexpected error occurred. Please try again.';
}