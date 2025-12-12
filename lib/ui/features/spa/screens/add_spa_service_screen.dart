import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/service.dart';
import '../bloc/spa_bloc.dart';

class AddSpaServiceScreen extends StatefulWidget {
  const AddSpaServiceScreen({super.key});

  @override
  State<AddSpaServiceScreen> createState() => _AddSpaServiceScreenState();
}

class _AddSpaServiceScreenState extends State<AddSpaServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _includesController = TextEditingController();
  Color _selectedColor = Colors.purple;

  final List<Color> _availableColors = [
    Colors.purple,
    Colors.deepPurple,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _includesController.dispose();
    super.dispose();
  }

  void _saveSpaService() {
    if (_formKey.currentState!.validate()) {
      final newSpaService = Service(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text,
        duration: _durationController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        includes: _includesController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        color: _selectedColor,
        type: ServiceType.spa,
      );

      context.read<SpaBloc>().add(AddSpaService(newSpaService));
      context.pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Услуга успешно добавлена'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить SPA программу'),
        backgroundColor: Colors.pink[100],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSpaService,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название программы',
                  border: OutlineInputBorder(),
                  hintText: 'Например: SPA "Релакс", SPA "Королевский"',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название программы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Длительность программы',
                  border: OutlineInputBorder(),
                  hintText: 'Например: 120 мин, 180 мин',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите длительность программы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Стоимость программы',
                  border: OutlineInputBorder(),
                  hintText: 'Например: 8000 ₽, 12000 ₽',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите стоимость программы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание программы',
                  border: OutlineInputBorder(),
                  hintText: 'Подробное описание SPA программы',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание программы';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _includesController,
                decoration: const InputDecoration(
                  labelText: 'Что входит в программу (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Массаж, Обертывание, Уход за лицом, Ароматерапия',
                  helperText: 'Перечислите услуги, входящие в программу, через запятую',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите услуги, входящие в программу';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Цвет программы:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableColors.length,
                  itemBuilder: (context, index) {
                    final color = _availableColors[index];
                    return GestureDetector(
                      onTap: () => _selectColor(color),
                      child: Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: _selectedColor == color
                              ? Border.all(color: Colors.black, width: 3)
                              : null,
                        ),
                        child: _selectedColor == color
                            ? const Icon(Icons.check, color: Colors.white, size: 20)
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveSpaService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Сохранить SPA программу',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





