import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_display_entity.dart';
import '../../../domain/usecase/admin_usecase.dart';

part 'admin_res_event.dart';
part 'admin_res_state.dart';

class AdminResBloc extends Bloc<AdminResEvent, AdminResState> {
  final AdminUsecase usecase;
  AdminResBloc(this.usecase) : super(AdminResInitial()) {
    on<AdminResEvent>((event, emit) {});

    on<GetAllOrders>(
      (event, emit) async {
        emit(AdminResLoading());
        final result = await usecase.getAllOrders();
        result.fold((faluier) {
          emit(adminResError(faluier.message));
        }, (orders) {
          emit(AdminResLoaded(orders));
        });
      },
    );
    on<deleteOrder>((event, emit) async {
      print(
          "the event have been called to delte the order which have the id of ========${event.orderId}");
      emit(AdminResLoading());
      final result = await usecase.deleteOrder(event.orderId);
      add(GetAllOrders());
      result.fold((faluier) {
        emit(adminResError(faluier.message));
      }, (_) {
        emit(adminResSuccess("the order deleted successfully"));
      });
    });
  }
}
