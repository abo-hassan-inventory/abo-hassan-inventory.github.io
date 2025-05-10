part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();

  @override
  List<Object> get props => [];
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<InventoryEntity> inventoryList;
  const InventoryLoaded({required this.inventoryList});
}

class InventoryError extends InventoryState {
  final String message;
  const InventoryError({required this.message});
}

class added_sucessfuly extends InventoryState {
  final String message;
  const added_sucessfuly({required this.message});
}

class removed_sucessfuly extends InventoryState {
  final String message;
  const removed_sucessfuly({required this.message});
}

class updated_sucessfuly extends InventoryState {
  final String message;
  const updated_sucessfuly({required this.message});
}
