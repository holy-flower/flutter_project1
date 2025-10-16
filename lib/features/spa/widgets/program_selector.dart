import 'package:flutter/material.dart';
import 'package:flutter_project1/features/spa/models/spa_service.dart';
import '../models/spa_service.dart';

class ProgramSelector extends StatelessWidget {
  final List<SpaService> programs;
  final int selectedProgram;
  final Function(int) onSelectProgram;
  final Function(int) onDeleteProgram;

  const ProgramSelector({
    super.key,
    required this.programs,
    required this.selectedProgram,
    required this.onSelectProgram,
    required this.onDeleteProgram,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: programs.length,
        itemBuilder: (context, index) {
          final program = programs[index];
          return GestureDetector(
            onTap: () => onSelectProgram(index),
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selectedProgram == index
                    ? program.color.withOpacity(0.2)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selectedProgram == index
                      ? program.color
                      : Colors.grey[300]!,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        program.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: program.color,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        program.price,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: program.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (programs.length > 1)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => onDeleteProgram(index),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.red[700],
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}