import '../../domain/repositories/services_repository.dart';
import '../../core/models/service_category.dart';
import '../../core/models/service.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/local/services_local_datasource.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesLocalDataSource localDataSource;

  ServicesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<ServiceCategory>>> getServiceCategories() async {
    return await localDataSource.getServiceCategories();
  }

  @override
  Future<Either<Failure, List<Service>>> getServicesByType(ServiceType type) async {
    return await localDataSource.getServicesByType(type);
  }

  @override
  Future<Either<Failure, Service>> addService(Service service) async {
    return await localDataSource.addService(service);
  }

  @override
  Future<Either<Failure, void>> deleteService(String serviceId) async {
    return await localDataSource.deleteService(serviceId);
  }
}



