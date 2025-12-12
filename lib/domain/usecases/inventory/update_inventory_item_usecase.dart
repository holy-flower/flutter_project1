import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/inventory_item.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/inventory_repository.dart';

class UpdateInventoryItemUseCase {
  final InventoryRepository repository;

  UpdateInventoryItemUseCase(this.repository);

  Future<Either<Failure, InventoryItem>> call(InventoryItem item) async {
    return await repository.updateInventoryItem(item);
  }
}





