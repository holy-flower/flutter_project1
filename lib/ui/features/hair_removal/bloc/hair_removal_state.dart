part of 'hair_removal_bloc.dart';

abstract class HairRemovalState extends Equatable {
  const HairRemovalState();

  @override
  List<Object> get props => [];
}

class HairRemovalInitial extends HairRemovalState {}

class HairRemovalLoading extends HairRemovalState {}

class HairRemovalLoaded extends HairRemovalState {
  final List<Service> services;
  final int selectedIndex;

  const HairRemovalLoaded({
    required this.services,
    this.selectedIndex = -1,
  });

  @override
  List<Object> get props => [services, selectedIndex];
}

class HairRemovalError extends HairRemovalState {
  final String message;

  const HairRemovalError(this.message);

  @override
  List<Object> get props => [message];
}


