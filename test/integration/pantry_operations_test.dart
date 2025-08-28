import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_services.dart';
import '../../lib/domain/entities/pantry_item.dart';
import '../../lib/domain/services/pantry_service.dart';
import '../../lib/infrastructure/services/pantry_service_impl.dart';

void main() {
  group('Pantry Operations Integration Tests', () {
    late MockPantryRepository mockRepository;
    late MockBarcodeScannerService mockBarcodeService;
    late IPantryService pantryService;
    
    const testUserId = 'test_user_123';

    setUp(() {
      mockRepository = MockPantryRepository();
      mockBarcodeService = MockBarcodeScannerService();
      pantryService = PantryServiceImpl(mockRepository, mockBarcodeService);
    });

    group('Pantry Item Addition', () {
      test('should add item with manual entry successfully', () async {
        // Arrange
        final testItem = PantryItem(
          id: 'test_item_1',
          name: 'Test Milk',
          quantity: 2.0,
          unit: 'L',
          category: PantryCategories.dairy,
          createdAt: DateTime.now(),
        );

        when(mockRepository.addPantryItem(any))
            .thenAnswer((_) async => testItem);

        // Act
        final result = await mockRepository.addPantryItem(testItem);

        // Assert
        expect(result.id, equals('test_item_1'));
        expect(result.name, equals('Test Milk'));
        expect(result.quantity, equals(2.0));
        expect(result.category.id, equals('dairy'));
        verify(mockRepository.addPantryItem(testItem)).called(1);
      });

      test('should add item with barcode scanning successfully', () async {
        // Arrange
        const testBarcode = '123456789012';
        final mockProductInfo = MockProductInfo(
          barcode: testBarcode,
          name: 'Organic Milk',
          brand: 'Organic Valley',
          category: 'dairy',
          unit: 'L',
        );

        final expectedItem = PantryItem(
          id: 'scanned_item_1',
          name: 'Organic Milk',
          quantity: 1.0,
          unit: 'L',
          category: PantryCategories.dairy,
          barcode: testBarcode,
          brand: 'Organic Valley',
          createdAt: DateTime.now(),
        );

        when(mockRepository.getPantryItemByBarcode(testUserId, testBarcode))
            .thenAnswer((_) async => null);
        when(mockBarcodeService.getProductInfo(testBarcode))
            .thenAnswer((_) async => mockProductInfo);
        when(mockRepository.addPantryItem(any))
            .thenAnswer((_) async => expectedItem);

        // Act
        final result = await pantryService.addItemWithBarcode(testBarcode, testUserId);

        // Assert
        expect(result.name, equals('Organic Milk'));
        expect(result.barcode, equals(testBarcode));
        expect(result.brand, equals('Organic Valley'));
        expect(result.category.id, equals('dairy'));
        verify(mockBarcodeService.getProductInfo(testBarcode)).called(1);
        verify(mockRepository.addPantryItem(any)).called(1);
      });

      test('should throw conflict exception when barcode already exists', () async {
        // Arrange
        const testBarcode = '123456789012';
        final existingItem = PantryItem(
          id: 'existing_item',
          name: 'Existing Milk',
          quantity: 1.0,
          unit: 'L',
          category: PantryCategories.dairy,
          barcode: testBarcode,
          createdAt: DateTime.now(),
        );

        when(mockRepository.getPantryItemByBarcode(testUserId, testBarcode))
            .thenAnswer((_) async => existingItem);

        // Act & Assert
        expect(
          () => pantryService.addItemWithBarcode(testBarcode, testUserId),
          throwsA(isA<ConflictException>()),
        );
        verify(mockRepository.getPantryItemByBarcode(testUserId, testBarcode)).called(1);
        verifyNever(mockBarcodeService.getProductInfo(any));
        verifyNever(mockRepository.addPantryItem(any));
      });
    });

    group('Expiry Notifications', () {
      test('should generate expiry notifications correctly', () async {
        // Arrange
        final now = DateTime.now();
        final expiringItems = [
          PantryItem(
            id: 'item_1',
            name: 'Milk',
            quantity: 1.0,
            unit: 'L',
            category: PantryCategories.dairy,
            expiryDate: now.add(const Duration(days: 1)), // Tomorrow
            createdAt: now.subtract(const Duration(days: 5)),
          ),
          PantryItem(
            id: 'item_2',
            name: 'Bread',
            quantity: 1.0,
            unit: 'loaf',
            category: PantryCategories.grains,
            expiryDate: now.subtract(const Duration(days: 1)), // Yesterday (expired)
            createdAt: now.subtract(const Duration(days: 7)),
          ),
          PantryItem(
            id: 'item_3',
            name: 'Yogurt',
            quantity: 2.0,
            unit: 'cup',
            category: PantryCategories.dairy,
            expiryDate: now.add(const Duration(days: 3)), // In 3 days
            createdAt: now.subtract(const Duration(days: 2)),
          ),
        ];

        when(mockRepository.getExpiringItems(testUserId, 7))
            .thenAnswer((_) async => expiringItems);

        // Act
        final notifications = await pantryService.getExpiryNotifications(testUserId);

        // Assert
        expect(notifications.length, equals(3));
        
        // Check that expired item has urgent priority
        final expiredNotification = notifications.firstWhere((n) => n.itemName == 'Bread');
        expect(expiredNotification.priority, equals(NotificationPriority.urgent));
        expect(expiredNotification.daysUntilExpiry, equals(-1));

        // Check that item expiring tomorrow has high priority
        final tomorrowNotification = notifications.firstWhere((n) => n.itemName == 'Milk');
        expect(tomorrowNotification.priority, equals(NotificationPriority.high));
        expect(tomorrowNotification.daysUntilExpiry, equals(1));

        // Check that item expiring in 3 days has medium priority
        final mediumNotification = notifications.firstWhere((n) => n.itemName == 'Yogurt');
        expect(mediumNotification.priority, equals(NotificationPriority.medium));
        expect(mediumNotification.daysUntilExpiry, equals(3));

        verify(mockRepository.getExpiringItems(testUserId, 7)).called(1);
      });

      test('should suggest recipes for expiring items', () async {
        // Arrange
        final expiringItems = [
          PantryItem(
            id: 'item_1',
            name: 'Chicken',
            quantity: 1.0,
            unit: 'lb',
            category: PantryCategories.meat,
            expiryDate: DateTime.now().add(const Duration(days: 2)),
            createdAt: DateTime.now().subtract(const Duration(days: 3)),
          ),
          PantryItem(
            id: 'item_2',
            name: 'Carrots',
            quantity: 5.0,
            unit: 'pieces',
            category: PantryCategories.vegetables,
            expiryDate: DateTime.now().add(const Duration(days: 1)),
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
        ];

        when(mockRepository.getExpiringItems(testUserId, 7))
            .thenAnswer((_) async => expiringItems);

        // Act
        final suggestions = await pantryService.suggestRecipesForExpiringItems(testUserId);

        // Assert
        expect(suggestions.isNotEmpty, isTrue);
        expect(suggestions.length, lessThanOrEqualTo(10));
        
        // Should contain recipes for both meat and vegetables
        final hasChickenRecipe = suggestions.any((recipe) => 
            recipe.toLowerCase().contains('chicken'));
        final hasVegetableRecipe = suggestions.any((recipe) => 
            recipe.toLowerCase().contains('vegetable') || 
            recipe.toLowerCase().contains('stir fry'));
        
        expect(hasChickenRecipe, isTrue);
        expect(hasVegetableRecipe, isTrue);

        verify(mockRepository.getExpiringItems(testUserId, 7)).called(1);
      });
    });

    group('Shopping List Generation', () {
      test('should generate shopping list from low stock items', () async {
        // Arrange
        final lowStockItems = [
          PantryItem(
            id: 'item_1',
            name: 'Milk',
            quantity: 0.5,
            unit: 'L',
            category: PantryCategories.dairy,
            minQuantity: 1.0,
            isLowStock: true,
            createdAt: DateTime.now(),
          ),
          PantryItem(
            id: 'item_2',
            name: 'Bread',
            quantity: 0.0,
            unit: 'loaf',
            category: PantryCategories.grains,
            minQuantity: 1.0,
            isLowStock: true,
            createdAt: DateTime.now(),
          ),
        ];

        when(mockRepository.getLowStockItems(testUserId))
            .thenAnswer((_) async => lowStockItems);

        // Act
        final shoppingList = await pantryService.generateShoppingListFromLowStock(testUserId);

        // Assert
        expect(shoppingList.length, equals(2));
        
        final milkItem = shoppingList.firstWhere((item) => item.name == 'Milk');
        expect(milkItem.quantity, greaterThan(0));
        expect(milkItem.category, equals('Dairy'));
        expect(milkItem.isUrgent, isFalse);

        final breadItem = shoppingList.firstWhere((item) => item.name == 'Bread');
        expect(breadItem.quantity, greaterThan(0));
        expect(breadItem.category, equals('Grains & Cereals'));
        expect(breadItem.isUrgent, isTrue); // Out of stock

        verify(mockRepository.getLowStockItems(testUserId)).called(1);
      });
    });

    group('Pantry Value Calculation', () {
      test('should calculate total pantry value correctly', () async {
        // Arrange
        final pantryItems = [
          PantryItem(
            id: 'item_1',
            name: 'Chicken',
            quantity: 2.0,
            unit: 'lb',
            category: PantryCategories.meat, // $8 per unit
            createdAt: DateTime.now(),
          ),
          PantryItem(
            id: 'item_2',
            name: 'Milk',
            quantity: 3.0,
            unit: 'L',
            category: PantryCategories.dairy, // $3 per unit
            createdAt: DateTime.now(),
          ),
          PantryItem(
            id: 'item_3',
            name: 'Rice',
            quantity: 5.0,
            unit: 'kg',
            category: PantryCategories.grains, // $1.50 per unit
            createdAt: DateTime.now(),
          ),
        ];

        when(mockRepository.getUserPantryItems(testUserId))
            .thenAnswer((_) async => pantryItems);

        // Act
        final totalValue = await pantryService.calculatePantryValue(testUserId);

        // Assert
        // Expected: (2 * 8) + (3 * 3) + (5 * 1.5) = 16 + 9 + 7.5 = 32.5
        expect(totalValue, equals(32.5));
        verify(mockRepository.getUserPantryItems(testUserId)).called(1);
      });
    });

    group('Usage Pattern Analysis', () {
      test('should analyze usage patterns correctly', () async {
        // Arrange
        final usageHistory = [
          PantryUsageRecord(
            id: 'usage_1',
            itemId: 'item_1',
            itemName: 'Milk',
            quantityUsed: 1.0,
            unit: 'L',
            usedAt: DateTime.now().subtract(const Duration(days: 1)),
            recipeId: 'recipe_1',
            recipeName: 'Pancakes',
          ),
          PantryUsageRecord(
            id: 'usage_2',
            itemId: 'item_1',
            itemName: 'Milk',
            quantityUsed: 0.5,
            unit: 'L',
            usedAt: DateTime.now().subtract(const Duration(days: 3)),
            recipeId: 'recipe_2',
            recipeName: 'Cereal',
          ),
          PantryUsageRecord(
            id: 'usage_3',
            itemId: 'item_2',
            itemName: 'Bread',
            quantityUsed: 1.0,
            unit: 'loaf',
            usedAt: DateTime.now().subtract(const Duration(days: 2)),
            // No recipe ID - indicates waste
          ),
        ];

        final currentItems = [
          PantryItem(
            id: 'item_1',
            name: 'Milk',
            quantity: 2.0,
            unit: 'L',
            category: PantryCategories.dairy,
            createdAt: DateTime.now().subtract(const Duration(days: 10)),
            expiryDate: DateTime.now().add(const Duration(days: 5)),
          ),
          PantryItem(
            id: 'item_2',
            name: 'Bread',
            quantity: 1.0,
            unit: 'loaf',
            category: PantryCategories.grains,
            createdAt: DateTime.now().subtract(const Duration(days: 7)),
            expiryDate: DateTime.now().add(const Duration(days: 3)),
          ),
        ];

        when(mockRepository.getUsageHistory(testUserId))
            .thenAnswer((_) async => usageHistory);
        when(mockRepository.getUserPantryItems(testUserId))
            .thenAnswer((_) async => currentItems);

        // Act
        final usagePattern = await pantryService.analyzeUsagePatterns(testUserId);

        // Assert
        expect(usagePattern.frequentlyUsedItems['Milk'], equals(1.5));
        expect(usagePattern.wastedItems['Bread'], equals(1.0));
        expect(usagePattern.categoryUsage['Dairy'], equals(2));
        expect(usagePattern.categoryUsage['Grains & Cereals'], equals(1));
        expect(usagePattern.recommendations.isNotEmpty, isTrue);

        verify(mockRepository.getUsageHistory(testUserId)).called(1);
        verify(mockRepository.getUserPantryItems(testUserId)).called(1);
      });
    });

    group('Organization Suggestions', () {
      test('should provide organization suggestions', () async {
        // Arrange
        final now = DateTime.now();
        final pantryItems = [
          // Expiring items
          PantryItem(
            id: 'item_1',
            name: 'Milk',
            quantity: 1.0,
            unit: 'L',
            category: PantryCategories.dairy,
            expiryDate: now.add(const Duration(days: 2)),
            createdAt: now.subtract(const Duration(days: 5)),
          ),
          PantryItem(
            id: 'item_2',
            name: 'Yogurt',
            quantity: 2.0,
            unit: 'cup',
            category: PantryCategories.dairy,
            expiryDate: now.add(const Duration(days: 3)),
            createdAt: now.subtract(const Duration(days: 3)),
          ),
          // Items without location
          PantryItem(
            id: 'item_3',
            name: 'Rice',
            quantity: 5.0,
            unit: 'kg',
            category: PantryCategories.grains,
            createdAt: now.subtract(const Duration(days: 10)),
          ),
          // Multiple items in same category
          PantryItem(
            id: 'item_4',
            name: 'Cheese',
            quantity: 1.0,
            unit: 'block',
            category: PantryCategories.dairy,
            location: 'Fridge',
            createdAt: now.subtract(const Duration(days: 2)),
          ),
        ];

        when(mockRepository.getUserPantryItems(testUserId))
            .thenAnswer((_) async => pantryItems);

        // Act
        final suggestions = await pantryService.getOrganizationSuggestions(testUserId);

        // Assert
        expect(suggestions.isNotEmpty, isTrue);
        
        // Should suggest moving expiring items forward
        final expirySuggestion = suggestions.firstWhere(
          (s) => s.type == OrganizationType.expiry,
          orElse: () => throw StateError('No expiry suggestion found'),
        );
        expect(expirySuggestion.affectedItems, contains('Milk'));
        expect(expirySuggestion.affectedItems, contains('Yogurt'));

        // Should suggest grouping dairy items
        final categorySuggestion = suggestions.firstWhere(
          (s) => s.type == OrganizationType.category,
          orElse: () => throw StateError('No category suggestion found'),
        );
        expect(categorySuggestion.title, contains('Dairy'));

        // Should suggest assigning locations
        final locationSuggestion = suggestions.firstWhere(
          (s) => s.type == OrganizationType.location,
          orElse: () => throw StateError('No location suggestion found'),
        );
        expect(locationSuggestion.affectedItems, contains('Rice'));

        verify(mockRepository.getUserPantryItems(testUserId)).called(1);
      });
    });
  });
}

// Mock classes for testing
class MockProductInfo {
  final String barcode;
  final String name;
  final String? brand;
  final String category;
  final String unit;

  MockProductInfo({
    required this.barcode,
    required this.name,
    this.brand,
    required this.category,
    required this.unit,
  });
}