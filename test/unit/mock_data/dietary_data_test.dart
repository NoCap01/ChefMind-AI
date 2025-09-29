import 'package:flutter_test/flutter_test.dart';
import 'package:chefmind_ai/infrastructure/services/mock_data/dietary_data.dart';
import 'package:chefmind_ai/domain/enums/dietary_restriction.dart';

void main() {
  group('DietaryData Tests', () {
    test('should return profile for valid dietary restriction', () {
      final veganProfile = DietaryData.getProfile(DietaryRestriction.vegan);
      
      expect(veganProfile, isNotNull);
      expect(veganProfile!.name, 'Vegan');
      expect(veganProfile.allowedProteins, isNotEmpty);
      expect(veganProfile.forbiddenIngredients, isNotEmpty);
      expect(veganProfile.substitutions, isNotEmpty);
      expect(veganProfile.commonIngredients, isNotEmpty);
      expect(veganProfile.nutritionFocus, isNotEmpty);
    });

    test('should return null for unsupported dietary restriction', () {
      final noneProfile = DietaryData.getProfile(DietaryRestriction.none);
      expect(noneProfile, isNull);
    });

    test('should provide appropriate substitutions', () {
      final substitutions = DietaryData.getSubstitutions(
        [DietaryRestriction.vegan], 
        'chicken'
      );
      
      expect(substitutions, isNotEmpty);
      expect(substitutions.first, contains('tofu'));
    });

    test('should return original ingredient when no substitutions available', () {
      final substitutions = DietaryData.getSubstitutions(
        [DietaryRestriction.vegan], 
        'unknown_ingredient'
      );
      
      expect(substitutions, contains('unknown_ingredient'));
    });

    test('should correctly identify forbidden ingredients', () {
      expect(DietaryData.isIngredientAllowed(
        [DietaryRestriction.vegan], 
        'chicken'
      ), isFalse);
      
      expect(DietaryData.isIngredientAllowed(
        [DietaryRestriction.vegan], 
        'tofu'
      ), isTrue);
      
      expect(DietaryData.isIngredientAllowed(
        [DietaryRestriction.glutenFree], 
        'wheat flour'
      ), isFalse);
      
      expect(DietaryData.isIngredientAllowed(
        [DietaryRestriction.glutenFree], 
        'rice flour'
      ), isTrue);
    });

    test('should handle multiple dietary restrictions', () {
      final restrictions = [
        DietaryRestriction.vegan,
        DietaryRestriction.glutenFree,
      ];
      
      expect(DietaryData.isIngredientAllowed(restrictions, 'chicken'), isFalse);
      expect(DietaryData.isIngredientAllowed(restrictions, 'wheat flour'), isFalse);
      expect(DietaryData.isIngredientAllowed(restrictions, 'rice'), isTrue);
    });

    test('should provide recommended ingredients for dietary restrictions', () {
      final veganRecommendations = DietaryData.getRecommendedIngredients(
        [DietaryRestriction.vegan]
      );
      
      expect(veganRecommendations, isNotEmpty);
      expect(veganRecommendations, contains('vegetables'));
      expect(veganRecommendations, contains('legumes'));
    });

    test('should have appropriate vegan substitutions', () {
      final veganProfile = DietaryData.getProfile(DietaryRestriction.vegan)!;
      
      expect(veganProfile.substitutions['eggs'], isNotNull);
      expect(veganProfile.substitutions['milk'], isNotNull);
      expect(veganProfile.substitutions['cheese'], isNotNull);
      expect(veganProfile.substitutions['butter'], isNotNull);
    });

    test('should have appropriate vegetarian restrictions', () {
      final vegetarianProfile = DietaryData.getProfile(DietaryRestriction.vegetarian)!;
      
      expect(vegetarianProfile.forbiddenIngredients, contains('chicken'));
      expect(vegetarianProfile.forbiddenIngredients, contains('beef'));
      expect(vegetarianProfile.forbiddenIngredients, contains('fish'));
      
      expect(vegetarianProfile.allowedProteins, contains('eggs'));
      expect(vegetarianProfile.allowedProteins, contains('cheese'));
    });

    test('should have appropriate gluten-free substitutions', () {
      final glutenFreeProfile = DietaryData.getProfile(DietaryRestriction.glutenFree)!;
      
      expect(glutenFreeProfile.substitutions['wheat flour'], contains('flour'));
      expect(glutenFreeProfile.substitutions['bread'], contains('gluten-free'));
      expect(glutenFreeProfile.substitutions['pasta'], isNotNull);
    });

    test('should have appropriate keto restrictions', () {
      final ketoProfile = DietaryData.getProfile(DietaryRestriction.keto)!;
      
      expect(ketoProfile.forbiddenIngredients, contains('bread'));
      expect(ketoProfile.forbiddenIngredients, contains('pasta'));
      expect(ketoProfile.forbiddenIngredients, contains('rice'));
      expect(ketoProfile.forbiddenIngredients, contains('sugar'));
      
      expect(ketoProfile.allowedProteins, contains('chicken'));
      expect(ketoProfile.allowedProteins, contains('cheese'));
    });

    test('should have appropriate paleo restrictions', () {
      final paleoProfile = DietaryData.getProfile(DietaryRestriction.paleo)!;
      
      expect(paleoProfile.forbiddenIngredients, contains('grains'));
      expect(paleoProfile.forbiddenIngredients, contains('legumes'));
      expect(paleoProfile.forbiddenIngredients, contains('dairy'));
      
      expect(paleoProfile.allowedProteins, contains('chicken'));
      expect(paleoProfile.allowedProteins, contains('fish'));
    });

    test('should have appropriate dairy-free substitutions', () {
      final dairyFreeProfile = DietaryData.getProfile(DietaryRestriction.dairyFree)!;
      
      expect(dairyFreeProfile.substitutions['milk'], contains('milk'));
      expect(dairyFreeProfile.substitutions['cheese'], isNotNull);
      expect(dairyFreeProfile.substitutions['butter'], isNotNull);
    });

    test('should have appropriate low-carb restrictions', () {
      final lowCarbProfile = DietaryData.getProfile(DietaryRestriction.lowCarb)!;
      
      expect(lowCarbProfile.forbiddenIngredients, contains('bread'));
      expect(lowCarbProfile.forbiddenIngredients, contains('pasta'));
      expect(lowCarbProfile.forbiddenIngredients, contains('rice'));
    });

    test('should provide nutrition focus for each restriction', () {
      final veganProfile = DietaryData.getProfile(DietaryRestriction.vegan)!;
      final ketoProfile = DietaryData.getProfile(DietaryRestriction.keto)!;
      
      expect(veganProfile.nutritionFocus, contains('B12'));
      expect(ketoProfile.nutritionFocus, contains('high fat'));
    });

    test('should handle case insensitive ingredient checking', () {
      expect(DietaryData.isIngredientAllowed(
        [DietaryRestriction.vegan], 
        'CHICKEN'
      ), isFalse);
      
      expect(DietaryData.isIngredientAllowed(
        [DietaryRestriction.vegan], 
        'Chicken Breast'
      ), isFalse);
    });

    test('should provide multiple substitutions when available', () {
      final substitutions = DietaryData.getSubstitutions(
        [DietaryRestriction.vegan, DietaryRestriction.glutenFree], 
        'chicken'
      );
      
      expect(substitutions.length, greaterThanOrEqualTo(1));
    });

    test('should combine recommendations from multiple restrictions', () {
      final recommendations = DietaryData.getRecommendedIngredients([
        DietaryRestriction.vegan,
        DietaryRestriction.glutenFree,
      ]);
      
      expect(recommendations, isNotEmpty);
      // Should contain ingredients that satisfy both restrictions
      expect(recommendations, contains('vegetables'));
    });
  });
}