import 'package:flutter/material.dart';
import '../models/massage_service.dart';
import '../widgets/massage_list.dart';

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