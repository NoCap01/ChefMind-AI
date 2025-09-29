/// Comprehensive cuisine-specific data for realistic recipe generation
class CuisineData {
  static const Map<String, CuisineProfile> cuisines = {
    'italian': CuisineProfile(
      name: 'Italian',
      commonIngredients: [
        'olive oil',
        'garlic',
        'tomatoes',
        'basil',
        'oregano',
        'parmesan cheese',
        'mozzarella',
        'pasta',
        'risotto rice',
        'balsamic vinegar',
        'pine nuts',
        'prosciutto',
        'pancetta',
        'rosemary',
        'thyme',
        'red wine'
      ],
      spices: [
        'dried basil',
        'oregano',
        'red pepper flakes',
        'black pepper',
        'sea salt',
        'garlic powder',
        'italian seasoning'
      ],
      cookingMethods: [
        'sautéing',
        'braising',
        'roasting',
        'grilling',
        'simmering'
      ],
      dishTypes: [
        'pasta',
        'risotto',
        'pizza',
        'antipasto',
        'bruschetta',
        'osso buco',
        'carbonara',
        'bolognese',
        'parmigiana',
        'minestrone'
      ],
      equipment: ['pasta pot', 'wooden spoon', 'cheese grater', 'pizza stone'],
      techniques: [
        'al dente pasta cooking',
        'slow simmering sauces',
        'proper cheese melting'
      ],
    ),
    'mexican': CuisineProfile(
      name: 'Mexican',
      commonIngredients: [
        'lime',
        'cilantro',
        'onions',
        'tomatoes',
        'jalapeños',
        'cumin',
        'chili powder',
        'black beans',
        'corn',
        'avocado',
        'cheese',
        'sour cream',
        'bell peppers',
        'garlic',
        'paprika'
      ],
      spices: [
        'cumin',
        'chili powder',
        'paprika',
        'cayenne pepper',
        'oregano',
        'garlic powder',
        'onion powder',
        'chipotle powder'
      ],
      cookingMethods: [
        'grilling',
        'sautéing',
        'roasting',
        'charring',
        'slow cooking'
      ],
      dishTypes: [
        'tacos',
        'burritos',
        'quesadillas',
        'enchiladas',
        'fajitas',
        'nachos',
        'guacamole',
        'salsa',
        'pozole',
        'mole'
      ],
      equipment: ['cast iron skillet', 'molcajete', 'tortilla press', 'comal'],
      techniques: [
        'charring peppers',
        'proper lime juicing',
        'layering flavors'
      ],
    ),
    'asian': CuisineProfile(
      name: 'Asian',
      commonIngredients: [
        'soy sauce',
        'ginger',
        'garlic',
        'sesame oil',
        'rice vinegar',
        'green onions',
        'bok choy',
        'mushrooms',
        'rice',
        'noodles',
        'miso paste',
        'sriracha',
        'fish sauce',
        'coconut milk'
      ],
      spices: [
        'five-spice powder',
        'white pepper',
        'sesame seeds',
        'star anise',
        'ginger powder',
        'garlic powder',
        'red pepper flakes'
      ],
      cookingMethods: [
        'stir-frying',
        'steaming',
        'braising',
        'deep-frying',
        'blanching'
      ],
      dishTypes: [
        'stir-fry',
        'fried rice',
        'noodle soup',
        'dumplings',
        'spring rolls',
        'pad thai',
        'ramen',
        'curry',
        'teriyaki',
        'tempura'
      ],
      equipment: ['wok', 'bamboo steamer', 'rice cooker', 'chopsticks'],
      techniques: [
        'high-heat stir-frying',
        'proper rice cooking',
        'umami balancing'
      ],
    ),
    'indian': CuisineProfile(
      name: 'Indian',
      commonIngredients: [
        'turmeric',
        'cumin',
        'coriander',
        'garam masala',
        'ginger',
        'garlic',
        'onions',
        'tomatoes',
        'coconut milk',
        'yogurt',
        'basmati rice',
        'lentils',
        'chickpeas',
        'cilantro',
        'mint',
        'ghee'
      ],
      spices: [
        'turmeric',
        'cumin seeds',
        'coriander seeds',
        'cardamom',
        'cinnamon',
        'cloves',
        'bay leaves',
        'mustard seeds',
        'fenugreek',
        'asafoetida'
      ],
      cookingMethods: [
        'tempering',
        'slow cooking',
        'pressure cooking',
        'roasting spices',
        'simmering'
      ],
      dishTypes: [
        'curry',
        'dal',
        'biryani',
        'tandoori',
        'samosa',
        'naan',
        'chapati',
        'raita',
        'chutney',
        'korma',
        'vindaloo',
        'masala'
      ],
      equipment: ['pressure cooker', 'tawa', 'tandoor', 'spice grinder'],
      techniques: [
        'spice tempering',
        'layered cooking',
        'proper spice roasting'
      ],
    ),
    'thai': CuisineProfile(
      name: 'Thai',
      commonIngredients: [
        'fish sauce',
        'lime juice',
        'coconut milk',
        'thai basil',
        'lemongrass',
        'galangal',
        'kaffir lime leaves',
        'thai chilies',
        'palm sugar',
        'tamarind paste',
        'shallots',
        'garlic',
        'ginger'
      ],
      spices: [
        'white pepper',
        'coriander seeds',
        'cumin',
        'thai chili powder',
        'dried galangal',
        'dried lemongrass'
      ],
      cookingMethods: [
        'stir-frying',
        'steaming',
        'grilling',
        'boiling',
        'pounding'
      ],
      dishTypes: [
        'pad thai',
        'green curry',
        'tom yum',
        'som tam',
        'massaman',
        'larb',
        'pad krapow',
        'mango sticky rice',
        'thai fried rice'
      ],
      equipment: [
        'mortar and pestle',
        'wok',
        'bamboo steamer',
        'coconut grater'
      ],
      techniques: [
        'balancing sweet, sour, salty, spicy',
        'proper herb preparation'
      ],
    ),
    'french': CuisineProfile(
      name: 'French',
      commonIngredients: [
        'butter',
        'cream',
        'wine',
        'shallots',
        'herbs de provence',
        'thyme',
        'bay leaves',
        'parsley',
        'tarragon',
        'chives',
        'gruyere cheese',
        'brie',
        'mushrooms',
        'leeks'
      ],
      spices: [
        'white pepper',
        'black pepper',
        'nutmeg',
        'paprika',
        'herbs de provence',
        'fine herbs'
      ],
      cookingMethods: [
        'sautéing',
        'braising',
        'roasting',
        'poaching',
        'flambéing',
        'confit'
      ],
      dishTypes: [
        'coq au vin',
        'bouillabaisse',
        'ratatouille',
        'quiche',
        'soufflé',
        'cassoulet',
        'confit',
        'bisque',
        'tarte tatin',
        'crème brûlée'
      ],
      equipment: ['copper pots', 'mandoline', 'whisk', 'ramekins'],
      techniques: [
        'proper sauce making',
        'knife skills',
        'temperature control'
      ],
    ),
    'mediterranean': CuisineProfile(
      name: 'Mediterranean',
      commonIngredients: [
        'olive oil',
        'lemon',
        'garlic',
        'tomatoes',
        'olives',
        'feta cheese',
        'oregano',
        'basil',
        'cucumber',
        'red onion',
        'capers',
        'pine nuts',
        'sun-dried tomatoes',
        'artichokes'
      ],
      spices: [
        'oregano',
        'thyme',
        'rosemary',
        'sumac',
        'za\'atar',
        'black pepper',
        'sea salt'
      ],
      cookingMethods: [
        'grilling',
        'roasting',
        'sautéing',
        'marinating',
        'braising'
      ],
      dishTypes: [
        'greek salad',
        'hummus',
        'tabbouleh',
        'moussaka',
        'spanakopita',
        'paella',
        'gazpacho',
        'bruschetta',
        'caprese',
        'ratatouille'
      ],
      equipment: ['grill pan', 'mortar and pestle', 'olive oil cruet'],
      techniques: [
        'proper olive oil usage',
        'herb combinations',
        'fresh ingredient focus'
      ],
    ),
    'american': CuisineProfile(
      name: 'American',
      commonIngredients: [
        'ground beef',
        'chicken',
        'potatoes',
        'onions',
        'cheese',
        'bacon',
        'corn',
        'tomatoes',
        'lettuce',
        'pickles',
        'barbecue sauce',
        'ketchup',
        'mustard',
        'mayonnaise'
      ],
      spices: [
        'black pepper',
        'garlic powder',
        'onion powder',
        'paprika',
        'chili powder',
        'barbecue seasoning',
        'salt'
      ],
      cookingMethods: [
        'grilling',
        'frying',
        'baking',
        'roasting',
        'smoking',
        'barbecuing'
      ],
      dishTypes: [
        'burger',
        'mac and cheese',
        'fried chicken',
        'barbecue ribs',
        'meatloaf',
        'apple pie',
        'coleslaw',
        'potato salad',
        'chili'
      ],
      equipment: ['grill', 'cast iron skillet', 'smoker', 'deep fryer'],
      techniques: [
        'proper grilling',
        'smoking meats',
        'comfort food preparation'
      ],
    ),
    'japanese': CuisineProfile(
      name: 'Japanese',
      commonIngredients: [
        'soy sauce',
        'miso paste',
        'rice vinegar',
        'mirin',
        'sake',
        'dashi',
        'nori',
        'wasabi',
        'ginger',
        'sesame oil',
        'short-grain rice',
        'tofu',
        'shiitake mushrooms'
      ],
      spices: [
        'shichimi togarashi',
        'sesame seeds',
        'wasabi powder',
        'nori flakes',
        'bonito flakes'
      ],
      cookingMethods: [
        'steaming',
        'grilling',
        'simmering',
        'tempura frying',
        'sashimi cutting'
      ],
      dishTypes: [
        'sushi',
        'ramen',
        'tempura',
        'teriyaki',
        'miso soup',
        'yakitori',
        'donburi',
        'onigiri',
        'katsu',
        'udon'
      ],
      equipment: ['rice cooker', 'bamboo mat', 'sharp knives', 'chopsticks'],
      techniques: [
        'proper rice preparation',
        'knife skills',
        'umami development'
      ],
    ),
  };

  static CuisineProfile? getCuisine(String? cuisineName) {
    if (cuisineName == null) return null;
    return cuisines[cuisineName.toLowerCase()];
  }

  static List<String> getAllCuisineNames() {
    return cuisines.keys.toList();
  }
}

class CuisineProfile {
  final String name;
  final List<String> commonIngredients;
  final List<String> spices;
  final List<String> cookingMethods;
  final List<String> dishTypes;
  final List<String> equipment;
  final List<String> techniques;

  const CuisineProfile({
    required this.name,
    required this.commonIngredients,
    required this.spices,
    required this.cookingMethods,
    required this.dishTypes,
    required this.equipment,
    required this.techniques,
  });
}
