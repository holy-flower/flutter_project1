import 'package:json_annotation/json_annotation.dart';

part 'news_article_dto.g.dart';

@JsonSerializable()
class NewsArticleDto {
  final NewsSourceDto? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? urlToImage;
  @JsonKey(name: 'publishedAt')
  final String? publishedAt;
  final String? content;

  NewsArticleDto({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsArticleDto.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsArticleDtoToJson(this);
}

@JsonSerializable()
class NewsSourceDto {
  final String? id;
  final String? name;

  NewsSourceDto({
    this.id,
    this.name,
  });

  factory NewsSourceDto.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceDtoToJson(this);
}

@JsonSerializable()
class NewsResponseDto {
  final String? status;
  final int? totalResults;
  final List<NewsArticleDto>? articles;

  NewsResponseDto({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseDtoToJson(this);
}

@JsonSerializable()
class NewsSourcesResponseDto {
  final String? status;
  final List<NewsSourceDto>? sources;

  NewsSourcesResponseDto({
    this.status,
    this.sources,
  });

  factory NewsSourcesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$NewsSourcesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourcesResponseDtoToJson(this);
}

