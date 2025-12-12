import 'package:equatable/equatable.dart';

class BeautyProduct extends Equatable {
  final String barcode;
  final String productName;
  final String brands;
  final String categories;
  final String ingredientsText;
  final String? nutriscoreGrade;
  final String? ecoscoreGrade;
  final int? novaGroup;
  final String? imageUrl;

  const BeautyProduct({
    required this.barcode,
    required this.productName,
    required this.brands,
    required this.categories,
    required this.ingredientsText,
    this.nutriscoreGrade,
    this.ecoscoreGrade,
    this.novaGroup,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        barcode,
        productName,
        brands,
        categories,
        ingredientsText,
        nutriscoreGrade,
        ecoscoreGrade,
        novaGroup,
        imageUrl,
      ];
}

class BeautyProductSearchResult extends Equatable {
  final int count;
  final int page;
  final int pageSize;
  final int pageCount;
  final List<BeautyProduct> products;

  const BeautyProductSearchResult({
    required this.count,
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.products,
  });

  @override
  List<Object?> get props => [count, page, pageSize, pageCount, products];
}

