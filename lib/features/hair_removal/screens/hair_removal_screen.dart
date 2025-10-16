import 'package:flutter/material.dart';
import '../models/hair_removal_service.dart';
import '../widgets/service_selector.dart';
import '../widgets/service_details.dart';

class HairRemovalScreen extends StatelessWidget {
  final List<HairRemovalService> services;
  final int selectedService;
  final Function(int) onSelectService;
  final VoidCallback onAddService;
  final Function(int) onDeleteService;

  const HairRemovalScreen({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onSelectService,
    required this.onAddService,
    required this.onDeleteService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      floatingActionButton: FloatingActionButton(
        onPressed: onAddService,
        backgroundColor: Colors.orange[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ServiceSelector(
              services: services,
              selectedService: selectedService,
              onSelectService: onSelectService,
              onDeleteService: onDeleteService,
            ),
            const SizedBox(height: 20),
            ServiceDetails(
              service: services[selectedService],
            ),
          ],
        ),
      ),
    );
  }
}