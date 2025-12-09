import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/inventory_item.dart';
import 'bloc/inventory_bloc.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InventoryBloc>().add(LoadInventory());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<InventoryBloc, InventoryState>(
        listener: (context, state) {
          if (state is InventoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InventoryLoaded) {
            return _buildLoadedState(context, state);
          }

          if (state is InventoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<InventoryBloc>().add(LoadInventory());
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context),
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, InventoryLoaded state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.pink[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(state.items.length.toString(), 'Всего позиций'),
              _buildStatItem(state.lowStockCount.toString(), 'Низкий запас', Colors.orange),
              _buildStatItem(state.expiringSoonCount.toString(), 'Скоро истекает', Colors.red),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<InventoryBloc>().add(SearchInventory(value));
            },
            decoration: InputDecoration(
              hintText: 'Поиск материалов...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCategoryChip(context, 'Все', 'all', state.selectedFilter),
              ...state.categories.where((cat) => cat != 'all').map((category) =>
                  _buildCategoryChip(context, category, category, state.selectedFilter)
              ),
            ],
          ),
        ),

        Expanded(
          child: state.filteredItems.isEmpty
              ? const Center(
            child: Text(
              'Материалы не найдены',
              style: TextStyle(color: Colors.grey),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.filteredItems.length,
            itemBuilder: (context, index) {
              final item = state.filteredItems[index];
              return _buildInventoryCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, [Color? color]) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.pink,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label, String category, String selectedFilter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selectedFilter == category,
        onSelected: (selected) {
          context.read<InventoryBloc>().add(FilterInventory(category));
        },
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.pink[100],
        checkmarkColor: Colors.pink,
      ),
    );
  }

  Widget _buildInventoryCard(BuildContext context, InventoryItem item) {
    final isLowStock = item.currentStock <= item.minStock;
    final isExpiringSoon = item.expiryDate.isBefore(DateTime.now().add(const Duration(days: 30)));

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
                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (isLowStock)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Низкий запас',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (isExpiringSoon)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        margin: const EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Срок годности',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    item.category,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.business, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  item.supplier,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'На складе: ${item.currentStock} ${item.unit}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isLowStock ? Colors.orange : Colors.black,
                      ),
                    ),
                    Text(
                      'Мин. запас: ${item.minStock} ${item.unit}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${item.cost} ₽',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                    Text(
                      'за ${item.unit}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Последняя поставка: ${_formatDate(item.lastRestock)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Годен до: ${_formatDate(item.expiryDate)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isExpiringSoon ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _restockItem(context, item.id),
                    child: const Text('Пополнить'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _useItem(context, item.id),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.pink,
                    ),
                    child: const Text('Использовать'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  void _showAddItemDialog(BuildContext context) {
    final InventoryBloc bloc = context.read<InventoryBloc>();
    final InventoryItem newItem = InventoryItem.empty();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController(text: 'Филлеры');
    final TextEditingController currentStockController = TextEditingController(text: '0');
    final TextEditingController minStockController = TextEditingController(text: '0');
    final TextEditingController unitController = TextEditingController(text: 'шт');
    final TextEditingController costController = TextEditingController(text: '0');
    final TextEditingController supplierController = TextEditingController();

    DateTime selectedExpiryDate = newItem.expiryDate;
    DateTime selectedLastRestock = newItem.lastRestock;

    final List<String> categories = [
      'Филлеры',
      'Нейромодуляторы',
      'Маски',
      'Сыворотки',
      'Пилинги',
      'Анестетики',
      'Другое'
    ];

    final List<String> units = ['шт', 'флакон', 'туба', 'набор', 'упаковка', 'мл', 'гр'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Добавить новый материал'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Название материала*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: categories.first,
                    decoration: const InputDecoration(
                      labelText: 'Категория*',
                      border: OutlineInputBorder(),
                    ),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      categoryController.text = newValue ?? categories.first;
                    },
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: supplierController,
                    decoration: const InputDecoration(
                      labelText: 'Поставщик*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: units.first,
                    decoration: const InputDecoration(
                      labelText: 'Единица измерения*',
                      border: OutlineInputBorder(),
                    ),
                    items: units.map((String unit) {
                      return DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      unitController.text = newValue ?? units.first;
                    },
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: currentStockController,
                          decoration: const InputDecoration(
                            labelText: 'Текущий запас*',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isEmpty) currentStockController.text = '0';
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: minStockController,
                          decoration: const InputDecoration(
                            labelText: 'Мин. запас*',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isEmpty) minStockController.text = '0';
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: costController,
                    decoration: const InputDecoration(
                      labelText: 'Стоимость (₽)*',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isEmpty) costController.text = '0';
                    },
                  ),
                  const SizedBox(height: 12),

                  ListTile(
                    title: const Text('Дата последней поставки'),
                    subtitle: Text(_formatDate(selectedLastRestock)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedLastRestock,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedLastRestock = picked;
                        });
                      }
                    },
                  ),

                  ListTile(
                    title: const Text('Срок годности до'),
                    subtitle: Text(_formatDate(selectedExpiryDate)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedExpiryDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedExpiryDate = picked;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addNewItem(
                    context: context,
                    name: nameController.text,
                    category: categoryController.text.isEmpty ? categories.first : categoryController.text,
                    currentStock: int.tryParse(currentStockController.text) ?? 0,
                    minStock: int.tryParse(minStockController.text) ?? 0,
                    unit: unitController.text.isEmpty ? units.first : unitController.text,
                    cost: int.tryParse(costController.text) ?? 0,
                    supplier: supplierController.text,
                    lastRestock: selectedLastRestock,
                    expiryDate: selectedExpiryDate,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Добавить'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addNewItem({
    required BuildContext context,
    required String name,
    required String category,
    required int currentStock,
    required int minStock,
    required String unit,
    required int cost,
    required String supplier,
    required DateTime lastRestock,
    required DateTime expiryDate,
  }) {
    if (name.isEmpty || supplier.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, заполните все обязательные поля'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (currentStock < 0 || minStock < 0 || cost < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Значения не могут быть отрицательными'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newItem = InventoryItem(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      category: category,
      currentStock: currentStock,
      minStock: minStock,
      unit: unit,
      cost: cost,
      supplier: supplier,
      lastRestock: lastRestock,
      expiryDate: expiryDate,
    );

    context.read<InventoryBloc>().add(AddInventoryItem(newItem));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Материал "$name" успешно добавлен'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _restockItem(BuildContext context, String itemId) {
    final TextEditingController quantityController = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Пополнить запас'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Введите количество для пополнения:'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Количество',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text) ?? 0;
              if (quantity > 0) {
                context.read<InventoryBloc>().add(RestockItem(itemId, quantity));
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Запас пополнен на $quantity единиц'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Введите корректное количество'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Пополнить'),
          ),
        ],
      ),
    );
  }

  void _useItem(BuildContext context, String itemId) {
    final TextEditingController quantityController = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Использовать материал'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Введите количество для списания:'),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Количество',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              final quantity = int.tryParse(quantityController.text) ?? 0;
              if (quantity > 0) {
                context.read<InventoryBloc>().add(UseItem(itemId, quantity));
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Списано $quantity единиц'),
                    backgroundColor: Colors.blue,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Введите корректное количество'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Использовать'),
          ),
        ],
      ),
    );
  }
}


