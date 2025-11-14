part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<ServiceCategory> services;
  final List<ServiceCategory> filteredServices;

  const ServicesLoaded({
    required this.services,
    required this.filteredServices,
  });

  @override
  List<Object> get props => [services, filteredServices];
}

class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);

  @override
  List<Object> get props => [message];
}

class ServiceCategory {
  final String title;
  final IconData icon;
  final String route;
  final Color color;
  final String description;
  final int serviceCount;
  final int totalPrice;
  final bool isPopular;

  const ServiceCategory({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
    required this.description,
    required this.serviceCount,
    required this.totalPrice,
    required this.isPopular,
  });

  ServiceCategory copyWith({
    String? title,
    IconData? icon,
    String? route,
    Color? color,
    String? description,
    int? serviceCount,
    int? totalPrice,
    bool? isPopular,
  }) {
    return ServiceCategory(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      color: color ?? this.color,
      description: description ?? this.description,
      serviceCount: serviceCount ?? this.serviceCount,
      totalPrice: totalPrice ?? this.totalPrice,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}