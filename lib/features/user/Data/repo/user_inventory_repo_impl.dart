import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/user/Data/data_source/user_inventory_remote.dart';
import 'package:inventory_project/features/user/Domain/entity/user_gorge_order.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';
import 'package:inventory_project/features/user/Domain/repo/user_inventory_repo.dart';

import '../../Domain/entity/user_gorge_orditem.dart';

class UserInventoryRepoImpl implements UserInventoryRepository {
  final UserInventoryRemote remoteDataSource;

  UserInventoryRepoImpl(this.remoteDataSource);
  @override
  Stream<Either<Failure, List<UserInventoryEntity>>>
      listenToInventoryChanges() {
    return remoteDataSource.listenToInventoryChanges().map((data) {
      try {
        return Right(data);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, List<UserInventoryEntity>>> getInventory() async {
    try {
      final result = await remoteDataSource.getInventory();
      return result.fold(
        (failure) => Left(Failure(failure)),
        (inventory) => Right(inventory),
      );
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmOrder(
      String clientId, List<UserInventoryEntity> tempList) async {
    try {
      await remoteDataSource.confirmOrder(clientId, tempList);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserGorgeOrder>>> getAllOrdersForUser(
      String userId) async {
    try {
      // أ) جيب اسم المستخدم
      final userName =
          await remoteDataSource.getUserName(userId) ?? "Unknown User";

      // ب) جيب الطلبات
      final ordersData = await remoteDataSource.getOrdersByUser(userId);

      final List<UserGorgeOrder> result = [];

      for (final orderMap in ordersData) {
        final orderId = orderMap['id'] as String;
        final orderDateStr = orderMap['order_date'] as String?;
        final orderDate =
            orderDateStr != null ? DateTime.parse(orderDateStr) : null;

        // ج) جيب عناصر الطلب
        final itemsData = await remoteDataSource.getOrderItems(orderId);

        // د) حولهم لـ List<UserOrderItemEntity> أو مباشرة List<UserInventoryEntity>
        final items = itemsData.map((itemMap) {
          final itemId = itemMap['id'] as String?;
          final quantity = itemMap['quantity'] as int;
          final itemName =
              itemMap['item_name'] as String; // اللي أضفته في order_items

          // هنا ممكن تستخدم UserOrderItemEntity أو لو عايز تعرضها في UI مباشرة
          // بس انت قلت هتستخدم UserInventoryEntity
          return UserGorgeOrditem(
            id: itemId, // أو itemMap['inventory_id'] لو عايز
            quantity: quantity, orderId: itemId!, itemName: itemName,
          );
        }).toList();

        // هـ) نبني الـ UserOrderDisplayEntity
        final orderEntity = UserGorgeOrder(
          orderId: orderId,
          clientId: userId,
          orderDate: orderDate,
          userName: userName,
          items: items,
        );
        result.add(orderEntity);
      }

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
