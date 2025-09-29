import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/infrastructure/services/mock_data/cuisine_data.dart';

void main() {
  group('CuisineData Tests', () {
    test('should return cuisine profile for valid cuisine', () {
      final italianProfile = CuisineData.getCuisine('italian');
      
      expect(italianProfile, isNotNull);
      expect(italianProfile!.name, 'Italian');
      expect(italianProfile.commonIngredients, isNotEmpty);
      expect(italianProfile.spices, isNotEmpty);
      expect(italianProfile.cookingMethods, isNotEmpty);
      expect(italianProfile.dishTypes, isNotEmpty);
    });

    test('should return null for invalid cuisine', () {
      final invalidProfile = CuisineData.getCuisine('invalid_cuisine');
      expect(invalidProfile, isNull);
    });

    test('should handle case insensitive cuisine names', () {
      final upperCaseProfile = CuisineData.getCuisine('ITALIAN');
      final lowerCaseProfile = CuisineData.getCuisine('italian');
      final mixedCaseProfile = CuisineData.getCuisine('Italian');
      
      expect(upperCaseProfile, isNotNull);
      expect(lowerCaseProfile, isNotNull);
      expect(mixedCaseProfile, isNotNull);
      
      expect(upperCaseProfile!.name, lowerCaseProfile!.name);
      expect(lowerCaseProfile.name, mixedCaseProfile!.name);
    });

    test('should return all cuisine names', () {
      final cuisineNames = CuisineData.getAllCuisineNames();
      
      expect(cuisineNames, isNotEmpty);
      expect(cuisineNames, contains('italian'));
      expect(cuisineNames, contains('mexican'));
      expect(cuisineNames, contains('asian'));
      expect(cuisineNames, contains('indian'));
    });

    test('should have consistent data structure for all cuisines', () {
      final cuisineNames = CuisineData.getAllCuisineNames();
      
      for (final cuisineName in cuisineNames) {
        final profile = CuisineData.getCuisine(cuisineName);
        
        expect(profile, isNotNull);
        expect(profile!.name, isNotEmpty);
        expect(profile.commonIngredients, isNotEmpty);
        expect(profile.spices, isNotEmpty);
        expect(profile.cookingMethods, isNotEmpty);
        expect(profile.dishTypes, isNotEmpty);
        expect(profile.equipment, isNotEmpty);
        expect(profile.techniques, isNotEmpty);
      }
    });

    test('should have unique ingredients for different cuisines', () {
      final italianProfile = CuisineData.getCuisine('italian')!;
      final mexicanProfile = CuisineData.getCuisine('mexican')!;
      
      // Should have some different ingredients
      final italianIngredients = italianProfile.commonIngredients.toSet();
      final mexicanIngredients = mexicanProfile.commonIngredients.toSet();
      
      expect(italianIngredients.intersection(mexicanIngredients).length,
             lessThan(italianIngredients.length));
    });

    test('should have cuisine-specific spices', () {
      final indianProfile = CuisineData.getCuisine('indian')!;
      final italianProfile = CuisineData.getCuisine('italian')!;
      
      expect(indianProfile.spices, contains('turmeric'));
      expect(indianProfile.spices, contains('cumin seeds'));
      expect(italianProfile.spices, contains('oregano'));
      expect(italianProfile.spices, contains('dried basil'));
    });

    test('should have appropriate cooking methods for each cuisine', () {
      final asianProfile = CuisineData.getCuisine('asian')!;
      final frenchProfile = CuisineData.getCuisine('french')!;
      
      expect(asianProfile.cookingMethods, contains('stir-frying'));
      expect(frenchProfile.cookingMethods, contains('braising'));
      expect(frenchProfile.cookingMethods, contains('confit'));
    });

    test('should have realistic dish types', () {
      final italianProfile = CuisineData.getCuisine('italian')!;
      final mexicanProfile = CuisineData.getCuisine('mexican')!;
      
      expect(italianProfile.dishTypes, contains('pasta'));
      expect(italianProfile.dishTypes, contains('risotto'));
      expect(mexicanProfile.dishTypes, contains('tacos'));
      expect(mexicanProfile.dishTypes, contains('burritos'));
    });

    test('should have appropriate equipment for each cuisine', () {
      final asianProfile = CuisineData.getCuisine('asian')!;
      final indianProfile = CuisineData.getCuisine('indian')!;
      
      expect(asianProfile.equipment, contains('wok'));
      expect(indianProfile.equipment, contains('pressure cooker'));
    });

    test('should have cooking techniques for each cuisine', () {
      final thaiProfile = CuisineData.getCuisine('thai')!;
      final frenchProfile = CuisineData.getCuisine('french')!;
      
      expect(thaiProfile.techniques, isNotEmpty);
      expect(frenchProfile.techniques, contains('proper sauce making'));
    });
  });
}