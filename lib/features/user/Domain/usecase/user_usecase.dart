import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/user/Data/repo/user_inventory_repo_impl.dart';
import 'package:inventory_project/features/user/Domain/entity/user_gorge_order.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';

class UserUsecase {
  final UserInventoryRepoImpl repo;

  UserUsecase(this.repo);

  Future<Either<Failure, List<UserInventoryEntity>>> getInventory() async {
    return await repo.getInventory();
  }

  Stream<Either<Failure, List<UserInventoryEntity>>>
      listenToInventoryChanges() {
    return repo.listenToInventoryChanges();
  }

  Future<Either<Failure, void>> ConfirmOrder(
      String clientId, List<UserInventoryEntity> tempList) {
    return repo.confirmOrder(clientId, tempList);
  }

  Future<Either<Failure, List<UserGorgeOrder>>> getAllOrdersForUser(
      String userId) {
    return repo.getAllOrdersForUser(userId);
  }
}
