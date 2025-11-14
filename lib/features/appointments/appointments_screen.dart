import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

enum AppointmentStatus {
  confirmed,
  pending,
  completed,
  cancelled,
}

class Appointment {
  final String id;
  final String clientName;
  final String service;
  final DateTime dateTime;
  final int duration;
  final int price;
  AppointmentStatus status;
  final String phone;

  Appointment({
    required this.id,
    required this.clientName,
    required this.service,
    required this.dateTime,
    required this.duration,
    required this.price,
    required this.status,
    required this.phone,
  });
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<Appointment> _appointments = [
    Appointment(
      id: '1',
      clientName: 'Мария Иванова',
      service: 'Чистка лица',
      dateTime: DateTime.now().add(const Duration(hours: 2)),
      duration: 60,
      price: 2000,
      status: AppointmentStatus.confirmed,
      phone: '+7 (911) 123-45-67',
    ),
    Appointment(
      id: '2',
      clientName: 'Елена Петрова',
      service: 'SPA "Релакс"',
      dateTime: DateTime.now().add(const Duration(days: 1, hours: 3)),
      duration: 120,
      price: 8000,
      status: AppointmentStatus.confirmed,
      phone: '+7 (912) 234-56-78',
    ),
    Appointment(
      id: '3',
      clientName: 'Анна Сидорова',
      service: 'Лазерная эпиляция',
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 1)),
      duration: 90,
      price: 3000,
      status: AppointmentStatus.pending,
      phone: '+7 (913) 345-67-89',
    ),
    Appointment(
      id: '4',
      clientName: 'Ольга Козлова',
      service: 'Антицеллюлитный массаж',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      duration: 45,
      price: 3500,
      status: AppointmentStatus.completed,
      phone: '+7 (914) 456-78-90',
    ),
    Appointment(
      id: '5',
      clientName: 'Ирина Николаева',
      service: 'Обертывание',
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      duration: 60,
      price: 4000,
      status: AppointmentStatus.completed,
      phone: '+7 (915) 567-89-01',
    ),
  ];

  String _selectedFilter = 'upcoming';

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day.$month.$year $hour:$minute';
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes мин';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return '$hours ч ${remainingMinutes > 0 ? '$remainingMinutes мин' : ''}'.trim();
    }
  }

  List<Appointment> get _filteredAppointments {
    final now = DateTime.now();
    switch (_selectedFilter) {
      case 'upcoming':
        return _appointments
            .where((appointment) =>
        appointment.dateTime.isAfter(now) &&
            appointment.status != AppointmentStatus.cancelled)
            .toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
      case 'today':
        return _appointments
            .where((appointment) =>
        appointment.dateTime.year == now.year &&
            appointment.dateTime.month == now.month &&
            appointment.dateTime.day == now.day)
            .toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
      case 'completed':
        return _appointments
            .where((appointment) => appointment.status == AppointmentStatus.completed)
            .toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
      case 'cancelled':
        return _appointments
            .where((appointment) => appointment.status == AppointmentStatus.cancelled)
            .toList()
          ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
      default:
        return _appointments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Фильтры
        SizedBox(
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildFilterChip('Предстоящие', 'upcoming'),
              _buildFilterChip('Сегодня', 'today'),
              _buildFilterChip('Завершенные', 'completed'),
              _buildFilterChip('Отмененные', 'cancelled'),
            ],
          ),
        ),
        const Divider(height: 1),

        Expanded(
          child: _filteredAppointments.isEmpty
              ? const Center(
            child: Text(
              'Нет записей',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredAppointments.length,
            itemBuilder: (context, index) {
              final appointment = _filteredAppointments[index];
              return _buildAppointmentCard(appointment);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String filter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: _selectedFilter == filter,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = filter;
          });
        },
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.pink[100],
        checkmarkColor: Colors.pink,
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment.clientName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(appointment.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(appointment.status),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              appointment.service,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  _formatDateTime(appointment.dateTime),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  _formatDuration(appointment.duration),
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      appointment.phone,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                Text(
                  '${appointment.price} ₽',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (appointment.status == AppointmentStatus.pending ||
                (appointment.dateTime.isAfter(DateTime.now()) &&
                    appointment.status == AppointmentStatus.confirmed))
              Row(
                children: [
                  if (appointment.status == AppointmentStatus.pending)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _confirmAppointment(appointment.id),
                        child: const Text('Подтвердить'),
                      ),
                    ),
                  if (appointment.status == AppointmentStatus.pending)
                    const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _cancelAppointment(appointment.id),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Отменить'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return Colors.green;
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.completed:
        return Colors.blue;
      case AppointmentStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return 'Подтверждена';
      case AppointmentStatus.pending:
        return 'Ожидание';
      case AppointmentStatus.completed:
        return 'Завершена';
      case AppointmentStatus.cancelled:
        return 'Отменена';
    }
  }

  void _confirmAppointment(String appointmentId) {
    setState(() {
      final appointment = _appointments.firstWhere((a) => a.id == appointmentId);
      appointment.status = AppointmentStatus.confirmed;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Запись подтверждена')),
    );
  }

  void _cancelAppointment(String appointmentId) {
    setState(() {
      final appointment = _appointments.firstWhere((a) => a.id == appointmentId);
      appointment.status = AppointmentStatus.cancelled;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Запись отменена')),
    );
  }
}