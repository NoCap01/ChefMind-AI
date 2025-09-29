enum DietaryRestriction {
  none,
  vegetarian,
  vegan,
  glutenFree,
  dairyFree,
  nutFree,
  lowCarb,
  keto,
  paleo,
  lowSodium,
  diabetic,
  halal,
  kosher;

  String get displayName {
    switch (this) {
      case DietaryRestriction.none:
        return 'No Restrictions';
      case DietaryRestriction.vegetarian:
        return 'Vegetarian';
      case DietaryRestriction.vegan:
        return 'Vegan';
      case DietaryRestriction.glutenFree:
        return 'Gluten-Free';
      case DietaryRestriction.dairyFree:
        return 'Dairy-Free';
      case DietaryRestriction.nutFree:
        return 'Nut-Free';
      case DietaryRestriction.lowCarb:
        return 'Low Carb';
      case DietaryRestriction.keto:
        return 'Ketogenic';
      case DietaryRestriction.paleo:
        return 'Paleo';
      case DietaryRestriction.lowSodium:
        return 'Low Sodium';
      case DietaryRestriction.diabetic:
        return 'Diabetic-Friendly';
      case DietaryRestriction.halal:
        return 'Halal';
      case DietaryRestriction.kosher:
        return 'Kosher';
    }
  }

  List<String> get restrictedIngredients {
    switch (this) {
      case DietaryRestriction.none:
        return [];
      case DietaryRestriction.vegetarian:
        return ['meat', 'poultry', 'fish', 'seafood'];
      case DietaryRestriction.vegan:
        return ['meat', 'poultry', 'fish', 'seafood', 'dairy', 'eggs', 'honey'];
      case DietaryRestriction.glutenFree:
        return ['wheat', 'barley', 'rye', 'gluten'];
      case DietaryRestriction.dairyFree:
        return ['milk', 'cheese', 'butter', 'yogurt', 'cream'];
      case DietaryRestriction.nutFree:
        return ['nuts', 'peanuts', 'tree nuts'];
      case DietaryRestriction.lowCarb:
        return ['bread', 'pasta', 'rice', 'potatoes', 'sugar'];
      case DietaryRestriction.keto:
        return ['bread', 'pasta', 'rice', 'potatoes', 'sugar', 'fruits'];
      case DietaryRestriction.paleo:
        return ['grains', 'legumes', 'dairy', 'processed foods'];
      case DietaryRestriction.lowSodium:
        return ['high-sodium foods', 'processed meats', 'canned soups'];
      case DietaryRestriction.diabetic:
        return ['high-sugar foods', 'refined carbohydrates'];
      case DietaryRestriction.halal:
        return ['pork', 'alcohol', 'non-halal meat'];
      case DietaryRestriction.kosher:
        return ['pork', 'shellfish', 'mixing meat and dairy'];
    }
  }
}
