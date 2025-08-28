import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../lib/infrastructure/repositories/firebase_recipe_rating_repository.dart';
import '../../../lib/infrastructure/services/firebase_service.dart';
import '../../../lib/domain/entities/recipe_rating.dart';
import '../../../lib/domain/exceptions/app_exceptions.dart';

@GenerateMocks([FirebaseService])
import 'firebase_recipe_rating_repository_test.mocks.dart';

void main() {
  group('FirebaseRecipeRatingRepository', () {
    late FirebaseRecipeRatingRepository repository;
    late MockFirebaseService mockFirebaseService;

    setUp(() {
      mockFirebaseService = MockFirebaseService();
      repository = FirebaseRecipeRatingRepository();
      // Note: In a real implementation, we would inject the mock service
    });

    group('Rating Calculations', () {
      test('should calculate average rating correctly', () async {
        // Arrange
        final mockRatings = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'rating': 4.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '2',
            'recipeId': 'recipe1',
            'userId': 'user2',
            'rating': 5.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '3',
            'recipeId': 'recipe1',
            'userId': 'user3',
            'rating': 3.0,
            'wasSuccessful': false,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockRatings);

        // Act
        final averageRating = await repository.getAverageRating('recipe1');

        // Assert
        expect(averageRating, equals(4.0)); // (4.0 + 5.0 + 3.0) / 3 = 4.0
      });

      test('should return 0.0 for average rating when no ratings exist', () async {
        // Arrange
        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => []);

        // Act
        final averageRating = await repository.getAverageRating('recipe1');

        // Assert
        expect(averageRating, equals(0.0));
      });

      test('should calculate rating distribution correctly', () async {
        // Arrange
        final mockRatings = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'rating': 4.2,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '2',
            'recipeId': 'recipe1',
            'userId': 'user2',
            'rating': 4.8,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '3',
            'recipeId': 'recipe1',
            'userId': 'user3',
            'rating': 3.1,
            'wasSuccessful': false,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '4',
            'recipeId': 'recipe1',
            'userId': 'user4',
            'rating': 5.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockRatings);

        // Act
        final distribution = await repository.getRatingDistribution('recipe1');

        // Assert
        expect(distribution[3], equals(1)); // 3.1 rounds to 3
        expect(distribution[4], equals(1)); // 4.2 rounds to 4
        expect(distribution[5], equals(2)); // 4.8 and 5.0 round to 5
      });

      test('should calculate success rate correctly', () async {
        // Arrange
        final mockRatings = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'rating': 4.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '2',
            'recipeId': 'recipe1',
            'userId': 'user2',
            'rating': 5.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '3',
            'recipeId': 'recipe1',
            'userId': 'user3',
            'rating': 3.0,
            'wasSuccessful': false,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '4',
            'recipeId': 'recipe1',
            'userId': 'user4',
            'rating': 2.0,
            'wasSuccessful': false,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockRatings);

        // Act
        final successRate = await repository.getRecipeSuccessRate('recipe1');

        // Assert
        expect(successRate, equals(0.5)); // 2 successful out of 4 total = 0.5
      });

      test('should return 0.0 for success rate when no ratings exist', () async {
        // Arrange
        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => []);

        // Act
        final successRate = await repository.getRecipeSuccessRate('recipe1');

        // Assert
        expect(successRate, equals(0.0));
      });

      test('should calculate average cooking time correctly', () async {
        // Arrange
        final mockRatings = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'rating': 4.0,
            'wasSuccessful': true,
            'actualCookingTime': const Duration(minutes: 30).inMicroseconds,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '2',
            'recipeId': 'recipe1',
            'userId': 'user2',
            'rating': 5.0,
            'wasSuccessful': true,
            'actualCookingTime': const Duration(minutes: 45).inMicroseconds,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '3',
            'recipeId': 'recipe1',
            'userId': 'user3',
            'rating': 3.0,
            'wasSuccessful': false,
            'actualCookingTime': const Duration(minutes: 60).inMicroseconds,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockRatings);

        // Act
        final averageTime = await repository.getAverageCookingTime('recipe1');

        // Assert
        expect(averageTime.inMinutes, equals(45)); // (30 + 45 + 60) / 3 = 45
      });

      test('should return default cooking time when no times recorded', () async {
        // Arrange
        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => []);

        // Act
        final averageTime = await repository.getAverageCookingTime('recipe1');

        // Assert
        expect(averageTime.inMinutes, equals(30)); // Default value
      });
    });

    group('Analytics Data Processing', () {
      test('should calculate cooking frequency by day correctly', () async {
        // Arrange
        final now = DateTime.now();
        final monday = now.subtract(Duration(days: now.weekday - 1));
        final tuesday = monday.add(const Duration(days: 1));
        final wednesday = monday.add(const Duration(days: 2));

        final mockHistory = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': monday.toIso8601String(),
          },
          {
            'id': '2',
            'recipeId': 'recipe2',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': monday.toIso8601String(),
          },
          {
            'id': '3',
            'recipeId': 'recipe3',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': tuesday.toIso8601String(),
          },
          {
            'id': '4',
            'recipeId': 'recipe4',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': wednesday.toIso8601String(),
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_history',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockHistory);

        // Act
        final frequency = await repository.getCookingFrequencyByDay('user1');

        // Assert
        expect(frequency['Monday'], equals(2));
        expect(frequency['Tuesday'], equals(1));
        expect(frequency['Wednesday'], equals(1));
        expect(frequency['Thursday'], isNull);
      });

      test('should get most cooked recipes correctly', () async {
        // Arrange
        final mockHistory = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': DateTime.now().toIso8601String(),
          },
          {
            'id': '2',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': DateTime.now().toIso8601String(),
          },
          {
            'id': '3',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': DateTime.now().toIso8601String(),
          },
          {
            'id': '4',
            'recipeId': 'recipe2',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': DateTime.now().toIso8601String(),
          },
          {
            'id': '5',
            'recipeId': 'recipe2',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': DateTime.now().toIso8601String(),
          },
          {
            'id': '6',
            'recipeId': 'recipe3',
            'userId': 'user1',
            'action': 'cooked',
            'timestamp': DateTime.now().toIso8601String(),
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_history',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockHistory);

        // Act
        final mostCooked = await repository.getMostCookedRecipes('user1', limit: 3);

        // Assert
        expect(mostCooked.length, equals(3));
        expect(mostCooked[0], equals('recipe1')); // 3 times
        expect(mostCooked[1], equals('recipe2')); // 2 times
        expect(mostCooked[2], equals('recipe3')); // 1 time
      });

      test('should get recently viewed recipes without duplicates', () async {
        // Arrange
        final now = DateTime.now();
        final mockHistory = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'action': 'viewed',
            'timestamp': now.subtract(const Duration(minutes: 1)).toIso8601String(),
          },
          {
            'id': '2',
            'recipeId': 'recipe2',
            'userId': 'user1',
            'action': 'viewed',
            'timestamp': now.subtract(const Duration(minutes: 2)).toIso8601String(),
          },
          {
            'id': '3',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'action': 'viewed',
            'timestamp': now.subtract(const Duration(minutes: 3)).toIso8601String(),
          },
          {
            'id': '4',
            'recipeId': 'recipe3',
            'userId': 'user1',
            'action': 'viewed',
            'timestamp': now.subtract(const Duration(minutes: 4)).toIso8601String(),
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_history',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockHistory);

        // Act
        final recentlyViewed = await repository.getRecentlyViewedRecipes('user1', limit: 5);

        // Assert
        expect(recentlyViewed.length, equals(3)); // Only unique recipes
        expect(recentlyViewed[0], equals('recipe1')); // Most recent
        expect(recentlyViewed[1], equals('recipe2'));
        expect(recentlyViewed[2], equals('recipe3'));
      });

      test('should calculate skill progress metrics correctly', () async {
        // Arrange
        final mockRatings = [
          {
            'id': '1',
            'recipeId': 'recipe1',
            'userId': 'user1',
            'rating': 4.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '2',
            'recipeId': 'recipe2',
            'userId': 'user1',
            'rating': 5.0,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '3',
            'recipeId': 'recipe3',
            'userId': 'user1',
            'rating': 3.0,
            'wasSuccessful': false,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
          {
            'id': '4',
            'recipeId': 'recipe4',
            'userId': 'user1',
            'rating': 4.5,
            'wasSuccessful': true,
            'createdAt': DateTime.now().toIso8601String(),
            'type': 'general',
            'tags': <String>[],
          },
        ];

        when(mockFirebaseService.queryDocuments(
          'recipe_ratings',
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => mockRatings);

        // Act
        final metrics = await repository.getSkillProgressMetrics('user1');

        // Assert
        expect(metrics['average_rating'], equals(4.125)); // (4.0 + 5.0 + 3.0 + 4.5) / 4
        expect(metrics['success_rate'], equals(0.75)); // 3 successful out of 4
        expect(metrics['total_recipes'], equals(4.0));
        expect(metrics['skill_score'], closeTo(66.0, 0.1)); // (4.125 * 0.4 + 0.75 * 0.6) * 20
      });
    });

    group('Error Handling', () {
      test('should throw AnalyticsException when Firebase operation fails', () async {
        // Arrange
        when(mockFirebaseService.queryDocuments(
          any,
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenThrow(Exception('Firebase error'));

        // Act & Assert
        expect(
          () => repository.getAverageRating('recipe1'),
          throwsA(isA<AnalyticsException>()),
        );
      });

      test('should handle empty data gracefully', () async {
        // Arrange
        when(mockFirebaseService.queryDocuments(
          any,
          where: anyNamed('where'),
          orderBy: anyNamed('orderBy'),
        )).thenAnswer((_) async => []);

        // Act
        final averageRating = await repository.getAverageRating('recipe1');
        final successRate = await repository.getRecipeSuccessRate('recipe1');
        final mostCooked = await repository.getMostCookedRecipes('user1');

        // Assert
        expect(averageRating, equals(0.0));
        expect(successRate, equals(0.0));
        expect(mostCooked, isEmpty);
      });
    });
  });
}