part of 'user_order_bloc.dart';

abstract class UserOrderEvent extends Equatable {
  const UserOrderEvent();

  @override
  List<Object> get props => [];
}

class add_item extends UserOrderEvent {
  final UserInventoryEntity oreder_item;

  add_item(this.oreder_item);
}

class remove_item extends UserOrderEvent {
  final String id;
  remove_item(this.id);
}

class cancelOrder extends UserOrderEvent {}

class confirmOrder extends UserOrderEvent {
  final String clientId;
  final List<UserInventoryEntity> tempList;
  confirmOrder(this.clientId, this.tempList);
}
