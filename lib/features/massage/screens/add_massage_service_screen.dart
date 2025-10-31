import 'package:flutter/material.dart';
import '../models/massage_service.dart';

class AddMassageServiceScreen extends StatefulWidget {
  final Function(MassageService) onMassageAdded;

  const AddMassageServiceScreen({
    super.key,
    required this.onMassageAdded,
  });

  @override
  State<AddMassageServiceScreen> createState() => _AddMassageServiceScreenState();
}

class _AddMassageServiceScreenState extends State<AddMassageServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _indicationController = TextEditingController();
  final _detailsController = TextEditingController();
  final _techniquesController = TextEditingController();
  final _benefitsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _indicationController.dispose();
    _detailsController.dispose();
    _techniquesController.dispose();
    _benefitsController.dispose();
    super.dispose();
  }

  void _saveMassage() {
    if (_formKey.currentState!.validate()) {
      final newMassage = MassageService(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text,
        duration: _durationController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        indication: _indicationController.text,
        details: _detailsController.text,
        techniques: _techniquesController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        benefits: _benefitsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      );

      widget.onMassageAdded(newMassage);
      Navigator.pop(context); // Вертикальный возврат назад
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить вид массажа'),
        backgroundColor: Colors.pink[100],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveMassage,
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
                  labelText: 'Название массажа',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Классический массаж, Антицеллюлитный массаж',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Длительность',
                  border: OutlineInputBorder(),
                  hintText: 'Например: 60 мин, 45 мин',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите длительность массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Стоимость',
                  border: OutlineInputBorder(),
                  hintText: 'Например: 3000 ₽, 2500 ₽',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите стоимость массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Краткое описание',
                  border: OutlineInputBorder(),
                  hintText: 'Краткое описание массажа',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _indicationController,
                decoration: const InputDecoration(
                  labelText: 'Показания',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Стресс, мышечное напряжение, целлюлит',
                  helperText: 'Для каких проблем предназначен этот массаж',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите показания для массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'Подробное описание',
                  border: OutlineInputBorder(),
                  hintText: 'Детальное описание процедуры массажа',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите подробное описание';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _techniquesController,
                decoration: const InputDecoration(
                  labelText: 'Техники массажа (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Поглаживание, Разминание, Растирание, Вибрация',
                  helperText: 'Перечислите используемые техники через запятую',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите техники массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _benefitsController,
                decoration: const InputDecoration(
                  labelText: 'Преимущества (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Снятие напряжения, Улучшение кровообращения, Расслабление',
                  helperText: 'Перечислите преимущества массажа через запятую',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите преимущества массажа';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveMassage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Сохранить массаж',
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