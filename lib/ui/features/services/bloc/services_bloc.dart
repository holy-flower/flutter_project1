import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project1/domain/usecases/services/get_services_by_type_usecase.dart';
import '../../../../core/models/service_category.dart';
import '../../../../domain/usecases/services/get_service_categories_usecase.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final GetServiceCategoriesUseCase getServiceCategoriesUseCase;

  ServicesBloc({
    required this.getServiceCategoriesUseCase, required GetServicesByTypeUseCase getServicesByTypeUseCase,
  }) : super(ServicesInitial()) {
    on<LoadServices>(_onLoadServices);
    on<UpdateServiceStats>(_onUpdateServiceStats);
    on<FilterServices>(_onFilterServices);
  }

  void _onLoadServices(LoadServices event, Emitter<ServicesState> emit) async {
    emit(ServicesLoading());
    
    final result = await getServiceCategoriesUseCase();
    
    result.fold(
      (failure) => emit(ServicesError(failure.message)),
      (categories) {
        // Преобразуем ServiceCategory в UI модель с иконками и цветами
        final services = categories.map((category) {
          IconData icon;
          Color color;
          
          switch (category.title) {
            case 'Уход за лицом':
              icon = Icons.face;
              color = Colors.blue;
              break;
            case 'Уход за телом':
              icon = Icons.self_improvement;
              color = Colors.green;
              break;
            case 'Депиляция':
              icon = Icons.content_cut;
              color = Colors.orange;
              break;
            case 'Массаж':
              icon = Icons.spa;
              color = Colors.purple;
              break;
            case 'SPA-программы':
              icon = Icons.pool;
              color = Colors.pink;
              break;
            default:
              icon = Icons.spa;
              color = Colors.grey;
          }
          
          return ServiceCategoryUI(
            id: category.id,
            title: category.title,
            icon: icon,
            route: category.route,
            color: color,
            description: category.description,
            serviceCount: category.serviceCount,
            totalPrice: category.totalPrice,
            isPopular: category.isPopular,
          );
        }).toList();
        
        emit(ServicesLoaded(services: services, filteredServices: services));
      },
    );
  }

  void _onUpdateServiceStats(UpdateServiceStats event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      final updatedServices = currentState.services.map((service) {
        if (service.title == event.categoryTitle) {
          return service.copyWith(
            serviceCount: service.serviceCount + 1,
            totalPrice: service.totalPrice + event.price,
          );
        }
        return service;
      }).toList();

      emit(ServicesLoaded(
        services: updatedServices,
        filteredServices: updatedServices,
      ));
    }
  }

  void _onFilterServices(FilterServices event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      List<ServiceCategoryUI> filteredServices;

      if (event.filter == ServiceFilter.all) {
        filteredServices = currentState.services;
      } else if (event.filter == ServiceFilter.popular) {
        filteredServices = currentState.services.where((service) => service.isPopular).toList();
      } else {
        filteredServices = currentState.services.where((service) =>
        service.title.toLowerCase().contains(event.searchQuery.toLowerCase()) ||
            service.description.toLowerCase().contains(event.searchQuery.toLowerCase())
        ).toList();
      }

      emit(ServicesLoaded(
        services: currentState.services,
        filteredServices: filteredServices,
      ));
    }
  }
}


