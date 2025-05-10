import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_project/features/user/Domain/entity/user_gorge_order.dart';

import '../../../Domain/usecase/user_usecase.dart';

part 'res_event.dart';
part 'res_state.dart';

class ResBloc extends Bloc<ResEvent, ResState> {
  final UserUsecase usecase;

  ResBloc(this.usecase) : super(ResInitial()) {
    on<GetReservations>((event, emit) async {
      emit(resLoading());
      final result = await usecase.getAllOrdersForUser(event.userId);
      result.fold((failure) => emit(resError(failure.message)), (orders) {
        emit(resLoaded(orders));
      });
    });
  }
}
