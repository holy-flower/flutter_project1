import '../../core/models/appointment.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class AppointmentsRepository {
  Future<Either<Failure, List<Appointment>>> getAppointments();
  Future<Either<Failure, Appointment>> addAppointment(Appointment appointment);
  Future<Either<Failure, Appointment>> updateAppointment(Appointment appointment);
  Future<Either<Failure, void>> deleteAppointment(String appointmentId);
}

