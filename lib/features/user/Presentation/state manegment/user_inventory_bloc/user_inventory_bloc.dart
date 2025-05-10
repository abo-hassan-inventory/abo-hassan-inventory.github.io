import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';
import 'package:inventory_project/features/user/Domain/usecase/user_usecase.dart';

part 'user_inventory_event.dart';
part 'user_inventory_state.dart';

class UserInventoryBloc extends Bloc<UserInventoryEvent, UserInventoryState> {
  final UserUsecase usecase;

  UserInventoryBloc(this.usecase) : super(user_InventoryInitial()) {
    List<UserInventoryEntity> _originalInventory = [];
    on<GetInventory>((event, emit) async {
      emit(user_inventoryloading());

      final result = await usecase.getInventory();

      result.fold((failure) {
        emit(user_inventoryError(message: failure.message));
      }, (inventory) {
        _originalInventory = inventory;
        emit(user_inventoryLoaded(inventory: inventory));
      });
    });

    on<UpdateInventory_temp>((event, emit) async {
      final currentInventory = (state as user_inventoryLoaded).inventory;

      final index =
          currentInventory.indexWhere((item) => item.id == event.item_id);
      if (index == -1) {
        emit(user_inventoryError(message: "العنصر غير موجود"));
        return;
      }

      final updatedInventory = List<UserInventoryEntity>.from(currentInventory);

      final oldItem = updatedInventory[index];
      print("====================================================$oldItem");

      final newQuantity = oldItem.quantity - event.temp_item_quantaty;
      updatedInventory[index] = UserInventoryEntity(
        id: oldItem.id,
        name: oldItem.name,
        quantity: newQuantity < 0 ? 0 : newQuantity,
      );
      _originalInventory = updatedInventory;

      // نبعت حالة نجاح (اختياري لو عايز تظهر رسالة نجاح)
      emit(user_updated_successfully(
          message: "تمت اضافة طلبك الي قائمة الطلبات بنجاح"));

      // أخيرًا، نبعت الحالة الجديدة للقائمة المُحدثة
      emit(user_inventoryLoaded(inventory: updatedInventory));
    });

    //here is when i update the item from the order list if i deleted an item from it
    on<updateInventoryfromorder>((event, emit) async {
      final currentInventory = (state as user_inventoryLoaded).inventory;

      final index =
          currentInventory.indexWhere((item) => item.id == event.item_id);
      if (index == -1) {
        emit(user_inventoryError(message: "العنصر غير موجود"));
        return;
      }

      final updatedInventory = List<UserInventoryEntity>.from(currentInventory);

      final oldItem = updatedInventory[index];
      print("====================================================$oldItem");

      final newQuantity = oldItem.quantity + event.temp_item_quantaty;
      updatedInventory[index] = UserInventoryEntity(
        id: oldItem.id,
        name: oldItem.name,
        quantity: newQuantity < 0 ? 0 : newQuantity,
      );

      _originalInventory = updatedInventory;
      // نبعت حالة نجاح (اختياري لو عايز تظهر رسالة نجاح)
      emit(user_updated_successfully(
          message: "تمت اضافة طلبك الي قائمة الطلبات بنجاح"));

      // أخيرًا، نبعت الحالة الجديدة للقائمة المُحدثة
      emit(user_inventoryLoaded(inventory: updatedInventory));
    });

    on<UpdateInventoryFromOrderList>((event, emit) async {
      final currentState = state;
      if (currentState is! user_inventoryLoaded) {
        emit(user_inventoryError(message: "القائمة مش محملة لسة"));
        return;
      }

      // ignore: unnecessary_cast
      final currentInventory = (currentState as user_inventoryLoaded).inventory;
      final updatedInventory = List<UserInventoryEntity>.from(currentInventory);

      // لف على كل عنصر في الـ temp list اللي عايز تحدثه
      for (final tempItem in event.tempList) {
        // ابحث عنه في الـ updatedInventory
        final index =
            updatedInventory.indexWhere((invItem) => invItem.id == tempItem.id);
        if (index != -1) {
          final oldItem = updatedInventory[index];
          // هنا بتزود أو تنقص الكمية
          final newQuantity = oldItem.quantity + tempItem.quantity;
          updatedInventory[index] = UserInventoryEntity(
            id: oldItem.id,
            name: oldItem.name,
            quantity: newQuantity < 0 ? 0 : newQuantity,
          );
        } else {
          // لو العنصر مش موجود في الـ inventory، ممكن تتجاهله أو تعمل emit خطأ
          // هنكتفي بتجاهله مثلاً
        }
      }
      _originalInventory = updatedInventory;

      // emit رسالة نجاح
      emit(user_updated_successfully(
          message: "تمت إضافة طلبك إلى قائمة الطلبات بنجاح"));

      emit(user_inventoryLoaded(inventory: updatedInventory));
    });

    on<searchEvent>((event, emit) async {
      emit(user_inventoryloading());
      print(
          "=============================original count ${_originalInventory.length}");
      if (event.searchKey.isEmpty) {
        print("===================the key is eampty");
        emit(user_inventoryLoaded(inventory: _originalInventory));
      } else if (event.searchKey.isNotEmpty) {
        print("starting to search =============>>>>>>");
        final List<UserInventoryEntity> filteredMembers = _originalInventory
            .where((member) => member.name
                .toLowerCase()
                .contains(event.searchKey.toLowerCase()))
            .toList();

        if (filteredMembers.isEmpty) {
          print("===================the resulllt is eampty");
          emit(user_inventoryError(message: "لا يوجد نتائج للبحث"));
          emit(user_inventoryLoaded(inventory: _originalInventory));
        } else if (filteredMembers.isNotEmpty) {
          print("found result=========================>> ");
          emit(user_inventoryLoaded(inventory: filteredMembers));
          print("${filteredMembers}=========================>> ");
        }
      }
    });
  }
}
