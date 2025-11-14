import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'Уход за лицом',
        'icon': Icons.face,
        'route': '/facial_care',
        'color': Colors.blue,
        'description': 'Чистка, пилинги, уходовые процедуры'
      },
      {
        'title': 'Уход за телом',
        'icon': Icons.self_improvement,
        'route': '/body_care',
        'color': Colors.green,
        'description': 'Обертывания, скрабы, коррекция фигуры'
      },
      {
        'title': 'Депиляция',
        'icon': Icons.content_cut,
        'route': '/hair_removal',
        'color': Colors.orange,
        'description': 'Все виды удаления волос'
      },
      {
        'title': 'Массаж',
        'icon': Icons.spa,
        'route': '/massage',
        'color': Colors.purple,
        'description': 'Расслабляющий и лечебный массаж'
      },
      {
        'title': 'SPA-программы',
        'icon': Icons.pool,
        'route': '/spa',
        'color': Colors.pink,
        'description': 'Комплексные программы релаксации'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Категории услуг',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      service['icon'],
                      color: service['color'],
                      size: 32,
                    ),
                    title: Text(
                      service['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(service['description']),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.push(service['route']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}