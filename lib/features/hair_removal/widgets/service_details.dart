import 'package:flutter/material.dart';
import '../models/hair_removal_service.dart';

class ServiceDetails extends StatelessWidget {
  final HairRemovalService service;

  const ServiceDetails({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
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
                    service.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: service.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service.price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: service.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Время: ${service.time}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Text(
                service.description,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
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
                children: service.zones.map((zone) => Chip(
                  label: Text(
                    zone,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: service.color.withOpacity(0.1),
                )).toList(),
              ),
              const SizedBox(height: 20),
              _buildAdditionalInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Дополнительная информация:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, color: service.color, size: 16),
            const SizedBox(width: 8),
            Text('Длительность эффекта: ${_getDurationInfo(service.name)}'),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.psychology, color: service.color, size: 16),
            const SizedBox(width: 8),
            Text('Рекомендуемый курс: ${_getCourseInfo(service.name)}'),
          ],
        ),
      ],
    );
  }

  String _getDurationInfo(String serviceName) {
    switch (serviceName) {
      case 'Восковая депиляция':
        return '2-4 недели';
      case 'Шугаринг':
        return '3-5 недель';
      case 'Лазерная эпиляция':
        return '6-12 месяцев';
      case 'Электроэпиляция':
        return '2-3 месяца';
      case 'Фотоэпиляция':
        return '4-8 месяцев';
      default:
        return '3-4 недели';
    }
  }

  String _getCourseInfo(String serviceName) {
    switch (serviceName) {
      case 'Восковая депиляция':
        return '1 процедура';
      case 'Шугаринг':
        return '1 процедура';
      case 'Лазерная эпиляция':
        return '6-8 процедур';
      case 'Электроэпиляция':
        return '10-15 процедур';
      case 'Фотоэпиляция':
        return '5-7 процедур';
      default:
        return '1 процедура';
    }
  }
}