part of 'admin_res_bloc.dart';

abstract class AdminResEvent extends Equatable {
  const AdminResEvent();

  @override
  List<Object> get props => [];
}

class GetAllOrders extends AdminResEvent {}

class deleteOrder extends AdminResEvent {
  final String orderId;
  const deleteOrder(this.orderId);
}
