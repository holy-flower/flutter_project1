import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/cosmetology_news_repository.dart';
import '../../entities/news_article.dart';

class GetCosmeticsNewsByDateUseCase {
  final CosmetologyNewsRepository repository;

  GetCosmeticsNewsByDateUseCase(this.repository);

  Future<Either<Failure, NewsResponse>> call(String fromDate, String toDate) async {
    if (fromDate.isEmpty || toDate.isEmpty) {
      return left(ValidationFailure('Даты не могут быть пустыми'));
    }
    return repository.getCosmeticsNewsByDate(fromDate, toDate);
  }
}

