import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<LoadServices>(_onLoadServices);
    on<UpdateServiceStats>(_onUpdateServiceStats);
    on<FilterServices>(_onFilterServices);
  }

  void _onLoadServices(LoadServices event, Emitter<ServicesState> emit) async {
    try {
      emit(ServicesLoading());

      await Future.delayed(const Duration(milliseconds: 500));

      final services = [
        ServiceCategory(
          title: 'Уход за лицом',
          icon: Icons.face,
          route: '/facial_care',
          color: Colors.blue,
          description: 'Чистка, пилинги, уходовые процедуры',
          serviceCount: 12,
          totalPrice: 45000,
          isPopular: true,
        ),
        ServiceCategory(
          title: 'Уход за телом',
          icon: Icons.self_improvement,
          route: '/body_care',
          color: Colors.green,
          description: 'Обертывания, скрабы, коррекция фигуры',
          serviceCount: 8,
          totalPrice: 32000,
          isPopular: false,
        ),
        ServiceCategory(
          title: 'Депиляция',
          icon: Icons.content_cut,
          route: '/hair_removal',
          color: Colors.orange,
          description: 'Все виды удаления волос',
          serviceCount: 6,
          totalPrice: 18000,
          isPopular: true,
        ),
        ServiceCategory(
          title: 'Массаж',
          icon: Icons.spa,
          route: '/massage',
          color: Colors.purple,
          description: 'Расслабляющий и лечебный массаж',
          serviceCount: 10,
          totalPrice: 35000,
          isPopular: false,
        ),
        ServiceCategory(
          title: 'SPA-программы',
          icon: Icons.pool,
          route: '/spa',
          color: Colors.pink,
          description: 'Комплексные программы релаксации',
          serviceCount: 5,
          totalPrice: 55000,
          isPopular: true,
        ),
      ];

      emit(ServicesLoaded(services: services, filteredServices: services));
    } catch (e) {
      emit(ServicesError('Не удалось загрузить услуги: $e'));
    }
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
      List<ServiceCategory> filteredServices;

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