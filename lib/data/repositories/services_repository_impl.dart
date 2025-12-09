import '../../domain/repositories/services_repository.dart';
import '../../core/models/service_category.dart';
import '../../core/models/service.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/services_api_datasource.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesApiDataSource dataSource;

  ServicesRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<ServiceCategory>>> getServiceCategories() async {
    return await dataSource.getServiceCategories();
  }

  @override
  Future<Either<Failure, List<Service>>> getServicesByType(ServiceType type) async {
    return await dataSource.getServicesByType(type);
  }

  @override
  Future<Either<Failure, Service>> addService(Service service) async {
    return await dataSource.addService(service);
  }

  @override
  Future<Either<Failure, void>> deleteService(String serviceId) async {
    return await dataSource.deleteService(serviceId);
  }
}


