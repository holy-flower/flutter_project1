import 'package:flutter/material.dart';
import 'package:flutter_project1/features/body_care/body_care_feature.dart';
import '../models/body_service.dart';

class AddBodyServiceScreen extends StatefulWidget {
  final Function(BodyService) onServiceAdded;
  final List<BodyService> currentServices;

  const AddBodyServiceScreen({
    super.key,
    required this.onServiceAdded,
    required this.currentServices,
  });

  @override
  State<AddBodyServiceScreen> createState() => _AddBodyServiceScreenState();
}

class _AddBodyServiceScreenState extends State<AddBodyServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _featuresController = TextEditingController();
  final _detailsController = TextEditingController();
  final _effectsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _durationController.dispose();
    _descriptionController.dispose();
    _featuresController.dispose();
    _detailsController.dispose();
    _effectsController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final newService = BodyService(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text,
        price: _priceController.text,
        duration: _durationController.text,
        description: _descriptionController.text,
        features: _featuresController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        details: _detailsController.text,
        effects: _effectsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
      );

      final updateServices = List<BodyService>.from(widget.currentServices)
      ..add(newService);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => BodyCareContainer.withServices(updateServices),
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить услугу по уходу за телом'),
        backgroundColor: Colors.pink[100],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveService,
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
                  labelText: 'Название услуги',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Обертывание, Скрабирование',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название услуги';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Цена',
                  border: OutlineInputBorder(),
                  hintText: 'Например: 4000 ₽',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите цену услуги';
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
                  hintText: 'Например: 60 мин',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите длительность услуги';
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
                  hintText: 'Краткое описание услуги',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание услуги';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _featuresController,
                decoration: const InputDecoration(
                  labelText: 'Особенности (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Водорослевое, Шоколадное, Медовое',
                  helperText: 'Перечислите варианты или особенности услуги через запятую',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите особенности услуги';
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
                  hintText: 'Детальное описание процедуры',
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
                controller: _effectsController,
                decoration: const InputDecoration(
                  labelText: 'Эффекты (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Коррекция фигуры, Выведение токсинов, Улучшение тонуса кожи',
                  helperText: 'Перечислите эффекты от процедуры через запятую',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите эффекты от услуги';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Сохранить услугу',
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