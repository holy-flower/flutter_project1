// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beauty_product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeautyProductDto _$BeautyProductDtoFromJson(Map<String, dynamic> json) =>
    BeautyProductDto(
      code: json['code']?.toString(),
      status: json['status']?.toString(),
      statusVerbose: json['statusVerbose']?.toString(),
      product: json['product'] == null
          ? null
          : ProductDto.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BeautyProductDtoToJson(BeautyProductDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'statusVerbose': instance.statusVerbose,
      'product': instance.product,
    };

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) {
  String? productName = _parseString(json['product_name']) ?? 
                        _parseString(json['product_name_en']) ??
                        _parseString(json['product_name_fr']) ??
                        _parseString(json['product_name_de']);

  if (productName == null) {
    for (var key in json.keys) {
      if (key.toString().toLowerCase().contains('name') && 
          key.toString().toLowerCase().contains('product')) {
        productName = _parseString(json[key]);
        if (productName != null) break;
      }
    }
  }
  
  // Парсим рейтинги с проверкой альтернативных названий полей
  String? nutriscoreGrade = _parseString(json['nutriscore_grade']) ?? 
                           _parseString(json['nutriscore']) ??
                           _parseString(json['nutrition_grade']);
  String? ecoscoreGrade = _parseString(json['ecoscore_grade']) ?? 
                         _parseString(json['ecoscore']) ??
                         _parseString(json['environment_impact_level']);
  int? novaGroup = _parseInt(json['nova_group']) ?? 
                  _parseInt(json['nova']) ??
                  _parseInt(json['nova_groups']);
  
  return ProductDto(
    productName: productName,
    productNameRu: _parseString(json['product_name_ru']),
    brands: _parseStringOrList(json['brands']),
    categories: _parseStringOrList(json['categories']),
    ingredientsText: _parseString(json['ingredients_text']),
    ingredientsTextRu: _parseString(json['ingredients_text_ru']),
    nutriscoreGrade: nutriscoreGrade,
    ecoscoreGrade: ecoscoreGrade,
    novaGroup: novaGroup,
    images: _parseStringList(json['images']),
    imageUrl: _parseString(json['image_url']),
    imageSmallUrl: _parseString(json['image_small_url']),
  );
}

String? _parseString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value.isEmpty ? null : value;
  return value.toString();
}

String? _parseStringOrList(dynamic value) {
  if (value == null) return null;
  if (value is String) return value.isEmpty ? null : value;
  if (value is List) {
    final list = value.whereType<String>().where((s) => s.isNotEmpty).toList();
    return list.isEmpty ? null : list.join(', ');
  }
  return value.toString();
}

List<String>? _parseStringList(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }
  return null;
}

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'product_name_ru': instance.productNameRu,
      'brands': instance.brands,
      'categories': instance.categories,
      'ingredients_text': instance.ingredientsText,
      'ingredients_text_ru': instance.ingredientsTextRu,
      'nutriscore_grade': instance.nutriscoreGrade,
      'ecoscore_grade': instance.ecoscoreGrade,
      'nova_group': instance.novaGroup,
      'images': instance.images,
      'image_url': instance.imageUrl,
      'image_small_url': instance.imageSmallUrl,
    };

BeautyProductSearchDto _$BeautyProductSearchDtoFromJson(
  Map<String, dynamic> json,
) {
  List<ProductDto>? productsList;
  final productsData = json['products'];
  
  if (productsData != null) {
    if (productsData is List) {
      productsList = <ProductDto>[];
      for (var item in productsData) {
        try {
          if (item is Map<String, dynamic>) {
            productsList.add(ProductDto.fromJson(item));
          }
        } catch (e) {
        }
      }
    } else if (productsData is Map) {
      productsList = <ProductDto>[];
      for (var value in (productsData as Map<String, dynamic>).values) {
        try {
          if (value is Map<String, dynamic>) {
            productsList.add(ProductDto.fromJson(value));
          }
        } catch (e) {
        }
      }
    }
  }
  
  return BeautyProductSearchDto(
    count: _parseInt(json['count']),
    page: _parseInt(json['page']),
    pageSize: _parseInt(json['page_size']),
    pageCount: _parseInt(json['page_count']),
    products: productsList,
  );
}

int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) {
    final parsed = int.tryParse(value);
    return parsed;
  }
  return null;
}

Map<String, dynamic> _$BeautyProductSearchDtoToJson(
  BeautyProductSearchDto instance,
) => <String, dynamic>{
  'count': instance.count,
  'page': instance.page,
  'page_size': instance.pageSize,
  'page_count': instance.pageCount,
  'products': instance.products,
};
