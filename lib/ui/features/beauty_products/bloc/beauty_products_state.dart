part of 'beauty_products_bloc.dart';

abstract class BeautyProductsState extends Equatable {
  const BeautyProductsState();

  @override
  List<Object?> get props => [];
}

class BeautyProductsInitial extends BeautyProductsState {}

class BeautyProductsLoading extends BeautyProductsState {}

class BeautyProductsLoaded extends BeautyProductsState {
  final BeautyProduct product;

  const BeautyProductsLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class BeautyProductsSearchLoaded extends BeautyProductsState {
  final BeautyProductSearchResult searchResult;

  const BeautyProductsSearchLoaded({required this.searchResult});

  @override
  List<Object?> get props => [searchResult];
}

class BeautyProductsIngredientsLoaded extends BeautyProductsState {
  final String ingredients;

  const BeautyProductsIngredientsLoaded({required this.ingredients});

  @override
  List<Object?> get props => [ingredients];
}

class BeautyProductsRatingLoaded extends BeautyProductsState {
  final ProductRating rating;

  const BeautyProductsRatingLoaded({required this.rating});

  @override
  List<Object?> get props => [rating];
}

class BeautyProductsError extends BeautyProductsState {
  final String message;

  const BeautyProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

