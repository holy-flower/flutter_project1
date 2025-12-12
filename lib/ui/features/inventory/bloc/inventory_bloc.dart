import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/inventory_item.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/usecases/inventory/get_inventory_items_usecase.dart';
import '../../../../domain/usecases/inventory/add_inventory_item_usecase.dart';
import '../../../../domain/usecases/inventory/update_inventory_item_usecase.dart';
import '../../../../domain/usecases/inventory/delete_inventory_item_usecase.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final GetInventoryItemsUseCase getInventoryItemsUseCase;
  final AddInventoryItemUseCase addInventoryItemUseCase;
  final UpdateInventoryItemUseCase updateInventoryItemUseCase;
  final DeleteInventoryItemUseCase deleteInventoryItemUseCase;

  InventoryBloc({
    GetInventoryItemsUseCase? getInventoryItemsUseCase,
    AddInventoryItemUseCase? addInventoryItemUseCase,
    UpdateInventoryItemUseCase? updateInventoryItemUseCase,
    DeleteInventoryItemUseCase? deleteInventoryItemUseCase,
  })  : getInventoryItemsUseCase = getInventoryItemsUseCase ?? getIt<GetInventoryItemsUseCase>(),
        addInventoryItemUseCase = addInventoryItemUseCase ?? getIt<AddInventoryItemUseCase>(),
        updateInventoryItemUseCase = updateInventoryItemUseCase ?? getIt<UpdateInventoryItemUseCase>(),
        deleteInventoryItemUseCase = deleteInventoryItemUseCase ?? getIt<DeleteInventoryItemUseCase>(),
        super(InventoryInitial()) {
    on<LoadInventory>(_onLoadInventory);
    on<FilterInventory>(_onFilterInventory);
    on<SearchInventory>(_onSearchInventory);
    on<AddInventoryItem>(_onAddInventoryItem);
    on<UpdateInventoryItem>(_onUpdateInventoryItem);
    on<DeleteInventoryItem>(_onDeleteInventoryItem);
    on<RestockItem>(_onRestockItem);
    on<UseItem>(_onUseItem);
  }

  void _onLoadInventory(LoadInventory event, Emitter<InventoryState> emit) async {
    emit(InventoryLoading());
    
    final result = await getInventoryItemsUseCase();
    
    result.fold(
      (failure) => emit(InventoryError(failure.message)),
      (items) => emit(InventoryLoaded(
        items: items,
        filteredItems: items,
        selectedFilter: 'all',
        searchQuery: '',
      )),
    );
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

  void _onAddInventoryItem(AddInventoryItem event, Emitter<InventoryState> emit) async {
    final result = await addInventoryItemUseCase(event.item);
    
    result.fold(
      (failure) => emit(InventoryError(failure.message)),
      (_) => add(LoadInventory()),
    );
  }

  void _onUpdateInventoryItem(UpdateInventoryItem event, Emitter<InventoryState> emit) async {
    final result = await updateInventoryItemUseCase(event.item);
    
    result.fold(
      (failure) => emit(InventoryError(failure.message)),
      (_) => add(LoadInventory()),
    );
  }

  void _onDeleteInventoryItem(DeleteInventoryItem event, Emitter<InventoryState> emit) async {
    final result = await deleteInventoryItemUseCase(event.itemId);
    
    result.fold(
      (failure) => emit(InventoryError(failure.message)),
      (_) => add(LoadInventory()),
    );
  }

  void _onRestockItem(RestockItem event, Emitter<InventoryState> emit) async {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final item = currentState.items.firstWhere((i) => i.id == event.itemId);
      final updatedItem = item.copyWith(
        currentStock: item.currentStock + event.quantity,
        lastRestock: DateTime.now(),
      );
      
      final result = await updateInventoryItemUseCase(updatedItem);
      
      result.fold(
        (failure) => emit(InventoryError(failure.message)),
        (_) => add(LoadInventory()),
      );
    }
  }

  void _onUseItem(UseItem event, Emitter<InventoryState> emit) async {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final item = currentState.items.firstWhere((i) => i.id == event.itemId);
      final updatedItem = item.copyWith(
        currentStock: item.currentStock - event.quantity,
      );
      
      final result = await updateInventoryItemUseCase(updatedItem);
      
      result.fold(
        (failure) => emit(InventoryError(failure.message)),
        (_) => add(LoadInventory()),
      );
    }
  }

  List<InventoryItem> _applyFilters(List<InventoryItem> items, String filter, String searchQuery) {
    List<InventoryItem> filteredItems = items;

    if (searchQuery.isNotEmpty) {
      filteredItems = filteredItems.where((item) =>
      item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.category.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    if (filter != 'all') {
      filteredItems = filteredItems.where((item) => item.category == filter).toList();
    }

    return filteredItems;
  }
}





