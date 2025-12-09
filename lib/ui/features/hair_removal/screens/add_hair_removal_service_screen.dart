import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/service.dart';
import '../bloc/hair_removal_bloc.dart';

class AddHairRemovalServiceScreen extends StatefulWidget {
  const AddHairRemovalServiceScreen({super.key});

  @override
  State<AddHairRemovalServiceScreen> createState() => _AddHairRemovalServiceScreenState();
}

class _AddHairRemovalServiceScreenState extends State<AddHairRemovalServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _zonesController = TextEditingController();
  Color _selectedColor = Colors.orange;

  final List<Color> _availableColors = [
    Colors.brown,
    Colors.orange,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.pink,
    Colors.teal,
    Colors.indigo,
    Colors.amber,
    Colors.grey,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();
    _zonesController.dispose();
    super.dispose();
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final newService = Service(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _nameController.text,
        price: _priceController.text,
        duration: _timeController.text,
        description: _descriptionController.text,
        color: _selectedColor,
        zones: _zonesController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        type: ServiceType.hairRemoval,
      );

      context.read<HairRemovalBloc>().add(AddHairRemovalService(newService));
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
        title: const Text('Добавить метод депиляции'),
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
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название метода',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Лазерная эпиляция, Шугаринг',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название метода';
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
                  hintText: 'Например: от 1000 ₽',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите стоимость услуги';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Время процедуры',
                  border: OutlineInputBorder(),
                  hintText: 'Например: 30-60 мин',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите время процедуры';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Описание метода',
                  border: OutlineInputBorder(),
                  hintText: 'Подробное описание процедуры',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание метода';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _zonesController,
                decoration: const InputDecoration(
                  labelText: 'Зоны применения (через запятую)',
                  border: OutlineInputBorder(),
                  hintText: 'Например: Лицо, Подмышки, Ноги, Бикини',
                  helperText: 'Перечислите зоны для депиляции через запятую',
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите зоны применения';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Цвет для отображения:',
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
                onPressed: _saveService,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Сохранить метод',
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


