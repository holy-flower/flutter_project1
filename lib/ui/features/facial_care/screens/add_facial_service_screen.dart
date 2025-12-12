import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/service.dart';
import '../bloc/facial_care_bloc.dart';

class AddFacialServiceScreen extends StatefulWidget {
  const AddFacialServiceScreen({super.key});

  @override
  State<AddFacialServiceScreen> createState() => _AddFacialServiceScreenState();
}

class _AddFacialServiceScreenState extends State<AddFacialServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _detailsController = TextEditingController();
  final _effectsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _detailsController.dispose();
    _effectsController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final newService = Service(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text,
        duration: _durationController.text,
        price: _priceController.text,
        description: _descriptionController.text,
        details: _detailsController.text,
        effects: _effectsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        type: ServiceType.facialCare,
      );

      context.read<FacialCareBloc>().add(AddFacialService(newService));
      context.pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Услуга успешно добавлена'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новую услугу'),
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
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Длительность (например: 45 мин)',
                  border: OutlineInputBorder(),
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
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Цена (например: 2000 ₽)',
                  border: OutlineInputBorder(),
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
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Краткое описание',
                  border: OutlineInputBorder(),
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
                controller: _detailsController,
                decoration: const InputDecoration(
                  labelText: 'Подробное описание',
                  border: OutlineInputBorder(),
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
                  helperText: 'Например: Очищение пор, Уменьшение воспалений, Улучшение цвета лица',
                ),
                maxLines: 2,
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





