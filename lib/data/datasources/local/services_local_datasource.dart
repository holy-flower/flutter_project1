import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../core/models/service.dart' as models;
import '../../../core/models/service_category.dart' as models;
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'app_database.dart';
import 'package:drift/drift.dart';

abstract class ServicesLocalDataSource {
  Future<Either<Failure, List<models.ServiceCategory>>> getServiceCategories();
  Future<Either<Failure, List<models.Service>>> getServicesByType(models.ServiceType type);
  Future<Either<Failure, models.Service>> addService(models.Service service);
  Future<Either<Failure, void>> deleteService(String serviceId);
}

class ServicesLocalDataSourceImpl implements ServicesLocalDataSource {
  final AppDatabase _database;

  ServicesLocalDataSourceImpl(this._database);

  @override
  Future<Either<Failure, List<models.ServiceCategory>>> getServiceCategories() async {
    try {
      final query = _database.select(_database.serviceCategories);
      final rows = await query.get();

      final categories = rows.map((row) {
        return models.ServiceCategory(
          id: row.id,
          title: row.title,
          route: row.route,
          description: row.description,
          serviceCount: row.serviceCount,
          totalPrice: row.totalPrice,
          isPopular: row.isPopular,
        );
      }).toList();

      if (categories.isEmpty) {
        final defaultCategories = _getDefaultCategories();
        for (final category in defaultCategories) {
          await _saveCategory(category);
        }
        return right(defaultCategories);
      }

      final updatedCategories = await _updateCategoryCounts(categories);
      return right(updatedCategories);

      return right(categories);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки категорий услуг: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<models.Service>>> getServicesByType(models.ServiceType type) async {
    try {
      final query = _database.select(_database.services)
        ..where((t) => t.type.equals(type.name));
      final rows = await query.get();

      final services = rows.map((row) {
        return _serviceFromRow(row as dynamic);
      }).toList();

      return right(services);
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки услуг: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, models.Service>> addService(models.Service service) async {
    try {
      final companion = ServicesCompanion(
        id: Value(service.id),
        title: Value(service.title),
        duration: Value(service.duration),
        price: Value(service.price),
        description: Value(service.description),
        details: Value(service.details),
        effects: Value(service.effects != null ? jsonEncode(service.effects) : null),
        features: Value(service.features != null ? jsonEncode(service.features) : null),
        zones: Value(service.zones != null ? jsonEncode(service.zones) : null),
        techniques: Value(service.techniques != null ? jsonEncode(service.techniques) : null),
        benefits: Value(service.benefits != null ? jsonEncode(service.benefits) : null),
        includes: Value(service.includes != null ? jsonEncode(service.includes) : null),
        indication: Value(service.indication),
        colorValue: Value(service.color?.value),
        type: Value(service.type.name),
      );

      await _database.into(_database.services).insert(companion);
      return right(service);
    } catch (e) {
      return left(CacheFailure('Ошибка добавления услуги: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteService(String serviceId) async {
    try {
      final deleted = await (_database.delete(_database.services)..where((t) => t.id.equals(serviceId))).go();

      if (deleted == 0) {
        return left(const ServerFailure('Услуга не найдена'));
      }

      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления услуги: ${e.toString()}'));
    }
  }

  models.Service _serviceFromRow(dynamic row) {
    return models.Service(
      id: row.id,
      title: row.title,
      duration: row.duration,
      price: row.price,
      description: row.description,
      details: row.details,
      effects: row.effects != null ? List<String>.from(jsonDecode(row.effects!)) : null,
      features: row.features != null ? List<String>.from(jsonDecode(row.features!)) : null,
      zones: row.zones != null ? List<String>.from(jsonDecode(row.zones!)) : null,
      techniques: row.techniques != null ? List<String>.from(jsonDecode(row.techniques!)) : null,
      benefits: row.benefits != null ? List<String>.from(jsonDecode(row.benefits!)) : null,
      includes: row.includes != null ? List<String>.from(jsonDecode(row.includes!)) : null,
      indication: row.indication,
      color: row.colorValue != null ? Color(row.colorValue!) : null,
      type: models.ServiceType.values.firstWhere(
        (e) => e.name == row.type,
        orElse: () => models.ServiceType.facialCare,
      ),
    );
  }

  Future<void> _saveCategory(models.ServiceCategory category) async {
    final companion = ServiceCategoriesCompanion(
      id: Value(category.id),
      title: Value(category.title),
      route: Value(category.route),
      description: Value(category.description),
      serviceCount: Value(category.serviceCount),
      totalPrice: Value(category.totalPrice),
      isPopular: Value(category.isPopular),
    );

    await _database.into(_database.serviceCategories).insert(companion, mode: InsertMode.replace);
  }

  Future<List<models.ServiceCategory>> _updateCategoryCounts(List<models.ServiceCategory> categories) async {
    final updatedCategories = <models.ServiceCategory>[];
    
    for (final category in categories) {
      final type = _getServiceTypeFromRoute(category.route);
      if (type != null) {
        final servicesQuery = _database.select(_database.services)
          ..where((t) => t.type.equals(type.name));
        final services = await servicesQuery.get();
        
        int totalPrice = 0;
        for (final s in services) {
          final priceStr = (s as dynamic).price as String?;
          if (priceStr != null) {
            final price = int.tryParse(priceStr.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
            totalPrice += price;
          }
        }
        
        final updatedCategory = category.copyWith(
          serviceCount: services.length,
          totalPrice: totalPrice,
        );
        updatedCategories.add(updatedCategory);
      } else {
        updatedCategories.add(category);
      }
    }
    
    return updatedCategories;
  }

  models.ServiceType? _getServiceTypeFromRoute(String route) {
    switch (route) {
      case '/facial_care':
        return models.ServiceType.facialCare;
      case '/body_care':
        return models.ServiceType.bodyCare;
      case '/hair_removal':
        return models.ServiceType.hairRemoval;
      case '/massage':
        return models.ServiceType.massage;
      case '/spa':
        return models.ServiceType.spa;
      default:
        return null;
    }
  }

  List<models.ServiceCategory> _getDefaultCategories() {
    return [
      models.ServiceCategory(
        id: '1',
        title: 'Уход за лицом',
        route: '/facial_care',
        description: 'Чистка, пилинги, уходовые процедуры',
        serviceCount: 0,
        totalPrice: 0,
        isPopular: true,
      ),
      models.ServiceCategory(
        id: '2',
        title: 'Уход за телом',
        route: '/body_care',
        description: 'Обертывания, скрабы, коррекция фигуры',
        serviceCount: 0,
        totalPrice: 0,
        isPopular: false,
      ),
      models.ServiceCategory(
        id: '3',
        title: 'Депиляция',
        route: '/hair_removal',
        description: 'Все виды удаления волос',
        serviceCount: 0,
        totalPrice: 0,
        isPopular: true,
      ),
      models.ServiceCategory(
        id: '4',
        title: 'Массаж',
        route: '/massage',
        description: 'Расслабляющий и лечебный массаж',
        serviceCount: 0,
        totalPrice: 0,
        isPopular: false,
      ),
      models.ServiceCategory(
        id: '5',
        title: 'SPA-программы',
        route: '/spa',
        description: 'Комплексные программы релаксации',
        serviceCount: 0,
        totalPrice: 0,
        isPopular: true,
      ),
    ];
  }
}

