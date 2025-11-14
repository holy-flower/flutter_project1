import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

  Widget _buildAppointmentsList(BuildContext context, List<Map<String, dynamic>> appointments) {
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
                  color: _getServiceColor(appointment['serviceType']),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getServiceIcon(appointment['serviceType']),
                  color: Colors.white,
                ),
              ),
              title: Text(
                appointment['serviceName'] ?? 'Услуга',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Дата: ${appointment['date']}'),
                  Text('Время: ${appointment['time']}'),
                  Text('Мастер: ${appointment['master']}'),
                  if (appointment['price'] != null)
                    Text('Цена: ${appointment['price']} руб.'),
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
                      _showDeleteConfirmationDialog(context, appointment['id']);
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

  Color _getServiceColor(String serviceType) {
    switch (serviceType) {
      case 'facial':
        return Colors.blue;
      case 'body':
        return Colors.green;
      case 'hair_removal':
        return Colors.orange;
      case 'massage':
        return Colors.purple;
      case 'spa':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getServiceIcon(String serviceType) {
    switch (serviceType) {
      case 'facial':
        return Icons.face;
      case 'body':
        return Icons.self_improvement;
      case 'hair_removal':
        return Icons.content_cut;
      case 'massage':
        return Icons.spa;
      case 'spa':
        return Icons.pool;
      default:
        return Icons.calendar_today;
    }
  }

  void _showAddAppointmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String serviceName = '';
        String date = '';
        String time = '';
        String master = '';
        String serviceType = 'facial';

        return AlertDialog(
          title: const Text('Новая запись'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: serviceType,
                  items: const [
                    DropdownMenuItem(value: 'facial', child: Text('Уход за лицом')),
                    DropdownMenuItem(value: 'body', child: Text('Уход за телом')),
                    DropdownMenuItem(value: 'hair_removal', child: Text('Депиляция')),
                    DropdownMenuItem(value: 'massage', child: Text('Массаж')),
                    DropdownMenuItem(value: 'spa', child: Text('SPA-программы')),
                  ],
                  onChanged: (value) {
                    serviceType = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Тип услуги'),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Название услуги'),
                  onChanged: (value) => serviceName = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Дата (дд.мм.гггг)'),
                  onChanged: (value) => date = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Время (чч:мм)'),
                  onChanged: (value) => time = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Мастер'),
                  onChanged: (value) => master = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (serviceName.isNotEmpty && date.isNotEmpty && time.isNotEmpty && master.isNotEmpty) {
                  final newAppointment = {
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'serviceType': serviceType,
                    'serviceName': serviceName,
                    'date': date,
                    'time': time,
                    'master': master,
                    'price': _getDefaultPrice(serviceType),
                  };

                  context.read<AppointmentsBloc>().add(AddAppointment(newAppointment));
                  context.pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Запись успешно добавлена!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAppointmentDialog(BuildContext context, Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) {
        String serviceName = appointment['serviceName'] ?? '';
        String date = appointment['date'] ?? '';
        String time = appointment['time'] ?? '';
        String master = appointment['master'] ?? '';
        String serviceType = appointment['serviceType'] ?? 'facial';

        return AlertDialog(
          title: const Text('Редактировать запись'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: serviceType,
                  items: const [
                    DropdownMenuItem(value: 'facial', child: Text('Уход за лицом')),
                    DropdownMenuItem(value: 'body', child: Text('Уход за телом')),
                    DropdownMenuItem(value: 'hair_removal', child: Text('Депиляция')),
                    DropdownMenuItem(value: 'massage', child: Text('Массаж')),
                    DropdownMenuItem(value: 'spa', child: Text('SPA-программы')),
                  ],
                  onChanged: (value) {
                    serviceType = value!;
                  },
                  decoration: const InputDecoration(labelText: 'Тип услуги'),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Название услуги'),
                  controller: TextEditingController(text: serviceName),
                  onChanged: (value) => serviceName = value,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Дата (дд.мм.гггг)'),
                  controller: TextEditingController(text: date),
                  onChanged: (value) => date = value,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Время (чч:мм)'),
                  controller: TextEditingController(text: time),
                  onChanged: (value) => time = value,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Мастер'),
                  controller: TextEditingController(text: master),
                  onChanged: (value) => master = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (serviceName.isNotEmpty && date.isNotEmpty && time.isNotEmpty && master.isNotEmpty) {
                  final updatedAppointment = Map<String, dynamic>.from(appointment)
                    ..update('serviceType', (value) => serviceType)
                    ..update('serviceName', (value) => serviceName)
                    ..update('date', (value) => date)
                    ..update('time', (value) => time)
                    ..update('master', (value) => master)
                    ..update('price', (value) => _getDefaultPrice(serviceType));

                  context.read<AppointmentsBloc>().add(UpdateAppointment(updatedAppointment));
                  context.pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Запись успешно обновлена!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Заполните все поля!'),
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
                context.pop();
              },
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AppointmentsBloc>().add(DeleteAppointment(appointmentId));
                context.pop();

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

  double _getDefaultPrice(String serviceType) {
    switch (serviceType) {
      case 'facial':
        return 2500.0;
      case 'body':
        return 3500.0;
      case 'hair_removal':
        return 2000.0;
      case 'massage':
        return 3000.0;
      case 'spa':
        return 5000.0;
      default:
        return 0.0;
    }
  }
}