import 'package:flutter/foundation.dart';
import '../dto/beauty_product_dto.dart';
import '../../../../domain/entities/beauty_product.dart';

extension BeautyProductDtoMapper on BeautyProductDto {
  BeautyProduct toDomain() {
    // Если продукт отсутствует, выбрасываем исключение
    if (product == null) {
      throw Exception('Product is null');
    }
    
    // Пытаемся найти название продукта в различных полях
    String? productName = product?.productName;
    
    // Если основное название пустое, пробуем русское название
    if (productName == null || productName.isEmpty) {
      productName = product?.productNameRu;
    }
    
    // Если все еще пустое, пробуем найти в других полях
    if (productName == null || productName.isEmpty) {
      // Используем бренд как fallback
      if (product?.brands != null && product!.brands!.isNotEmpty) {
        productName = product!.brands!;
      } 
      // Или первую категорию
      else if (product?.categories != null && product!.categories!.isNotEmpty) {
        final categories = product!.categories!.split(',').first.trim();
        if (categories.isNotEmpty) {
          productName = categories;
        }
      }
    }
    
    // Если название все еще пустое, используем штрих-код как последний fallback
    if (productName == null || productName.isEmpty) {
      productName = code ?? 'Продукт без названия';
    }
    
    // Логирование рейтингов из DTO перед маппингом
    if (kDebugMode) {
      print('=== BeautyProductMapper Debug ===');
      print('Product DTO ratings:');
      print('  nutriscoreGrade from DTO: ${product?.nutriscoreGrade}');
      print('  ecoscoreGrade from DTO: ${product?.ecoscoreGrade}');
      print('  novaGroup from DTO: ${product?.novaGroup}');
      print('  nutriscoreGrade is null: ${product?.nutriscoreGrade == null}');
      print('  ecoscoreGrade is null: ${product?.ecoscoreGrade == null}');
      print('  novaGroup is null: ${product?.novaGroup == null}');
    }
    
    final beautyProduct = BeautyProduct(
      barcode: code ?? '',
      productName: productName,
      brands: product?.brands ?? '',
      categories: product?.categories ?? '',
      ingredientsText: product?.ingredientsText ?? product?.ingredientsTextRu ?? '',
      nutriscoreGrade: product?.nutriscoreGrade,
      ecoscoreGrade: product?.ecoscoreGrade,
      novaGroup: product?.novaGroup,
      imageUrl: product?.imageUrl ?? product?.imageSmallUrl,
    );
    
    // Логирование рейтингов после маппинга
    if (kDebugMode) {
      print('BeautyProduct mapped:');
      print('  nutriscoreGrade: ${beautyProduct.nutriscoreGrade}');
      print('  ecoscoreGrade: ${beautyProduct.ecoscoreGrade}');
      print('  novaGroup: ${beautyProduct.novaGroup}');
      print('===============================');
    }
    
    return beautyProduct;
  }
}

extension BeautyProductSearchDtoMapper on BeautyProductSearchDto {
  BeautyProductSearchResult toDomain() {
    return BeautyProductSearchResult(
      count: count ?? 0,
      page: page ?? 0,
      pageSize: pageSize ?? 0,
      pageCount: pageCount ?? 0,
      products: products?.map((p) => BeautyProductDto(
        code: null,
        product: p,
      ).toDomain()).toList() ?? [],
    );
  }
}

