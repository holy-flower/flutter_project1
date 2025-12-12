import 'package:flutter/material.dart';
import '../../../../core/models/service.dart';

class ServiceDetails extends StatelessWidget {
  final Service service;

  const ServiceDetails({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final color = service.color ?? Colors.orange;
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
                    service.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service.price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Время: ${service.duration}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Text(
                service.description,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
              if (service.zones != null && service.zones!.isNotEmpty) ...[
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
                  children: service.zones!.map((zone) => Chip(
                    label: Text(
                      zone,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: color.withOpacity(0.1),
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





