import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/inventory_item.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/inventory_repository.dart';

class GetInventoryItemsUseCase {
  final InventoryRepository repository;

  GetInventoryItemsUseCase(this.repository);

  Future<Either<Failure, List<InventoryItem>>> call() async {
    return await repository.getInventoryItems();
  }
}


