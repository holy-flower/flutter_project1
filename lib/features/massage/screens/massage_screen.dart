import 'package:flutter/material.dart';
import '../models/massage_service.dart';
import '../widgets/massage_list.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MassageScreen extends StatelessWidget {
  final List<MassageService> massages;
  final int selectedMassage;
  final Function(int) onSelectMassage;
  final Function(int) onDeleteMassage;
  final VoidCallback onAddMassage;

  const MassageScreen({
    super.key,
    required this.massages,
    required this.selectedMassage,
    required this.onSelectMassage,
    required this.onDeleteMassage,
    required this.onAddMassage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      floatingActionButton: FloatingActionButton(
        onPressed: onAddMassage,
        backgroundColor: Colors.green[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://avatars.mds.yandex.net/get-altay/367512/2a0000015b861eefde2b7a30525f34bd1031/orig',
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
              child: MassageList(
                massages: massages,
                selectedMassage: selectedMassage,
                onSelectMassage: onSelectMassage,
                onDeleteMassage: onDeleteMassage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}