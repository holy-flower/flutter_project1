part of 'massage_bloc.dart';

abstract class MassageEvent extends Equatable {
  const MassageEvent();

  @override
  List<Object> get props => [];
}

class LoadMassageServices extends MassageEvent {}

class AddMassageService extends MassageEvent {
  final Service service;

  const AddMassageService(this.service);

  @override
  List<Object> get props => [service];
}

class DeleteMassageService extends MassageEvent {
  final String serviceId;

  const DeleteMassageService(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class SelectMassageService extends MassageEvent {
  final int index;

  const SelectMassageService(this.index);

  @override
  List<Object> get props => [index];
}





