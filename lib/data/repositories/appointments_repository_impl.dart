import '../../domain/repositories/appointments_repository.dart';
import '../../core/models/appointment.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/local/appointments_local_datasource.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsLocalDataSource localDataSource;

  AppointmentsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    return await localDataSource.getAppointments();
  }

  @override
  Future<Either<Failure, Appointment>> addAppointment(Appointment appointment) async {
    return await localDataSource.addAppointment(appointment);
  }

  @override
  Future<Either<Failure, Appointment>> updateAppointment(Appointment appointment) async {
    return await localDataSource.updateAppointment(appointment);
  }

  @override
  Future<Either<Failure, void>> deleteAppointment(String appointmentId) async {
    return await localDataSource.deleteAppointment(appointmentId);
  }
}



