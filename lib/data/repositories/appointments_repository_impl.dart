import '../../domain/repositories/appointments_repository.dart';
import '../../core/models/appointment.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/appointments_api_datasource.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsApiDataSource dataSource;

  AppointmentsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    return await dataSource.getAppointments();
  }

  @override
  Future<Either<Failure, Appointment>> addAppointment(Appointment appointment) async {
    return await dataSource.addAppointment(appointment);
  }

  @override
  Future<Either<Failure, Appointment>> updateAppointment(Appointment appointment) async {
    return await dataSource.updateAppointment(appointment);
  }

  @override
  Future<Either<Failure, void>> deleteAppointment(String appointmentId) async {
    return await dataSource.deleteAppointment(appointmentId);
  }
}


