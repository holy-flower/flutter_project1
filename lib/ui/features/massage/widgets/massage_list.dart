import 'package:flutter/material.dart';
import '../../../../core/models/service.dart';
import 'massage_card.dart';

class MassageList extends StatelessWidget {
  final List<Service> massages;
  final int selectedMassage;
  final Function(int) onSelectMassage;
  final Function(int) onDeleteMassage;

  const MassageList({
    super.key,
    required this.massages,
    required this.selectedMassage,
    required this.onSelectMassage,
    required this.onDeleteMassage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: massages.length,
      itemBuilder: (context, index) {
        final massage = massages[index];
        return MassageCard(
          massage: massage,
          isExpanded: selectedMassage == index,
          onTap: () => onSelectMassage(index),
          onDelete: () => onDeleteMassage(index),
        );
      },
    );
  }
}


