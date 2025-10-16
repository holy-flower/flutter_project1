import 'package:flutter/material.dart';

class HairRemovalService {
  final String id;
  final String name;
  final String price;
  final String time;
  final String description;
  final Color color;
  final List<String> zones;

  HairRemovalService({
    required this.id,
    required this.name,
    required this.price,
    required this.time,
    required this.description,
    required this.color,
    required this.zones,
  });

  HairRemovalService copyWith({
    String? id,
    String? name,
    String? price,
    String? time,
    String? description,
    Color? color,
    List<String>? zones,
  }) {
    return HairRemovalService(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      time: time ?? this.time,
      description: description ?? this.description,
      color: color ?? this.color,
      zones: zones ?? this.zones,
    );
  }
}