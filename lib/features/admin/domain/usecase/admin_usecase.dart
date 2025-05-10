import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/admin/data/repo/admin_repository_impl.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_inventory_entity.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_display_entity.dart';

import '../entiti/analysis/UserOrdersSummaryEntity.dart';
import '../entiti/message_entity.dart';
import '../entiti/user_monthly_orders_entity.dart';

class AdminUsecase {
  final AdminRepositoryImpl repository;
  AdminUsecase(this.repository);

  Stream<Either<Failure, List<InventoryEntity>>> listenToInventoryChanges() {
    return repository.listenToInventoryChanges();
  }

  Future<Either<Failure, void>> addProduct(InventoryEntity product) async {
    return repository.addProduct(product);
  }

  Future<Either<Failure, void>> updateProduct(InventoryEntity product) async {
    return repository.updateProduct(product);
  }

  Future<Either<Failure, void>> deleteProduct(String productId) async {
    return repository.deleteProduct(productId);
  }

  Future<Either<Failure, List<AdminOrderDisplayEntity>>> getAllOrders() {
    return repository.getAllOrders();
  }

  Future<Either<Failure, void>> deleteOrder(String orderId) {
    return repository.deleteOrder(orderId);
  }

  Stream<Either<Failure, List<MessageEntity>>> listenToMessages() {
    return repository.listenToMessages();
  }

  Future<Either<Failure, void>> sendMessage(String senderId, String text) {
    return repository.sendMessage(senderId, text);
  }

  Future<Either<Failure, List<UserMonthlyOrdersEntity>>> getOrdersPerMonth() {
    return repository.getOrdersPerMonth();
  }

  Future<Either<Failure, List<InventoryEntity>>> getInventory() async {
    return await repository.getInventory();
  }

  Future<Either<Failure, List<UserOrdersSummaryEntity>>>
      GetAllUsersOrdersSummary() {
    return repository.getAllUsersOrdersSummary();
  }

  Future<Either<Failure, void>> ConfirmUserOrders(String userId) {
    return repository.confirmUserOrders(userId);
  }
}
