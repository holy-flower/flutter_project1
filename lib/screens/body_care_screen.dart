import 'package:flutter/material.dart';

class BodyCareScreen extends StatelessWidget {
  const BodyCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildServiceGridItem(
                    'Обертывание',
                    '4000 ₽',
                    ['Водорослевое', 'Шоколадное', 'Медовое'],
                  ),
                  _buildServiceGridItem(
                    'Скрабирование',
                    '2500 ₽',
                    ['Кофейный скраб', 'Соляной скраб', 'Сахарный скраб'],
                  ),
                  _buildServiceGridItem(
                    'Антицеллюлит',
                    '5000 ₽',
                    ['Массаж', 'Обертывание', 'Скрабирование'],
                  ),
                  _buildServiceGridItem(
                    'Увлажнение',
                    '3000 ₽',
                    ['Интенсивное', 'Питательное', 'Восстанавливающее'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceGridItem(String title, String price, List<String> features) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features.take(2).map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  '• $feature',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}