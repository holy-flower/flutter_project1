import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/service.dart';
import '../../../../domain/usecases/services/get_services_by_type_usecase.dart';
import '../../../../domain/usecases/services/add_service_usecase.dart';
import '../../../../domain/usecases/services/delete_service_usecase.dart';

part 'massage_event.dart';
part 'massage_state.dart';

class MassageBloc extends Bloc<MassageEvent, MassageState> {
  final GetServicesByTypeUseCase getServicesByTypeUseCase;
  final AddServiceUseCase addServiceUseCase;
  final DeleteServiceUseCase deleteServiceUseCase;

  MassageBloc({
    required this.getServicesByTypeUseCase,
    required this.addServiceUseCase,
    required this.deleteServiceUseCase,
  }) : super(MassageInitial()) {
    on<LoadMassageServices>(_onLoadMassageServices);
    on<AddMassageService>(_onAddMassageService);
    on<DeleteMassageService>(_onDeleteMassageService);
    on<SelectMassageService>(_onSelectMassageService);
  }

  void _onLoadMassageServices(LoadMassageServices event, Emitter<MassageState> emit) async {
    emit(MassageLoading());
    final result = await getServicesByTypeUseCase(ServiceType.massage);
    result.fold(
      (failure) => emit(MassageError(failure.message)),
      (services) => emit(MassageLoaded(services: services, selectedIndex: -1)),
    );
  }

  void _onAddMassageService(AddMassageService event, Emitter<MassageState> emit) async {
    final result = await addServiceUseCase(event.service);
    result.fold(
      (failure) => emit(MassageError(failure.message)),
      (_) => add(LoadMassageServices()),
    );
  }

  void _onDeleteMassageService(DeleteMassageService event, Emitter<MassageState> emit) async {
    final result = await deleteServiceUseCase(event.serviceId);
    result.fold(
      (failure) => emit(MassageError(failure.message)),
      (_) => add(LoadMassageServices()),
    );
  }

  void _onSelectMassageService(SelectMassageService event, Emitter<MassageState> emit) {
    if (state is MassageLoaded) {
      final currentState = state as MassageLoaded;
      final newIndex = currentState.selectedIndex == event.index ? -1 : event.index;
      emit(MassageLoaded(services: currentState.services, selectedIndex: newIndex));
    }
  }
}


