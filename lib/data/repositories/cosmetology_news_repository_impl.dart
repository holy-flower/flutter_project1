import '../../core/utils/either.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/cosmetology_news_repository.dart';
import '../../domain/entities/news_article.dart';
import '../datasources/remote/cosmetology_news_remote_datasource.dart';
import '../datasources/remote/mappers/news_mapper.dart';

class CosmetologyNewsRepositoryImpl implements CosmetologyNewsRepository {
  final CosmetologyNewsRemoteDataSource remoteDataSource;

  CosmetologyNewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, NewsResponse>> searchCosmetologyNews() async {
    final result = await remoteDataSource.searchCosmetologyNews();
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, NewsResponse>> getSkincareNews() async {
    final result = await remoteDataSource.getSkincareNews();
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, NewsResponse>> getTopBeautyNews() async {
    final result = await remoteDataSource.getTopBeautyNews();
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, NewsResponse>> getCosmeticsNewsByDate(String fromDate, String toDate) async {
    final result = await remoteDataSource.getCosmeticsNewsByDate(fromDate, toDate);
    return result.map((dto) => dto.toDomain());
  }

  @override
  Future<Either<Failure, NewsSourcesResponse>> getHealthNewsSources() async {
    final result = await remoteDataSource.getHealthNewsSources();
    return result.map((dto) => dto.toDomain());
  }
}

