import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/service.dart';
import '../../../../domain/usecases/services/get_services_by_type_usecase.dart';
import '../../../../domain/usecases/services/add_service_usecase.dart';
import '../../../../domain/usecases/services/delete_service_usecase.dart';

part 'facial_care_event.dart';
part 'facial_care_state.dart';

class FacialCareBloc extends Bloc<FacialCareEvent, FacialCareState> {
  final GetServicesByTypeUseCase getServicesByTypeUseCase;
  final AddServiceUseCase addServiceUseCase;
  final DeleteServiceUseCase deleteServiceUseCase;

  FacialCareBloc({
    required this.getServicesByTypeUseCase,
    required this.addServiceUseCase,
    required this.deleteServiceUseCase,
  }) : super(FacialCareInitial()) {
    on<LoadFacialServices>(_onLoadFacialServices);
    on<AddFacialService>(_onAddFacialService);
    on<DeleteFacialService>(_onDeleteFacialService);
    on<SelectFacialService>(_onSelectFacialService);
  }

  void _onLoadFacialServices(LoadFacialServices event, Emitter<FacialCareState> emit) async {
    emit(FacialCareLoading());
    final result = await getServicesByTypeUseCase(ServiceType.facialCare);
    result.fold(
      (failure) => emit(FacialCareError(failure.message)),
      (services) => emit(FacialCareLoaded(services: services, selectedIndex: -1)),
    );
  }

  void _onAddFacialService(AddFacialService event, Emitter<FacialCareState> emit) async {
    final result = await addServiceUseCase(event.service);
    result.fold(
      (failure) => emit(FacialCareError(failure.message)),
      (_) => add(LoadFacialServices()),
    );
  }

  void _onDeleteFacialService(DeleteFacialService event, Emitter<FacialCareState> emit) async {
    final result = await deleteServiceUseCase(event.serviceId);
    result.fold(
      (failure) => emit(FacialCareError(failure.message)),
      (_) => add(LoadFacialServices()),
    );
  }

  void _onSelectFacialService(SelectFacialService event, Emitter<FacialCareState> emit) {
    if (state is FacialCareLoaded) {
      final currentState = state as FacialCareLoaded;
      final newIndex = currentState.selectedIndex == event.index ? -1 : event.index;
      emit(FacialCareLoaded(services: currentState.services, selectedIndex: newIndex));
    }
  }
}





