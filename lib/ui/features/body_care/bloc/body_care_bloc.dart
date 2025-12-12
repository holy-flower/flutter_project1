import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/service.dart';
import '../../../../domain/usecases/services/get_services_by_type_usecase.dart';
import '../../../../domain/usecases/services/add_service_usecase.dart';
import '../../../../domain/usecases/services/delete_service_usecase.dart';

part 'body_care_event.dart';
part 'body_care_state.dart';

class BodyCareBloc extends Bloc<BodyCareEvent, BodyCareState> {
  final GetServicesByTypeUseCase getServicesByTypeUseCase;
  final AddServiceUseCase addServiceUseCase;
  final DeleteServiceUseCase deleteServiceUseCase;

  BodyCareBloc({
    required this.getServicesByTypeUseCase,
    required this.addServiceUseCase,
    required this.deleteServiceUseCase,
  }) : super(BodyCareInitial()) {
    on<LoadBodyServices>(_onLoadBodyServices);
    on<AddBodyService>(_onAddBodyService);
    on<DeleteBodyService>(_onDeleteBodyService);
    on<SelectBodyService>(_onSelectBodyService);
  }

  void _onLoadBodyServices(LoadBodyServices event, Emitter<BodyCareState> emit) async {
    emit(BodyCareLoading());
    final result = await getServicesByTypeUseCase(ServiceType.bodyCare);
    result.fold(
      (failure) => emit(BodyCareError(failure.message)),
      (services) => emit(BodyCareLoaded(services: services, selectedIndex: -1)),
    );
  }

  void _onAddBodyService(AddBodyService event, Emitter<BodyCareState> emit) async {
    final result = await addServiceUseCase(event.service);
    result.fold(
      (failure) => emit(BodyCareError(failure.message)),
      (_) => add(LoadBodyServices()),
    );
  }

  void _onDeleteBodyService(DeleteBodyService event, Emitter<BodyCareState> emit) async {
    final result = await deleteServiceUseCase(event.serviceId);
    result.fold(
      (failure) => emit(BodyCareError(failure.message)),
      (_) => add(LoadBodyServices()),
    );
  }

  void _onSelectBodyService(SelectBodyService event, Emitter<BodyCareState> emit) {
    if (state is BodyCareLoaded) {
      final currentState = state as BodyCareLoaded;
      final newIndex = currentState.selectedIndex == event.index ? -1 : event.index;
      emit(BodyCareLoaded(services: currentState.services, selectedIndex: newIndex));
    }
  }
}





