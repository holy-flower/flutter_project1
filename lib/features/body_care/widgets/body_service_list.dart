import 'package:flutter/material.dart';
import '../models/body_service.dart';
import '../widgets/body_service_card.dart';

class BodyServiceList extends StatelessWidget {
  final List<BodyService> services;
  final int selectedService;
  final Function(int) onSelectService;
  final Function(int) onDeleteService;

  const BodyServiceList({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onSelectService,
    required this.onDeleteService,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return BodyServiceCard(
          service: service,
          isExpanded: selectedService == index,
          onTap: () => onSelectService(index),
          onDelete: () => onDeleteService(index),
        );
      },
    );
  }
}