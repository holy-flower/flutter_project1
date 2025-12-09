import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/appointment.dart';
import 'bloc/appointments_bloc.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Мои записи',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<AppointmentsBloc, AppointmentsState>(
              builder: (context, state) {
                if (state is AppointmentsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AppointmentsLoaded) {
                  return _buildAppointmentsList(context, state.appointments);
                } else if (state is AppointmentsError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ошибка: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<AppointmentsBloc>().add(LoadAppointments());
                          },
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Загрузка записей...'),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAppointmentDialog(context);
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAppointmentsList(BuildContext context, List<Appointment> appointments) {
    if (appointments.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              const Text(
                'Нет активных записей',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Нажмите + чтобы записаться',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getStatusColor(appointment.status),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
              ),
              title: Text(
                appointment.service,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Клиент: ${appointment.clientName}'),
                  Text('Дата: ${_formatDateTime(appointment.dateTime)}'),
                  if (appointment.phone != null)
                    Text('Телефон: ${appointment.phone}'),
                  if (appointment.notes != null && appointment.notes!.isNotEmpty)
                    Text('Примечание: ${appointment.notes}'),
                  Text('Статус: ${_getStatusText(appointment.status)}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      _showEditAppointmentDialog(context, appointment);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, appointment.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'scheduled':
        return 'Запланировано';
      case 'completed':
        return 'Завершено';
      case 'cancelled':
        return 'Отменено';
      default:
        return status;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showAddAppointmentDialog(BuildContext context) {
    final TextEditingController clientNameController = TextEditingController();
    final TextEditingController serviceController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    
    DateTime selectedDateTime = DateTime.now();
    String selectedStatus = 'scheduled';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Новая запись'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: clientNameController,
                    decoration: const InputDecoration(
                      labelText: 'Имя клиента*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: serviceController,
                    decoration: const InputDecoration(
                      labelText: 'Услуга*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Телефон',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: 'Примечания',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Статус',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'scheduled', child: Text('Запланировано')),
                      DropdownMenuItem(value: 'completed', child: Text('Завершено')),
                      DropdownMenuItem(value: 'cancelled', child: Text('Отменено')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value ?? 'scheduled';
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: const Text('Дата и время'),
                    subtitle: Text(_formatDateTime(selectedDateTime)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (clientNameController.text.isNotEmpty && 
                      serviceController.text.isNotEmpty) {
                    final newAppointment = Appointment(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      clientName: clientNameController.text,
                      service: serviceController.text,
                      dateTime: selectedDateTime,
                      phone: phoneController.text.isEmpty ? null : phoneController.text,
                      notes: notesController.text.isEmpty ? null : notesController.text,
                      status: selectedStatus,
                    );

                    context.read<AppointmentsBloc>().add(AddAppointment(newAppointment));
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Запись успешно добавлена!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Заполните обязательные поля!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Добавить'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditAppointmentDialog(BuildContext context, Appointment appointment) {
    final TextEditingController clientNameController = TextEditingController(text: appointment.clientName);
    final TextEditingController serviceController = TextEditingController(text: appointment.service);
    final TextEditingController phoneController = TextEditingController(text: appointment.phone ?? '');
    final TextEditingController notesController = TextEditingController(text: appointment.notes ?? '');
    
    DateTime selectedDateTime = appointment.dateTime;
    String selectedStatus = appointment.status;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Редактировать запись'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: clientNameController,
                    decoration: const InputDecoration(
                      labelText: 'Имя клиента*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: serviceController,
                    decoration: const InputDecoration(
                      labelText: 'Услуга*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Телефон',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: 'Примечания',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Статус',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'scheduled', child: Text('Запланировано')),
                      DropdownMenuItem(value: 'completed', child: Text('Завершено')),
                      DropdownMenuItem(value: 'cancelled', child: Text('Отменено')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value ?? 'scheduled';
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    title: const Text('Дата и время'),
                    subtitle: Text(_formatDateTime(selectedDateTime)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (clientNameController.text.isNotEmpty && 
                      serviceController.text.isNotEmpty) {
                    final updatedAppointment = appointment.copyWith(
                      clientName: clientNameController.text,
                      service: serviceController.text,
                      dateTime: selectedDateTime,
                      phone: phoneController.text.isEmpty ? null : phoneController.text,
                      notes: notesController.text.isEmpty ? null : notesController.text,
                      status: selectedStatus,
                    );

                    context.read<AppointmentsBloc>().add(UpdateAppointment(updatedAppointment));
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Запись успешно обновлена!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Заполните обязательные поля!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String appointmentId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить эту запись?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AppointmentsBloc>().add(DeleteAppointment(appointmentId));
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Запись удалена!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Удалить'),
            ),
          ],
        );
      },
    );
  }
}


