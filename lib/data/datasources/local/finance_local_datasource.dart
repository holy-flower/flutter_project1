import '../../../core/models/financial_record.dart' as models;
import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import 'app_database.dart';
import 'package:drift/drift.dart';

abstract class FinanceLocalDataSource {
  Future<Either<Failure, Map<String, List<models.FinancialRecord>>>> getFinancialData();
  Future<Either<Failure, models.FinancialRecord>> addFinancialRecord(models.FinancialRecord record);
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId);
}

class FinanceLocalDataSourceImpl implements FinanceLocalDataSource {
  final AppDatabase _database;

  FinanceLocalDataSourceImpl(this._database);

  @override
  Future<Either<Failure, Map<String, List<models.FinancialRecord>>>> getFinancialData() async {
    try {
      final query = _database.select(_database.financialRecords);
      final rows = await query.get();

      final allRecords = rows.map((row) {
        return models.FinancialRecord(
          id: row.id,
          date: DateTime.fromMillisecondsSinceEpoch(row.date),
          service: row.service,
          amount: row.amount,
          client: row.client,
          description: row.description,
          type: row.type == 'income' ? models.FinancialType.income : models.FinancialType.expense,
        );
      }).toList();

      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final quarterStart = DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 1, 1);
      final yearStart = DateTime(now.year, 1, 1);

      final monthRecords = allRecords.where((r) => r.date.isAfter(monthStart.subtract(const Duration(days: 1)))).toList();
      final quarterRecords = allRecords.where((r) => r.date.isAfter(quarterStart.subtract(const Duration(days: 1)))).toList();
      final yearRecords = allRecords.where((r) => r.date.isAfter(yearStart.subtract(const Duration(days: 1)))).toList();

      return right({
        'month': monthRecords,
        'quarter': quarterRecords,
        'year': yearRecords,
      });
    } catch (e) {
      return left(CacheFailure('Ошибка загрузки финансовых данных: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, models.FinancialRecord>> addFinancialRecord(models.FinancialRecord record) async {
    try {
      final companion = FinancialRecordsCompanion(
        id: Value(record.id),
        date: Value(record.date.millisecondsSinceEpoch),
        service: Value(record.service),
        amount: Value(record.amount),
        client: Value(record.client),
        description: Value(record.description),
        type: Value(record.type.name),
      );

      await _database.into(_database.financialRecords).insert(companion);
      return right(record);
    } catch (e) {
      return left(CacheFailure('Ошибка добавления финансовой записи: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFinancialRecord(String recordId) async {
    try {
      final deleted = await (_database.delete(_database.financialRecords)..where((t) => t.id.equals(recordId))).go();

      if (deleted == 0) {
        return left(const ServerFailure('Запись не найдена'));
      }

      return right(null);
    } catch (e) {
      return left(CacheFailure('Ошибка удаления финансовой записи: ${e.toString()}'));
    }
  }
}

