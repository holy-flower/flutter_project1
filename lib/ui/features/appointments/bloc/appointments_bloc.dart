import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/appointment.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/usecases/appointments/get_appointments_usecase.dart';
import '../../../../domain/usecases/appointments/add_appointment_usecase.dart';
import '../../../../domain/usecases/appointments/update_appointment_usecase.dart';
import '../../../../domain/usecases/appointments/delete_appointment_usecase.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final GetAppointmentsUseCase getAppointmentsUseCase;
  final AddAppointmentUseCase addAppointmentUseCase;
  final UpdateAppointmentUseCase updateAppointmentUseCase;
  final DeleteAppointmentUseCase deleteAppointmentUseCase;

  AppointmentsBloc({
    required GetAppointmentsUseCase getAppointmentsUseCase,
    required AddAppointmentUseCase addAppointmentUseCase,
    required UpdateAppointmentUseCase updateAppointmentUseCase,
    required DeleteAppointmentUseCase deleteAppointmentUseCase,
  })  : getAppointmentsUseCase = getAppointmentsUseCase,
        addAppointmentUseCase = addAppointmentUseCase,
        updateAppointmentUseCase = updateAppointmentUseCase,
        deleteAppointmentUseCase = deleteAppointmentUseCase,
        super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<AddAppointment>(_onAddAppointment);
    on<UpdateAppointment>(_onUpdateAppointment);
    on<DeleteAppointment>(_onDeleteAppointment);
  }

  void _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());
    
    final result = await getAppointmentsUseCase();
    
    result.fold(
      (failure) => emit(AppointmentsError(failure.message)),
      (appointments) => emit(AppointmentsLoaded(appointments: appointments)),
    );
  }

  void _onAddAppointment(AddAppointment event, Emitter<AppointmentsState> emit) async {
    final result = await addAppointmentUseCase(event.appointment);
    
    result.fold(
      (failure) => emit(AppointmentsError(failure.message)),
      (_) => add(LoadAppointments()),
    );
  }

  void _onUpdateAppointment(UpdateAppointment event, Emitter<AppointmentsState> emit) async {
    final result = await updateAppointmentUseCase(event.appointment);
    
    result.fold(
      (failure) => emit(AppointmentsError(failure.message)),
      (_) => add(LoadAppointments()),
    );
  }

  void _onDeleteAppointment(DeleteAppointment event, Emitter<AppointmentsState> emit) async {
    final result = await deleteAppointmentUseCase(event.appointmentId);
    
    result.fold(
      (failure) => emit(AppointmentsError(failure.message)),
      (_) => add(LoadAppointments()),
    );
  }
}

