part of 'cosmetology_news_bloc.dart';

abstract class CosmetologyNewsState extends Equatable {
  const CosmetologyNewsState();

  @override
  List<Object?> get props => [];
}

class CosmetologyNewsInitial extends CosmetologyNewsState {}

class CosmetologyNewsLoading extends CosmetologyNewsState {}

class CosmetologyNewsLoaded extends CosmetologyNewsState {
  final NewsResponse newsResponse;

  const CosmetologyNewsLoaded({required this.newsResponse});

  @override
  List<Object?> get props => [newsResponse];
}

class CosmetologyNewsSourcesLoaded extends CosmetologyNewsState {
  final NewsSourcesResponse sourcesResponse;

  const CosmetologyNewsSourcesLoaded({required this.sourcesResponse});

  @override
  List<Object?> get props => [sourcesResponse];
}

class CosmetologyNewsError extends CosmetologyNewsState {
  final String message;

  const CosmetologyNewsError(this.message);

  @override
  List<Object?> get props => [message];
}

