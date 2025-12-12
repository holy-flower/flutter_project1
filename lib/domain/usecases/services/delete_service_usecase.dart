import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/services_repository.dart';

class DeleteServiceUseCase {
  final ServicesRepository repository;

  DeleteServiceUseCase(this.repository);

  Future<Either<Failure, void>> call(String serviceId) async {
    return await repository.deleteService(serviceId);
  }
}





