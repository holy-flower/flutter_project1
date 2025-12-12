import 'package:json_annotation/json_annotation.dart';

part 'beauty_product_dto.g.dart';

@JsonSerializable()
class BeautyProductDto {
  final String? code;
  final String? status;
  final String? statusVerbose;
  final ProductDto? product;

  BeautyProductDto({
    this.code,
    this.status,
    this.statusVerbose,
    this.product,
  });

  factory BeautyProductDto.fromJson(Map<String, dynamic> json) =>
      _$BeautyProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BeautyProductDtoToJson(this);
}

@JsonSerializable()
class ProductDto {
  @JsonKey(name: 'product_name')
  final String? productName;
  
  @JsonKey(name: 'product_name_ru')
  final String? productNameRu;
  
  final String? brands;
  final String? categories;
  
  @JsonKey(name: 'ingredients_text')
  final String? ingredientsText;
  
  @JsonKey(name: 'ingredients_text_ru')
  final String? ingredientsTextRu;
  
  @JsonKey(name: 'nutriscore_grade')
  final String? nutriscoreGrade;
  
  @JsonKey(name: 'ecoscore_grade')
  final String? ecoscoreGrade;
  
  @JsonKey(name: 'nova_group')
  final int? novaGroup;
  
  final List<String>? images;
  
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  
  @JsonKey(name: 'image_small_url')
  final String? imageSmallUrl;

  ProductDto({
    this.productName,
    this.productNameRu,
    this.brands,
    this.categories,
    this.ingredientsText,
    this.ingredientsTextRu,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.novaGroup,
    this.images,
    this.imageUrl,
    this.imageSmallUrl,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}

@JsonSerializable()
class BeautyProductSearchDto {
  final int? count;
  final int? page;
  @JsonKey(name: 'page_size')
  final int? pageSize;
  @JsonKey(name: 'page_count')
  final int? pageCount;
  final List<ProductDto>? products;

  BeautyProductSearchDto({
    this.count,
    this.page,
    this.pageSize,
    this.pageCount,
    this.products,
  });

  factory BeautyProductSearchDto.fromJson(Map<String, dynamic> json) =>
      _$BeautyProductSearchDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BeautyProductSearchDtoToJson(this);
}

