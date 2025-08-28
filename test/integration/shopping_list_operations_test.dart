import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_services.dart';
import '../../lib/domain/entities/shopping_list.dart';
import '../../lib/domain/entities/recipe.dart';
import '../../lib/domain/entities/pantry_item.dart';
import '../../lib/domain/services/shopping_list_service.dart';
import '../../lib/infrastructure/services/shopping_list_service_impl.dart';

void main() {
  group('Shopping List Operations Integration Tests', () {
    late MockShoppingListRepository mockRepository;
    late MockPantryRepository mockPantryRepository;
    late IShoppingListService shoppingListService;
    
    const testUserId = 'test_user_123';

    setUp(() {
      mockRepository = MockShoppingListRepository();
      mockPantryRepository = MockPantryRepository();
      shoppingListService = ShoppingListServiceImpl(mockRepository, mockPantryRepository);
    });

    group('Shopping List Generation from Recipes', () {
      test('should generate shopping list from recipes with ingredient consolidation', () async {
        // Arrange
        final recipes = [
          createMockRecipe(
            id: 'recipe_1',
            title: 'Pasta Carbonara',
            ingredients: [
              const Ingredient(name: 'Pasta', quantity: 200, unit: 'g'),
              const Ingredient(name: 'Eggs', quantity: 2, unit: 'pieces'),
              const Ingredient(name: 'Bacon', quantity: 100, unit: 'g'),
            ],
          ),
          createMockRecipe(
            id: 'recipe_2',
            title: 'Pasta Salad',
            ingredients: [
              const Ingredient(name: 'Pasta', quantity: 150, unit: 'g'),
              const Ingredient(name: 'Tomatoes', quantity: 3, unit: 'pieces'),
              const Ingredient(name: 'Mozzarella', quantity: 200, unit: 'g'),
            ],
          ),
        ];

        final expectedShoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Recipe Shopping List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Pasta',
              quantity: 350, // Consolidated: 200 + 150
              unit: 'g',
              category: 'grains',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        when(mockPantryRepository.getUserPantryItems(testUserId))
            .thenAnswer((_) async => []);
        when(mockRepository.createShoppingList(any))
            .thenAnswer((_) async => expectedShoppingList);

        // Act
        final result = await shoppingListService.generateFromRecipes(
          recipes,
          testUserId,
          'Recipe Shopping List',
          consolidateIngredients: true,
          excludePantryItems: false,
        );

        // Assert
        expect(result.name, equals('Recipe Shopping List'));
        expect(result.userId, equals(testUserId));
        expect(result.items.isNotEmpty, isTrue);
        
        // Verify pasta was consolidated
        final pastaItem = result.items.firstWhere((item) => item.name == 'Pasta');
        expect(pastaItem.quantity, equals(350));
        
        verify(mockRepository.createShoppingList(any)).called(1);
      });

      test('should exclude pantry items when generating from recipes', () async {
        // Arrange
        final recipes = [
          createMockRecipe(
            id: 'recipe_1',
            title: 'Simple Pasta',
            ingredients: [
              const Ingredient(name: 'Pasta', quantity: 200, unit: 'g'),
              const Ingredient(name: 'Olive Oil', quantity: 2, unit: 'tbsp'),
            ],
          ),
        ];

        final pantryItems = [
          PantryItem(
            id: 'pantry_1',
            name: 'Pasta',
            quantity: 500, // Enough in pantry
            unit: 'g',
            category: PantryCategories.grains,
            createdAt: DateTime.now(),
          ),
        ];

        final expectedShoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Recipe Shopping List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Olive Oil',
              quantity: 2,
              unit: 'tbsp',
              category: 'pantry_staples',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        when(mockPantryRepository.getUserPantryItems(testUserId))
            .thenAnswer((_) async => pantryItems);
        when(mockRepository.createShoppingList(any))
            .thenAnswer((_) async => expectedShoppingList);

        // Act
        final result = await shoppingListService.generateFromRecipes(
          recipes,
          testUserId,
          'Recipe Shopping List',
          excludePantryItems: true,
        );

        // Assert
        expect(result.items.length, equals(1));
        expect(result.items.first.name, equals('Olive Oil'));
        
        // Pasta should not be in the list since it's available in pantry
        final pastaItems = result.items.where((item) => item.name == 'Pasta');
        expect(pastaItems.isEmpty, isTrue);
        
        verify(mockPantryRepository.getUserPantryItems(testUserId)).called(1);
      });
    });

    group('Shopping List Generation from Low Stock', () {
      test('should generate shopping list from low stock pantry items', () async {
        // Arrange
        final lowStockItems = [
          PantryItem(
            id: 'pantry_1',
            name: 'Milk',
            quantity: 0.2,
            unit: 'L',
            category: PantryCategories.dairy,
            minQuantity: 1.0,
            isLowStock: true,
            createdAt: DateTime.now(),
          ),
          PantryItem(
            id: 'pantry_2',
            name: 'Bread',
            quantity: 0.0,
            unit: 'loaf',
            category: PantryCategories.grains,
            minQuantity: 1.0,
            isLowStock: true,
            createdAt: DateTime.now(),
          ),
        ];

        final expectedShoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Low Stock Items',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 2.0, // Restock quantity
              unit: 'L',
              category: 'dairy',
              isUrgent: false,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Bread',
              quantity: 2.0,
              unit: 'loaf',
              category: 'grains',
              isUrgent: true, // Out of stock
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        when(mockPantryRepository.getLowStockItems(testUserId))
            .thenAnswer((_) async => lowStockItems);
        when(mockRepository.createShoppingList(any))
            .thenAnswer((_) async => expectedShoppingList);

        // Act
        final result = await shoppingListService.generateFromLowStock(
          testUserId,
          'Low Stock Items',
        );

        // Assert
        expect(result.name, equals('Low Stock Items'));
        expect(result.items.length, equals(2));
        
        final milkItem = result.items.firstWhere((item) => item.name == 'Milk');
        expect(milkItem.isUrgent, isFalse);
        
        final breadItem = result.items.firstWhere((item) => item.name == 'Bread');
        expect(breadItem.isUrgent, isTrue); // Out of stock
        
        verify(mockPantryRepository.getLowStockItems(testUserId)).called(1);
      });
    });

    group('Shopping List Item Consolidation', () {
      test('should consolidate duplicate items correctly', () async {
        // Arrange
        final shoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Test List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 1.0,
              unit: 'L',
              category: 'dairy',
              estimatedPrice: 3.50,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Milk',
              quantity: 0.5,
              unit: 'L',
              category: 'dairy',
              estimatedPrice: 1.75,
              isUrgent: true,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_3',
              name: 'Bread',
              quantity: 1.0,
              unit: 'loaf',
              category: 'bakery',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        final consolidatedList = shoppingList.copyWith(
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 1.5, // Consolidated quantity
              unit: 'L',
              category: 'dairy',
              estimatedPrice: 2.625, // Average price
              isUrgent: true, // Should inherit urgent flag
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_3',
              name: 'Bread',
              quantity: 1.0,
              unit: 'loaf',
              category: 'bakery',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          updatedAt: DateTime.now(),
        );

        when(mockRepository.updateShoppingList(any))
            .thenAnswer((_) async => consolidatedList);

        // Act
        final result = await shoppingListService.consolidateItems(shoppingList);

        // Assert
        expect(result.items.length, equals(2));
        
        final milkItem = result.items.firstWhere((item) => item.name == 'Milk');
        expect(milkItem.quantity, equals(1.5));
        expect(milkItem.isUrgent, isTrue);
        
        verify(mockRepository.updateShoppingList(any)).called(1);
      });
    });

    group('Shopping List Categorization', () {
      test('should categorize items correctly', () async {
        // Arrange
        final shoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Test List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 1.0,
              unit: 'L',
              category: 'uncategorized',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Chicken Breast',
              quantity: 500,
              unit: 'g',
              category: 'uncategorized',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_3',
              name: 'Bananas',
              quantity: 6,
              unit: 'pieces',
              category: 'uncategorized',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        final categorizedList = shoppingList.copyWith(
          items: [
            ShoppingListItem(
              id: 'item_3',
              name: 'Bananas',
              quantity: 6,
              unit: 'pieces',
              category: 'produce', // Should be categorized as produce
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 1.0,
              unit: 'L',
              category: 'dairy', // Should be categorized as dairy
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Chicken Breast',
              quantity: 500,
              unit: 'g',
              category: 'meat', // Should be categorized as meat
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          updatedAt: DateTime.now(),
        );

        when(mockRepository.updateShoppingList(any))
            .thenAnswer((_) async => categorizedList);

        // Act
        final result = await shoppingListService.categorizeItems(shoppingList);

        // Assert
        expect(result.items.length, equals(3));
        
        final milkItem = result.items.firstWhere((item) => item.name == 'Milk');
        expect(milkItem.category, equals('dairy'));
        
        final chickenItem = result.items.firstWhere((item) => item.name == 'Chicken Breast');
        expect(chickenItem.category, equals('meat'));
        
        final bananaItem = result.items.firstWhere((item) => item.name == 'Bananas');
        expect(bananaItem.category, equals('produce'));
        
        // Items should be sorted by category order (produce first, then dairy, then meat)
        expect(result.items[0].category, equals('produce'));
        expect(result.items[1].category, equals('dairy'));
        expect(result.items[2].category, equals('meat'));
        
        verify(mockRepository.updateShoppingList(any)).called(1);
      });
    });

    group('Shopping List Collaboration', () {
      test('should share shopping list with collaborators', () async {
        // Arrange
        const listId = 'test_list_1';
        final collaboratorIds = ['user_2', 'user_3'];

        when(mockRepository.shareShoppingList(listId, collaboratorIds))
            .thenAnswer((_) async => ShoppingList(
              id: listId,
              name: 'Shared List',
              userId: testUserId,
              items: [],
              createdAt: DateTime.now(),
              isShared: true,
              sharedWith: collaboratorIds,
            ));

        // Act
        await shoppingListService.shareWithCollaborators(listId, collaboratorIds);

        // Assert
        verify(mockRepository.shareShoppingList(listId, collaboratorIds)).called(1);
      });
    });

    group('Shopping List Import/Export', () {
      test('should import shopping list from text correctly', () async {
        // Arrange
        const textInput = '''
        2 L Milk
        1 loaf Bread
        500g Chicken Breast
        Bananas
        3 tbsp Olive Oil
        ''';

        final expectedShoppingList = ShoppingList(
          id: 'imported_list_1',
          name: 'Imported List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 2.0,
              unit: 'L',
              category: 'dairy',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Bread',
              quantity: 1.0,
              unit: 'loaf',
              category: 'bakery',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_3',
              name: 'Chicken Breast',
              quantity: 500.0,
              unit: 'g',
              category: 'meat',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        when(mockRepository.createShoppingList(any))
            .thenAnswer((_) async => expectedShoppingList);

        // Act
        final result = await shoppingListService.importFromText(
          textInput,
          testUserId,
          'Imported List',
        );

        // Assert
        expect(result.name, equals('Imported List'));
        expect(result.items.length, greaterThanOrEqualTo(3));
        
        // Check that quantities and units were parsed correctly
        final milkItem = result.items.firstWhere((item) => item.name == 'Milk');
        expect(milkItem.quantity, equals(2.0));
        expect(milkItem.unit, equals('L'));
        
        verify(mockRepository.createShoppingList(any)).called(1);
      });

      test('should export shopping list as text format', () async {
        // Arrange
        final shoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'My Shopping List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 2.0,
              unit: 'L',
              category: 'dairy',
              isCompleted: false,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Bread',
              quantity: 1.0,
              unit: 'loaf',
              category: 'bakery',
              isCompleted: true,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        // Act
        final result = await shoppingListService.exportShoppingList(
          shoppingList,
          ExportFormat.text,
        );

        // Assert
        expect(result, isNotNull);
        expect(result, contains('My Shopping List'));
        expect(result, contains('Milk'));
        expect(result, contains('Bread'));
        expect(result, contains('2.0 L'));
        expect(result, contains('1.0 loaf'));
        expect(result, contains('☐')); // Uncompleted item
        expect(result, contains('✓')); // Completed item
      });
    });

    group('Smart Suggestions', () {
      test('should provide smart suggestions based on shopping list', () async {
        // Arrange
        final shoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Test List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Pasta',
              quantity: 500,
              unit: 'g',
              category: 'grains',
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        // Act
        final suggestions = await shoppingListService.getSmartSuggestions(
          shoppingList,
          testUserId,
        );

        // Assert
        expect(suggestions.isNotEmpty, isTrue);
        
        // Should suggest pasta sauce since pasta is in the list
        final hasPastaSauce = suggestions.any((item) => 
          item.name.toLowerCase().contains('sauce'));
        expect(hasPastaSauce, isTrue);
      });

      test('should get seasonal recommendations', () async {
        // Act
        final seasonalItems = await shoppingListService.getSeasonalRecommendations(testUserId);

        // Assert
        expect(seasonalItems.isNotEmpty, isTrue);
        
        // All items should have seasonal recommendation note
        for (final item in seasonalItems) {
          expect(item.notes, contains('Seasonal recommendation'));
        }
      });
    });

    group('Price Tracking', () {
      test('should calculate estimated total correctly', () async {
        // Arrange
        final shoppingList = ShoppingList(
          id: 'test_list_1',
          name: 'Test List',
          userId: testUserId,
          items: [
            ShoppingListItem(
              id: 'item_1',
              name: 'Milk',
              quantity: 2.0,
              unit: 'L',
              category: 'dairy',
              estimatedPrice: 3.50,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
            ShoppingListItem(
              id: 'item_2',
              name: 'Bread',
              quantity: 1.0,
              unit: 'loaf',
              category: 'bakery',
              estimatedPrice: 2.25,
              addedAt: DateTime.now(),
              addedBy: testUserId,
            ),
          ],
          createdAt: DateTime.now(),
        );

        // Act
        final total = await shoppingListService.calculateEstimatedTotal(shoppingList);

        // Assert
        // Expected: (2.0 * 3.50) + (1.0 * 2.25) = 7.00 + 2.25 = 9.25
        expect(total, equals(9.25));
      });

      test('should get price comparison across stores', () async {
        // Arrange
        final item = ShoppingListItem(
          id: 'item_1',
          name: 'Milk',
          quantity: 1.0,
          unit: 'L',
          category: 'dairy',
          addedAt: DateTime.now(),
          addedBy: testUserId,
        );

        final storeIds = ['store_1', 'store_2', 'store_3'];

        // Act
        final priceComparison = await shoppingListService.getPriceComparison(item, storeIds);

        // Assert
        expect(priceComparison.length, equals(3));
        expect(priceComparison.containsKey('store_1'), isTrue);
        expect(priceComparison.containsKey('store_2'), isTrue);
        expect(priceComparison.containsKey('store_3'), isTrue);
        
        // All prices should be positive
        for (final price in priceComparison.values) {
          expect(price, greaterThan(0));
        }
      });
    });
  });
}

// Helper function to create mock recipes
Recipe createMockRecipe({
  required String id,
  required String title,
  required List<Ingredient> ingredients,
}) {
  return Recipe(
    id: id,
    title: title,
    description: 'Mock recipe description',
    ingredients: ingredients,
    instructions: [
      const CookingStep(stepNumber: 1, instruction: 'Mock instruction'),
    ],
    cookingTime: const Duration(minutes: 30),
    prepTime: const Duration(minutes: 15),
    difficulty: DifficultyLevel.intermediate,
    servings: 4,
    tags: ['mock'],
    nutrition: const NutritionInfo(
      calories: 300,
      protein: 20,
      carbs: 25,
      fat: 10,
      fiber: 3,
      sugar: 5,
      sodium: 500,
    ),
    rating: 0.0,
    createdAt: DateTime.now(),
  );
}