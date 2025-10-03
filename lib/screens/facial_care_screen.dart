import 'package:flutter/material.dart';

class FacialCareScreen extends StatelessWidget {
  const FacialCareScreen({super.key});

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
              child: ListView(
                children: [
                  _buildServiceCard(
                    'Чистка лица',
                    '45 мин',
                    '2000 ₽',
                    'Комплексная очистка пор, удаление черных точек',
                  ),
                  _buildServiceCard(
                    'Ультразвуковая чистка',
                    '50 мин',
                    '2800 ₽',
                    'Безболезненная чистка ультразвуком',
                  ),
                  _buildServiceCard(
                    'Химический пилинг',
                    '60 мин',
                    '3500 ₽',
                    'Обновление кожи, уменьшение морщин',
                  ),
                  _buildServiceCard(
                    'Альгинатная маска',
                    '30 мин',
                    '1500 ₽',
                    'Увлажнение и питание кожи',
                  ),
                  _buildServiceCard(
                    'Массаж лица',
                    '40 мин',
                    '2200 ₽',
                    'Лимфодренажный массаж для тонуса кожи',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String duration, String price, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}