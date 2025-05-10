import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_project/features/admin/domain/usecase/admin_usecase.dart';

import '../../../../domain/entiti/user_monthly_orders_entity.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final AdminUsecase usecase;
  AnalysisBloc(this.usecase) : super(AnalysisInitial()) {
    on<FetchOrdersPerMonthEvent>((event, emit) async {
      emit(AnalysisLoading());
      final result = await usecase.getOrdersPerMonth();
      result.fold(
        (failure) => emit(AnalysisError(failure.message)),
        (data) => emit(AnalysisLoaded(data)),
      );
    });
  }
}
