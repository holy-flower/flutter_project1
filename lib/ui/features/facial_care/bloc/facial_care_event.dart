part of 'facial_care_bloc.dart';

abstract class FacialCareEvent extends Equatable {
  const FacialCareEvent();

  @override
  List<Object> get props => [];
}

class LoadFacialServices extends FacialCareEvent {}

class AddFacialService extends FacialCareEvent {
  final Service service;

  const AddFacialService(this.service);

  @override
  List<Object> get props => [service];
}

class DeleteFacialService extends FacialCareEvent {
  final String serviceId;

  const DeleteFacialService(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class SelectFacialService extends FacialCareEvent {
  final int index;

  const SelectFacialService(this.index);

  @override
  List<Object> get props => [index];
}





