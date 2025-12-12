part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<ServiceCategoryUI> services;
  final List<ServiceCategoryUI> filteredServices;

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

class ServiceCategoryUI {
  final String id;
  final String title;
  final IconData icon;
  final String route;
  final Color color;
  final String description;
  final int serviceCount;
  final int totalPrice;
  final bool isPopular;

  const ServiceCategoryUI({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
    required this.description,
    required this.serviceCount,
    required this.totalPrice,
    required this.isPopular,
  });

  ServiceCategoryUI copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? route,
    Color? color,
    String? description,
    int? serviceCount,
    int? totalPrice,
    bool? isPopular,
  }) {
    return ServiceCategoryUI(
      id: id ?? this.id,
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





