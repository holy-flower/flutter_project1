import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<AddAppointment>(_onAddAppointment);
    on<UpdateAppointment>(_onUpdateAppointment);
    on<DeleteAppointment>(_onDeleteAppointment);
  }

  final List<Map<String, dynamic>> _appointments = [];

  void _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit) async {
    try {
      emit(AppointmentsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      if (_appointments.isEmpty) {
        emit(const AppointmentsLoaded(appointments: []));
      } else {
        emit(AppointmentsLoaded(appointments: List.from(_appointments)));
      }
    } catch (e) {
      emit(AppointmentsError('Не удалось загрузить записи: $e'));
    }
  }

  void _onAddAppointment(AddAppointment event, Emitter<AppointmentsState> emit) {
    try {
      if (state is AppointmentsLoaded) {
        final currentState = state as AppointmentsLoaded;
        _appointments.add(event.appointment);
        emit(AppointmentsLoaded(appointments: List.from(_appointments)));
      }
    } catch (e) {
      emit(AppointmentsError('Не удалось добавить запись: $e'));
    }
  }

  void _onUpdateAppointment(UpdateAppointment event, Emitter<AppointmentsState> emit) {
    try {
      if (state is AppointmentsLoaded) {
        final currentState = state as AppointmentsLoaded;
        final index = _appointments.indexWhere((appt) => appt['id'] == event.appointment['id']);
        if (index != -1) {
          _appointments[index] = event.appointment;
          emit(AppointmentsLoaded(appointments: List.from(_appointments)));
        }
      }
    } catch (e) {
      emit(AppointmentsError('Не удалось обновить запись: $e'));
    }
  }

  void _onDeleteAppointment(DeleteAppointment event, Emitter<AppointmentsState> emit) {
    try {
      if (state is AppointmentsLoaded) {
        final currentState = state as AppointmentsLoaded;
        _appointments.removeWhere((appt) => appt['id'] == event.appointmentId);
        emit(AppointmentsLoaded(appointments: List.from(_appointments)));
      }
    } catch (e) {
      emit(AppointmentsError('Не удалось удалить запись: $e'));
    }
  }
}