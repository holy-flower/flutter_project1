import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/service.dart';
import '../../../../domain/usecases/services/get_services_by_type_usecase.dart';
import '../../../../domain/usecases/services/add_service_usecase.dart';
import '../../../../domain/usecases/services/delete_service_usecase.dart';

part 'spa_event.dart';
part 'spa_state.dart';

class SpaBloc extends Bloc<SpaEvent, SpaState> {
  final GetServicesByTypeUseCase getServicesByTypeUseCase;
  final AddServiceUseCase addServiceUseCase;
  final DeleteServiceUseCase deleteServiceUseCase;

  SpaBloc({
    required this.getServicesByTypeUseCase,
    required this.addServiceUseCase,
    required this.deleteServiceUseCase,
  }) : super(SpaInitial()) {
    on<LoadSpaServices>(_onLoadSpaServices);
    on<AddSpaService>(_onAddSpaService);
    on<DeleteSpaService>(_onDeleteSpaService);
    on<SelectSpaService>(_onSelectSpaService);
  }

  void _onLoadSpaServices(LoadSpaServices event, Emitter<SpaState> emit) async {
    emit(SpaLoading());
    final result = await getServicesByTypeUseCase(ServiceType.spa);
    result.fold(
      (failure) => emit(SpaError(failure.message)),
      (services) => emit(SpaLoaded(
        services: services,
        selectedIndex: services.isNotEmpty ? 0 : -1,
      )),
    );
  }

  void _onAddSpaService(AddSpaService event, Emitter<SpaState> emit) async {
    final result = await addServiceUseCase(event.service);
    result.fold(
      (failure) => emit(SpaError(failure.message)),
      (_) => add(LoadSpaServices()),
    );
  }

  void _onDeleteSpaService(DeleteSpaService event, Emitter<SpaState> emit) async {
    final result = await deleteServiceUseCase(event.serviceId);
    result.fold(
      (failure) => emit(SpaError(failure.message)),
      (_) => add(LoadSpaServices()),
    );
  }

  void _onSelectSpaService(SelectSpaService event, Emitter<SpaState> emit) {
    if (state is SpaLoaded) {
      final currentState = state as SpaLoaded;
      final newIndex = currentState.selectedIndex == event.index ? -1 : event.index;
      emit(SpaLoaded(services: currentState.services, selectedIndex: newIndex));
    }
  }
}

