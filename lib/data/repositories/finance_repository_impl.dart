import '../../domain/repositories/finance_repository.dart';
import '../../core/models/financial_record.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../datasources/api/finance_api_datasource.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  final FinanceApiDataSource dataSource;

  FinanceRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Map<String, List<FinancialRecord>>>> getFinancialData() async {
    return await dataSource.getFinancialData();
  }

  @override
  Future<Either<Failure, FinancialRecord>> addFinancialRecord(FinancialRecord record) async {
    return await dataSource.addFinancialRecord(record);
  }

  @override
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId) async {
    return await dataSource.deleteFinancialRecord(recordId);
  }
}


