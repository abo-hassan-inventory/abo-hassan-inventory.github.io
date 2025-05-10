part of 'orderssummary_bloc.dart';

abstract class OrdersSummaryState {}

class OrdersSummaryInitial extends OrdersSummaryState {}

class OrdersSummaryLoading extends OrdersSummaryState {}

class OrdersSummaryLoaded extends OrdersSummaryState {
  final List<UserOrdersSummaryEntity> summaries;
  OrdersSummaryLoaded(this.summaries);
}

class OrdersSummaryError extends OrdersSummaryState {
  final String message;
  OrdersSummaryError(this.message);
}

class OrdersSummaryConfirmed extends OrdersSummaryState {
  final String message;
  OrdersSummaryConfirmed(this.message);
}
