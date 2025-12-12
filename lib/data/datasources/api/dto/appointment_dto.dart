class AppointmentDto {
  final String id;
  final String clientName;
  final String service;
  final String dateTime;
  final String? notes;
  final String? phone;
  final String status;

  AppointmentDto({
    required this.id,
    required this.clientName,
    required this.service,
    required this.dateTime,
    this.notes,
    this.phone,
    this.status = 'scheduled',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'clientName': clientName,
    'service': service,
    'dateTime': dateTime,
    'notes': notes,
    'phone': phone,
    'status': status,
  };

  factory AppointmentDto.fromJson(Map<String, dynamic> json) => AppointmentDto(
    id: json['id'] as String,
    clientName: json['clientName'] as String,
    service: json['service'] as String,
    dateTime: json['dateTime'] as String,
    notes: json['notes'] as String?,
    phone: json['phone'] as String?,
    status: json['status'] as String? ?? 'scheduled',
  );
}





