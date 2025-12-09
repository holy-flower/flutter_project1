import '../../core/models/service_category.dart';
import '../../core/models/service.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<ServiceCategory>>> getServiceCategories();
  Future<Either<Failure, List<Service>>> getServicesByType(ServiceType type);
  Future<Either<Failure, Service>> addService(Service service);
  Future<Either<Failure, void>> deleteService(String serviceId);
}

