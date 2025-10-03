import 'package:flutter/material.dart';

class MassageScreen extends StatelessWidget {
  const MassageScreen({super.key});

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
                children: const [
                  MassageTypeCard(
                    title: 'Классический массаж',
                    duration: '60 мин',
                    price: '3000 ₽',
                    description: 'Расслабляющий массаж всего тела для снятия напряжения и стресса',
                    indication: 'Стресс, усталость, мышечное напряжение'
                  ),
                  MassageTypeCard(
                    title: 'Антицеллюлитный массаж',
                    duration: '45 мин',
                    price: '3500 ₽',
                    description: 'Интенсивная проработка проблемных зон для коррекции фигуры',
                    indication: 'Целлюлит, дряблость кожи, локальные жировые отложения'
                  ),
                  MassageTypeCard(
                    title: 'Лимфодренажный массаж',
                    duration: '50 мин',
                    price: '4000 ₽',
                    description: 'Техника для выведения лишней жидкости и токсинов из организма',
                    indication: 'Отеки, нарушение лимфотока, детокс'
                  ),
                  MassageTypeCard(
                    title: 'SPA-массаж',
                    duration: '75 мин',
                    price: '5000 ₽',
                    description: 'Комплексный релакс с ароматерапией и расслабляющей атмосферой',
                    indication: 'Глубокий релакс, восстановление, гармония'
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

class MassageTypeCard extends StatelessWidget {
  final String title;
  final String duration;
  final String price;
  final String description;
  final String indication;

  const MassageTypeCard({
    super.key,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.indication
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold
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
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Показания: $indication',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
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