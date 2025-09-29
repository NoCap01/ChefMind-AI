import '../enums/skill_level.dart';
import '../enums/dietary_restriction.dart';

class UserProfile {
  final String userId; // Changed from 'id' to 'userId' for consistency
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final SkillLevel skillLevel;
  final List<DietaryRestriction> dietaryRestrictions;
  final List<String> allergies;
  final List<String> favoriteIngredients;
  final List<String> dislikedIngredients;
  final List<String> kitchenEquipment;
  final CookingPreferences preferences;
  final NutritionalGoals nutritionalGoals;
  final List<String> favoriteRecipes;
  final List<String> savedCollections;
  final DateTime createdAt;
  final DateTime? lastActiveAt;
  final bool isEmailVerified;
  final bool isPremiumUser;
  final Map<String, dynamic>? settings;

  const UserProfile({
    required this.userId,
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

  UserProfile copyWith({
    String? userId,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    SkillLevel? skillLevel,
    List<DietaryRestriction>? dietaryRestrictions,
    List<String>? allergies,
    List<String>? favoriteIngredients,
    List<String>? dislikedIngredients,
    List<String>? kitchenEquipment,
    CookingPreferences? preferences,
    NutritionalGoals? nutritionalGoals,
    List<String>? favoriteRecipes,
    List<String>? savedCollections,
    DateTime? createdAt,
    DateTime? lastActiveAt,
    bool? isEmailVerified,
    bool? isPremiumUser,
    Map<String, dynamic>? settings,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      skillLevel: skillLevel ?? this.skillLevel,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      allergies: allergies ?? this.allergies,
      favoriteIngredients: favoriteIngredients ?? this.favoriteIngredients,
      dislikedIngredients: dislikedIngredients ?? this.dislikedIngredients,
      kitchenEquipment: kitchenEquipment ?? this.kitchenEquipment,
      preferences: preferences ?? this.preferences,
      nutritionalGoals: nutritionalGoals ?? this.nutritionalGoals,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
      savedCollections: savedCollections ?? this.savedCollections,
      createdAt: createdAt ?? this.createdAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPremiumUser: isPremiumUser ?? this.isPremiumUser,
      settings: settings ?? this.settings,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'skillLevel': skillLevel.name,
      'dietaryRestrictions': dietaryRestrictions.map((e) => e.name).toList(),
      'allergies': allergies,
      'favoriteIngredients': favoriteIngredients,
      'dislikedIngredients': dislikedIngredients,
      'kitchenEquipment': kitchenEquipment,
      'preferences': preferences.toJson(),
      'nutritionalGoals': nutritionalGoals.toJson(),
      'favoriteRecipes': favoriteRecipes,
      'savedCollections': savedCollections,
      'createdAt': createdAt.toIso8601String(),
      'lastActiveAt': lastActiveAt?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'isPremiumUser': isPremiumUser,
      'settings': settings,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] ?? json['id'] ?? '', // Handle both userId and id
      email: json['email'] ?? '',
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      phoneNumber: json['phoneNumber'],
      skillLevel: SkillLevel.values.firstWhere(
        (e) => e.name == json['skillLevel'],
        orElse: () => SkillLevel.beginner,
      ),
      dietaryRestrictions: (json['dietaryRestrictions'] as List<dynamic>?)
              ?.map((e) => DietaryRestriction.values.firstWhere(
                    (dr) => dr.name == e,
                    orElse: () => DietaryRestriction.none,
                  ))
              .toList() ??
          [],
      allergies: List<String>.from(json['allergies'] ?? []),
      favoriteIngredients: List<String>.from(json['favoriteIngredients'] ?? []),
      dislikedIngredients: List<String>.from(json['dislikedIngredients'] ?? []),
      kitchenEquipment: List<String>.from(json['kitchenEquipment'] ?? []),
      preferences: json['preferences'] != null
          ? CookingPreferences.fromJson(json['preferences'])
          : const CookingPreferences(),
      nutritionalGoals: json['nutritionalGoals'] != null
          ? NutritionalGoals.fromJson(json['nutritionalGoals'])
          : const NutritionalGoals(),
      favoriteRecipes: List<String>.from(json['favoriteRecipes'] ?? []),
      savedCollections: List<String>.from(json['savedCollections'] ?? []),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      lastActiveAt: json['lastActiveAt'] != null
          ? DateTime.tryParse(json['lastActiveAt'])
          : null,
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPremiumUser: json['isPremiumUser'] ?? false,
      settings: json['settings'],
    );
  }
}

class CookingPreferences {
  final int maxCookingTime;
  final int defaultServings;
  final bool preferQuickMeals;
  final bool preferBatchCooking;
  final bool preferOnePotMeals;
  final List<String> commonSpices;
  final String? preferredCuisine;
  final int spiceToleranceLevel;

