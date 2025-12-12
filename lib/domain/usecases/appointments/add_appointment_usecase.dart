import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/appointment.dart';
import 'package:flutter_project1/domain/repositories/appointments_repository.dart';

import '../../../core/utils/either.dart';

class AddAppointmentUseCase {
  final AppointmentsRepository repository;

  AddAppointmentUseCase(this.repository);

  Future<Either<Failure, Appointment>> call(Appointment appointment) async {
    if (appointment.clientName.isEmpty) {
      return left(const ValidationFailure('Имя клиента не может быть пустым'));
    }
    if (appointment.service.isEmpty) {
      return left(const ValidationFailure('Услуга не может быть пустой'));
    }
    return await repository.addAppointment(appointment);
  }
}



