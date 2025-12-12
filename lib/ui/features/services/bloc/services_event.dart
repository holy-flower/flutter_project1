part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class LoadServices extends ServicesEvent {}

class UpdateServiceStats extends ServicesEvent {
  final String categoryTitle;
  final int price;

  const UpdateServiceStats({
    required this.categoryTitle,
    required this.price,
  });

  @override
  List<Object> get props => [categoryTitle, price];
}

class FilterServices extends ServicesEvent {
  final ServiceFilter filter;
  final String searchQuery;

  const FilterServices({
    required this.filter,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [filter, searchQuery];
}

enum ServiceFilter {
  all,
  popular,
  search,
}





