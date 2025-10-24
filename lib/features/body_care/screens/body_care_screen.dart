import 'package:flutter/material.dart';
import '../models/body_service.dart';
import '../widgets/body_service_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            CachedNetworkImage(
              imageUrl: 'https://avatars.mds.yandex.net/get-ydo/3927445/2a00000180bd9555624724006a173c0f80bd/diploma',
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