part of 'massage_bloc.dart';

abstract class MassageState extends Equatable {
  const MassageState();

  @override
  List<Object> get props => [];
}

class MassageInitial extends MassageState {}

class MassageLoading extends MassageState {}

class MassageLoaded extends MassageState {
  final List<Service> services;
  final int selectedIndex;

  const MassageLoaded({
    required this.services,
    this.selectedIndex = -1,
  });

  @override
  List<Object> get props => [services, selectedIndex];
}

class MassageError extends MassageState {
  final String message;

  const MassageError(this.message);

  @override
  List<Object> get props => [message];
}


