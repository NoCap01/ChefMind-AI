import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/enums/skill_level.dart';
import '../../domain/enums/dietary_restriction.dart';
import '../../core/errors/app_exceptions.dart';

/// Hive-based user profile storage service with proper error handling and data validation
class HiveUserProfileStorage {
  static const String _profilesBoxName = 'user_profiles';
  static const String _settingsBoxName = 'user_settings';
  static const String _statisticsBoxName = 'user_statistics';

  static final HiveUserProfileStorage _instance =
      HiveUserProfileStorage._internal();
  factory HiveUserProfileStorage() => _instance;
  HiveUserProfileStorage._internal();

  Box<UserProfile>? _profilesBox;
  Box<Map<String, dynamic>>? _settingsBox;
  Box<Map<String, dynamic>>? _statisticsBox;

  bool _initialized = false;

  /// Initialize Hive storage with adapters and boxes
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(20)) {
        Hive.registerAdapter(UserProfileAdapter());
      }
      if (!Hive.isAdapterRegistered(21)) {
        Hive.registerAdapter(CookingPreferencesAdapter());
      }
      if (!Hive.isAdapterRegistered(22)) {
        Hive.registerAdapter(NutritionalGoalsAdapter());
      }
      if (!Hive.isAdapterRegistered(23)) {
        Hive.registerAdapter(SkillLevelAdapter());
      }
      if (!Hive.isAdapterRegistered(24)) {
        Hive.registerAdapter(DietaryRestrictionAdapter());
      }

      // Open boxes
      _profilesBox = await Hive.openBox<UserProfile>(_profilesBoxName);
      _settingsBox = await Hive.openBox<Map<String, dynamic>>(_settingsBoxName);
      _statisticsBox =
          await Hive.openBox<Map<String, dynamic>>(_statisticsBoxName);

      _initialized = true;

      // Perform data migration if needed
      await _performDataMigration();
    } catch (e) {
      throw StorageException('Failed to initialize user profile storage: $e');
    }
  }

  /// Perform data migration from older versions
  Future<void> _performDataMigration() async {
    try {
      // Check if migration is needed by looking for version key in settings box
      final versionData =
          _settingsBox!.get('_storage_version', defaultValue: {'version': 1})
              as Map<String, dynamic>;
      final currentVersion = versionData['version'] as int? ?? 1;
      const latestVersion = 2;

      if (currentVersion < latestVersion) {
        await _migrateToVersion2();
        await _settingsBox!.put('_storage_version', {'version': latestVersion});
      }
    } catch (e) {
      // Log migration error but don't fail initialization
      print('Migration warning: $e');
    }
  }

  /// Migrate to version 2 - add missing fields to existing profiles
  Future<void> _migrateToVersion2() async {
    final profiles = _profilesBox!.values
        .whereType<UserProfile>()
        .cast<UserProfile>()
        .toList();

    for (final profile in profiles) {
      // Update profiles that might be missing new fields
      final updatedProfile = profile.copyWith(
        lastActiveAt: profile.lastActiveAt ?? DateTime.now(),
        isEmailVerified: profile.isEmailVerified,
        isPremiumUser: profile.isPremiumUser,
      );

      if (updatedProfile != profile) {
        await _profilesBox!.put(profile.userId, updatedProfile);
      }
    }
  }

  void _ensureInitialized() {
    if (!_initialized) {
      throw const StorageException('HiveUserProfileStorage not initialized');
    }
  }

  /// Validate user profile data before storage
  bool _validateUserProfile(UserProfile profile) {
    if (profile.userId.isEmpty) return false;
    if (profile.email.trim().isEmpty) return false;
    return true;
  }

  /// Save a user profile to storage
  Future<bool> saveUserProfile(UserProfile profile) async {
    _ensureInitialized();

    if (!_validateUserProfile(profile)) {
      throw const ValidationException('Invalid user profile data');
    }

    try {
      // Update the lastActiveAt timestamp
      final updatedProfile = profile.copyWith(
        lastActiveAt: DateTime.now(),
      );

      await _profilesBox!.put(profile.userId, updatedProfile);
      return true;
    } catch (e) {
      throw StorageException('Failed to save user profile: $e');
    }
  }

  /// Get user profile by ID
  Future<UserProfile?> getUserProfile(String userId) async {
    _ensureInitialized();

    try {
      return _profilesBox!.get(userId);
    } catch (e) {
      throw StorageException('Failed to get user profile: $e');
    }
  }

  /// Delete user profile by ID
  Future<bool> deleteUserProfile(String userId) async {
    _ensureInitialized();

    try {
      await _profilesBox!.delete(userId);
      await _settingsBox!.delete(userId);
      await _statisticsBox!.delete(userId);
      return true;
    } catch (e) {
      throw StorageException('Failed to delete user profile: $e');
    }
  }

  /// Check if user profile exists
  Future<bool> userProfileExists(String userId) async {
    _ensureInitialized();
    return _profilesBox!.containsKey(userId);
  }

  /// Update user profile preferences
  Future<bool> updatePreferences(
      String userId, CookingPreferences preferences) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const StorageException('User profile not found');
      }

      final updatedProfile = profile.copyWith(preferences: preferences);
      return await saveUserProfile(updatedProfile);
    } catch (e) {
      throw StorageException('Failed to update preferences: $e');
    }
  }

  /// Update nutritional goals
  Future<bool> updateNutritionalGoals(
      String userId, NutritionalGoals goals) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const StorageException('User profile not found');
      }

      final updatedProfile = profile.copyWith(nutritionalGoals: goals);
      return await saveUserProfile(updatedProfile);
    } catch (e) {
      throw StorageException('Failed to update nutritional goals: $e');
    }
  }

  /// Update dietary restrictions
  Future<bool> updateDietaryRestrictions(
      String userId, List<DietaryRestriction> restrictions) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const StorageException('User profile not found');
      }

      final updatedProfile =
          profile.copyWith(dietaryRestrictions: restrictions);
      return await saveUserProfile(updatedProfile);
    } catch (e) {
      throw StorageException('Failed to update dietary restrictions: $e');
    }
  }

  /// Update skill level
  Future<bool> updateSkillLevel(String userId, SkillLevel skillLevel) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const StorageException('User profile not found');
      }

      final updatedProfile = profile.copyWith(skillLevel: skillLevel);
      return await saveUserProfile(updatedProfile);
    } catch (e) {
      throw StorageException('Failed to update skill level: $e');
    }
  }

  /// Add favorite recipe
  Future<bool> addFavoriteRecipe(String userId, String recipeId) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const StorageException('User profile not found');
      }

      final favorites = List<String>.from(profile.favoriteRecipes);
      if (!favorites.contains(recipeId)) {
        favorites.add(recipeId);
        final updatedProfile = profile.copyWith(favoriteRecipes: favorites);
        return await saveUserProfile(updatedProfile);
      }
      return true;
    } catch (e) {
      throw StorageException('Failed to add favorite recipe: $e');
    }
  }

  /// Remove favorite recipe
  Future<bool> removeFavoriteRecipe(String userId, String recipeId) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      if (profile == null) {
        throw const StorageException('User profile not found');
      }

      final favorites = List<String>.from(profile.favoriteRecipes);
      favorites.remove(recipeId);
      final updatedProfile = profile.copyWith(favoriteRecipes: favorites);
      return await saveUserProfile(updatedProfile);
    } catch (e) {
      throw StorageException('Failed to remove favorite recipe: $e');
    }
  }

  /// Save user settings
  Future<bool> saveUserSettings(
      String userId, Map<String, dynamic> settings) async {
    _ensureInitialized();

    try {
      await _settingsBox!.put(userId, settings);
      return true;
    } catch (e) {
      throw StorageException('Failed to save user settings: $e');
    }
  }

  /// Get user settings
  Future<Map<String, dynamic>> getUserSettings(String userId) async {
    _ensureInitialized();

    try {
      return _settingsBox!.get(userId, defaultValue: <String, dynamic>{}) ??
          <String, dynamic>{};
    } catch (e) {
      return <String, dynamic>{};
    }
  }

  /// Save user statistics
  Future<bool> saveUserStatistics(
      String userId, Map<String, dynamic> statistics) async {
    _ensureInitialized();

    try {
      await _statisticsBox!.put(userId, statistics);
      return true;
    } catch (e) {
      throw StorageException('Failed to save user statistics: $e');
    }
  }

  /// Get user statistics
  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    _ensureInitialized();

    try {
      return _statisticsBox!.get(userId, defaultValue: <String, dynamic>{}) ??
          <String, dynamic>{};
    } catch (e) {
      return <String, dynamic>{};
    }
  }

  /// Export user profile to JSON format
  Future<Map<String, dynamic>?> exportUserProfile(String userId) async {
    _ensureInitialized();

    try {
      final profile = await getUserProfile(userId);
      return profile?.toJson();
    } catch (e) {
      throw StorageException('Failed to export user profile: $e');
    }
  }

  /// Import user profile from JSON format
  Future<bool> importUserProfile(Map<String, dynamic> profileJson) async {
    _ensureInitialized();

    try {
      final profile = UserProfile.fromJson(profileJson);
      if (_validateUserProfile(profile)) {
        return await saveUserProfile(profile);
      }
      return false;
    } catch (e) {
      throw StorageException('Failed to import user profile: $e');
    }
  }

  /// Clear all user data
  Future<bool> clearAllData() async {
    _ensureInitialized();

    try {
      await _profilesBox!.clear();
      await _settingsBox!.clear();
      await _statisticsBox!.clear();
      return true;
    } catch (e) {
      throw StorageException('Failed to clear all data: $e');
    }
  }

  /// Get storage info
  Map<String, dynamic> getStorageInfo() {
    _ensureInitialized();

    return {
      'profilesCount': _profilesBox!.length,
      'settingsCount': _settingsBox!.length,
      'statisticsCount': _statisticsBox!.length,
      'isInitialized': _initialized,
    };
  }

  /// Close all boxes and cleanup
  Future<void> dispose() async {
    if (_initialized) {
      await _profilesBox?.close();
      await _settingsBox?.close();
      await _statisticsBox?.close();
      _initialized = false;
    }
  }
}

