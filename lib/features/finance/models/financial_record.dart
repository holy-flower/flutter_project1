import 'package:equatable/equatable.dart';

enum FinancialType { income, expense }

class FinancialRecord extends Equatable {
  final String id;
  final DateTime date;
  final String service;
  final int amount;
  final String client;
  final String description;
  final FinancialType type;

  const FinancialRecord({
    required this.id,
    required this.date,
    required this.service,
    required this.amount,
    this.client = '',
    this.description = '',
    required this.type,
  });

  FinancialRecord copyWith({
    String? id,
    DateTime? date,
    String? service,
    int? amount,
    String? client,
    String? description,
    FinancialType? type,
  }) {
    return FinancialRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      service: service ?? this.service,
      amount: amount ?? this.amount,
      client: client ?? this.client,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }

  factory FinancialRecord.empty() {
    return FinancialRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      service: '',
      amount: 0,
      client: '',
      description: '',
      type: FinancialType.income,
    );
  }

  @override
  List<Object> get props => [
    id,
    date,
    service,
    amount,
    client,
    description,
    type,
  ];
}