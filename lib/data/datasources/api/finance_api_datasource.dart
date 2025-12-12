import '../../../core/models/financial_record.dart';
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';

abstract class FinanceApiDataSource {
  Future<Either<Failure, Map<String, List<FinancialRecord>>>> getFinancialData();
  Future<Either<Failure, FinancialRecord>> addFinancialRecord(FinancialRecord record);
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId);
}

class FinanceApiDataSourceImpl implements FinanceApiDataSource {
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
    ],
    'quarter': [],
    'year': [],
  };

  @override
  Future<Either<Failure, Map<String, List<FinancialRecord>>>> getFinancialData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return right(Map.from(_financialData));
  }

  @override
  Future<Either<Failure, FinancialRecord>> addFinancialRecord(FinancialRecord record) async {
    final period = _getPeriod(record.date);
    if (!_financialData.containsKey(period)) {
      _financialData[period] = [];
    }
    _financialData[period]!.add(record);
    return right(record);
  }

  @override
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId) async {
    for (var period in _financialData.keys) {
      _financialData[period]!.removeWhere((r) => r.id == recordId);
    }
    return right(null);
  }

  String _getPeriod(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff <= 30) return 'month';
    if (diff <= 90) return 'quarter';
    return 'year';
  }
}



