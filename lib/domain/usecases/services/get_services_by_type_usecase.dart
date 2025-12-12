import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/service.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/services_repository.dart';

class GetServicesByTypeUseCase {
  final ServicesRepository repository;

  GetServicesByTypeUseCase(this.repository);

  Future<Either<Failure, List<Service>>> call(ServiceType type) async {
    return await repository.getServicesByType(type);
  }
}





