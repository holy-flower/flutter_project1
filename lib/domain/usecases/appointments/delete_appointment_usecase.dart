import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/appointments_repository.dart';

class DeleteAppointmentUseCase {
  final AppointmentsRepository repository;

  DeleteAppointmentUseCase(this.repository);

  Future<Either<Failure, void>> call(String appointmentId) async {
    return await repository.deleteAppointment(appointmentId);
  }
}





