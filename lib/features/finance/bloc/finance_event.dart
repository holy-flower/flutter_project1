part of 'finance_bloc.dart';

abstract class FinanceEvent extends Equatable {
  const FinanceEvent();

  @override
  List<Object> get props => [];
}

class LoadFinanceData extends FinanceEvent {}

class ChangePeriod extends FinanceEvent {
  final String period;

  const ChangePeriod(this.period);

  @override
  List<Object> get props => [period];
}

class AddFinancialRecord extends FinanceEvent {
  final FinancialRecord record;

  const AddFinancialRecord(this.record);

  @override
  List<Object> get props => [record];
}

class DeleteFinancialRecord extends FinanceEvent {
  final String recordId;

  const DeleteFinancialRecord(this.recordId);

  @override
  List<Object> get props => [recordId];
}