// Hive adapters for user profile entities
class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 20;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      userId: fields[0] as String,
      email: fields[1] as String,
      displayName: fields[2] as String?,
      photoUrl: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      skillLevel: fields[5] as SkillLevel,
      dietaryRestrictions: (fields[6] as List).cast<DietaryRestriction>(),
      allergies: (fields[7] as List).cast<String>(),
      favoriteIngredients: (fields[8] as List).cast<String>(),
      dislikedIngredients: (fields[9] as List).cast<String>(),
      kitchenEquipment: (fields[10] as List).cast<String>(),
      preferences: fields[11] as CookingPreferences,
      nutritionalGoals: fields[12] as NutritionalGoals,
      favoriteRecipes: (fields[13] as List?)?.cast<String>() ?? [],
      savedCollections: (fields[14] as List?)?.cast<String>() ?? [],
      createdAt: fields[15] as DateTime,
      lastActiveAt: fields[16] as DateTime?,
      isEmailVerified: fields[17] as bool? ?? false,
      isPremiumUser: fields[18] as bool? ?? false,
      settings: (fields[19] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.photoUrl)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.skillLevel)
      ..writeByte(6)
      ..write(obj.dietaryRestrictions)
      ..writeByte(7)
      ..write(obj.allergies)
      ..writeByte(8)
      ..write(obj.favoriteIngredients)
      ..writeByte(9)
      ..write(obj.dislikedIngredients)
      ..writeByte(10)
      ..write(obj.kitchenEquipment)
      ..writeByte(11)
      ..write(obj.preferences)
      ..writeByte(12)
      ..write(obj.nutritionalGoals)
      ..writeByte(13)
      ..write(obj.favoriteRecipes)
      ..writeByte(14)
      ..write(obj.savedCollections)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.lastActiveAt)
      ..writeByte(17)
      ..write(obj.isEmailVerified)
      ..writeByte(18)
      ..write(obj.isPremiumUser)
      ..writeByte(19)
      ..write(obj.settings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CookingPreferencesAdapter extends TypeAdapter<CookingPreferences> {
  @override
  final int typeId = 21;

  @override
  CookingPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CookingPreferences(
      maxCookingTime: fields[0] as int? ?? 30,
      defaultServings: fields[1] as int? ?? 4,
      preferQuickMeals: fields[2] as bool? ?? true,
      preferBatchCooking: fields[3] as bool? ?? false,
      preferOnePotMeals: fields[4] as bool? ?? false,
      commonSpices: (fields[5] as List?)?.cast<String>() ??
          ['salt', 'pepper', 'olive oil'],
      preferredCuisine: fields[6] as String?,
      spiceToleranceLevel: fields[7] as int? ?? 5,
    );
  }

  @override
  void write(BinaryWriter writer, CookingPreferences obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.maxCookingTime)
      ..writeByte(1)
      ..write(obj.defaultServings)
      ..writeByte(2)
      ..write(obj.preferQuickMeals)
      ..writeByte(3)
      ..write(obj.preferBatchCooking)
      ..writeByte(4)
      ..write(obj.preferOnePotMeals)
      ..writeByte(5)
      ..write(obj.commonSpices)
      ..writeByte(6)
      ..write(obj.preferredCuisine)
      ..writeByte(7)
      ..write(obj.spiceToleranceLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CookingPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NutritionalGoalsAdapter extends TypeAdapter<NutritionalGoals> {
  @override
  final int typeId = 22;

  @override
  NutritionalGoals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionalGoals(
      dailyCalories: fields[0] as double?,
      dailyProtein: fields[1] as double?,
      dailyCarbs: fields[2] as double?,
      dailyFat: fields[3] as double?,
      dailyFiber: fields[4] as double?,
      dailySodium: fields[5] as double?,
      trackCalories: fields[6] as bool? ?? false,
      trackMacros: fields[7] as bool? ?? false,
      trackMicros: fields[8] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, NutritionalGoals obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.dailyCalories)
      ..writeByte(1)
      ..write(obj.dailyProtein)
      ..writeByte(2)
      ..write(obj.dailyCarbs)
      ..writeByte(3)
      ..write(obj.dailyFat)
      ..writeByte(4)
      ..write(obj.dailyFiber)
      ..writeByte(5)
      ..write(obj.dailySodium)
      ..writeByte(6)
      ..write(obj.trackCalories)
      ..writeByte(7)
      ..write(obj.trackMacros)
      ..writeByte(8)
      ..write(obj.trackMicros);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionalGoalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SkillLevelAdapter extends TypeAdapter<SkillLevel> {
  @override
  final int typeId = 23;

  @override
  SkillLevel read(BinaryReader reader) {
    final index = reader.readByte();
    return SkillLevel.values[index];
  }

  @override
  void write(BinaryWriter writer, SkillLevel obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DietaryRestrictionAdapter extends TypeAdapter<DietaryRestriction> {
  @override
  final int typeId = 24;

  @override
  DietaryRestriction read(BinaryReader reader) {
    final index = reader.readByte();
    return DietaryRestriction.values[index];
  }

  @override
  void write(BinaryWriter writer, DietaryRestriction obj) {
    writer.writeByte(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietaryRestrictionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
