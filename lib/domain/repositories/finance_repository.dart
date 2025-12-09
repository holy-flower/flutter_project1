import '../../core/models/financial_record.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';

abstract class FinanceRepository {
  Future<Either<Failure, Map<String, List<FinancialRecord>>>> getFinancialData();
  Future<Either<Failure, FinancialRecord>> addFinancialRecord(FinancialRecord record);
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId);
}

