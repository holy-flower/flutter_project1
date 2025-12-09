part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadAppointments extends AppointmentsEvent {}

class AddAppointment extends AppointmentsEvent {
  final Appointment appointment;

  const AddAppointment(this.appointment);

  @override
  List<Object> get props => [appointment];
}

class UpdateAppointment extends AppointmentsEvent {
  final Appointment appointment;

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


