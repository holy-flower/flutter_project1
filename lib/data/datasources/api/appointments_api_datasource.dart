import '../../../core/models/appointment.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'dto/appointment_dto.dart';
import 'mappers/appointment_mapper.dart';

abstract class AppointmentsApiDataSource {
  Future<Either<Failure, List<Appointment>>> getAppointments();
  Future<Either<Failure, Appointment>> addAppointment(Appointment appointment);
  Future<Either<Failure, Appointment>> updateAppointment(Appointment appointment);
  Future<Either<Failure, void>> deleteAppointment(String appointmentId);
}

class AppointmentsApiDataSourceImpl implements AppointmentsApiDataSource {
  final List<Appointment> _appointments = [];

  @override
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return right(List.from(_appointments));
  }

  @override
  Future<Either<Failure, Appointment>> addAppointment(Appointment appointment) async {
    _appointments.add(appointment);
    return right(appointment);
  }

  @override
  Future<Either<Failure, Appointment>> updateAppointment(Appointment appointment) async {
    final index = _appointments.indexWhere((a) => a.id == appointment.id);
    if (index == -1) {
      return left(const ServerFailure('Запись не найдена'));
    }
    _appointments[index] = appointment;
    return right(appointment);
  }

  @override
  Future<Either<Failure, void>> deleteAppointment(String appointmentId) async {
    _appointments.removeWhere((a) => a.id == appointmentId);
    return right(null);
  }
}



