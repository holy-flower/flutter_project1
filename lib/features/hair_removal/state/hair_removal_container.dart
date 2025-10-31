import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/hair_removal_service.dart';
import '../screens/hair_removal_screen.dart';
import '../screens/add_hair_removal_service_screen.dart';

class HairRemovalContainer extends StatefulWidget {
  const HairRemovalContainer({super.key});

  @override
  State<HairRemovalContainer> createState() => _HairRemovalContainerState();
}

class _HairRemovalContainerState extends State<HairRemovalContainer> {
  int _selectedService = 0;
  final List<HairRemovalService> _services = [
    HairRemovalService(
      id: '1',
      name: 'Восковая депиляция',
      price: 'от 800 ₽',
      time: '15-60 мин',
      description: 'Классическая восковая депиляция с использованием натурального воска. Эффективно удаляет волосы, замедляет их рост. Подходит для всех типов кожи.',
      color: Colors.brown,
      zones: ['Лицо', 'Подмышки', 'Ноги', 'Бикини', 'Руки'],
    ),
    HairRemovalService(
      id: '2',
      name: 'Шугаринг',
      price: 'от 1000 ₽',
      time: '20-70 мин',
      description: 'Сахарная депиляция по древней персидской технологии. Менее болезненная процедура, подходит для чувствительной кожи.',
      color: Colors.orange,
      zones: ['Лицо', 'Подмышки', 'Ноги', 'Бикини', 'Руки', 'Спина'],
    ),
    HairRemovalService(
      id: '3',
      name: 'Лазерная эпиляция',
      price: 'от 3000 ₽',
      time: '30-90 мин',
      description: 'Современная аппаратная эпиляция с использованием лазерных технологий. Длительный эффект, постепенное уменьшение роста волос.',
      color: Colors.purple,
      zones: ['Все зоны тела'],
    ),
    HairRemovalService(
      id: '4',
      name: 'Электроэпиляция',
      price: 'от 2500 ₽',
      time: '30-120 мин',
      description: 'Процедура полного удаления волос с помощью электрического тока. Наиболее эффективный метод для полного удаления.',
      color: Colors.blue,
      zones: ['Лицо', 'Подмышки', 'Бикини', 'Ноги'],
    ),
    HairRemovalService(
      id: '5',
      name: 'Фотоэпиляция',
      price: 'от 2000 ₽',
      time: '25-75 мин',
      description: 'Удаление волос с помощью интенсивного импульсного света. Безболезненная процедура с длительным эффектом.',
      color: Colors.green,
      zones: ['Лицо', 'Руки', 'Ноги', 'Подмышки'],
    ),
  ];

  void _selectService(int index) {
    setState(() {
      _selectedService = index;
    });
  }

  void _navigateToAddService() {
    context.push('/hair_removal/add', extra: _addService);
  }

  void _addService(HairRemovalService newService) {
    setState(() {
      _services.add(newService);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Метод "${newService.name}" добавлен'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteService(int index) {
    if (_services.length <= 1) return;

    final removedService = _services[index];

    setState(() {
      _services.removeAt(index);
      if (_selectedService >= index) {
        _selectedService = _selectedService == index ? 0 : _selectedService - 1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Метод "${removedService.name}" удален'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _services.insert(index, removedService);
              _selectedService = index;
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HairRemovalScreen(
      services: _services,
      selectedService: _selectedService,
      onSelectService: _selectService,
      onAddService: _navigateToAddService,
      onDeleteService: _deleteService,
    );
  }
}