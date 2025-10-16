import 'package:flutter/material.dart';
import 'package:flutter_project1/features/spa/models/spa_service.dart';
import '../models/spa_service.dart';
import '../widgets/program_selector.dart';
import '../widgets/program_details.dart';

class SpaScreen extends StatelessWidget {
  final List<SpaService> programs;
  final int selectedProgram;
  final Function(int) onSelectProgram;
  final Function(int) onDeleteProgram;
  final VoidCallback onAddProgram;
  final VoidCallback onBookProgram;

  const SpaScreen({
    super.key,
    required this.programs,
    required this.selectedProgram,
    required this.onSelectProgram,
    required this.onDeleteProgram,
    required this.onAddProgram,
    required this.onBookProgram,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      floatingActionButton: FloatingActionButton(
        onPressed: onAddProgram,
        backgroundColor: Colors.purple[400],
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          ProgramSelector(
            programs: programs,
            selectedProgram: selectedProgram,
            onSelectProgram: onSelectProgram,
            onDeleteProgram: onDeleteProgram,
          ),
          ProgramDetails(
            program: programs[selectedProgram],
            onBookProgram: onBookProgram,
          ),
        ],
      ),
    );
  }
}