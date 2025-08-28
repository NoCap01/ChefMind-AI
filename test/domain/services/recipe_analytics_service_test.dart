import 'package:flutter_test/flutter_test.dart';
import '../../../lib/domain/services/recipe_analytics_service.dart';
import '../../../lib/domain/entities/recipe.dart';
import '../../../lib/domain/entities/user_profile.dart';

void main() {
  group('RecipeAnalytics', () {
    test('should create RecipeAnalytics with correct values', () {
      // Arrange
      const recipeId = 'recipe123';
      const averageRating = 4.2;
      const totalRatings = 15;
      const viewCount = 100;
      const cookCount = 25;
      const shareCount = 8;
      const successRate = 0.85;
      const averageCookingTime = Duration(minutes: 35);
      const ratingDistribution = {1: 0, 2: 1, 3: 2, 4: 5, 5: 7};
      const commonFeedback = ['Delicious!', 'Easy to follow', 'Great recipe'];
      final lastCooked = DateTime.now().subtract(const Duration(days: 2));
      final lastViewed = DateTime.now().subtract(const Duration(hours: 3));

      // Act
      final analytics = RecipeAnalytics(
        recipeId: recipeId,
        averageRating: averageRating,
        totalRatings: totalRatings,
        viewCount: viewCount,
        cookCount: cookCount,
        shareCount: shareCount,
        successRate: successRate,
        averageCookingTime: averageCookingTime,
        ratingDistribution: ratingDistribution,
        commonFeedback: commonFeedback,
        lastCooked: lastCooked,
        lastViewed: lastViewed,
      );

      // Assert
      expect(analytics.recipeId, equals(recipeId));
      expect(analytics.averageRating, equals(averageRating));
      expect(analytics.totalRatings, equals(totalRatings));
      expect(analytics.viewCount, equals(viewCount));
      expect(analytics.cookCount, equals(cookCount));
      expect(analytics.shareCount, equals(shareCount));
      expect(analytics.successRate, equals(successRate));
      expect(analytics.averageCookingTime, equals(averageCookingTime));
      expect(analytics.ratingDistribution, equals(ratingDistribution));
      expect(analytics.commonFeedback, equals(commonFeedback));
      expect(analytics.lastCooked, equals(lastCooked));
      expect(analytics.lastViewed, equals(lastViewed));
    });
  });

  group('UserCookingStats', () {
    test('should create UserCookingStats with correct values', () {
      // Arrange
      const userId = 'user123';
      const totalRecipesCooked = 47;
      const totalRecipesSaved = 23;
      const totalRecipesShared = 8;
      const averageRating = 4.2;
      const totalCookingTime = Duration(hours: 32, minutes: 15);
      const averageCookingTime = Duration(minutes: 41);
      const difficultyDistribution = {
        DifficultyLevel.beginner: 15,
        DifficultyLevel.intermediate: 25,
        DifficultyLevel.advanced: 7,
      };
      const cuisineDistribution = {
        'Italian': 12,
        'Asian': 10,
        'Mexican': 8,
      };
      const currentStreak = 5;
      const longestStreak = 12;
      final lastCookingDate = DateTime.now().subtract(const Duration(days: 1));
      const currentSkillLevel = SkillLevel.intermediate;
      const skillProgress = 0.68;

      // Act
      final stats = UserCookingStats(
        userId: userId,
        totalRecipesCooked: totalRecipesCooked,
        totalRecipesSaved: totalRecipesSaved,
        totalRecipesShared: totalRecipesShared,
        averageRating: averageRating,
        totalCookingTime: totalCookingTime,
        averageCookingTime: averageCookingTime,
        difficultyDistribution: difficultyDistribution,
        cuisineDistribution: cuisineDistribution,
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        lastCookingDate: lastCookingDate,
        currentSkillLevel: currentSkillLevel,
        skillProgress: skillProgress,
      );

      // Assert
      expect(stats.userId, equals(userId));
      expect(stats.totalRecipesCooked, equals(totalRecipesCooked));
      expect(stats.totalRecipesSaved, equals(totalRecipesSaved));
      expect(stats.totalRecipesShared, equals(totalRecipesShared));
      expect(stats.averageRating, equals(averageRating));
      expect(stats.totalCookingTime, equals(totalCookingTime));
      expect(stats.averageCookingTime, equals(averageCookingTime));
      expect(stats.difficultyDistribution, equals(difficultyDistribution));
      expect(stats.cuisineDistribution, equals(cuisineDistribution));
      expect(stats.currentStreak, equals(currentStreak));
      expect(stats.longestStreak, equals(longestStreak));
      expect(stats.lastCookingDate, equals(lastCookingDate));
      expect(stats.currentSkillLevel, equals(currentSkillLevel));
      expect(stats.skillProgress, equals(skillProgress));
    });

    test('should calculate cooking efficiency metrics', () {
      // Arrange
      const totalRecipesCooked = 50;
      const totalCookingTime = Duration(hours: 40); // 2400 minutes
      const averageCookingTime = Duration(minutes: 48); // 2400 / 50

      final stats = UserCookingStats(
        userId: 'user123',
        totalRecipesCooked: totalRecipesCooked,
        totalRecipesSaved: 25,
        totalRecipesShared: 10,
        averageRating: 4.0,
        totalCookingTime: totalCookingTime,
        averageCookingTime: averageCookingTime,
        difficultyDistribution: const {},
        cuisineDistribution: const {},
        currentStreak: 3,
        longestStreak: 8,
        lastCookingDate: DateTime.now(),
        currentSkillLevel: SkillLevel.intermediate,
        skillProgress: 0.5,
      );

      // Assert
      expect(stats.totalCookingTime.inMinutes, equals(2400));
      expect(stats.averageCookingTime.inMinutes, equals(48));
      
      // Calculate recipes per hour of cooking
      final recipesPerHour = totalRecipesCooked / (totalCookingTime.inMinutes / 60);
      expect(recipesPerHour, equals(1.25)); // 50 recipes / 40 hours = 1.25 recipes/hour
    });
  });

  group('CookingTrends', () {
    test('should create CookingTrends with correct values', () {
      // Arrange
      const period = Duration(days: 30);
      const recipesCooked = 12;
      const newRecipesTried = 8;
      const averageRating = 4.3;
      const popularCuisines = {
        'Italian': 4,
        'Asian': 3,
        'Mexican': 2,
      };
      const difficultyProgression = {
        DifficultyLevel.beginner: 2,
        DifficultyLevel.intermediate: 7,
        DifficultyLevel.advanced: 3,
      };
      const emergingPreferences = ['Vegetarian', 'Quick meals'];
      const improvementScore = 0.15;

      // Act
      const trends = CookingTrends(
        period: period,
        recipesCooked: recipesCooked,
        newRecipesTried: newRecipesTried,
        averageRating: averageRating,
        popularCuisines: popularCuisines,
        difficultyProgression: difficultyProgression,
        emergingPreferences: emergingPreferences,
        improvementScore: improvementScore,
      );

      // Assert
      expect(trends.period, equals(period));
      expect(trends.recipesCooked, equals(recipesCooked));
      expect(trends.newRecipesTried, equals(newRecipesTried));
      expect(trends.averageRating, equals(averageRating));
      expect(trends.popularCuisines, equals(popularCuisines));
      expect(trends.difficultyProgression, equals(difficultyProgression));
      expect(trends.emergingPreferences, equals(emergingPreferences));
      expect(trends.improvementScore, equals(improvementScore));
    });

    test('should calculate trend metrics correctly', () {
      // Arrange
      const trends = CookingTrends(
        period: Duration(days: 30),
        recipesCooked: 15,
        newRecipesTried: 10,
        averageRating: 4.2,
        popularCuisines: {
          'Italian': 5,
          'Asian': 4,
          'Mexican': 3,
          'American': 2,
          'French': 1,
        },
        difficultyProgression: {
          DifficultyLevel.beginner: 3,
          DifficultyLevel.intermediate: 8,
          DifficultyLevel.advanced: 4,
        },
        emergingPreferences: ['Healthy', 'Quick'],
        improvementScore: 0.25,
      );

      // Assert
      // Calculate percentage of new recipes tried
      final newRecipePercentage = trends.newRecipesTried / trends.recipesCooked;
      expect(newRecipePercentage, closeTo(0.67, 0.01)); // 10/15 ≈ 0.67

      // Calculate most popular cuisine percentage
      final totalCuisineCount = trends.popularCuisines.values.reduce((a, b) => a + b);
      final italianPercentage = trends.popularCuisines['Italian']! / totalCuisineCount;
      expect(italianPercentage, closeTo(0.33, 0.01)); // 5/15 ≈ 0.33

      // Calculate difficulty distribution
      final totalDifficulty = trends.difficultyProgression.values.reduce((a, b) => a + b);
      final intermediatePercentage = trends.difficultyProgression[DifficultyLevel.intermediate]! / totalDifficulty;
      expect(intermediatePercentage, closeTo(0.53, 0.01)); // 8/15 ≈ 0.53
    });
  });

  group('SkillProgressAnalytics', () {
    test('should create SkillProgressAnalytics with correct values', () {
      // Arrange
      const currentLevel = SkillLevel.intermediate;
      const progressToNextLevel = 0.75;
      const masteredTechniques = ['sautéing', 'roasting', 'grilling'];
      const recommendedTechniques = ['braising', 'poaching'];
      const skillScores = {
        'knife_skills': 0.8,
        'seasoning': 0.9,
        'timing': 0.7,
      };
      const recentAchievements = <Achievement>[];

      // Act
      const analytics = SkillProgressAnalytics(
        currentLevel: currentLevel,
        progressToNextLevel: progressToNextLevel,
        masteredTechniques: masteredTechniques,
        recommendedTechniques: recommendedTechniques,
        skillScores: skillScores,
        recentAchievements: recentAchievements,
      );

      // Assert
      expect(analytics.currentLevel, equals(currentLevel));
      expect(analytics.progressToNextLevel, equals(progressToNextLevel));
      expect(analytics.masteredTechniques, equals(masteredTechniques));
      expect(analytics.recommendedTechniques, equals(recommendedTechniques));
      expect(analytics.skillScores, equals(skillScores));
      expect(analytics.recentAchievements, equals(recentAchievements));
    });

    test('should calculate overall skill score', () {
      // Arrange
      const skillScores = {
        'knife_skills': 0.8,
        'seasoning': 0.9,
        'timing': 0.7,
        'temperature_control': 0.6,
        'presentation': 0.85,
      };

      const analytics = SkillProgressAnalytics(
        currentLevel: SkillLevel.intermediate,
        progressToNextLevel: 0.65,
        masteredTechniques: const ['sautéing', 'roasting'],
        recommendedTechniques: const ['braising'],
        skillScores: skillScores,
        recentAchievements: const [],
      );

      // Act
      final averageSkillScore = skillScores.values.reduce((a, b) => a + b) / skillScores.length;

      // Assert
      expect(averageSkillScore, closeTo(0.77, 0.01)); // (0.8 + 0.9 + 0.7 + 0.6 + 0.85) / 5 = 0.77
      expect(analytics.masteredTechniques.length, equals(2));
      expect(analytics.recommendedTechniques.length, equals(1));
    });
  });

  group('NutritionTrends', () {
    test('should create NutritionTrends with correct values', () {
      // Arrange
      const period = Duration(days: 30);
      const averageCalories = 450.0;
      const averageProtein = 25.0;
      const averageCarbs = 35.0;
      const averageFat = 18.0;
      const nutritionGoalProgress = {
        'calories': 0.85,
        'protein': 0.92,
        'carbs': 0.78,
      };
      const healthyChoices = ['More vegetables', 'Lean proteins'];
      const improvementSuggestions = ['Reduce sodium', 'Increase fiber'];

      // Act
      const trends = NutritionTrends(
        period: period,
        averageCalories: averageCalories,
        averageProtein: averageProtein,
        averageCarbs: averageCarbs,
        averageFat: averageFat,
        nutritionGoalProgress: nutritionGoalProgress,
        healthyChoices: healthyChoices,
        improvementSuggestions: improvementSuggestions,
      );

      // Assert
      expect(trends.period, equals(period));
      expect(trends.averageCalories, equals(averageCalories));
      expect(trends.averageProtein, equals(averageProtein));
      expect(trends.averageCarbs, equals(averageCarbs));
      expect(trends.averageFat, equals(averageFat));
      expect(trends.nutritionGoalProgress, equals(nutritionGoalProgress));
      expect(trends.healthyChoices, equals(healthyChoices));
      expect(trends.improvementSuggestions, equals(improvementSuggestions));
    });

    test('should calculate macro distribution percentages', () {
      // Arrange
      const trends = NutritionTrends(
        period: Duration(days: 30),
        averageCalories: 500.0,
        averageProtein: 30.0, // 30g * 4 cal/g = 120 cal
        averageCarbs: 40.0,   // 40g * 4 cal/g = 160 cal
        averageFat: 24.0,     // 24g * 9 cal/g = 216 cal
        nutritionGoalProgress: const {},
        healthyChoices: const [],
        improvementSuggestions: const [],
      );

      // Act
      final proteinCalories = trends.averageProtein * 4; // 4 calories per gram
      final carbCalories = trends.averageCarbs * 4;
      final fatCalories = trends.averageFat * 9; // 9 calories per gram
      final totalMacroCalories = proteinCalories + carbCalories + fatCalories;

      final proteinPercentage = proteinCalories / totalMacroCalories;
      final carbPercentage = carbCalories / totalMacroCalories;
      final fatPercentage = fatCalories / totalMacroCalories;

      // Assert
      expect(totalMacroCalories, equals(496.0)); // 120 + 160 + 216
      expect(proteinPercentage, closeTo(0.24, 0.01)); // 120/496 ≈ 0.24
      expect(carbPercentage, closeTo(0.32, 0.01));    // 160/496 ≈ 0.32
      expect(fatPercentage, closeTo(0.44, 0.01));     // 216/496 ≈ 0.44
    });
  });

  group('Achievement', () {
    test('should create Achievement with correct values', () {
      // Arrange
      const id = 'achievement_001';
      const title = 'Master Chef';
      const description = 'Cooked 100 recipes successfully';
      const iconName = 'chef_hat';
      final unlockedAt = DateTime.now();
      const type = AchievementType.cooking;

      // Act
      final achievement = Achievement(
        id: id,
        title: title,
        description: description,
        iconName: iconName,
        unlockedAt: unlockedAt,
        type: type,
      );

      // Assert
      expect(achievement.id, equals(id));
      expect(achievement.title, equals(title));
      expect(achievement.description, equals(description));
      expect(achievement.iconName, equals(iconName));
      expect(achievement.unlockedAt, equals(unlockedAt));
      expect(achievement.type, equals(type));
    });
  });
}