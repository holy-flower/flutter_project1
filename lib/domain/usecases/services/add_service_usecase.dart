import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/service.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/services_repository.dart';

class AddServiceUseCase {
  final ServicesRepository repository;

  AddServiceUseCase(this.repository);

  Future<Either<Failure, Service>> call(Service service) async {
    return await repository.addService(service);
  }
}


