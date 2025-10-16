import 'package:flutter/material.dart';

class HairRemovalScreen extends StatefulWidget {
  const HairRemovalScreen({super.key});

  @override
  State<HairRemovalScreen> createState() => _HairRemovalScreenState();
}

class _HairRemovalScreenState extends State<HairRemovalScreen> {
  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Восковая депиляция',
      'price': 'от 800 ₽',
      'time': '15-60 мин',
      'description': 'Классическая восковая депиляция',
      'color': Colors.brown,
      'zones': ['Лицо', 'Подмышки', 'Ноги', 'Бикини', 'Руки']
    },
    {
      'name': 'Шугаринг',
      'price': 'от 1000 ₽',
      'time': '20-70 мин',
      'description': 'Сахарная депиляция',
      'color': Colors.brown,
      'zones': ['Лицо', 'Подмышки', 'Ноги', 'Бикини', 'Руки', 'Спина']
    },
    {
      'name': 'Лазерная эпиляция',
      'price': 'от 3000 ₽',
      'time': '30-90 мин',
      'description': 'Аппаратная эпиляция',
      'color': Colors.brown,
      'zones': ['Все зоны тела']
    },
  ];

  int _selectedService = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildServiceSelector(),
            const SizedBox(height: 20),
            _buildServiceDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceSelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedService = index;
              });
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _selectedService == index
                    ? service['color'].withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedService == index
                      ? service['color']
                      : Colors.grey[300]!,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    service['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: service['color'],
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

  Widget _buildServiceDetails() {
    final service = _services[_selectedService];
    return Expanded(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    service['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: service['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service['price'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: service['color'],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Время: ${service['time']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Text(service['description']),
              const SizedBox(height: 20),
              const Text(
                'Доступные зоны:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (service['zones'] as List<String>).map((zone) => Chip(
                  label: Text(zone),
                  backgroundColor: service['color'].withOpacity(0.1),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}