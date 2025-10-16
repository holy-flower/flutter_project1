import 'package:flutter/material.dart';

class BodyCareScreen extends StatefulWidget {
  const BodyCareScreen({super.key});

  @override
  State<BodyCareScreen> createState() => _BodyCareScreenState();
}

class _BodyCareScreenState extends State<BodyCareScreen> {
  int _selectedService = -1;

  List<Map<String, dynamic>> _services = [
    {
      'title': 'Обертывание',
      'price': '4000 ₽',
      'duration': '60 мин',
      'description': 'Комплексное обертывание для коррекции фигуры',
      'features': ['Водорослевое', 'Шоколадное', 'Медовое'],
      'details': 'Процедура обертывания с использованием натуральных компонентов. Способствует уменьшению объемов, выведению токсинов и улучшению состояния кожи.',
      'effects': ['Коррекция фигуры', 'Выведение токсинов', 'Улучшение тонуса кожи'],
    },
    {
      'title': 'Скрабирование',
      'price': '2500 ₽',
      'duration': '45 мин',
      'description': 'Глубокое очищение и обновление кожи тела',
      'features': ['Кофейный скраб', 'Соляной скраб', 'Сахарный скраб'],
      'details': 'Процедура эксфолиации для удаления омертвевших клеток кожи. Стимулирует кровообращение и подготавливает кожу к последующему уходу.',
      'effects': ['Очищение кожи', 'Стимуляция кровообращения', 'Обновление клеток'],
    },
    {
      'title': 'Антицеллюлит',
      'price': '5000 ₽',
      'duration': '75 мин',
      'description': 'Комплексная программа против целлюлита',
      'features': ['Массаж', 'Обертывание', 'Скрабирование'],
      'details': 'Интенсивная программа, сочетающая несколько методик для эффективной борьбы с целлюлитом. Включает массаж, обертывание и скрабирование.',
      'effects': ['Уменьшение целлюлита', 'Улучшение лимфотока', 'Подтяжка кожи'],
    },
    {
      'title': 'Увлажнение',
      'price': '3000 ₽',
      'duration': '50 мин',
      'description': 'Интенсивное увлажнение и питание кожи тела',
      'features': ['Интенсивное', 'Питательное', 'Восстанавливающее'],
      'details': 'Процедура глубокого увлажнения с использованием профессиональной косметики. Восстанавливает гидролипидный баланс и улучшает эластичность кожи.',
      'effects': ['Глубокое увлажнение', 'Восстановление баланса', 'Улучшение эластичности'],
    },
  ];

  void _selectService(int index) {
    setState(() {
      _selectedService = _selectedService == index ? -1 : index;
    });
  }

  void _deleteService(int index) {
    setState(() {
      _services.removeAt(index);
      if (_selectedService == index) {
        _selectedService = -1;
      } else if (_selectedService > index) {
        _selectedService--;
      }
    });
  }

  void _addService() {
    setState(() {
      _services.add({
        'title': 'Новая услуга',
        'price': '2000 ₽',
        'duration': '45 мин',
        'description': 'Описание новой услуги по уходу за телом',
        'features': ['Вариант 1', 'Вариант 2'],
        'details': 'Подробное описание новой услуги будет добавлено позже.',
        'effects': ['Эффект 1', 'Эффект 2', 'Эффект 3'],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton(
        onPressed: _addService,
        backgroundColor: Colors.blue[400],
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
                  child: Column (
                    children: [
                      ..._services.asMap().entries.map((entry) {
                        final index = entry.key;
                        final service = entry.value;
                        return _buildServiceCard(
                          service['title'],
                          service['price'],
                          service['duration'],
                          service['description'],
                          service['features'],
                          service['details'],
                          service['effects'],
                          index,
                          isExpanded: _selectedService == index,
                        );
                      }),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      String title,
      String price,
      String duration,
      String description,
      List<String> features,
      String details,
      List<String> effects,
      int index, {
        required bool isExpanded,
      }) {
    return Card(
      key: ValueKey(title),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => _selectService(index),
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
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: features.map((feature) => Chip(
                      label: Text(
                        feature,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.blue[100],
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    )).toList(),
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
                        color: Colors.blue[700],
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
                      'Эффект:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: effects.map((effect) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue[400],
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              effect,
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

          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => _deleteService(index),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red[700],
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}