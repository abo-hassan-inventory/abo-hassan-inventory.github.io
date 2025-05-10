import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/user/Domain/entity/user_gorge_order.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';

abstract class UserInventoryRepository {
  Stream<Either<Failure, List<UserInventoryEntity>>> listenToInventoryChanges();

  Future<Either<Failure, List<UserInventoryEntity>>> getInventory();
  Future<Either<Failure, void>> confirmOrder(
      String clientId, List<UserInventoryEntity> tempList);
  Future<Either<Failure, List<UserGorgeOrder>>> getAllOrdersForUser(
      String userId);
}
