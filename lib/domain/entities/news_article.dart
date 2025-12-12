import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final String? sourceId;
  final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String content;

  const NewsArticle({
    this.sourceId,
    required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    this.publishedAt,
    required this.content,
  });

  @override
  List<Object?> get props => [
        sourceId,
        sourceName,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}

class NewsResponse extends Equatable {
  final String status;
  final int totalResults;
  final List<NewsArticle> articles;

  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object?> get props => [status, totalResults, articles];
}

class NewsSource extends Equatable {
  final String id;
  final String name;

  const NewsSource({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class NewsSourcesResponse extends Equatable {
  final String status;
  final List<NewsSource> sources;

  const NewsSourcesResponse({
    required this.status,
    required this.sources,
  });

  @override
  List<Object?> get props => [status, sources];
}

