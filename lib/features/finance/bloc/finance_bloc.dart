import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/financial_record.dart';

part 'finance_event.dart';
part 'finance_state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc() : super(FinanceInitial()) {
    on<LoadFinanceData>(_onLoadFinanceData);
    on<ChangePeriod>(_onChangePeriod);
    on<AddFinancialRecord>(_onAddFinancialRecord);
    on<DeleteFinancialRecord>(_onDeleteFinancialRecord);
  }

  final Map<String, List<FinancialRecord>> _financialData = {
    'month': [
      FinancialRecord(
        id: '1',
        date: DateTime.now().subtract(const Duration(days: 1)),
        service: 'Чистка лица',
        amount: 2000,
        client: 'Мария Иванова',
        type: FinancialType.income,
      ),
      FinancialRecord(
        id: '2',
        date: DateTime.now().subtract(const Duration(days: 2)),
        service: 'SPA "Релакс"',
        amount: 8000,
        client: 'Елена Петрова',
        type: FinancialType.income,
      ),
      FinancialRecord(
        id: '3',
        date: DateTime.now().subtract(const Duration(days: 3)),
        service: 'Закупка материалов',
        amount: 15000,
        description: 'Косметика и расходники',
        type: FinancialType.expense,
      ),
      FinancialRecord(
        id: '7',
        date: DateTime.now().subtract(const Duration(days: 5)),
        service: 'Массаж лица',
        amount: 3500,
        client: 'Анна Сидорова',
        type: FinancialType.income,
      ),
    ],
    'quarter': [
      FinancialRecord(
        id: '4',
        date: DateTime.now().subtract(const Duration(days: 30)),
        service: 'Обертывание',
        amount: 4000,
        client: 'Ирина Николаева',
        type: FinancialType.income,
      ),
      FinancialRecord(
        id: '5',
        date: DateTime.now().subtract(const Duration(days: 45)),
        service: 'Аренда помещения',
        amount: 25000,
        description: 'Оплата аренды',
        type: FinancialType.expense,
      ),
      FinancialRecord(
        id: '8',
        date: DateTime.now().subtract(const Duration(days: 60)),
        service: 'Консультация',
        amount: 1500,
        client: 'Оксана Козлова',
        type: FinancialType.income,
      ),
    ],
    'year': [
      FinancialRecord(
        id: '6',
        date: DateTime.now().subtract(const Duration(days: 100)),
        service: 'Годовой абонемент',
        amount: 50000,
        client: 'Ольга Смирнова',
        type: FinancialType.income,
      ),
      FinancialRecord(
        id: '9',
        date: DateTime.now().subtract(const Duration(days: 200)),
        service: 'Оборудование',
        amount: 120000,
        description: 'Покупка нового оборудования',
        type: FinancialType.expense,
      ),
    ],
  };

  void _onLoadFinanceData(LoadFinanceData event, Emitter<FinanceState> emit) async {
    try {
      emit(FinanceLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(FinanceLoaded(
        financialData: _financialData,
        selectedPeriod: 'month',
      ));
    } catch (e) {
      emit(FinanceError('Не удалось загрузить финансовые данные: $e'));
    }
  }

  void _onChangePeriod(ChangePeriod event, Emitter<FinanceState> emit) {
    if (state is FinanceLoaded) {
      final currentState = state as FinanceLoaded;
      emit(FinanceLoaded(
        financialData: currentState.financialData,
        selectedPeriod: event.period,
      ));
    }
  }

  void _onAddFinancialRecord(AddFinancialRecord event, Emitter<FinanceState> emit) {
    if (state is FinanceLoaded) {
      final currentState = state as FinanceLoaded;
      final updatedData = Map<String, List<FinancialRecord>>.from(currentState.financialData);

      if (!updatedData.containsKey(currentState.selectedPeriod)) {
        updatedData[currentState.selectedPeriod] = [];
      }

      updatedData[currentState.selectedPeriod]!.add(event.record);

      emit(FinanceLoaded(
        financialData: updatedData,
        selectedPeriod: currentState.selectedPeriod,
      ));
    }
  }

  void _onDeleteFinancialRecord(DeleteFinancialRecord event, Emitter<FinanceState> emit) {
    if (state is FinanceLoaded) {
      final currentState = state as FinanceLoaded;
      final updatedData = Map<String, List<FinancialRecord>>.from(currentState.financialData);

      if (updatedData.containsKey(currentState.selectedPeriod)) {
        updatedData[currentState.selectedPeriod] = updatedData[currentState.selectedPeriod]!
            .where((record) => record.id != event.recordId)
            .toList();
      }

      emit(FinanceLoaded(
        financialData: updatedData,
        selectedPeriod: currentState.selectedPeriod,
      ));
    }
  }
}