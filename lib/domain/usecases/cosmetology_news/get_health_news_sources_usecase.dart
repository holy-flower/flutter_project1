import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/cosmetology_news_repository.dart';
import '../../entities/news_article.dart';

class GetHealthNewsSourcesUseCase {
  final CosmetologyNewsRepository repository;

  GetHealthNewsSourcesUseCase(this.repository);

  Future<Either<Failure, NewsSourcesResponse>> call() {
    return repository.getHealthNewsSources();
  }
}

