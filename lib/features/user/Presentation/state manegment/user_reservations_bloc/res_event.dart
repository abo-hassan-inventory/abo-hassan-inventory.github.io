part of 'res_bloc.dart';

abstract class ResEvent extends Equatable {
  const ResEvent();

  @override
  List<Object> get props => [];
}

class GetReservations extends ResEvent {
  final String userId;

  const GetReservations({required this.userId});
}
