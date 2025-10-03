import 'package:flutter/material.dart';

class MassageScreen extends StatefulWidget {
  const MassageScreen({super.key});

  @override
  State<MassageScreen> createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen> {
  int _selectedMassage = -1;

  final List<Map<String, dynamic>> _massages = [
    {
      'title': 'Классический массаж',
      'duration': '60 мин',
      'price': '3000 ₽',
      'description': 'Расслабляющий массаж всего тела для снятия напряжения и стресса',
      'indication': 'Стресс, усталость, мышечное напряжение',
      'details': 'Традиционный массаж, направленный на расслабление мышц, снятие напряжения и улучшение общего состояния. Включает техники поглаживания, разминания и растирания.',
      'techniques': ['Поглаживание', 'Разминание', 'Растирание', 'Вибрация'],
      'benefits': ['Снятие мышечного напряжения', 'Улучшение кровообращения', 'Расслабление нервной системы'],
    },
    {
      'title': 'Антицеллюлитный массаж',
      'duration': '45 мин',
      'price': '3500 ₽',
      'description': 'Интенсивная проработка проблемных зон для коррекции фигуры',
      'indication': 'Целлюлит, дряблость кожи, локальные жировые отложения',
      'details': 'Специализированный массаж, направленный на борьбу с целлюлитом и улучшение контуров тела. Используются интенсивные техники для разрушения жировых отложений.',
      'techniques': ['Глубокое разминание', 'Вакуумный массаж', 'Ручной лимфодренаж'],
      'benefits': ['Уменьшение целлюлита', 'Улучшение тонуса кожи', 'Коррекция фигуры'],
    },
    {
      'title': 'Лимфодренажный массаж',
      'duration': '50 мин',
      'price': '4000 ₽',
      'description': 'Техника для выведения лишней жидкости и токсинов из организма',
      'indication': 'Отеки, нарушение лимфотока, детокс',
      'details': 'Щадящий массаж, стимулирующий лимфатическую систему. Способствует выведению токсинов, уменьшению отеков и улучшению обмена веществ.',
      'techniques': ['Легкие надавливания', 'Круговые движения', 'Направленный лимфоток'],
      'benefits': ['Уменьшение отеков', 'Выведение токсинов', 'Улучшение лимфотока'],
    },
    {
      'title': 'SPA-массаж',
      'duration': '75 мин',
      'price': '5000 ₽',
      'description': 'Комплексный релакс с ароматерапией и расслабляющей атмосферой',
      'indication': 'Глубокий релакс, восстановление, гармония',
      'details': 'Премиальный массаж с использованием ароматических масел и расслабляющей музыки. Сочетает различные техники для достижения глубокого релакса.',
      'techniques': ['Ароматерапия', 'Комбинированные техники', 'Энергетический баланс'],
      'benefits': ['Глубокое расслабление', 'Восстановление энергии', 'Гармония тела и духа'],
    },
  ];

  void _selectMassage(int index) {
    setState(() {
      _selectedMassage = _selectedMassage == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ..._massages.asMap().entries.map((entry) {
                    final index = entry.key;
                    final massage = entry.value;
                    return _buildMassageCard(
                      massage['title'],
                      massage['duration'],
                      massage['price'],
                      massage['description'],
                      massage['indication'],
                      massage['details'],
                      massage['techniques'],
                      massage['benefits'],
                      index,
                      isExpanded: _selectedMassage == index,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMassageCard(
      String title,
      String duration,
      String price,
      String description,
      String indication,
      String details,
      List<String> techniques,
      List<String> benefits,
      int index, {
        required bool isExpanded,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      child: GestureDetector(
        onTap: () => _selectMassage(index),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Длительность: $duration',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(description),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 16,
                      color: Colors.green[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Показания: $indication',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (isExpanded) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 12),
                Text(
                  'Подробное описание:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  details,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Используемые техники:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: techniques.map((technique) => Chip(
                    label: Text(
                      technique,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.green[100],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  )).toList(),
                ),
                const SizedBox(height: 12),
                Text(
                  'Преимущества:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: benefits.map((benefit) => Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green[400],
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          benefit,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}