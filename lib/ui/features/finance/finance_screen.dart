import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/financial_record.dart';
import 'bloc/finance_bloc.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FinanceBloc>().add(LoadFinanceData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансы'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddRecordDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<FinanceBloc, FinanceState>(
        listener: (context, state) {
          if (state is FinanceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is FinanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FinanceLoaded) {
            return _buildFinanceContent(context, state);
          }

          if (state is FinanceError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FinanceBloc>().add(LoadFinanceData());
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
    );
  }

  Widget _buildFinanceContent(BuildContext context, FinanceLoaded state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildPeriodButton(context, 'Месяц', 'month', state.selectedPeriod),
              const SizedBox(width: 8),
              _buildPeriodButton(context, 'Квартал', 'quarter', state.selectedPeriod),
              const SizedBox(width: 8),
              _buildPeriodButton(context, 'Год', 'year', state.selectedPeriod),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.pink[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFinanceItem(
                '${state.totalIncome} ₽',
                'Доход',
                Colors.green,
                Icons.arrow_upward,
              ),
              _buildFinanceItem(
                '${state.totalExpenses} ₽',
                'Расходы',
                Colors.red,
                Icons.arrow_downward,
              ),
              _buildFinanceItem(
                '${state.profit} ₽',
                'Прибыль',
                state.profit >= 0 ? Colors.blue : Colors.orange,
                state.profit >= 0 ? Icons.trending_up : Icons.trending_down,
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMiniStat(
                'Доходы: ${state.incomeByService.length}',
                Colors.green,
              ),
              _buildMiniStat(
                'Расходы: ${state.expensesByService.length}',
                Colors.red,
              ),
              _buildMiniStat(
                'Всего: ${state.currentRecords.length}',
                Colors.blue,
              ),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(
                'Последние операции',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: state.currentRecords.isEmpty
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Нет операций за выбранный период',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.currentRecords.length,
            itemBuilder: (context, index) {
              final record = state.currentRecords[index];
              return _buildFinanceRecord(context, record);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton(BuildContext context, String label, String period, String selectedPeriod) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          context.read<FinanceBloc>().add(ChangePeriod(period));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedPeriod == period ? Colors.pink : Colors.grey[300],
          foregroundColor: selectedPeriod == period ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildFinanceItem(String amount, String label, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildMiniStat(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFinanceRecord(BuildContext context, FinancialRecord record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: record.type == FinancialType.income
                ? Colors.green[100]
                : Colors.red[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            record.type == FinancialType.income
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            color: record.type == FinancialType.income
                ? Colors.green
                : Colors.red,
          ),
        ),
        title: Text(
          record.service,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (record.client.isNotEmpty)
              Text('Клиент: ${record.client}', style: const TextStyle(fontSize: 12)),
            if (record.description.isNotEmpty)
              Text(record.description, style: const TextStyle(fontSize: 12)),
            Text(
              _formatDate(record.date),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${record.type == FinancialType.income ? '+' : '-'}${record.amount} ₽',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: record.type == FinancialType.income ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 4),
            IconButton(
              icon: const Icon(Icons.delete, size: 18),
              onPressed: () => _deleteRecord(context, record.id),
              color: Colors.grey,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _showAddRecordDialog(BuildContext context) {
    final FinancialRecord newRecord = FinancialRecord.empty();

    final TextEditingController serviceController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController clientController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    FinancialType selectedType = FinancialType.income;
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Добавить операцию'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Доход'),
                          leading: Radio<FinancialType>(
                            value: FinancialType.income,
                            groupValue: selectedType,
                            onChanged: (FinancialType? value) {
                              setState(() {
                                selectedType = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Расход'),
                          leading: Radio<FinancialType>(
                            value: FinancialType.expense,
                            groupValue: selectedType,
                            onChanged: (FinancialType? value) {
                              setState(() {
                                selectedType = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextField(
                    controller: serviceController,
                    decoration: const InputDecoration(
                      labelText: 'Услуга/Наименование*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      labelText: 'Сумма (₽)*',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: clientController,
                    decoration: const InputDecoration(
                      labelText: 'Клиент/Поставщик',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Описание',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),

                  ListTile(
                    title: const Text('Дата операции'),
                    subtitle: Text(_formatDate(selectedDate)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 365)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
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
                  _addNewRecord(
                    context: context,
                    service: serviceController.text,
                    amount: int.tryParse(amountController.text) ?? 0,
                    client: clientController.text,
                    description: descriptionController.text,
                    type: selectedType,
                    date: selectedDate,
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

  void _addNewRecord({
    required BuildContext context,
    required String service,
    required int amount,
    required String client,
    required String description,
    required FinancialType type,
    required DateTime date,
  }) {
    if (service.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, заполните обязательные поля'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newRecord = FinancialRecord(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      date: date,
      service: service,
      amount: amount,
      client: client,
      description: description,
      type: type,
    );

    context.read<FinanceBloc>().add(AddFinancialRecord(newRecord));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Операция "$service" добавлена'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteRecord(BuildContext context, String recordId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить операцию?'),
        content: const Text('Это действие нельзя отменить.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<FinanceBloc>().add(DeleteFinancialRecord(recordId));
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Операция удалена'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}


