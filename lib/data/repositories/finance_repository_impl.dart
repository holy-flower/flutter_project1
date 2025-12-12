import '../../domain/repositories/finance_repository.dart';
import '../../core/models/financial_record.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/local/finance_local_datasource.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceLocalDataSource localDataSource;

  FinanceRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Map<String, List<FinancialRecord>>>> getFinancialData() async {
    return await localDataSource.getFinancialData();
  }

  @override
  Future<Either<Failure, FinancialRecord>> addFinancialRecord(FinancialRecord record) async {
    return await localDataSource.addFinancialRecord(record);
  }

  @override
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId) async {
    return await localDataSource.deleteFinancialRecord(recordId);
  }
}



