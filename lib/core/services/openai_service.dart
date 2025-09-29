import 'package:dio/dio.dart';
import '../config/environment.dart';
import '../errors/app_exceptions.dart';

class OpenAIService {
  static final OpenAIService _instance = OpenAIService._internal();
  factory OpenAIService() => _instance;
  OpenAIService._internal();

  late final Dio _dio;
  bool _initialized = false;

  void initialize() {
    if (_initialized) return;

    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.openai.com/v1',
      headers: {
        'Authorization': 'Bearer ${EnvironmentConfig.openAIApiKey}',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    ));

    _initialized = true;
  }

  Future<String> generateRecipe({
    required List<String> ingredients,
    String? cuisineType,
    String? mealType,
    int servings = 4,
  }) async {
    if (!_initialized) initialize();

    try {
      final prompt = _buildRecipePrompt(
        ingredients: ingredients,
        cuisineType: cuisineType,
        mealType: mealType,
        servings: servings,
      );

      final response = await _dio.post('/chat/completions', data: {
        'model': 'gpt-4',
        'messages': [
          const {
            'role': 'system',
            'content': 'You are a professional chef and recipe creator.'
          },
          {'role': 'user', 'content': prompt}
        ],
        'temperature': 0.7,
        'max_tokens': 2000,
      });

      return response.data['choices'][0]['message']['content'];
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  String _buildRecipePrompt({
    required List<String> ingredients,
    String? cuisineType,
    String? mealType,
    required int servings,
  }) {
    final buffer = StringBuffer();
    buffer.writeln(
        'Create a detailed recipe using these ingredients: ${ingredients.join(", ")}');

    if (cuisineType != null) {
      buffer.writeln('Cuisine style: $cuisineType');
    }

    if (mealType != null) {
      buffer.writeln('Meal type: $mealType');
    }

    buffer.writeln('Servings: $servings');
    buffer.writeln();
    buffer.writeln(
        'Format as JSON with: title, description, ingredients, instructions, prepTime, cookTime, difficulty, nutrition');

    return buffer.toString();
  }

  AppException _handleDioException(DioException e) {
    switch (e.response?.statusCode) {
      case 400:
        return const ValidationException('Invalid request to OpenAI API');
      case 401:
        return const AuthenticationException('Invalid OpenAI API key');
      case 429:
        return const RateLimitException('OpenAI API rate limit exceeded');
      case 500:
        return const ServerException('OpenAI server error');
      default:
        return NetworkException('Network error: ${e.message}');
    }
  }
}
