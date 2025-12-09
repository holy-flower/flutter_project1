import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/inventory_item.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/inventory_repository.dart';

class AddInventoryItemUseCase {
  final InventoryRepository repository;

  AddInventoryItemUseCase(this.repository);

  Future<Either<Failure, InventoryItem>> call(InventoryItem item) async {
    if (item.name.isEmpty) {
      return Either.left(const ValidationFailure('Название товара не может быть пустым'));
    }
    return await repository.addInventoryItem(item);
  }
}


