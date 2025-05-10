part of 'user_inventory_bloc.dart';

abstract class UserInventoryEvent extends Equatable {
  const UserInventoryEvent();

  @override
  List<Object> get props => [];
}

class GetInventory extends UserInventoryEvent {}

class ListenToInventoryChanges extends UserInventoryEvent {}

class UpdateInventory_temp extends UserInventoryEvent {
  final int temp_item_quantaty;
  final String item_id;

  const UpdateInventory_temp(this.temp_item_quantaty, this.item_id);
}

class updateInventoryfromorder extends UserInventoryEvent {
  final int temp_item_quantaty;
  final String item_id;
  const updateInventoryfromorder(this.temp_item_quantaty, this.item_id);
}

class UpdateInventoryFromOrderList extends UserInventoryEvent {
  final List<UserInventoryEntity> tempList;

  UpdateInventoryFromOrderList(this.tempList);
}

class searchEvent extends UserInventoryEvent {
  final String searchKey;
  searchEvent(this.searchKey);
}
