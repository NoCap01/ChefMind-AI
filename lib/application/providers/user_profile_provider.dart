import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/enums/skill_level.dart';
import '../../domain/enums/dietary_restriction.dart';
import '../../services/user_profile_service.dart';
import 'auth_provider.dart';

// User profile service provider
final userProfileServiceProvider = Provider<UserProfileService>((ref) {
  return UserProfileService();
});

// User profile provider
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final authState = ref.watch(authStateProvider);
  final profileService = ref.watch(userProfileServiceProvider);
  
  if (authState is AuthStateAuthenticated) {
    try {
      await profileService.initialize();
      return await profileService.getUserProfile(authState.user.userId);
    } catch (e) {
      return null;
    }
  }
  
  return null;
});

// User profile notifier for updates
final userProfileNotifierProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  final profileService = ref.watch(userProfileServiceProvider);
  return UserProfileNotifier(profileService);
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final UserProfileService _profileService;

  UserProfileNotifier(this._profileService) : super(const AsyncValue.data(null));

  Future<void> initialize() async {
    try {
      await _profileService.initialize();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> createProfile({
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
    state = const AsyncValue.loading();
    
    try {
      final profile = await _profileService.createUserProfile(
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
        preferences: preferences,
        nutritionalGoals: nutritionalGoals,
      );
      state = AsyncValue.data(profile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateUserProfile(profile);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadProfile(String userId) async {
    state = const AsyncValue.loading();
    
    try {
      final profile = await _profileService.getUserProfile(userId);
      if (profile != null) {
        state = AsyncValue.data(profile);
      } else {
        // Create a default profile if none exists
        await createProfile(
          userId: userId,
          email: 'user@example.com',
          displayName: 'Chef User',
        );
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateBasicInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateBasicInfo(
        userId: userId,
        displayName: displayName,
        photoUrl: photoUrl,
        phoneNumber: phoneNumber,
      );
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateSkillLevel(String userId, SkillLevel skillLevel) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateSkillLevel(userId, skillLevel);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateDietaryRestrictions(String userId, List<DietaryRestriction> restrictions) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateDietaryRestrictions(userId, restrictions);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateAllergies(String userId, List<String> allergies) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateAllergies(userId, allergies);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateFavoriteIngredients(String userId, List<String> ingredients) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateFavoriteIngredients(userId, ingredients);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateDislikedIngredients(String userId, List<String> ingredients) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateDislikedIngredients(userId, ingredients);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateKitchenEquipment(String userId, List<String> equipment) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateKitchenEquipment(userId, equipment);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateCookingPreferences(String userId, CookingPreferences preferences) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateCookingPreferences(userId, preferences);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateNutritionalGoals(String userId, NutritionalGoals goals) async {
    state = const AsyncValue.loading();
    
    try {
      final updatedProfile = await _profileService.updateNutritionalGoals(userId, goals);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> toggleFavoriteRecipe(String userId, String recipeId) async {
    try {
      final updatedProfile = await _profileService.toggleFavoriteRecipe(userId, recipeId);
      state = AsyncValue.data(updatedProfile);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteProfile(String userId) async {
    state = const AsyncValue.loading();
    
    try {
      await _profileService.deleteUserProfile(userId);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<Map<String, dynamic>?> exportProfile(String userId) async {
    try {
      return await _profileService.exportUserProfile(userId);
    } catch (e) {
      return null;
    }
  }

  Future<bool> importProfile(Map<String, dynamic> profileData) async {
    try {
      final success = await _profileService.importUserProfile(profileData);
      if (success) {
        // Reload the profile after import
        final profile = UserProfile.fromJson(profileData);
        state = AsyncValue.data(profile);
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}