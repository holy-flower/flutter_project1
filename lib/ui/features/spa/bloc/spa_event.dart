part of 'spa_bloc.dart';

abstract class SpaEvent extends Equatable {
  const SpaEvent();

  @override
  List<Object> get props => [];
}

class LoadSpaServices extends SpaEvent {}

class AddSpaService extends SpaEvent {
  final Service service;

  const AddSpaService(this.service);

  @override
  List<Object> get props => [service];
}

class DeleteSpaService extends SpaEvent {
  final String serviceId;

  const DeleteSpaService(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class SelectSpaService extends SpaEvent {
  final int index;

  const SelectSpaService(this.index);

  @override
  List<Object> get props => [index];
}


