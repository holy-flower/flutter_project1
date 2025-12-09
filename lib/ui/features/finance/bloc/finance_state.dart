part of 'finance_bloc.dart';

abstract class FinanceState extends Equatable {
  const FinanceState();

  @override
  List<Object> get props => [];
}

class FinanceInitial extends FinanceState {}

class FinanceLoading extends FinanceState {}

class FinanceLoaded extends FinanceState {
  final Map<String, List<FinancialRecord>> financialData;
  final String selectedPeriod;

  const FinanceLoaded({
    required this.financialData,
    required this.selectedPeriod,
  });

  List<FinancialRecord> get currentRecords {
    final records = financialData[selectedPeriod] ?? [];
    records.sort((a, b) => b.date.compareTo(a.date));
    return records;
  }

  int get totalIncome => currentRecords
      .where((record) => record.type == FinancialType.income)
      .fold(0, (sum, record) => sum + record.amount);

  int get totalExpenses => currentRecords
      .where((record) => record.type == FinancialType.expense)
      .fold(0, (sum, record) => sum + record.amount);

  int get profit => totalIncome - totalExpenses;

  Map<String, int> get incomeByService {
    final incomeRecords = currentRecords.where((r) => r.type == FinancialType.income);
    final Map<String, int> result = {};

    for (final record in incomeRecords) {
      result[record.service] = (result[record.service] ?? 0) + record.amount;
    }

    return result;
  }

  Map<String, int> get expensesByService {
    final expenseRecords = currentRecords.where((r) => r.type == FinancialType.expense);
    final Map<String, int> result = {};

    for (final record in expenseRecords) {
      result[record.service] = (result[record.service] ?? 0) + record.amount;
    }

    return result;
  }

  @override
  List<Object> get props => [financialData, selectedPeriod];
}

class FinanceError extends FinanceState {
  final String message;

  const FinanceError(this.message);

  @override
  List<Object> get props => [message];
}


