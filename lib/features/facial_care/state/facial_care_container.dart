import 'package:flutter/material.dart';
import 'package:flutter_project1/features/facial_care/screens/add_facial_service_screen.dart';
import '../models/facial_service.dart';
import '../screens/facial_care_screen.dart';

class FacialCareContainer extends StatefulWidget {
  const FacialCareContainer({super.key});

  @override
  State<FacialCareContainer> createState() => _FacialCareContainerState();
}

class _FacialCareContainerState extends State<FacialCareContainer> {
  int _selectedService = -1;
  final List<FacialService> _services = [
    FacialService(
      id: '1',
      title: 'Чистка лица',
      duration: '45 мин',
      price: '2000 ₽',
      description: 'Комплексная очистка пор, удаление черных точек',
      details: 'Глубокая чистка лица с использованием профессиональной косметики. Удаление черных точек, очистка пор, уменьшение воспалений. Подходит для всех типов кожи.',
      effects: ['Очищение пор', 'Уменьшение воспалений', 'Улучшение цвета лица'],
    ),
    FacialService(
      id: '2',
      title: 'Ультразвуковая чистка',
      duration: '50 мин',
      price: '2800 ₽',
      description: 'Безболезненная чистка ультразвуком',
      details: 'Современный метод очистки кожи с помощью ультразвуковых волн. Безболезненно и эффективно удаляет загрязнения, не травмируя кожу.',
      effects: ['Безболезненная процедура', 'Не травмирует кожу', 'Подходит для чувствительной кожи'],
    ),
    FacialService(
      id: '3',
      title: 'Химический пилинг',
      duration: '60 мин',
      price: '3500 ₽',
      description: 'Обновление кожи, уменьшение морщин',
      details: 'Процедура химического пилинга с использованием кислот для обновления кожи. Уменьшает морщины, выравнивает тон кожи.',
      effects: ['Обновление кожи', 'Уменьшение морщин', 'Выравнивание тона'],
    ),
    FacialService(
      id: '4',
      title: 'Альгинатная маска',
      duration: '30 мин',
      price: '1500 ₽',
      description: 'Увлажнение и питание кожи',
      details: 'Насыщающая маска на основе морских водорослей. Интенсивно увлажняет и питает кожу, восстанавливает гидролипидный баланс.',
      effects: ['Глубокое увлажнение', 'Питание кожи', 'Восстановление баланса'],
    ),
    FacialService(
      id: '5',
      title: 'Массаж лица',
      duration: '40 мин',
      price: '2200 ₽',
      description: 'Лимфодренажный массаж для тонуса кожи',
      details: 'Профессиональный лимфодренажный массаж лица. Улучшает кровообращение, снимает отечность, повышает тонус кожи.',
      effects: ['Улучшение кровообращения', 'Снятие отечности', 'Повышение тонуса'],
    ),
  ];

  void _selectService(int index) {
    setState(() {
      _selectedService = _selectedService == index ? -1 : index;
    });
  }

  void _deleteService(int index) {
    final removedService = _services[index];
    final removedIndex = index;

    setState(() {
      _services.removeAt(index);
      if (_selectedService == index) {
        _selectedService = -1;
      } else if (_selectedService > index) {
        _selectedService--;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Услуга "${removedService.title}" удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _services.insert(removedIndex, removedService);
              if (_selectedService >= removedIndex) {
                _selectedService++;
              }
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _navigateToAddService() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddFacialServiceScreen(
                onServiceAdded: _addService,
            )
        )
    );
  }

  void _addService(FacialService newService) {
    setState(() {
      _services.add(newService);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Услуга "${newService.title}" добавлена'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FacialCareScreen(
      services: _services,
      selectedService: _selectedService,
      onSelectService: _selectService,
      onDeleteService: _deleteService,
      onAddService: _navigateToAddService,
    );
  }
}