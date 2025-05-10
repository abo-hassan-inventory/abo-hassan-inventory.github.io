part of 'user_inventory_bloc.dart';

abstract class UserInventoryState extends Equatable {
  const UserInventoryState();

  @override
  List<Object> get props => [];
}

class user_InventoryInitial extends UserInventoryState {}

class user_inventoryloading extends UserInventoryState {}

class user_inventoryLoaded extends UserInventoryState {
  final List<UserInventoryEntity> inventory;
  user_inventoryLoaded({required this.inventory});
}

class user_inventoryError extends UserInventoryState {
  final String message;
  user_inventoryError({required this.message});
}

class user_updated_successfully extends UserInventoryState {
  final String message;
  user_updated_successfully({required this.message});
}

class searchresult extends UserInventoryState {
  final List<UserInventoryEntity> inventory;
  searchresult({required this.inventory});
}
