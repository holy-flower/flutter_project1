import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/appointment.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/appointments_repository.dart';

class UpdateAppointmentUseCase {
  final AppointmentsRepository repository;

  UpdateAppointmentUseCase(this.repository);

  Future<Either<Failure, Appointment>> call(Appointment appointment) async {
    return await repository.updateAppointment(appointment);
  }
}


