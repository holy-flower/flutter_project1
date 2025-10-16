import 'package:flutter/material.dart';
import '../models/spa_service.dart';
import '../screens/spa_screen.dart';

class SpaContainer extends StatefulWidget {
  const SpaContainer({super.key});

  @override
  State<SpaContainer> createState() => _SpaContainerState();
}

class _SpaContainerState extends State<SpaContainer> {
  int _selectedProgram = 0;
  final List<SpaService> _programs = [
    SpaService(
      id: '1',
      title: 'SPA "Релакс"',
      duration: '120 мин',
      price: '8000 ₽',
      description: 'Идеальная программа для снятия стресса и напряжения. Полное погружение в атмосферу спокойствия и гармонии.',
      includes: [
        'Консультация специалиста',
        'Ароматическая ванна',
        'Расслабляющий массаж всего тела',
        'Уход за лицом',
        'Травяной чай и отдых'
      ],
      color: Colors.purple,
    ),
    SpaService(
      id: '2',
      title: 'SPA "Королевский"',
      duration: '180 мин',
      price: '12000 ₽',
      description: 'Премиальный уход для настоящих ценителей роскоши. Исключительный комфорт и индивидуальный подход.',
      includes: [
        'Персональный SPA-консультант',
        'Джакузи с гидромассажем',
        'SPA-массаж премиум-класса',
        'Экспресс-уход за лицом',
        'Профессиональный маникюр',
        'Фруктовая тарелка и шампанское'
      ],
      color: Colors.deepPurple,
    ),
    SpaService(
      id: '3',
      title: 'SPA "Антистресс"',
      duration: '90 мин',
      price: '6000 ₽',
      description: 'Быстрое восстановление при нервном напряжении. Эффективные техники релаксации за короткое время.',
      includes: [
        'Аромотерапия',
        'Расслабляющий массаж',
        'Медитативная практика',
        'Травяной сбор'
      ],
      color: Colors.purpleAccent,
    ),
    SpaService(
      id: '4',
      title: 'SPA "Детокс"',
      duration: '150 мин',
      price: '9000 ₽',
      description: 'Очищение организма и восстановление энергии. Комплексное очищение и обновление организма.',
      includes: [
        'Сухая чистка тела',
        'Обертывание водорослями',
        'Лимфодренажный массаж',
        'Детокс-напитки',
        'Консультация по питанию'
      ],
      color: Colors.purple,
    ),
    SpaService(
      id: '5',
      title: 'SPA "Омоложение"',
      duration: '140 мин',
      price: '11000 ₽',
      description: 'Программа для восстановления молодости и тонуса кожи. Инновационные антивозрастные методики.',
      includes: [
        'Антивозрастной уход за лицом',
        'Лимфодренажный массаж',
        'Альгинатная маска',
        'Витаминный коктейль',
        'Консультация косметолога'
      ],
      color: Colors.deepPurpleAccent,
    ),
  ];

  void _selectProgram(int index) {
    setState(() {
      _selectedProgram = index;
    });
  }

  void _deleteProgram(int index) {
    if (_programs.length <= 1) return;

    final removedProgram = _programs[index];

    setState(() {
      _programs.removeAt(index);
      if (_selectedProgram >= index) {
        _selectedProgram = _selectedProgram == index ? 0 : _selectedProgram - 1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Программа "${removedProgram.title}" удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _programs.insert(index, removedProgram);
              _selectedProgram = index;
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _addProgram() {
    setState(() {
      _programs.add(SpaService(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: 'Новая SPA программа',
        duration: '120 мин',
        price: '7000 ₽',
        description: 'Описание новой SPA программы',
        includes: [
          'Услуга 1',
          'Услуга 2',
          'Услуга 3',
        ],
        color: Colors.purple,
      ));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Новая SPA программа добавлена'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _bookProgram() {
    final program = _programs[_selectedProgram];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Программа "${program.title}" забронирована!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SpaScreen(
      programs: _programs,
      selectedProgram: _selectedProgram,
      onSelectProgram: _selectProgram,
      onDeleteProgram: _deleteProgram,
      onAddProgram: _addProgram,
      onBookProgram: _bookProgram,
    );
  }
}