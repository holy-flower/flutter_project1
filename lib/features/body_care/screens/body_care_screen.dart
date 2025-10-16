import 'package:flutter/material.dart';
import '../models/body_service.dart';
import '../widgets/body_service_list.dart';

class BodyCareScreen extends StatelessWidget {
  final List<BodyService> services;
  final int selectedService;
  final Function(int) onSelectService;
  final Function(int) onDeleteService;
  final VoidCallback onAddService;

  const BodyCareScreen({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onSelectService,
    required this.onDeleteService,
    required this.onAddService,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton(
        onPressed: onAddService,
        backgroundColor: Colors.blue[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: BodyServiceList(
                services: services,
                selectedService: selectedService,
                onSelectService: onSelectService,
                onDeleteService: onDeleteService,
              ),
            ),
          ],
        ),
      ),
    );
  }
}