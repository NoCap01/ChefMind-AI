import '../../../domain/enums/dietary_restriction.dart';

/// Dietary restriction-aware recipe data and substitutions
class DietaryData {
  static const Map<DietaryRestriction, DietaryProfile> profiles = {
    DietaryRestriction.vegetarian: DietaryProfile(
      name: 'Vegetarian',
      allowedProteins: [
        'tofu',
        'tempeh',
        'beans',
        'lentils',
        'chickpeas',
        'eggs',
        'cheese',
        'yogurt',
        'nuts',
        'seeds',
        'quinoa'
      ],
      forbiddenIngredients: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'salmon',
        'shrimp',
        'tuna',
        'bacon',
        'ham',
        'sausage',
        'ground meat',
        'chicken broth',
        'beef broth'
      ],
      substitutions: {
        'chicken': 'tofu or tempeh',
        'beef': 'mushrooms or lentils',
        'fish': 'tofu or chickpeas',
        'chicken broth': 'vegetable broth',
        'beef broth': 'mushroom broth',
        'bacon': 'smoky tempeh',
      },
      commonIngredients: [
        'vegetables',
        'fruits',
        'grains',
        'legumes',
        'nuts',
        'seeds',
        'dairy products',
        'eggs',
        'herbs',
        'spices'
      ],
      nutritionFocus: [
        'protein from legumes',
        'iron from leafy greens',
        'B12 supplementation'
      ],
    ),
    DietaryRestriction.vegan: DietaryProfile(
      name: 'Vegan',
      allowedProteins: [
        'tofu',
        'tempeh',
        'beans',
        'lentils',
        'chickpeas',
        'nuts',
        'seeds',
        'quinoa',
        'nutritional yeast',
        'plant-based protein'
      ],
      forbiddenIngredients: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'eggs',
        'milk',
        'cheese',
        'butter',
        'yogurt',
        'cream',
        'honey',
        'gelatin',
        'whey'
      ],
      substitutions: {
        'chicken': 'seasoned tofu or jackfruit',
        'beef': 'mushrooms or lentils',
        'eggs': 'flax eggs or aquafaba',
        'milk': 'almond milk or oat milk',
        'cheese': 'nutritional yeast or cashew cheese',
        'butter': 'vegan butter or coconut oil',
        'honey': 'maple syrup or agave',
      },
      commonIngredients: [
        'vegetables',
        'fruits',
        'grains',
        'legumes',
        'nuts',
        'seeds',
        'plant-based milks',
        'nutritional yeast',
        'coconut products'
      ],
      nutritionFocus: [
        'complete proteins',
        'B12',
        'iron',
        'calcium',
        'omega-3'
      ],
    ),
    DietaryRestriction.glutenFree: DietaryProfile(
      name: 'Gluten-Free',
      allowedProteins: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'eggs',
        'tofu',
        'beans',
        'lentils',
        'nuts',
        'seeds',
        'dairy products'
      ],
      forbiddenIngredients: [
        'wheat flour',
        'bread',
        'pasta',
        'barley',
        'rye',
        'bulgur',
        'couscous',
        'seitan',
        'soy sauce',
        'beer',
        'malt'
      ],
      substitutions: {
        'wheat flour': 'almond flour or rice flour',
        'bread': 'gluten-free bread',
        'pasta': 'rice noodles or zucchini noodles',
        'soy sauce': 'tamari or coconut aminos',
        'breadcrumbs': 'crushed rice crackers',
      },
      commonIngredients: [
        'rice',
        'quinoa',
        'potatoes',
        'corn',
        'vegetables',
        'fruits',
        'meats',
        'fish',
        'dairy',
        'gluten-free grains'
      ],
      nutritionFocus: ['fiber from vegetables', 'B vitamins', 'iron'],
    ),
    DietaryRestriction.dairyFree: DietaryProfile(
      name: 'Dairy-Free',
      allowedProteins: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'eggs',
        'tofu',
        'beans',
        'lentils',
        'nuts',
        'seeds'
      ],
      forbiddenIngredients: [
        'milk',
        'cheese',
        'butter',
        'yogurt',
        'cream',
        'ice cream',
        'whey',
        'casein',
        'lactose'
      ],
      substitutions: {
        'milk': 'almond milk or coconut milk',
        'cheese': 'nutritional yeast or dairy-free cheese',
        'butter': 'coconut oil or vegan butter',
        'yogurt': 'coconut yogurt',
        'cream': 'coconut cream',
      },
      commonIngredients: [
        'vegetables',
        'fruits',
        'grains',
        'legumes',
        'nuts',
        'seeds',
        'meats',
        'fish',
        'plant-based milks'
      ],
      nutritionFocus: ['calcium from leafy greens', 'vitamin D'],
    ),
    DietaryRestriction.keto: DietaryProfile(
      name: 'Ketogenic',
      allowedProteins: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'eggs',
        'cheese',
        'nuts',
        'seeds',
        'avocado'
      ],
      forbiddenIngredients: [
        'bread',
        'pasta',
        'rice',
        'potatoes',
        'sugar',
        'fruits',
        'beans',
        'lentils',
        'quinoa',
        'oats'
      ],
      substitutions: {
        'pasta': 'zucchini noodles or shirataki noodles',
        'rice': 'cauliflower rice',
        'potatoes': 'turnips or radishes',
        'bread': 'almond flour bread',
        'sugar': 'stevia or erythritol',
      },
      commonIngredients: [
        'meats',
        'fish',
        'eggs',
        'cheese',
        'nuts',
        'seeds',
        'low-carb vegetables',
        'healthy fats',
        'avocado'
      ],
      nutritionFocus: ['high fat', 'moderate protein', 'very low carb'],
    ),
    DietaryRestriction.paleo: DietaryProfile(
      name: 'Paleo',
      allowedProteins: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'eggs',
        'nuts',
        'seeds'
      ],
      forbiddenIngredients: [
        'grains',
        'legumes',
        'dairy',
        'processed foods',
        'sugar',
        'bread',
        'pasta',
        'beans',
        'peanuts'
      ],
      substitutions: {
        'pasta': 'spiralized vegetables',
        'rice': 'cauliflower rice',
        'beans': 'nuts or seeds',
        'milk': 'coconut milk',
        'flour': 'almond flour or coconut flour',
      },
      commonIngredients: [
        'meats',
        'fish',
        'eggs',
        'vegetables',
        'fruits',
        'nuts',
        'seeds',
        'healthy oils',
        'herbs',
        'spices'
      ],
      nutritionFocus: ['whole foods', 'healthy fats', 'quality proteins'],
    ),
    DietaryRestriction.lowCarb: DietaryProfile(
      name: 'Low Carb',
      allowedProteins: [
        'chicken',
        'beef',
        'pork',
        'fish',
        'eggs',
        'cheese',
        'tofu',
        'nuts',
        'seeds'
      ],
      forbiddenIngredients: [
        'bread',
        'pasta',
        'rice',
        'potatoes',
        'sugar',
        'high-carb fruits'
      ],
      substitutions: {
        'pasta': 'zucchini noodles',
        'rice': 'cauliflower rice',
        'potatoes': 'turnips',
        'bread': 'lettuce wraps',
        'sugar': 'stevia',
      },
      commonIngredients: [
        'meats',
        'fish',
        'eggs',
        'cheese',
        'low-carb vegetables',
        'nuts',
        'seeds',
        'healthy fats'
      ],
      nutritionFocus: ['protein', 'healthy fats', 'fiber from vegetables'],
    ),
  };

  static DietaryProfile? getProfile(DietaryRestriction restriction) {
    return profiles[restriction];
  }

  static List<String> getSubstitutions(
      List<DietaryRestriction> restrictions, String ingredient) {
    final substitutions = <String>[];

    for (final restriction in restrictions) {
      final profile = profiles[restriction];
      if (profile != null &&
          profile.substitutions.containsKey(ingredient.toLowerCase())) {
        substitutions.add(profile.substitutions[ingredient.toLowerCase()]!);
      }
    }

    return substitutions.isEmpty ? [ingredient] : substitutions;
  }

  static bool isIngredientAllowed(
      List<DietaryRestriction> restrictions, String ingredient) {
    for (final restriction in restrictions) {
      final profile = profiles[restriction];
      if (profile != null) {
        if (profile.forbiddenIngredients.any((forbidden) =>
            ingredient.toLowerCase().contains(forbidden.toLowerCase()))) {
          return false;
        }
      }
    }
    return true;
  }

  static List<String> getRecommendedIngredients(
      List<DietaryRestriction> restrictions) {
    final recommended = <String>[];

    for (final restriction in restrictions) {
      final profile = profiles[restriction];
      if (profile != null) {
        recommended.addAll(profile.commonIngredients);
      }
    }

    return recommended.toSet().toList();
  }
}

class DietaryProfile {
  final String name;
  final List<String> allowedProteins;
  final List<String> forbiddenIngredients;
  final Map<String, String> substitutions;
  final List<String> commonIngredients;
  final List<String> nutritionFocus;

  const DietaryProfile({
    required this.name,
    required this.allowedProteins,
    required this.forbiddenIngredients,
    required this.substitutions,
    required this.commonIngredients,
    required this.nutritionFocus,
  });
}
