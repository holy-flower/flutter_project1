part of 'beauty_products_bloc.dart';

abstract class BeautyProductsEvent extends Equatable {
  const BeautyProductsEvent();

  @override
  List<Object?> get props => [];
}

class GetProductByBarcodeEvent extends BeautyProductsEvent {
  final String barcode;

  const GetProductByBarcodeEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class SearchProductsEvent extends BeautyProductsEvent {
  final String query;
  final int? pageSize;

  const SearchProductsEvent(this.query, {this.pageSize});

  @override
  List<Object?> get props => [query, pageSize];
}

class GetProductIngredientsEvent extends BeautyProductsEvent {
  final String barcode;

  const GetProductIngredientsEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class SearchProductsByIngredientEvent extends BeautyProductsEvent {
  final String ingredient;

  const SearchProductsByIngredientEvent(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

class GetProductRatingEvent extends BeautyProductsEvent {
  final String barcode;

  const GetProductRatingEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

