import '../../domain/entities/recipe.dart';

class OpenAIParsers {
  static String parseExplanationResponse(String response) {
    // Extract explanation from response
    return response.trim();
  }

  static Recipe parseRecipeResponse(String response) {
    // Parse JSON response to Recipe object
    try {
      // Add your JSON parsing logic here
      // This is a simplified version
      return Recipe.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to parse recipe response: $e');
    }
  }

  static bool parseValidationResponse(String response) {
    // Parse validation response
    return response.toLowerCase().contains('valid');
  }

  static String parseComplexityResponse(String response) {
    // Parse complexity analysis
    return response.trim();
  }

  static List<String> parseIssuesResponse(String response) {
    // Parse issues list
    return response
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();
  }
}
