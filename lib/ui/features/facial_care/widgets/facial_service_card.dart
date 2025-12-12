import 'package:flutter/material.dart';
import '../../../../core/models/service.dart';

class FacialServiceCard extends StatelessWidget {
  final Service service;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const FacialServiceCard({
    super.key,
    required this.service,
    required this.isExpanded,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(service.id),
      margin: const EdgeInsets.only(bottom: 12),
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
          service.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          service.price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
          service.duration,
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Text(
          service.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
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
        if (service.details != null && service.details!.isNotEmpty) ...[
          _buildSectionTitle('Подробное описание:'),
          const SizedBox(height: 8),
          Text(
            service.details!,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (service.effects != null && service.effects!.isNotEmpty) ...[
          _buildSectionTitle('Эффект:'),
          const SizedBox(height: 8),
          _buildEffectsList(),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.pink[700],
        fontSize: 14,
      ),
    );
  }

  Widget _buildEffectsList() {
    return Column(
      children: service.effects!.map((effect) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.pink[400],
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                effect,
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





