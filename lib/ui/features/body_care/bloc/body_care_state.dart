part of 'body_care_bloc.dart';

abstract class BodyCareState extends Equatable {
  const BodyCareState();

  @override
  List<Object> get props => [];
}

class BodyCareInitial extends BodyCareState {}

class BodyCareLoading extends BodyCareState {}

class BodyCareLoaded extends BodyCareState {
  final List<Service> services;
  final int selectedIndex;

  const BodyCareLoaded({
    required this.services,
    this.selectedIndex = -1,
  });

  @override
  List<Object> get props => [services, selectedIndex];
}

class BodyCareError extends BodyCareState {
  final String message;

  const BodyCareError(this.message);

  @override
  List<Object> get props => [message];
}


