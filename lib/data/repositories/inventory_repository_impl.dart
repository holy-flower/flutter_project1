import '../../domain/repositories/inventory_repository.dart';
import '../../core/models/inventory_item.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/inventory_api_datasource.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryApiDataSource dataSource;

  InventoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<InventoryItem>>> getInventoryItems() async {
    return await dataSource.getInventoryItems();
  }

  @override
  Future<Either<Failure, InventoryItem>> addInventoryItem(InventoryItem item) async {
    return await dataSource.addInventoryItem(item);
  }

  @override
  Future<Either<Failure, InventoryItem>> updateInventoryItem(InventoryItem item) async {
    return await dataSource.updateInventoryItem(item);
  }

  @override
  Future<Either<Failure, void>> deleteInventoryItem(String itemId) async {
    return await dataSource.deleteInventoryItem(itemId);
  }
}


