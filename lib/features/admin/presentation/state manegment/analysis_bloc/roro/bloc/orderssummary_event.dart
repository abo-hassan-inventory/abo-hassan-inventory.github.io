part of 'orderssummary_bloc.dart';

abstract class OrdersSummaryEvent {}

class FetchOrdersSummaryEvent extends OrdersSummaryEvent {}

class ConfirmUserOrdersEvent extends OrdersSummaryEvent {
  final String userId;
  ConfirmUserOrdersEvent(this.userId);
}
