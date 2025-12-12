import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/financial_record.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/finance_repository.dart';

class AddFinancialRecordUseCase {
  final FinanceRepository repository;

  AddFinancialRecordUseCase(this.repository);

  Future<Either<Failure, FinancialRecord>> call(FinancialRecord record) async {
    if (record.service.isEmpty) {
      return left(const ValidationFailure('Название услуги не может быть пустым'));
    }
    if (record.amount <= 0) {
      return left(const ValidationFailure('Сумма должна быть больше нуля'));
    }
    return await repository.addFinancialRecord(record);
  }
}



