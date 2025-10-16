import 'package:flutter/material.dart';

class SpaService {
  final String id;
  final String title;
  final String duration;
  final String price;
  final String description;
  final List<String> includes;
  final Color color;

  SpaService({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    required this.includes,
    required this.color,
  });

  SpaService copyWith({
    String? id,
    String? title,
    String? duration,
    String? price,
    String? description,
    List<String>? includes,
    Color? color,
  }) {
    return SpaService(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      description: description ?? this.description,
      includes: includes ?? this.includes,
      color: color ?? this.color,
    );
  }
}