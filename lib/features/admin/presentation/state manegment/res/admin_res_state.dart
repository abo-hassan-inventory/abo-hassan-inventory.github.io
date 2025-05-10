part of 'admin_res_bloc.dart';

abstract class AdminResState extends Equatable {
  const AdminResState();

  @override
  List<Object> get props => [];
}

class AdminResInitial extends AdminResState {}

class AdminResLoaded extends AdminResState {
  final List<AdminOrderDisplayEntity> orders;

  const AdminResLoaded(this.orders);
}

class adminResError extends AdminResState {
  final String message;

  const adminResError(this.message);
}

class adminResSuccess extends AdminResState {
  final String message;

  const adminResSuccess(this.message);
}

class AdminResLoading extends AdminResState {}
