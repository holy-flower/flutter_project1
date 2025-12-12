import 'package:flutter_project1/core/errors/failures.dart';
import 'package:flutter_project1/core/models/financial_record.dart';
import 'package:flutter_project1/core/utils/either.dart';
import 'package:flutter_project1/domain/repositories/finance_repository.dart';

class GetFinancialDataUseCase {
  final FinanceRepository repository;

  GetFinancialDataUseCase(this.repository);

  Future<Either<Failure, Map<String, List<FinancialRecord>>>> call() async {
    return await repository.getFinancialData();
  }
}





