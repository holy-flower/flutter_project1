import 'package:flutter/material.dart';
import '../models/hair_removal_service.dart';

class ServiceSelector extends StatelessWidget {
  final List<HairRemovalService> services;
  final int selectedService;
  final Function(int) onSelectService;
  final Function(int) onDeleteService;

  const ServiceSelector({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onSelectService,
    required this.onDeleteService,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () => onSelectService(index),
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selectedService == index
                    ? service.color.withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedService == index
                      ? service.color
                      : Colors.grey[300]!,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        service.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: service.color,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.price,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: service.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (services.length > 1)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => onDeleteService(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.red[700],
                            size: 12,
                          ),
                        ),
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
}