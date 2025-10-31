import 'package:flutter/material.dart';
import 'package:flutter_project1/features/spa/models/spa_service.dart';
import '../models/spa_service.dart';
import '../widgets/program_selector.dart';
import '../widgets/program_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: 'http://dental0c.beget.tech/wp-content/uploads/2024/12/1234.jpg',
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
            ),
            const SizedBox(height: 10),

            Container(
              height: 120,
              child: ProgramSelector(
                programs: programs,
                selectedProgram: selectedProgram,
                onSelectProgram: onSelectProgram,
                onDeleteProgram: onDeleteProgram,
              ),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ProgramDetails(
                  program: programs[selectedProgram],
                  onBookProgram: onBookProgram,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}