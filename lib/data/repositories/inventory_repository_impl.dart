import '../../domain/repositories/inventory_repository.dart';
import '../../core/models/inventory_item.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/local/inventory_local_datasource.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryLocalDataSource localDataSource;

  InventoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<InventoryItem>>> getInventoryItems() async {
    return await localDataSource.getInventoryItems();
  }

  @override
  Future<Either<Failure, InventoryItem>> addInventoryItem(InventoryItem item) async {
    return await localDataSource.addInventoryItem(item);
  }

  @override
  Future<Either<Failure, InventoryItem>> updateInventoryItem(InventoryItem item) async {
    return await localDataSource.updateInventoryItem(item);
  }

  @override
  Future<Either<Failure, void>> deleteInventoryItem(String itemId) async {
    return await localDataSource.deleteInventoryItem(itemId);
  }
}



