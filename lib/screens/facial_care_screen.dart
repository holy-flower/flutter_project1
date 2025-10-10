import 'package:flutter/material.dart';

class FacialCareScreen extends StatefulWidget {
  const FacialCareScreen({super.key});

  @override
  State<FacialCareScreen> createState() => _FacialCareScreenState();
}

class _FacialCareScreenState extends State<FacialCareScreen> {
  int _selectedService = -1;

  List<Map<String, dynamic>> _services = [
    {
      'title': 'Чистка лица',
      'duration': '45 мин',
      'price': '2000 ₽',
      'description': 'Комплексная очистка пор, удаление черных точек',
      'details': 'Глубокая чистка лица с использованием профессиональной косметики. Удаление черных точек, очистка пор, уменьшение воспалений. Подходит для всех типов кожи.',
      'effects': ['Очищение пор', 'Уменьшение воспалений', 'Улучшение цвета лица'],
    },
    {
      'title': 'Ультразвуковая чистка',
      'duration': '50 мин',
      'price': '2800 ₽',
      'description': 'Безболезненная чистка ультразвуком',
      'details': 'Современный метод очистки кожи с помощью ультразвуковых волн. Безболезненно и эффективно удаляет загрязнения, не травмируя кожу.',
      'effects': ['Безболезненная процедура', 'Не травмирует кожу', 'Подходит для чувствительной кожи'],
    },
    {
      'title': 'Химический пилинг',
      'duration': '60 мин',
      'price': '3500 ₽',
      'description': 'Обновление кожи, уменьшение морщин',
      'details': 'Процедура химического пилинга с использованием кислот для обновления кожи. Уменьшает морщины, выравнивает тон кожи.',
      'effects': ['Обновление кожи', 'Уменьшение морщин', 'Выравнивание тона'],
    },
    {
      'title': 'Альгинатная маска',
      'duration': '30 мин',
      'price': '1500 ₽',
      'description': 'Увлажнение и питание кожи',
      'details': 'Насыщающая маска на основе морских водорослей. Интенсивно увлажняет и питает кожу, восстанавливает гидролипидный баланс.',
      'effects': ['Глубокое увлажнение', 'Питание кожи', 'Восстановление баланса'],
    },
    {
      'title': 'Массаж лица',
      'duration': '40 мин',
      'price': '2200 ₽',
      'description': 'Лимфодренажный массаж для тонуса кожи',
      'details': 'Профессиональный лимфодренажный массаж лица. Улучшает кровообращение, снимает отечность, повышает тонус кожи.',
      'effects': ['Улучшение кровообращения', 'Снятие отечности', 'Повышение тонуса'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
                child: ListView.separated (
                    itemCount: _services.length,
                    separatorBuilder: (context, index) => Container(height: 3, color: Colors.purpleAccent),
                    itemBuilder: (context, index){
                      final service = _services[index];
                      return _buildServiceCard(
                        service['title'],
                        service['duration'],
                        service['price'],
                        service['description'],
                        service['details'],
                        service['effects'],
                        index,
                        isExpanded: _selectedService == index,
                      );
                    }
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
      String title,
      String duration,
      String price,
      String description,
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
                    duration,
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
                        color: Colors.pink[700],
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
                        color: Colors.pink[700],
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
                              color: Colors.pink[400],
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