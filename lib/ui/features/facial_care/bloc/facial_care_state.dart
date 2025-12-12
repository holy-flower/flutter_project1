part of 'facial_care_bloc.dart';

abstract class FacialCareState extends Equatable {
  const FacialCareState();

  @override
  List<Object> get props => [];
}

class FacialCareInitial extends FacialCareState {}

class FacialCareLoading extends FacialCareState {}

class FacialCareLoaded extends FacialCareState {
  final List<Service> services;
  final int selectedIndex;

  const FacialCareLoaded({
    required this.services,
    this.selectedIndex = -1,
  });

  @override
  List<Object> get props => [services, selectedIndex];
}

class FacialCareError extends FacialCareState {
  final String message;

  const FacialCareError(this.message);

  @override
  List<Object> get props => [message];
}





