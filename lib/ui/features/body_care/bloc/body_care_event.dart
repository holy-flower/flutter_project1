part of 'body_care_bloc.dart';

abstract class BodyCareEvent extends Equatable {
  const BodyCareEvent();

  @override
  List<Object> get props => [];
}

class LoadBodyServices extends BodyCareEvent {}

class AddBodyService extends BodyCareEvent {
  final Service service;

  const AddBodyService(this.service);

  @override
  List<Object> get props => [service];
}

class DeleteBodyService extends BodyCareEvent {
  final String serviceId;

  const DeleteBodyService(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class SelectBodyService extends BodyCareEvent {
  final int index;

  const SelectBodyService(this.index);

  @override
  List<Object> get props => [index];
}





