enum FinancialType { income, expense }

class FinancialRecord {
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'service': service,
      'amount': amount,
      'client': client,
      'description': description,
      'type': type.name,
    };
  }

  factory FinancialRecord.fromJson(Map<String, dynamic> json) {
    return FinancialRecord(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      service: json['service'] as String,
      amount: json['amount'] as int,
      client: json['client'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: FinancialType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => FinancialType.income,
      ),
    );
  }
}



