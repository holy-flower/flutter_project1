import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/service.dart';
import '../../../../domain/usecases/services/get_services_by_type_usecase.dart';
import '../../../../domain/usecases/services/add_service_usecase.dart';
import '../../../../domain/usecases/services/delete_service_usecase.dart';

part 'hair_removal_event.dart';
part 'hair_removal_state.dart';

class HairRemovalBloc extends Bloc<HairRemovalEvent, HairRemovalState> {
  final GetServicesByTypeUseCase getServicesByTypeUseCase;
  final AddServiceUseCase addServiceUseCase;
  final DeleteServiceUseCase deleteServiceUseCase;

  HairRemovalBloc({
    required this.getServicesByTypeUseCase,
    required this.addServiceUseCase,
    required this.deleteServiceUseCase,
  }) : super(HairRemovalInitial()) {
    on<LoadHairRemovalServices>(_onLoadHairRemovalServices);
    on<AddHairRemovalService>(_onAddHairRemovalService);
    on<DeleteHairRemovalService>(_onDeleteHairRemovalService);
    on<SelectHairRemovalService>(_onSelectHairRemovalService);
  }

  void _onLoadHairRemovalServices(LoadHairRemovalServices event, Emitter<HairRemovalState> emit) async {
    emit(HairRemovalLoading());
    final result = await getServicesByTypeUseCase(ServiceType.hairRemoval);
    result.fold(
      (failure) => emit(HairRemovalError(failure.message)),
      (services) => emit(HairRemovalLoaded(
        services: services,
        selectedIndex: services.isNotEmpty ? 0 : -1,
      )),
    );
  }

  void _onAddHairRemovalService(AddHairRemovalService event, Emitter<HairRemovalState> emit) async {
    final result = await addServiceUseCase(event.service);
    result.fold(
      (failure) => emit(HairRemovalError(failure.message)),
      (_) => add(LoadHairRemovalServices()),
    );
  }

  void _onDeleteHairRemovalService(DeleteHairRemovalService event, Emitter<HairRemovalState> emit) async {
    final result = await deleteServiceUseCase(event.serviceId);
    result.fold(
      (failure) => emit(HairRemovalError(failure.message)),
      (_) => add(LoadHairRemovalServices()),
    );
  }

  void _onSelectHairRemovalService(SelectHairRemovalService event, Emitter<HairRemovalState> emit) {
    if (state is HairRemovalLoaded) {
      final currentState = state as HairRemovalLoaded;
      final newIndex = currentState.selectedIndex == event.index ? -1 : event.index;
      emit(HairRemovalLoaded(services: currentState.services, selectedIndex: newIndex));
    }
  }
}

