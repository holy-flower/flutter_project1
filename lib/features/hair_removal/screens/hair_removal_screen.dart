import 'package:flutter/material.dart';
import '../models/hair_removal_service.dart';
import '../widgets/service_selector.dart';
import '../widgets/service_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            CachedNetworkImage(
              imageUrl: 'https://ak.picdn.net/shutterstock/videos/1093975795/thumb/1.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
              const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ServiceSelector(
              services: services,
              selectedService: selectedService,
              onSelectService: onSelectService,
              onDeleteService: onDeleteService,
            ),
            const SizedBox(height: 20),
            Expanded(
                child: SingleChildScrollView(
                  child: ServiceDetails(
                    service: services[selectedService],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}