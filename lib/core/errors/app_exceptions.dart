class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  const AppException(this.message, {this.code, this.originalException});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException(super.message) : super(code: 'network_error');
}

class AuthenticationException extends AppException {
  const AuthenticationException(super.message) : super(code: 'auth_error');
}

class ValidationException extends AppException {
  const ValidationException(super.message) : super(code: 'validation_error');
}

class ServerException extends AppException {
  const ServerException(super.message) : super(code: 'server_error');
}

class DatabaseException extends AppException {
  const DatabaseException(super.message) : super(code: 'database_error');
}

class CacheException extends AppException {
  const CacheException(super.message) : super(code: 'cache_error');
}

class PermissionException extends AppException {
  const PermissionException(super.message) : super(code: 'permission_error');
}

class NotFoundException extends AppException {
  const NotFoundException(super.message) : super(code: 'not_found');
}

class ConflictException extends AppException {
  const ConflictException(super.message) : super(code: 'conflict_error');
}

class RateLimitException extends AppException {
  const RateLimitException(super.message) : super(code: 'rate_limit');
}

class UnknownException extends AppException {
  const UnknownException(super.message) : super(code: 'unknown_error');
}

// OpenAI specific exceptions
class OpenAIException extends AppException {
  const OpenAIException(super.message) : super(code: 'openai_error');
}

class RecipeGenerationException extends AppException {
  const RecipeGenerationException(super.message)
      : super(code: 'recipe_generation_error');
}

class StorageException extends AppException {
  const StorageException(super.message) : super(code: 'storage_error');
}

class ServiceException extends AppException {
  const ServiceException(super.message) : super(code: 'service_error');
}
