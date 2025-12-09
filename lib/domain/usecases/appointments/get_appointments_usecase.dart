import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/appointment.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/appointments_repository.dart';

class GetAppointmentsUseCase {
  final AppointmentsRepository repository;

  GetAppointmentsUseCase(this.repository);

  Future<Either<Failure, List<Appointment>>> call() async {
    return await repository.getAppointments();
  }
}


