import 'package:bloc/bloc.dart';

import '../../../../../domain/entiti/analysis/UserOrdersSummaryEntity.dart';
import '../../../../../domain/usecase/admin_usecase.dart';

part 'orderssummary_event.dart';
part 'orderssummary_state.dart';

class OrdersSummaryBloc extends Bloc<OrdersSummaryEvent, OrdersSummaryState> {
  final AdminUsecase roro;

  OrdersSummaryBloc(this.roro) : super(OrdersSummaryInitial()) {
    on<FetchOrdersSummaryEvent>((event, emit) async {
      emit(OrdersSummaryLoading());
      final result = await roro.GetAllUsersOrdersSummary();
      result.fold(
        (failure) => emit(OrdersSummaryError(failure.message)),
        (summaries) => emit(OrdersSummaryLoaded(summaries)),
      );
    });

    on<ConfirmUserOrdersEvent>((event, emit) async {
      // ممكن نظهر مؤشر تحميل أو لا
      // هنستعمل نفس الحالة loading مؤقتًا
      emit(OrdersSummaryLoading());

      final result = await roro.ConfirmUserOrders(event.userId);
      result.fold(
        (failure) => emit(OrdersSummaryError(failure.message)),
        (_) {
          emit(OrdersSummaryConfirmed("تم تأكيد الطلبات للمستخدم بنجاح"));
          add(FetchOrdersSummaryEvent());
        },
      );
    });
  }
}
