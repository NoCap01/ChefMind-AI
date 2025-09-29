import '../domain/entities/user_profile.dart';
import '../domain/enums/skill_level.dart';
import '../domain/enums/dietary_restriction.dart';
import '../infrastructure/storage/hive_user_profile_storage.dart';
import '../core/errors/app_exceptions.dart';

/// Service for managing user profiles with local storage
class UserProfileService {
  final HiveUserProfileStorage _storage;

  UserProfileService({HiveUserProfileStorage? storage})
      : _storage = storage ?? HiveUserProfileStorage();

  /// Initialize the service
  Future<void> initialize() async {
    await _storage.initialize();
  }

  /// Create a new user profile
  Future<UserProfile> createUserProfile({
    required String userId,
    required String email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    SkillLevel skillLevel = SkillLevel.beginner,
    List<DietaryRestriction> dietaryRestrictions = const [],
    List<String> allergies = const [],
    List<String> favoriteIngredients = const [],
    List<String> dislikedIngredients = const [],
    List<String> kitchenEquipment = const [],
    CookingPreferences? preferences,
    NutritionalGoals? nutritionalGoals,
  }) async {
    try {
      final profile = UserProfile(
        userId: userId,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
        skillLevel: skillLevel,
        dietaryRestrictions: dietaryRestrictions,
        allergies: allergies,
        favoriteIngredients: favoriteIngredients,
        dislikedIngredients: dislikedIngredients,
        kitchenEquipment: kitchenEquipment,
        preferences: preferences ?? const CookingPreferences(),
        nutritionalGoals: nutritionalGoals ?? const NutritionalGoals(),
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
        isEmailVerified: false,
        isPremiumUser: false,
      );

      final success = await _storage.saveUserProfile(profile);
      if (!success) {
        throw const ServiceException('Failed to create user profile');
      }

      return profile;
    } catch (e) {
      throw ServiceException('Failed to create user profile: $e');
    }
  }

  /// Get user profile by ID
  Future<UserProfile?> getUserProfile(String userId) async {
    try {
      return await _storage.getUserProfile(userId);
    } catch (e) {
      throw ServiceException('Failed to get user profile: $e');
    }
  }

