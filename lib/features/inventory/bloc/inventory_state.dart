part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<InventoryItem> items;
  final List<InventoryItem> filteredItems;
  final String selectedFilter;
  final String searchQuery;

  const InventoryLoaded({
    required this.items,
    required this.filteredItems,
    required this.selectedFilter,
    required this.searchQuery,
  });

  List<String> get categories {
    final categories = items.map((item) => item.category).toSet().toList();
    categories.insert(0, 'all');
    return categories;
  }

  int get lowStockCount => items.where((item) => item.currentStock <= item.minStock).length;

  int get expiringSoonCount => items
      .where((item) => item.expiryDate.isBefore(DateTime.now().add(const Duration(days: 30))))
      .length;

  @override
  List<Object> get props => [items, filteredItems, selectedFilter, searchQuery];
}

class InventoryError extends InventoryState {
  final String message;

  const InventoryError(this.message);

  @override
  List<Object> get props => [message];
}