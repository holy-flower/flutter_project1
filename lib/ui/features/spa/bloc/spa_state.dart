part of 'spa_bloc.dart';

abstract class SpaState extends Equatable {
  const SpaState();

  @override
  List<Object> get props => [];
}

class SpaInitial extends SpaState {}

class SpaLoading extends SpaState {}

class SpaLoaded extends SpaState {
  final List<Service> services;
  final int selectedIndex;

  const SpaLoaded({
    required this.services,
    this.selectedIndex = -1,
  });

  @override
  List<Object> get props => [services, selectedIndex];
}

class SpaError extends SpaState {
  final String message;

  const SpaError(this.message);

  @override
  List<Object> get props => [message];
}





