import 'package:flutter/material.dart';

class SPAScreen extends StatefulWidget {
  const SPAScreen({super.key});

  @override
  State<SPAScreen> createState() => _SPAScreenState();
}

class _SPAScreenState extends State<SPAScreen> {
  int _selectedProgram = 0;

  final List<Map<String, dynamic>> _programs = [
    {
      'title': 'SPA "Релакс"',
      'duration': '120 мин',
      'price': '8000 ₽',
      'description': 'Идеальная программа для снятия стресса и напряжения',
      'includes': [
        'Консультация специалиста',
        'Ароматическая ванна',
        'Расслабляющий массаж всего тела',
        'Уход за лицом',
        'Травяной чай и отдых'
      ],
      'color': Colors.purple
    },
    {
      'title': 'SPA "Королевский"',
      'duration': '180 мин',
      'price': '12000 ₽',
      'description': 'Премиальный уход для настоящих ценителей роскоши',
      'includes': [
        'Персональный SPA-консультант',
        'Джакузи с гидромассажем',
        'SPA-массаж премиум-класса',
        'Экспресс-уход за лицом',
        'Профессиональный маникюр',
        'Фруктовая тарелка и шампанское'
      ],
      'color': Colors.purple
    },
    {
      'title': 'SPA "Антистресс"',
      'duration': '90 мин',
      'price': '6000 ₽',
      'description': 'Быстрое восстановление при нервном напряжении',
      'includes': [
        'Аромотерапия',
        'Расслабляющий массаж',
        'Медитативная практика',
        'Травяной сбор'
      ],
      'color': Colors.purple
    },
    {
      'title': 'SPA "Детокс"',
      'duration': '150 мин',
      'price': '9000 ₽',
      'description': 'Очищение организма и восстановление энергии',
      'includes': [
        'Сухая чистка тела',
        'Обертывание водорослями',
        'Лимфодренажный массаж',
        'Детокс-напитки',
        'Консультация по питанию'
      ],
      'color': Colors.purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Column(
        children: [
          _buildProgramSelector(),
          _buildProgramDetails(),
        ],
      ),
    );
  }

  Widget _buildProgramSelector() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: _programs.length,
        itemBuilder: (context, index) {
          final program = _programs[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedProgram = index;
              });
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _selectedProgram == index
                    ? program['color'].withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedProgram == index
                      ? program['color']
                      : Colors.grey[300]!,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    program['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: program['color'],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgramDetails() {
    final program = _programs[_selectedProgram];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      program['title'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: program['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        program['price'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: program['color'],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Длительность: ${program['duration']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  program['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'В программу входит:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: (program['includes'] as List<String>).length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                program['includes'][index],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: program['color'],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Забронировать программу',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}