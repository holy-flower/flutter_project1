import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/inventory_repository.dart';

class DeleteInventoryItemUseCase {
  final InventoryRepository repository;

  DeleteInventoryItemUseCase(this.repository);

  Future<Either<Failure, void>> call(String itemId) async {
    return await repository.deleteInventoryItem(itemId);
  }
}


