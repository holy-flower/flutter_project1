import 'package:flutter/material.dart';

import '../../../core/models/service_category.dart';
import '../../../core/models/service.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';

abstract class ServicesApiDataSource {
  Future<Either<Failure, List<ServiceCategory>>> getServiceCategories();
  Future<Either<Failure, List<Service>>> getServicesByType(ServiceType type);
  Future<Either<Failure, Service>> addService(Service service);
  Future<Either<Failure, void>> deleteService(String serviceId);
}

class ServicesApiDataSourceImpl implements ServicesApiDataSource {
  final List<ServiceCategory> _categories = [
    ServiceCategory(
      id: '1',
      title: 'Уход за лицом',
      route: '/facial_care',
      description: 'Чистка, пилинги, уходовые процедуры',
      serviceCount: 12,
      totalPrice: 45000,
      isPopular: true,
    ),
    ServiceCategory(
      id: '2',
      title: 'Уход за телом',
      route: '/body_care',
      description: 'Обертывания, скрабы, коррекция фигуры',
      serviceCount: 8,
      totalPrice: 32000,
      isPopular: false,
    ),
    ServiceCategory(
      id: '3',
      title: 'Депиляция',
      route: '/hair_removal',
      description: 'Все виды удаления волос',
      serviceCount: 6,
      totalPrice: 18000,
      isPopular: true,
    ),
    ServiceCategory(
      id: '4',
      title: 'Массаж',
      route: '/massage',
      description: 'Расслабляющий и лечебный массаж',
      serviceCount: 10,
      totalPrice: 35000,
      isPopular: false,
    ),
    ServiceCategory(
      id: '5',
      title: 'SPA-программы',
      route: '/spa',
      description: 'Комплексные программы релаксации',
      serviceCount: 5,
      totalPrice: 55000,
      isPopular: true,
    ),
  ];

  final Map<ServiceType, List<Service>> _services = {
    ServiceType.facialCare: [
      const Service(
        id: '1',
        title: 'Чистка лица',
        duration: '45 мин',
        price: '2000 ₽',
        description: 'Комплексная очистка пор, удаление черных точек',
        details: 'Глубокая чистка лица с использованием профессиональной косметики. Удаление черных точек, очистка пор, уменьшение воспалений. Подходит для всех типов кожи.',
        effects: ['Очищение пор', 'Уменьшение воспалений', 'Улучшение цвета лица'],
        type: ServiceType.facialCare,
      ),
      const Service(
        id: '2',
        title: 'Ультразвуковая чистка',
        duration: '50 мин',
        price: '2800 ₽',
        description: 'Безболезненная чистка ультразвуком',
        details: 'Современный метод очистки кожи с помощью ультразвуковых волн. Безболезненно и эффективно удаляет загрязнения, не травмируя кожу.',
        effects: ['Безболезненная процедура', 'Не травмирует кожу', 'Подходит для чувствительной кожи'],
        type: ServiceType.facialCare,
      ),
      const Service(
        id: '3',
        title: 'Химический пилинг',
        duration: '60 мин',
        price: '3500 ₽',
        description: 'Обновление кожи, уменьшение морщин',
        details: 'Процедура химического пилинга с использованием кислот для обновления кожи. Уменьшает морщины, выравнивает тон кожи.',
        effects: ['Обновление кожи', 'Уменьшение морщин', 'Выравнивание тона'],
        type: ServiceType.facialCare,
      ),
    ],
    ServiceType.bodyCare: [
      const Service(
        id: '4',
        title: 'Обертывание водорослевое',
        duration: '60 мин',
        price: '4000 ₽',
        description: 'Коррекция фигуры и выведение токсинов',
        details: 'Обертывание на основе морских водорослей. Способствует выведению токсинов, улучшению тонуса кожи, коррекции фигуры.',
        features: ['Водорослевое', 'Антицеллюлитное'],
        effects: ['Коррекция фигуры', 'Выведение токсинов', 'Улучшение тонуса кожи'],
        type: ServiceType.bodyCare,
      ),
    ],
    ServiceType.hairRemoval: [
      Service(
        id: '5',
        title: 'Лазерная эпиляция',
        duration: '30-60 мин',
        price: 'от 2000 ₽',
        description: 'Долговременное удаление волос лазером',
        zones: ['Лицо', 'Подмышки', 'Ноги', 'Бикини'],
        color: Colors.orange,
        type: ServiceType.hairRemoval,
      ),
    ],
    ServiceType.massage: [
      const Service(
        id: '6',
        title: 'Классический массаж',
        duration: '60 мин',
        price: '3000 ₽',
        description: 'Расслабляющий массаж всего тела',
        indication: 'Стресс, мышечное напряжение',
        details: 'Классический массаж всего тела для расслабления и снятия напряжения. Улучшает кровообращение и общее самочувствие.',
        techniques: ['Поглаживание', 'Разминание', 'Растирание'],
        benefits: ['Снятие напряжения', 'Улучшение кровообращения', 'Расслабление'],
        type: ServiceType.massage,
      ),
    ],
    ServiceType.spa: [
      Service(
        id: '7',
        title: 'SPA "Релакс"',
        duration: '120 мин',
        price: '8000 ₽',
        description: 'Комплексная программа релаксации',
        includes: ['Массаж', 'Обертывание', 'Уход за лицом', 'Ароматерапия'],
        color: Colors.purple,
        type: ServiceType.spa,
      ),
    ],
  };

  @override
  Future<Either<Failure, List<ServiceCategory>>> getServiceCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return right(List.from(_categories));
  }

  @override
  Future<Either<Failure, List<Service>>> getServicesByType(ServiceType type) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return right(List.from(_services[type] ?? []));
  }

  @override
  Future<Either<Failure, Service>> addService(Service service) async {
    if (!_services.containsKey(service.type)) {
      _services[service.type] = [];
    }
    _services[service.type]!.add(service);
    return right(service);
  }

  @override
  Future<Either<Failure, void>> deleteService(String serviceId) async {
    for (var services in _services.values) {
      services.removeWhere((s) => s.id == serviceId);
    }
    return right(null);
  }
}

