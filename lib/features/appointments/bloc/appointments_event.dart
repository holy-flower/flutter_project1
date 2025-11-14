part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentsEvent {
  @override
  List<Object> get props => [];
}

class AddAppointment extends AppointmentsEvent {
  final Map<String, dynamic> appointment;

  const AddAppointment(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class UpdateAppointment extends AppointmentsEvent {
  final Map<String, dynamic> appointment;

  const UpdateAppointment(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class DeleteAppointment extends AppointmentsEvent {
  final String appointmentId;

  const DeleteAppointment(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}