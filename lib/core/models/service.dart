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
  final List<String>? zones;
  final List<String>? techniques;
  final List<String>? benefits;
  final List<String>? includes;
  final String? indication;
  final Color? color;
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'price': price,
      'description': description,
      'details': details,
      'effects': effects,
      'features': features,
      'zones': zones,
      'techniques': techniques,
      'benefits': benefits,
      'includes': includes,
      'indication': indication,
      'colorValue': color?.value,
      'type': type.name,
    };
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      title: json['title'] as String,
      duration: json['duration'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
      details: json['details'] as String?,
      effects: json['effects'] != null ? List<String>.from(json['effects'] as List) : null,
      features: json['features'] != null ? List<String>.from(json['features'] as List) : null,
      zones: json['zones'] != null ? List<String>.from(json['zones'] as List) : null,
      techniques: json['techniques'] != null ? List<String>.from(json['techniques'] as List) : null,
      benefits: json['benefits'] != null ? List<String>.from(json['benefits'] as List) : null,
      includes: json['includes'] != null ? List<String>.from(json['includes'] as List) : null,
      indication: json['indication'] as String?,
      color: json['colorValue'] != null ? Color(json['colorValue'] as int) : null,
      type: ServiceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ServiceType.facialCare,
      ),
    );
  }
}

enum ServiceType {
  facialCare,
  bodyCare,
  hairRemoval,
  massage,
  spa,
}