  const CookingPreferences({
    this.maxCookingTime = 30,
    this.defaultServings = 4,
    this.preferQuickMeals = true,
    this.preferBatchCooking = false,
    this.preferOnePotMeals = false,
    this.commonSpices = const ['salt', 'pepper', 'olive oil'],
    this.preferredCuisine,
    this.spiceToleranceLevel = 5,
  });

  CookingPreferences copyWith({
    int? maxCookingTime,
    int? defaultServings,
    bool? preferQuickMeals,
    bool? preferBatchCooking,
    bool? preferOnePotMeals,
    List<String>? commonSpices,
    String? preferredCuisine,
    int? spiceToleranceLevel,
  }) {
    return CookingPreferences(
      maxCookingTime: maxCookingTime ?? this.maxCookingTime,
      defaultServings: defaultServings ?? this.defaultServings,
      preferQuickMeals: preferQuickMeals ?? this.preferQuickMeals,
      preferBatchCooking: preferBatchCooking ?? this.preferBatchCooking,
      preferOnePotMeals: preferOnePotMeals ?? this.preferOnePotMeals,
      commonSpices: commonSpices ?? this.commonSpices,
      preferredCuisine: preferredCuisine ?? this.preferredCuisine,
      spiceToleranceLevel: spiceToleranceLevel ?? this.spiceToleranceLevel,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maxCookingTime': maxCookingTime,
      'defaultServings': defaultServings,
      'preferQuickMeals': preferQuickMeals,
      'preferBatchCooking': preferBatchCooking,
      'preferOnePotMeals': preferOnePotMeals,
      'commonSpices': commonSpices,
      'preferredCuisine': preferredCuisine,
      'spiceToleranceLevel': spiceToleranceLevel,
    };
  }

  factory CookingPreferences.fromJson(Map<String, dynamic> json) {
    return CookingPreferences(
      maxCookingTime: json['maxCookingTime'] ?? 30,
      defaultServings: json['defaultServings'] ?? 4,
      preferQuickMeals: json['preferQuickMeals'] ?? true,
      preferBatchCooking: json['preferBatchCooking'] ?? false,
      preferOnePotMeals: json['preferOnePotMeals'] ?? false,
      commonSpices: List<String>.from(
          json['commonSpices'] ?? ['salt', 'pepper', 'olive oil']),
      preferredCuisine: json['preferredCuisine'],
      spiceToleranceLevel: json['spiceToleranceLevel'] ?? 5,
    );
  }
}

class NutritionalGoals {
  final double? dailyCalories;
  final double? dailyProtein;
  final double? dailyCarbs;
  final double? dailyFat;
  final double? dailyFiber;
  final double? dailySodium;
  final bool trackCalories;
  final bool trackMacros;
  final bool trackMicros;

  const NutritionalGoals({
    this.dailyCalories,
    this.dailyProtein,
    this.dailyCarbs,
    this.dailyFat,
    this.dailyFiber,
    this.dailySodium,
    this.trackCalories = false,
    this.trackMacros = false,
    this.trackMicros = false,
  });

  NutritionalGoals copyWith({
    double? dailyCalories,
    double? dailyProtein,
    double? dailyCarbs,
    double? dailyFat,
    double? dailyFiber,
    double? dailySodium,
    bool? trackCalories,
    bool? trackMacros,
    bool? trackMicros,
  }) {
    return NutritionalGoals(
      dailyCalories: dailyCalories ?? this.dailyCalories,
      dailyProtein: dailyProtein ?? this.dailyProtein,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      dailyFat: dailyFat ?? this.dailyFat,
      dailyFiber: dailyFiber ?? this.dailyFiber,
      dailySodium: dailySodium ?? this.dailySodium,
      trackCalories: trackCalories ?? this.trackCalories,
      trackMacros: trackMacros ?? this.trackMacros,
      trackMicros: trackMicros ?? this.trackMicros,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyCalories': dailyCalories,
      'dailyProtein': dailyProtein,
      'dailyCarbs': dailyCarbs,
      'dailyFat': dailyFat,
      'dailyFiber': dailyFiber,
      'dailySodium': dailySodium,
      'trackCalories': trackCalories,
      'trackMacros': trackMacros,
      'trackMicros': trackMicros,
    };
  }

  factory NutritionalGoals.fromJson(Map<String, dynamic> json) {
    return NutritionalGoals(
      dailyCalories: json['dailyCalories']?.toDouble(),
      dailyProtein: json['dailyProtein']?.toDouble(),
      dailyCarbs: json['dailyCarbs']?.toDouble(),
      dailyFat: json['dailyFat']?.toDouble(),
      dailyFiber: json['dailyFiber']?.toDouble(),
      dailySodium: json['dailySodium']?.toDouble(),
      trackCalories: json['trackCalories'] ?? false,
      trackMacros: json['trackMacros'] ?? false,
      trackMicros: json['trackMicros'] ?? false,
    );
  }
}
