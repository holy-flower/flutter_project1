import '../dto/news_article_dto.dart';
import '../../../../domain/entities/news_article.dart';

extension NewsArticleDtoMapper on NewsArticleDto {
  NewsArticle toDomain() {
    return NewsArticle(
      sourceId: source?.id,
      sourceName: source?.name ?? '',
      author: author ?? '',
      title: title ?? '',
      description: description ?? '',
      url: url ?? '',
      urlToImage: urlToImage,
      publishedAt: publishedAt != null ? DateTime.tryParse(publishedAt!) : null,
      content: content ?? '',
    );
  }
}

extension NewsResponseDtoMapper on NewsResponseDto {
  NewsResponse toDomain() {
    return NewsResponse(
      status: status ?? '',
      totalResults: totalResults ?? 0,
      articles: articles?.map((a) => a.toDomain()).toList() ?? [],
    );
  }
}

extension NewsSourceDtoMapper on NewsSourceDto {
  NewsSource toDomain() {
    return NewsSource(
      id: id ?? '',
      name: name ?? '',
    );
  }
}

extension NewsSourcesResponseDtoMapper on NewsSourcesResponseDto {
  NewsSourcesResponse toDomain() {
    return NewsSourcesResponse(
      status: status ?? '',
      sources: sources?.map((s) => s.toDomain()).toList() ?? [],
    );
  }
}

