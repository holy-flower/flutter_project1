import '../../core/models/inventory_item.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class InventoryRepository {
  Future<Either<Failure, List<InventoryItem>>> getInventoryItems();
  Future<Either<Failure, InventoryItem>> addInventoryItem(InventoryItem item);
  Future<Either<Failure, InventoryItem>> updateInventoryItem(InventoryItem item);
  Future<Either<Failure, void>> deleteInventoryItem(String itemId);
}

