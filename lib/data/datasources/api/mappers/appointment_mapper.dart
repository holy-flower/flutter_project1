import '../../../../core/models/appointment.dart';
import '../dto/appointment_dto.dart';

class AppointmentMapper {
  static Appointment toDomain(AppointmentDto dto) {
    return Appointment(
      id: dto.id,
      clientName: dto.clientName,
      service: dto.service,
      dateTime: DateTime.parse(dto.dateTime),
      notes: dto.notes,
      phone: dto.phone,
      status: dto.status,
    );
  }

  static AppointmentDto toDto(Appointment appointment) {
    return AppointmentDto(
      id: appointment.id,
      clientName: appointment.clientName,
      service: appointment.service,
      dateTime: appointment.dateTime.toIso8601String(),
      notes: appointment.notes,
      phone: appointment.phone,
      status: appointment.status,
    );
  }
}


