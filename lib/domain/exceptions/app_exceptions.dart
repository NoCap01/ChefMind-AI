// Base exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;
  final StackTrace? stackTrace;

  const AppException(
    this.message, {
    this.code,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message';
}

// Network and connectivity exceptions
class NetworkException extends AppException {
  const NetworkException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class TimeoutException extends NetworkException {
  const TimeoutException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class NoInternetException extends NetworkException {
  const NoInternetException()
      : super('No internet connection available');
}

// Authentication exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class UnauthorizedException extends AuthenticationException {
  const UnauthorizedException()
      : super('User is not authorized to perform this action');
}

class InvalidCredentialsException extends AuthenticationException {
  const InvalidCredentialsException()
      : super('Invalid email or password');
}

class UserNotSignedInException extends AuthenticationException {
  const UserNotSignedInException()
      : super('User must be signed in to perform this action');
}

// Database and storage exceptions
class DatabaseException extends AppException {
  const DatabaseException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class NotFoundException extends DatabaseException {
  const NotFoundException(String resource)
      : super('$resource not found');
}

class ConflictException extends DatabaseException {
  const ConflictException(String message)
      : super('Conflict: $message');
}

class PermissionException extends DatabaseException {
  const PermissionException(String message)
      : super('Permission denied: $message');
}

// Recipe generation exceptions
class RecipeGenerationException extends AppException {
  const RecipeGenerationException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class InvalidIngredientsException extends RecipeGenerationException {
  const InvalidIngredientsException(String message)
      : super('Invalid ingredients: $message');
}

class RecipeValidationException extends RecipeGenerationException {
  const RecipeValidationException(String message)
      : super('Recipe validation failed: $message');
}

class AIServiceException extends RecipeGenerationException {
  const AIServiceException(String message)
      : super('AI service error: $message');
}

class RateLimitException extends RecipeGenerationException {
  const RateLimitException()
      : super('API rate limit exceeded. Please try again later.');
}

// Validation exceptions
class ValidationException extends AppException {
  final Map<String, List<String>> fieldErrors;

  const ValidationException(
    String message,
    this.fieldErrors, {
    String? code,
  }) : super(message, code: code);

  bool hasFieldError(String field) => fieldErrors.containsKey(field);
  
  List<String> getFieldErrors(String field) => fieldErrors[field] ?? [];
  
  List<String> get allErrors => fieldErrors.values.expand((e) => e).toList();
}

class RequiredFieldException extends ValidationException {
  const RequiredFieldException(String field)
      : super(
          'Required field missing: $field',
          {field: ['This field is required']},
        );
}

class InvalidFormatException extends ValidationException {
  const InvalidFormatException(String field, String expectedFormat)
      : super(
          'Invalid format for $field. Expected: $expectedFormat',
          {field: ['Invalid format. Expected: $expectedFormat']},
        );
}

// Business logic exceptions
class BusinessLogicException extends AppException {
  const BusinessLogicException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class InsufficientIngredientsException extends BusinessLogicException {
  const InsufficientIngredientsException(String ingredient)
      : super('Insufficient quantity of $ingredient in pantry');
}

class DietaryRestrictionViolationException extends BusinessLogicException {
  const DietaryRestrictionViolationException(String restriction)
      : super('Recipe violates dietary restriction: $restriction');
}

class AllergenException extends BusinessLogicException {
  const AllergenException(String allergen)
      : super('Recipe contains allergen: $allergen');
}

// Cache and storage exceptions
class CacheException extends AppException {
  const CacheException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class StorageException extends AppException {
  const StorageException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class StorageQuotaExceededException extends StorageException {
  const StorageQuotaExceededException()
      : super('Storage quota exceeded');
}

// File and media exceptions
class FileException extends AppException {
  const FileException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

class FileNotSupportedException extends FileException {
  const FileNotSupportedException(String fileType)
      : super('File type not supported: $fileType');
}

class FileTooLargeException extends FileException {
  const FileTooLargeException(int maxSizeBytes)
      : super('File size exceeds maximum allowed size: ${maxSizeBytes}bytes');
}

// Analytics exceptions
class AnalyticsException extends AppException {
  const AnalyticsException(
    String message, {
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
          message,
          code: code,
          originalException: originalException,
          stackTrace: stackTrace,
        );
}

// Unknown or generic exceptions
class UnknownException extends AppException {
  const UnknownException([String? message])
      : super(message ?? 'An unknown error occurred');
}

class ServerException extends AppException {
  const ServerException([String? message])
      : super(message ?? 'Server error occurred');
}

// Exception factory for creating exceptions from error codes
class ExceptionFactory {
  static AppException fromCode(String code, [String? message]) {
    switch (code) {
      case 'network_error':
        return NetworkException(message ?? 'Network error occurred');
      case 'timeout':
        return TimeoutException(message ?? 'Request timed out');
      case 'no_internet':
        return const NoInternetException();
      case 'unauthorized':
        return const UnauthorizedException();
      case 'invalid_credentials':
        return const InvalidCredentialsException();
      case 'not_found':
        return NotFoundException(message ?? 'Resource');
      case 'permission_denied':
        return PermissionException(message ?? 'Access denied');
      case 'rate_limit':
        return const RateLimitException();
      case 'validation_error':
        return ValidationException(message ?? 'Validation failed', {});
      case 'server_error':
        return ServerException(message);
      default:
        return UnknownException(message);
    }
  }
}

// Exception handler utility
class ExceptionHandler {
  static String getDisplayMessage(AppException exception) {
    switch (exception.runtimeType) {
      case NoInternetException:
        return 'Please check your internet connection and try again.';
      case TimeoutException:
        return 'Request timed out. Please try again.';
      case UnauthorizedException:
        return 'You are not authorized to perform this action.';
      case InvalidCredentialsException:
        return 'Invalid email or password. Please try again.';
      case RateLimitException:
        return 'Too many requests. Please wait a moment and try again.';
      case ValidationException:
        final validationEx = exception as ValidationException;
        return validationEx.allErrors.join('\n');
      default:
        return exception.message;
    }
  }

  static bool shouldRetry(AppException exception) {
    return exception is NetworkException ||
           exception is TimeoutException ||
           exception is ServerException;
  }

  static bool requiresAuthentication(AppException exception) {
    return exception is AuthenticationException;
  }
}