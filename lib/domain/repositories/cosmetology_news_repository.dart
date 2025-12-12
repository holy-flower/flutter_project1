import '../../../core/utils/either.dart';
import '../../../core/errors/failures.dart';
import '../entities/news_article.dart';

abstract class CosmetologyNewsRepository {
  Future<Either<Failure, NewsResponse>> searchCosmetologyNews();
  Future<Either<Failure, NewsResponse>> getSkincareNews();
  Future<Either<Failure, NewsResponse>> getTopBeautyNews();
  Future<Either<Failure, NewsResponse>> getCosmeticsNewsByDate(String fromDate, String toDate);
  Future<Either<Failure, NewsSourcesResponse>> getHealthNewsSources();
}

