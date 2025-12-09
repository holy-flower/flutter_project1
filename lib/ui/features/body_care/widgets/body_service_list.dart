import 'package:flutter/material.dart';
import '../../../../core/models/service.dart';
import 'body_service_card.dart';

class BodyServiceList extends StatelessWidget {
  final List<Service> services;
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
    return ListView.separated(
      itemCount: services.length,
      separatorBuilder: (context, index) => Container(
          height: 3,
          color: Colors.blueAccent[100]
      ),
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


