class ApiConstants {
  // OpenAI Endpoints
  static const String openAIChatCompletions = '/chat/completions';
  static const String openAIModels = '/models';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String recipesCollection = 'recipes';
  static const String pantryCollection = 'pantry';
  static const String mealPlansCollection = 'meal_plans';
  static const String communityRecipesCollection = 'community_recipes';
  static const String cookingGroupsCollection = 'cooking_groups';
  static const String challengesCollection = 'challenges';

  // HTTP Headers
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';

  // HTTP Status Codes
  static const int statusOK = 200;
  static const int statusCreated = 201;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusTooManyRequests = 429;
  static const int statusInternalServerError = 500;

  // Cache Keys
  static const String userProfileCacheKey = 'user_profile';
  static const String recipesCacheKey = 'cached_recipes';
  static const String pantryItemsCacheKey = 'pantry_items';
  static const String mealPlansCacheKey = 'meal_plans';
}
