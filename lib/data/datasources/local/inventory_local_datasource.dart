import '../../../core/models/inventory_item.dart' as models;
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'app_database.dart';
import 'package:drift/drift.dart';

abstract class InventoryLocalDataSource {
  Future<Either<Failure, List<models.InventoryItem>>> getInventoryItems();
  Future<Either<Failure, models.InventoryItem>> addInventoryItem(models.InventoryItem item);
  Future<Either<Failure, models.InventoryItem>> updateInventoryItem(models.InventoryItem item);
  Future<Either<Failure, void>> deleteInventoryItem(String itemId);
}

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  final AppDatabase _database;

  InventoryLocalDataSourceImpl(this._database);

  @override
  Future<Either<Failure, List<models.InventoryItem>>> getInventoryItems() async {
    try {
      final query = _database.select(_database.inventoryItems);
      final rows = await query.get();

      final items = rows.map((row) {
        return models.InventoryItem(
          id: row.id,
          name: row.name,
          category: row.category,
          currentStock: row.currentStock,
          minStock: row.minStock,
          unit: row.unit,
          cost: row.cost,
          supplier: row.supplier,
          lastRestock: DateTime.fromMillisecondsSinceEpoch(row.lastRestock),
          expiryDate: DateTime.fromMillisecondsSinceEpoch(row.expiryDate),
        );
      }).toList();

      return right(items);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки инвентаря: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, models.InventoryItem>> addInventoryItem(models.InventoryItem item) async {
    try {
      final companion = InventoryItemsCompanion(
        id: Value(item.id),
        name: Value(item.name),
        category: Value(item.category),
        currentStock: Value(item.currentStock),
        minStock: Value(item.minStock),
        unit: Value(item.unit),
        cost: Value(item.cost),
        supplier: Value(item.supplier),
        lastRestock: Value(item.lastRestock.millisecondsSinceEpoch),
        expiryDate: Value(item.expiryDate.millisecondsSinceEpoch),
      );

      await _database.into(_database.inventoryItems).insert(companion);
      return right(item);
    } catch (e) {
      return left(CacheFailure('Ошибка добавления товара: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, models.InventoryItem>> updateInventoryItem(models.InventoryItem item) async {
    try {
      final companion = InventoryItemsCompanion(
        id: Value(item.id),
        name: Value(item.name),
        category: Value(item.category),
        currentStock: Value(item.currentStock),
        minStock: Value(item.minStock),
        unit: Value(item.unit),
        cost: Value(item.cost),
        supplier: Value(item.supplier),
        lastRestock: Value(item.lastRestock.millisecondsSinceEpoch),
        expiryDate: Value(item.expiryDate.millisecondsSinceEpoch),
      );

      final updated = await (_database.update(_database.inventoryItems)..where((t) => t.id.equals(item.id))).write(companion);

      if (updated == 0) {
        return left(const ServerFailure('Товар не найден'));
      }

      return right(item);
    } catch (e) {
      return left(CacheFailure('Ошибка обновления товара: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteInventoryItem(String itemId) async {
    try {
      final deleted = await (_database.delete(_database.inventoryItems)..where((t) => t.id.equals(itemId))).go();

      if (deleted == 0) {
        return left(const ServerFailure('Товар не найден'));
      }

      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления товара: ${e.toString()}'));
    }
  }
}

