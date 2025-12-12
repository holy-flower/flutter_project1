import 'package:flutter/material.dart';
import '../../../../core/models/service.dart';

class MassageCard extends StatelessWidget {
  final Service massage;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const MassageCard({
    super.key,
    required this.massage,
    required this.isExpanded,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(massage.id),
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 8),
                  _buildDescription(),
                  const SizedBox(height: 8),
                  if (massage.indication != null && massage.indication!.isNotEmpty)
                    _buildIndication(),
                  if (isExpanded) _buildExpandedContent(),
                ],
              ),
            ),
          ),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          massage.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            massage.price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Длительность: ${massage.duration}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Text(
          massage.description,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildIndication() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.medical_services,
            size: 16,
            color: Colors.green[600],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Показания: ${massage.indication}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.green[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 12),
        if (massage.details != null && massage.details!.isNotEmpty) ...[
          _buildSectionTitle('Подробное описание:'),
          const SizedBox(height: 8),
          Text(
            massage.details!,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (massage.techniques != null && massage.techniques!.isNotEmpty) ...[
          _buildSectionTitle('Используемые техники:'),
          const SizedBox(height: 8),
          _buildTechniques(),
          const SizedBox(height: 12),
        ],
        if (massage.benefits != null && massage.benefits!.isNotEmpty) ...[
          _buildSectionTitle('Преимущества:'),
          const SizedBox(height: 8),
          _buildBenefits(),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.green[700],
        fontSize: 14,
      ),
    );
  }

  Widget _buildTechniques() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: massage.techniques!.map((technique) => Chip(
        label: Text(
          technique,
          style: const TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.green[100],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      )).toList(),
    );
  }

  Widget _buildBenefits() {
    return Column(
      children: massage.benefits!.map((benefit) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green[400],
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                benefit,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildDeleteButton() {
    return Positioned(
      bottom: 8,
      right: 8,
      child: GestureDetector(
        onTap: onDelete,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.delete_outline,
            color: Colors.red[700],
            size: 18,
          ),
        ),
      ),
    );
  }
}





