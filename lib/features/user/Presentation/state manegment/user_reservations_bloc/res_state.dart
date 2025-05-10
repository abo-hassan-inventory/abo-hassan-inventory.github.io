part of 'res_bloc.dart';

abstract class ResState extends Equatable {
  const ResState();

  @override
  List<Object> get props => [];
}

class ResInitial extends ResState {}

class resSuccess extends ResState {
  final String message;

  resSuccess(this.message);
}

class resError extends ResState {
  final String message;

  resError(this.message);
}

class resLoading extends ResState {}

class resLoaded extends ResState {
  final List<UserGorgeOrder> ordersList;

  resLoaded(this.ordersList);
}
