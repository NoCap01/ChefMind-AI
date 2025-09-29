import '../../domain/entities/user_profile.dart';

class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final String skillLevel;
  final List<String> dietaryRestrictions;
  final List<String> allergies;
  final List<String> favoriteIngredients;
  final List<String> dislikedIngredients;
  final List<String> kitchenEquipment;
  final Map<String, dynamic> preferences;
  final Map<String, dynamic> nutritionalGoals;
  final List<String> favoriteRecipes;
  final List<String> savedCollections;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final bool isEmailVerified;
  final bool isPremiumUser;
  final Map<String, dynamic>? settings;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    required this.skillLevel,
    required this.dietaryRestrictions,
    required this.allergies,
    required this.favoriteIngredients,
    required this.dislikedIngredients,
    required this.kitchenEquipment,
    required this.preferences,
    required this.nutritionalGoals,
    this.favoriteRecipes = const [],
    this.savedCollections = const [],
    required this.createdAt,
    this.lastActiveAt,
    this.isEmailVerified = false,
    this.isPremiumUser = false,
    this.settings,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      phoneNumber: json['phoneNumber'],
      skillLevel: json['skillLevel'] ?? 'beginner',
      dietaryRestrictions: List<String>.from(json['dietaryRestrictions'] ?? []),
      allergies: List<String>.from(json['allergies'] ?? []),
      favoriteIngredients: List<String>.from(json['favoriteIngredients'] ?? []),
      dislikedIngredients: List<String>.from(json['dislikedIngredients'] ?? []),
      kitchenEquipment: List<String>.from(json['kitchenEquipment'] ?? []),
      preferences: Map<String, dynamic>.from(json['preferences'] ?? {}),
      nutritionalGoals:
          Map<String, dynamic>.from(json['nutritionalGoals'] ?? {}),
      favoriteRecipes: List<String>.from(json['favoriteRecipes'] ?? []),
      savedCollections: List<String>.from(json['savedCollections'] ?? []),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastActiveAt: json['lastActiveAt'] != null
          ? DateTime.parse(json['lastActiveAt'])
          : null,
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPremiumUser: json['isPremiumUser'] ?? false,
      settings: json['settings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'skillLevel': skillLevel,
      'dietaryRestrictions': dietaryRestrictions,
      'allergies': allergies,
      'favoriteIngredients': favoriteIngredients,
      'dislikedIngredients': dislikedIngredients,
      'kitchenEquipment': kitchenEquipment,
      'preferences': preferences,
      'nutritionalGoals': nutritionalGoals,
      'favoriteRecipes': favoriteRecipes,
      'savedCollections': savedCollections,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'isPremiumUser': isPremiumUser,
      'settings': settings,
    };
  }

  factory UserModel.fromDomain(UserProfile profile) {
    return UserModel(
      id: profile.userId,
      email: profile.email,
      displayName: profile.displayName,
      photoUrl: profile.photoUrl,
      phoneNumber: profile.phoneNumber,
      skillLevel: profile.skillLevel.name,
      dietaryRestrictions:
          profile.dietaryRestrictions.map((e) => e.name).toList(),
      allergies: profile.allergies,
      favoriteIngredients: profile.favoriteIngredients,
      dislikedIngredients: profile.dislikedIngredients,
      kitchenEquipment: profile.kitchenEquipment,
      preferences: {
        'maxCookingTime': profile.preferences.maxCookingTime,
        'defaultServings': profile.preferences.defaultServings,
        'preferQuickMeals': profile.preferences.preferQuickMeals,
        'preferBatchCooking': profile.preferences.preferBatchCooking,
        'preferOnePotMeals': profile.preferences.preferOnePotMeals,
        'commonSpices': profile.preferences.commonSpices,
        'preferredCuisine': profile.preferences.preferredCuisine,
        'spiceToleranceLevel': profile.preferences.spiceToleranceLevel,
      },
      nutritionalGoals: {
        'dailyCalories': profile.nutritionalGoals.dailyCalories,
        'dailyProtein': profile.nutritionalGoals.dailyProtein,
        'dailyCarbs': profile.nutritionalGoals.dailyCarbs,
        'dailyFat': profile.nutritionalGoals.dailyFat,
        'dailyFiber': profile.nutritionalGoals.dailyFiber,
        'dailySodium': profile.nutritionalGoals.dailySodium,
        'trackCalories': profile.nutritionalGoals.trackCalories,
        'trackMacros': profile.nutritionalGoals.trackMacros,
        'trackMicros': profile.nutritionalGoals.trackMicros,
      },
      favoriteRecipes: profile.favoriteRecipes,
      savedCollections: profile.savedCollections,
      createdAt: profile.createdAt,
      lastActiveAt: profile.lastActiveAt,
      isEmailVerified: profile.isEmailVerified,
      isPremiumUser: profile.isPremiumUser,
      settings: profile.settings,
    );
  }
}
