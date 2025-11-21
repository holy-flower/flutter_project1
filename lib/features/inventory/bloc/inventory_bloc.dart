import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/inventory_item.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  InventoryBloc() : super(InventoryInitial()) {
    on<LoadInventory>(_onLoadInventory);
    on<FilterInventory>(_onFilterInventory);
    on<SearchInventory>(_onSearchInventory);
    on<AddInventoryItem>(_onAddInventoryItem);
    on<UpdateInventoryItem>(_onUpdateInventoryItem);
    on<DeleteInventoryItem>(_onDeleteInventoryItem);
    on<RestockItem>(_onRestockItem);
    on<UseItem>(_onUseItem);
  }

  List<InventoryItem> _inventoryItems = [
    InventoryItem(
      id: '1',
      name: 'Гиалуроновая кислота',
      category: 'Филлеры',
      currentStock: 12,
      minStock: 5,
      unit: 'шт',
      cost: 2500,
      supplier: 'BioLab',
      lastRestock: DateTime.now().subtract(const Duration(days: 15)),
      expiryDate: DateTime.now().add(const Duration(days: 90)),
    ),
    InventoryItem(
      id: '2',
      name: 'Ботокс',
      category: 'Нейромодуляторы',
      currentStock: 8,
      minStock: 3,
      unit: 'флакон',
      cost: 8500,
      supplier: 'MedPharm',
      lastRestock: DateTime.now().subtract(const Duration(days: 7)),
      expiryDate: DateTime.now().add(const Duration(days: 60)),
    ),
    InventoryItem(
      id: '3',
      name: 'Коллагеновая маска',
      category: 'Маски',
      currentStock: 25,
      minStock: 10,
      unit: 'шт',
      cost: 350,
      supplier: 'SkinCare Pro',
      lastRestock: DateTime.now().subtract(const Duration(days: 30)),
      expiryDate: DateTime.now().add(const Duration(days: 180)),
    ),
    InventoryItem(
      id: '4',
      name: 'Сыворотка с витамином C',
      category: 'Сыворотки',
      currentStock: 2,
      minStock: 5,
      unit: 'флакон',
      cost: 1200,
      supplier: 'DermaLine',
      lastRestock: DateTime.now().subtract(const Duration(days: 45)),
      expiryDate: DateTime.now().add(const Duration(days: 120)),
    ),
    InventoryItem(
      id: '5',
      name: 'Пилинговый комплекс',
      category: 'Пилинги',
      currentStock: 15,
      minStock: 8,
      unit: 'набор',
      cost: 2800,
      supplier: 'Aesthetic Solutions',
      lastRestock: DateTime.now().subtract(const Duration(days: 20)),
      expiryDate: DateTime.now().add(const Duration(days: 150)),
    ),
    InventoryItem(
      id: '6',
      name: 'Анестезирующий крем',
      category: 'Анестетики',
      currentStock: 18,
      minStock: 6,
      unit: 'туба',
      cost: 650,
      supplier: 'PharmaCare',
      lastRestock: DateTime.now().subtract(const Duration(days: 10)),
      expiryDate: DateTime.now().add(const Duration(days: 200)),
    ),
  ];

  void _onLoadInventory(LoadInventory event, Emitter<InventoryState> emit) async {
    try {
      emit(InventoryLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      emit(InventoryLoaded(
        items: _inventoryItems,
        filteredItems: _inventoryItems,
        selectedFilter: 'all',
        searchQuery: '',
      ));
    } catch (e) {
      emit(InventoryError('Не удалось загрузить инвентарь: $e'));
    }
  }

  void _onFilterInventory(FilterInventory event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final filteredItems = _applyFilters(
        currentState.items,
        event.filter,
        currentState.searchQuery,
      );

      emit(InventoryLoaded(
        items: currentState.items,
        filteredItems: filteredItems,
        selectedFilter: event.filter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onSearchInventory(SearchInventory event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final filteredItems = _applyFilters(
        currentState.items,
        currentState.selectedFilter,
        event.query,
      );

      emit(InventoryLoaded(
        items: currentState.items,
        filteredItems: filteredItems,
        selectedFilter: currentState.selectedFilter,
        searchQuery: event.query,
      ));
    }
  }

  void _onAddInventoryItem(AddInventoryItem event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedItems = List<InventoryItem>.from(currentState.items)..add(event.item);

      final filteredItems = _applyFilters(
        updatedItems,
        currentState.selectedFilter,
        currentState.searchQuery,
      );

      emit(InventoryLoaded(
        items: updatedItems,
        filteredItems: filteredItems,
        selectedFilter: currentState.selectedFilter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onUpdateInventoryItem(UpdateInventoryItem event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedItems = currentState.items.map((item) {
        return item.id == event.item.id ? event.item : item;
      }).toList();

      final filteredItems = _applyFilters(
        updatedItems,
        currentState.selectedFilter,
        currentState.searchQuery,
      );

      emit(InventoryLoaded(
        items: updatedItems,
        filteredItems: filteredItems,
        selectedFilter: currentState.selectedFilter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onDeleteInventoryItem(DeleteInventoryItem event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedItems = currentState.items
          .where((item) => item.id != event.itemId)
          .toList();

      final filteredItems = _applyFilters(
        updatedItems,
        currentState.selectedFilter,
        currentState.searchQuery,
      );

      emit(InventoryLoaded(
        items: updatedItems,
        filteredItems: filteredItems,
        selectedFilter: currentState.selectedFilter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onRestockItem(RestockItem event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedItems = currentState.items.map((item) {
        if (item.id == event.itemId) {
          return item.copyWith(
            currentStock: item.currentStock + event.quantity,
            lastRestock: DateTime.now(),
          );
        }
        return item;
      }).toList();

      final filteredItems = _applyFilters(
        updatedItems,
        currentState.selectedFilter,
        currentState.searchQuery,
      );

      emit(InventoryLoaded(
        items: updatedItems,
        filteredItems: filteredItems,
        selectedFilter: currentState.selectedFilter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  void _onUseItem(UseItem event, Emitter<InventoryState> emit) {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedItems = currentState.items.map((item) {
        if (item.id == event.itemId) {
          return item.copyWith(
            currentStock: item.currentStock - event.quantity,
          );
        }
        return item;
      }).toList();

      final filteredItems = _applyFilters(
        updatedItems,
        currentState.selectedFilter,
        currentState.searchQuery,
      );

      emit(InventoryLoaded(
        items: updatedItems,
        filteredItems: filteredItems,
        selectedFilter: currentState.selectedFilter,
        searchQuery: currentState.searchQuery,
      ));
    }
  }

  List<InventoryItem> _applyFilters(List<InventoryItem> items, String filter, String searchQuery) {
    List<InventoryItem> filteredItems = items;

    // Применяем поиск
    if (searchQuery.isNotEmpty) {
      filteredItems = filteredItems.where((item) =>
      item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    // Применяем фильтр по категории
    if (filter != 'all') {
      filteredItems = filteredItems.where((item) => item.category == filter).toList();
    }

    return filteredItems;
  }
}