  /// Update user profile
  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    try {
      final success = await _storage.saveUserProfile(profile);
      if (!success) {
        throw const ServiceException('Failed to update user profile');
      }
      return profile;
    } catch (e) {
      throw ServiceException('Failed to update user profile: $e');
    }
  }

  /// Update basic profile information
  Future<UserProfile> updateBasicInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(
        displayName: displayName,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
      );

      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update basic info: $e');
    }
  }

  /// Update skill level
  Future<UserProfile> updateSkillLevel(
      String userId, SkillLevel skillLevel) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(skillLevel: skillLevel);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update skill level: $e');
    }
  }

  /// Update dietary restrictions
  Future<UserProfile> updateDietaryRestrictions(
      String userId, List<DietaryRestriction> restrictions) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile =
          profile.copyWith(dietaryRestrictions: restrictions);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update dietary restrictions: $e');
    }
  }

  /// Update allergies
  Future<UserProfile> updateAllergies(
      String userId, List<String> allergies) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(allergies: allergies);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update allergies: $e');
    }
  }

  /// Update favorite ingredients
  Future<UserProfile> updateFavoriteIngredients(
      String userId, List<String> ingredients) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(favoriteIngredients: ingredients);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update favorite ingredients: $e');
    }
  }

  /// Update disliked ingredients
  Future<UserProfile> updateDislikedIngredients(
      String userId, List<String> ingredients) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(dislikedIngredients: ingredients);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update disliked ingredients: $e');
    }
  }

  /// Update kitchen equipment
  Future<UserProfile> updateKitchenEquipment(
      String userId, List<String> equipment) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(kitchenEquipment: equipment);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update kitchen equipment: $e');
    }
  }

  /// Update cooking preferences
  Future<UserProfile> updateCookingPreferences(
      String userId, CookingPreferences preferences) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(preferences: preferences);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update cooking preferences: $e');
    }
  }

  /// Update nutritional goals
  Future<UserProfile> updateNutritionalGoals(
      String userId, NutritionalGoals goals) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final updatedProfile = profile.copyWith(nutritionalGoals: goals);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to update nutritional goals: $e');
    }
  }

  /// Add favorite recipe
  Future<UserProfile> addFavoriteRecipe(String userId, String recipeId) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final favorites = List<String>.from(profile.favoriteRecipes);
      if (!favorites.contains(recipeId)) {
        favorites.add(recipeId);
        final updatedProfile = profile.copyWith(favoriteRecipes: favorites);
        return await updateUserProfile(updatedProfile);
      }

      return profile;
    } catch (e) {
      throw ServiceException('Failed to add favorite recipe: $e');
    }
  }

  /// Remove favorite recipe
  Future<UserProfile> removeFavoriteRecipe(
      String userId, String recipeId) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final favorites = List<String>.from(profile.favoriteRecipes);
      favorites.remove(recipeId);
      final updatedProfile = profile.copyWith(favoriteRecipes: favorites);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to remove favorite recipe: $e');
    }
  }

  /// Toggle favorite recipe
  Future<UserProfile> toggleFavoriteRecipe(
      String userId, String recipeId) async {
    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const ServiceException('User profile not found');
      }

      final favorites = List<String>.from(profile.favoriteRecipes);
      if (favorites.contains(recipeId)) {
        favorites.remove(recipeId);
      } else {
        favorites.add(recipeId);
      }

      final updatedProfile = profile.copyWith(favoriteRecipes: favorites);
      return await updateUserProfile(updatedProfile);
    } catch (e) {
      throw ServiceException('Failed to toggle favorite recipe: $e');
    }
  }

  /// Check if recipe is favorite
  Future<bool> isRecipeFavorite(String userId, String recipeId) async {
    try {
      final profile = await getUserProfile(userId);
      return profile?.favoriteRecipes.contains(recipeId) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Get user's favorite recipes
  Future<List<String>> getFavoriteRecipes(String userId) async {
    try {
      final profile = await getUserProfile(userId);
      return profile?.favoriteRecipes ?? [];
    } catch (e) {
      return [];
    }
  }

  /// Delete user profile
  Future<bool> deleteUserProfile(String userId) async {
    try {
      return await _storage.deleteUserProfile(userId);
    } catch (e) {
      throw ServiceException('Failed to delete user profile: $e');
    }
  }

  /// Check if user profile exists
  Future<bool> userProfileExists(String userId) async {
    try {
      return await _storage.userProfileExists(userId);
    } catch (e) {
      return false;
    }
  }

  /// Export user profile data
  Future<Map<String, dynamic>?> exportUserProfile(String userId) async {
    try {
      return await _storage.exportUserProfile(userId);
    } catch (e) {
      throw ServiceException('Failed to export user profile: $e');
    }
  }

  /// Import user profile data
  Future<bool> importUserProfile(Map<String, dynamic> profileData) async {
    try {
      return await _storage.importUserProfile(profileData);
    } catch (e) {
      throw ServiceException('Failed to import user profile: $e');
    }
  }

  /// Get recommended recipes based on user preferences
  List<String> getRecommendedIngredients(UserProfile profile) {
    final recommendations = <String>[];

    // Add favorite ingredients
    recommendations.addAll(profile.favoriteIngredients);

    // Add skill-level appropriate ingredients
    switch (profile.skillLevel) {
      case SkillLevel.novice:
      case SkillLevel.beginner:
        recommendations
            .addAll(['chicken breast', 'pasta', 'rice', 'eggs', 'onion']);
        break;
      case SkillLevel.intermediate:
        recommendations.addAll(
            ['salmon', 'quinoa', 'mushrooms', 'bell peppers', 'garlic']);
        break;
      case SkillLevel.advanced:
      case SkillLevel.professional:
        recommendations.addAll(
            ['duck breast', 'truffle oil', 'saffron', 'lamb', 'exotic spices']);
        break;
    }

    // Add dietary restriction appropriate ingredients
    for (final restriction in profile.dietaryRestrictions) {
      switch (restriction) {
        case DietaryRestriction.vegetarian:
          recommendations.addAll(['tofu', 'beans', 'lentils', 'vegetables']);
          break;
        case DietaryRestriction.vegan:
          recommendations
              .addAll(['nutritional yeast', 'cashews', 'coconut milk']);
          break;
        case DietaryRestriction.glutenFree:
          recommendations
              .addAll(['rice flour', 'almond flour', 'gluten-free pasta']);
          break;
        case DietaryRestriction.keto:
          recommendations.addAll(['avocado', 'cheese', 'nuts', 'olive oil']);
          break;
        default:
          break;
      }
    }

    // Remove disliked ingredients
    recommendations.removeWhere(
        (ingredient) => profile.dislikedIngredients.contains(ingredient));

    // Remove duplicates and return
    return recommendations.toSet().toList();
  }

  /// Get cooking tips based on user skill level
  List<String> getCookingTips(SkillLevel skillLevel) {
    switch (skillLevel) {
      case SkillLevel.novice:
        return [
          'Start with simple recipes with few ingredients',
          'Read the entire recipe before starting',
          'Prep all ingredients before cooking',
          'Use a timer for everything',
          'Taste as you go',
        ];
      case SkillLevel.beginner:
        return [
          'Learn basic knife skills for efficiency',
          'Understand different cooking methods',
          'Season in layers throughout cooking',
          'Keep a cooking journal of what works',
          'Practice mise en place',
        ];
      case SkillLevel.intermediate:
        return [
          'Experiment with flavor combinations',
          'Learn to cook without strict measurements',
          'Master temperature control',
          'Try cooking techniques from different cuisines',
          'Focus on presentation skills',
        ];
      case SkillLevel.advanced:
        return [
          'Create your own recipe variations',
          'Master advanced techniques like sous vide',
          'Understand food science principles',
          'Experiment with molecular gastronomy',
          'Develop your signature dishes',
        ];
      case SkillLevel.professional:
        return [
          'Focus on consistency and speed',
          'Develop cost-effective menu items',
          'Master large-batch cooking',
          'Stay updated with culinary trends',
          'Mentor others in cooking techniques',
        ];
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _storage.dispose();
  }
}
