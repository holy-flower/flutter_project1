import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String id;
  final String clientName;
  final String service;
  final DateTime dateTime;
  final String? notes;
  final String? phone;
  final String status;

  const Appointment({
    required this.id,
    required this.clientName,
    required this.service,
    required this.dateTime,
    this.notes,
    this.phone,
    this.status = 'scheduled',
  });

  Appointment copyWith({
    String? id,
    String? clientName,
    String? service,
    DateTime? dateTime,
    String? notes,
    String? phone,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      service: service ?? this.service,
      dateTime: dateTime ?? this.dateTime,
      notes: notes ?? this.notes,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, clientName, service, dateTime, notes, phone, status];
}

