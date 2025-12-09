import '../../../core/models/inventory_item.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';

abstract class InventoryApiDataSource {
  Future<Either<Failure, List<InventoryItem>>> getInventoryItems();
  Future<Either<Failure, InventoryItem>> addInventoryItem(InventoryItem item);
  Future<Either<Failure, InventoryItem>> updateInventoryItem(InventoryItem item);
  Future<Either<Failure, void>> deleteInventoryItem(String itemId);
}

class InventoryApiDataSourceImpl implements InventoryApiDataSource {
  final List<InventoryItem> _items = [];

  @override
  Future<Either<Failure, List<InventoryItem>>> getInventoryItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Either.right(List.from(_items));
  }

  @override
  Future<Either<Failure, InventoryItem>> addInventoryItem(InventoryItem item) async {
    _items.add(item);
    return Either.right(item);
  }

  @override
  Future<Either<Failure, InventoryItem>> updateInventoryItem(InventoryItem item) async {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index == -1) {
      return Either.left(const ServerFailure('Товар не найден'));
    }
    _items[index] = item;
    return Either.right(item);
  }

  @override
  Future<Either<Failure, void>> deleteInventoryItem(String itemId) async {
    _items.removeWhere((i) => i.id == itemId);
    return Either.right(null);
  }
}


