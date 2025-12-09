part of 'hair_removal_bloc.dart';

abstract class HairRemovalEvent extends Equatable {
  const HairRemovalEvent();

  @override
  List<Object> get props => [];
}

class LoadHairRemovalServices extends HairRemovalEvent {}

class AddHairRemovalService extends HairRemovalEvent {
  final Service service;

  const AddHairRemovalService(this.service);

  @override
  List<Object> get props => [service];
}

class DeleteHairRemovalService extends HairRemovalEvent {
  final String serviceId;

  const DeleteHairRemovalService(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class SelectHairRemovalService extends HairRemovalEvent {
  final int index;

  const SelectHairRemovalService(this.index);

  @override
  List<Object> get props => [index];
}


