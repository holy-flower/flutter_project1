part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventory extends InventoryEvent {}

class FilterInventory extends InventoryEvent {
  final String filter;

  const FilterInventory(this.filter);

  @override
  List<Object> get props => [filter];
}

class SearchInventory extends InventoryEvent {
  final String query;

  const SearchInventory(this.query);

  @override
  List<Object> get props => [query];
}

class AddInventoryItem extends InventoryEvent {
  final InventoryItem item;

  const AddInventoryItem(this.item);

  @override
  List<Object> get props => [item];
}

class UpdateInventoryItem extends InventoryEvent {
  final InventoryItem item;

  const UpdateInventoryItem(this.item);

  @override
  List<Object> get props => [item];
}

class DeleteInventoryItem extends InventoryEvent {
  final String itemId;

  const DeleteInventoryItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class RestockItem extends InventoryEvent {
  final String itemId;
  final int quantity;

  const RestockItem(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}

class UseItem extends InventoryEvent {
  final String itemId;
  final int quantity;

  const UseItem(this.itemId, this.quantity);

  @override
  List<Object> get props => [itemId, quantity];
}