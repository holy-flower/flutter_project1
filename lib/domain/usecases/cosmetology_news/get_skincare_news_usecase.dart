import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../../repositories/cosmetology_news_repository.dart';
import '../../entities/news_article.dart';

class GetSkincareNewsUseCase {
  final CosmetologyNewsRepository repository;

  GetSkincareNewsUseCase(this.repository);

  Future<Either<Failure, NewsResponse>> call() {
    return repository.getSkincareNews();
  }
}

