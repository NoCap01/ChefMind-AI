import '../../domain/repositories/pantry_repository.dart';
import '../../core/errors/app_exceptions.dart';

class ManagePantryUseCase {
  final PantryRepository _pantryRepository;

  const ManagePantryUseCase(this._pantryRepository);

  Future<List<Map<String, dynamic>>> generateShoppingList({
    required String userId,
  }) async {
    try {
      await _pantryRepository.generateShoppingList(userId, []);

      return [
        {
          'name': 'Sample Item',
          'category': 'Other',
          'quantity': 1.0,
          'unit': 'piece',
          'priority': 'medium',
        }
      ];
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw const DatabaseException('Failed to generate shopping list');
    }
  }
}
