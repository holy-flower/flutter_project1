part of 'cosmetology_news_bloc.dart';

abstract class CosmetologyNewsEvent extends Equatable {
  const CosmetologyNewsEvent();

  @override
  List<Object?> get props => [];
}

class SearchCosmetologyNewsEvent extends CosmetologyNewsEvent {}

class GetSkincareNewsEvent extends CosmetologyNewsEvent {}

class GetTopBeautyNewsEvent extends CosmetologyNewsEvent {}

class GetCosmeticsNewsByDateEvent extends CosmetologyNewsEvent {
  final String fromDate;
  final String toDate;

  const GetCosmeticsNewsByDateEvent(this.fromDate, this.toDate);

  @override
  List<Object?> get props => [fromDate, toDate];
}

class GetHealthNewsSourcesEvent extends CosmetologyNewsEvent {}

