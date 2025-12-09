import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Service extends Equatable {
  final String id;
  final String title;
  final String duration;
  final String price;
  final String description;
  final String? details;
  final List<String>? effects;
  final List<String>? features;
  final List<String>? zones; // для hair_removal
  final List<String>? techniques; // для massage
  final List<String>? benefits; // для massage
  final List<String>? includes; // для spa
  final String? indication; // для massage
  final Color? color; // для hair_removal и spa
  final ServiceType type;

  const Service({
    required this.id,
    required this.title,
    required this.duration,
    required this.price,
    required this.description,
    this.details,
    this.effects,
    this.features,
    this.zones,
    this.techniques,
    this.benefits,
    this.includes,
    this.indication,
    this.color,
    required this.type,
  });

  Service copyWith({
    String? id,
    String? title,
    String? duration,
    String? price,
    String? description,
    String? details,
    List<String>? effects,
    List<String>? features,
    List<String>? zones,
    List<String>? techniques,
    List<String>? benefits,
    List<String>? includes,
    String? indication,
    Color? color,
    ServiceType? type,
  }) {
    return Service(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      price: price ?? this.price,
      description: description ?? this.description,
      details: details ?? this.details,
      effects: effects ?? this.effects,
      features: features ?? this.features,
      zones: zones ?? this.zones,
      techniques: techniques ?? this.techniques,
      benefits: benefits ?? this.benefits,
      includes: includes ?? this.includes,
      indication: indication ?? this.indication,
      color: color ?? this.color,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    duration,
    price,
    description,
    details,
    effects,
    features,
    zones,
    techniques,
    benefits,
    includes,
    indication,
    color,
    type,
  ];
}

enum ServiceType {
  facialCare,
  bodyCare,
  hairRemoval,
  massage,
  spa,
}

