import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/config/api_config.dart';
import 'dto/news_article_dto.dart';

part 'newsapi.g.dart';

@RestApi(baseUrl: ApiConfig.newsApiBaseUrl)
abstract class NewsApi {
  factory NewsApi(Dio dio) = _NewsApi;

  @GET("/everything")
  Future<NewsResponseDto> searchNews(
    @Query("q") String query,
    @Query("language") String? language,
    @Query("sortBy") String? sortBy,
  );

  @GET("/top-headlines")
  Future<NewsResponseDto> getTopHeadlines(
    @Query("category") String? category,
    @Query("q") String? query,
    @Query("language") String? language,
  );

  @GET("/everything")
  Future<NewsResponseDto> getNewsByDate(
    @Query("q") String query,
    @Query("from") String fromDate,
    @Query("to") String toDate,
    @Query("sortBy") String? sortBy,
  );

  @GET("/sources")
  Future<NewsSourcesResponseDto> getSources(
    @Query("category") String? category,
    @Query("language") String? language,
  );
}

