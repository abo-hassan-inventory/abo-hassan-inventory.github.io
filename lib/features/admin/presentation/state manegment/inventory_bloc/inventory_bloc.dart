import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:inventory_project/features/admin/domain/entiti/admin_inventory_entity.dart';
import 'package:inventory_project/features/admin/domain/usecase/admin_usecase.dart';
part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final AdminUsecase useCase;

  InventoryBloc(this.useCase) : super(InventoryInitial()) {
    on<getInventoryEvent>(
      (event, emit) async {
        emit(InventoryLoading());
        final data = await useCase.getInventory();
        data.fold((fail) {
          emit(InventoryError(message: fail.message));
        }, (data) => emit(InventoryLoaded(inventoryList: data)));
      },
    );
    on<AddProductEvent>((event, emit) async {
      final result = await useCase.addProduct(event.product);
      result.fold(
        (failure) => emit(InventoryError(message: failure.message)),
        (_) {
          emit(added_sucessfuly(message: "تمت اضافة المنتج بنجاح"));
          add(getInventoryEvent());
        },
      );
    });

    on<UpdateProductEvent>((event, emit) async {
      final result = await useCase.updateProduct(event.product);
      result.fold((failure) => emit(InventoryError(message: failure.message)),
          (_) {
        emit(updated_sucessfuly(message: "تم تحديث المنتج بنجاح"));
        add(getInventoryEvent());
      });
    });

    on<DeleteProductEvent>((event, emit) async {
      final result = await useCase.deleteProduct(event.productId);
      result.fold(
        (failure) => emit(InventoryError(message: failure.message)),
        (_) {
          emit(removed_sucessfuly(message: "تم حذف المنتج بنجاح"));
          add(getInventoryEvent());
        },
      );
    });

    on<searchEvent>(
      (event, emit) async {
        emit(InventoryLoading());
        final templist = await useCase.getInventory();

        templist.fold((faluir) {
          emit(InventoryError(message: faluir.message));
        }, (templis) {
          if (event.text.isEmpty) {
            emit(InventoryLoaded(inventoryList: templis));
          } else if (event.text.isNotEmpty) {
            final List<InventoryEntity> filteredMembers = templis
                .where((member) => member.name
                    .toLowerCase()
                    .contains(event.text.toLowerCase()))
                .toList();

            if (filteredMembers.isEmpty) {
              emit(InventoryError(message: "لا يوجد نتائج للبحث"));
              emit(InventoryLoaded(inventoryList: templis));
            } else if (filteredMembers.isNotEmpty) {
              emit(InventoryLoaded(inventoryList: filteredMembers));
            }
          }
        });
      },
    );
  }
}
