import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/finance_repository.dart';


class DeleteFinancialRecordUseCase {
  final FinanceRepository repository;

  DeleteFinancialRecordUseCase(this.repository);

  Future<Either<Failure, void>> call(String recordId) async {
    return await repository.deleteFinancialRecord(recordId);
  }
}


