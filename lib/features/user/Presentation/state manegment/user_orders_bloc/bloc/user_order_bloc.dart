import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';
import 'package:inventory_project/features/user/Domain/usecase/user_usecase.dart';

part 'user_order_event.dart';
part 'user_order_state.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  final UserUsecase use_case;

  UserOrderBloc(this.use_case) : super(UserOrderInitial()) {
    on<add_item>((event, emit) async {
      print("===========the add event has been called ===========");
      // 1) خزن الstate الحالي
      final currentState = state;
      // 2) لو هو Loaded خد القائمة، لو لأ اعمل قائمة جديدة
      List<UserInventoryEntity> currentInventory = [];
      if (currentState is user_order_temp_list_loaded) {
        currentInventory = currentState.templist;
      }

      // 3) عدل القائمة بإضافة العنصر الجديد
      final updatedList = List<UserInventoryEntity>.from(currentInventory)
        ..add(event.oreder_item);

      // 4) ممكن تعرض loading لو حابب
      emit(user_order_temp_list_loading());
      // 5) وأخيرًا ترجع الحالة loaded مع القائمة الجديدة
      emit(user_order_temp_list_loaded(updatedList));
    });

    on<remove_item>((event, emit) async {
      print("===========oreder deltion event was called ");
      final currentState = state;
      List<UserInventoryEntity> currentInventory = [];
      if (currentState is user_order_temp_list_loaded) {
        currentInventory = currentState.templist;
      }

      final updatedList =
          currentInventory.where((item) => item.id != event.id).toList();

      emit(orederitemdeltedsucessfuly("تم حذف الصنف من قائمة الطلبات بنجاح"));
      emit(user_order_temp_list_loaded(updatedList));
    });

    on<cancelOrder>((event, emit) async {
      print("the cancling order event have been triggerd");
      emit(user_order_temp_list_loading());
      emit(orederitemdeltedsucessfuly("تم الغاء الطلب بنجاح"));
      emit(user_order_temp_list_loaded([]));

      print("current incentory is ===============> []");
    });

    on<confirmOrder>(
      (event, emit) async {
        emit(user_order_temp_list_loading());

        final result =
            await use_case.ConfirmOrder(event.clientId, event.tempList);
        result.fold(
          (failure) {
            emit(user_order_temp_list_error(failure.message));
            print(
                "the error says =========================================${failure.message}");
          },
          (_) {
            emit(dexter());
            emit(orederitemdeltedsucessfuly(
                "واضافته الي الحجوزات تم تاكيد الطلب بنجاح"));
            emit(user_order_temp_list_loaded([]));
          },
        );
      },
    );
  }
}
