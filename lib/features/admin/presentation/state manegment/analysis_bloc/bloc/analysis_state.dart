part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object> get props => [];
}

class AnalysisInitial extends AnalysisState {}

class AnalysisLoading extends AnalysisState {}

class AnalysisLoaded extends AnalysisState {
  final List<UserMonthlyOrdersEntity> data;
  AnalysisLoaded(this.data);
}

class AnalysisError extends AnalysisState {
  final String message;
  AnalysisError(this.message);
}
