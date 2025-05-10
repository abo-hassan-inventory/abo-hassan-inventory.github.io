part of 'user_order_bloc.dart';

abstract class UserOrderState extends Equatable {
  const UserOrderState();

  @override
  List<Object> get props => [];
}

class UserOrderInitial extends UserOrderState {}

class user_order_temp_list_loading extends UserOrderState {}

class user_order_temp_list_loaded extends UserOrderState {
  final List<UserInventoryEntity> templist;
  user_order_temp_list_loaded(this.templist);
}

class user_order_temp_list_error extends UserOrderState {
  final String message;

  user_order_temp_list_error(this.message);
}

class orederitemdeltedsucessfuly extends UserOrderState {
  final String message;

  orederitemdeltedsucessfuly(this.message);
}

class dexter extends UserOrderState {}
