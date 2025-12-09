import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/service_category.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/services_repository.dart';

class GetServiceCategoriesUseCase {
  final ServicesRepository repository;

  GetServiceCategoriesUseCase(this.repository);

  Future<Either<Failure, List<ServiceCategory>>> call() async {
    return await repository.getServiceCategories();
  }
}


