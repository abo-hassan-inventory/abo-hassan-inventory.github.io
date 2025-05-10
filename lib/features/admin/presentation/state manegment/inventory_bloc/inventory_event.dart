part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class InventoryLoadingEvent extends InventoryEvent {}

class AddProductEvent extends InventoryEvent {
  final InventoryEntity product;
  AddProductEvent({required this.product});
}

class UpdateProductEvent extends InventoryEvent {
  final InventoryEntity product;
  UpdateProductEvent({required this.product});
}

class DeleteProductEvent extends InventoryEvent {
  final String productId;
  DeleteProductEvent({required this.productId});
}

class searchEvent extends InventoryEvent {
  final String text;
  searchEvent({required this.text});
}

class getInventoryEvent extends InventoryEvent {}
