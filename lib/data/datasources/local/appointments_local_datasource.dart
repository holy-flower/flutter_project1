import '../../../core/models/appointment.dart' as models;
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'app_database.dart';
import 'package:drift/drift.dart';

abstract class AppointmentsLocalDataSource {
  Future<Either<Failure, List<models.Appointment>>> getAppointments();
  Future<Either<Failure, models.Appointment>> addAppointment(models.Appointment appointment);
  Future<Either<Failure, models.Appointment>> updateAppointment(models.Appointment appointment);
  Future<Either<Failure, void>> deleteAppointment(String appointmentId);
}

class AppointmentsLocalDataSourceImpl implements AppointmentsLocalDataSource {
  final AppDatabase _database;

  AppointmentsLocalDataSourceImpl(this._database);

  @override
  Future<Either<Failure, List<models.Appointment>>> getAppointments() async {
    try {
      final query = _database.select(_database.appointments);
      final rows = await query.get();

      final appointments = rows.map((row) {
        return models.Appointment(
          id: row.id,
          clientName: row.clientName,
          service: row.service,
          dateTime: DateTime.fromMillisecondsSinceEpoch(row.appointmentDateTime),
          notes: row.notes,
          phone: row.phone,
          status: row.status,
        );
      }).toList();

      return right(appointments);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки записей: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, models.Appointment>> addAppointment(models.Appointment appointment) async {
    try {
      final companion = AppointmentsCompanion(
        id: Value(appointment.id),
        clientName: Value(appointment.clientName),
        service: Value(appointment.service),
        appointmentDateTime: Value(appointment.dateTime.millisecondsSinceEpoch),
        notes: Value(appointment.notes),
        phone: Value(appointment.phone),
        status: Value(appointment.status),
      );

      await _database.into(_database.appointments).insert(companion);
      return right(appointment);
    } catch (e) {
      return left(CacheFailure('Ошибка добавления записи: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, models.Appointment>> updateAppointment(models.Appointment appointment) async {
    try {
      final companion = AppointmentsCompanion(
        id: Value(appointment.id),
        clientName: Value(appointment.clientName),
        service: Value(appointment.service),
        appointmentDateTime: Value(appointment.dateTime.millisecondsSinceEpoch),
        notes: Value(appointment.notes),
        phone: Value(appointment.phone),
        status: Value(appointment.status),
      );

      final updated = await (_database.update(_database.appointments)..where((t) => t.id.equals(appointment.id))).write(companion);

      if (updated == 0) {
        return left(const ServerFailure('Запись не найдена'));
      }

      return right(appointment);
    } catch (e) {
      return left(CacheFailure('Ошибка обновления записи: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAppointment(String appointmentId) async {
    try {
      final deleted = await (_database.delete(_database.appointments)..where((t) => t.id.equals(appointmentId))).go();

      if (deleted == 0) {
        return left(const ServerFailure('Запись не найдена'));
      }

      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления записи: ${e.toString()}'));
    }
  }
}

