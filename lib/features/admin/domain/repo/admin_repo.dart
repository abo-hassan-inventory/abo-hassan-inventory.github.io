import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_inventory_entity.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_display_entity.dart';

import '../entiti/analysis/UserOrdersSummaryEntity.dart';
import '../entiti/message_entity.dart';
import '../entiti/user_monthly_orders_entity.dart';

///      the main repo that will be implemented in the date implementation
// have all the methodes that i need to implement
abstract class AdminRepository {
  Stream<Either<Failure, List<InventoryEntity>>> listenToInventoryChanges();
  Future<Either<Failure, void>> addProduct(InventoryEntity product);
  Future<Either<Failure, void>> updateProduct(InventoryEntity product);
  Future<Either<Failure, void>> deleteProduct(String productId);
  Future<Either<Failure, List<AdminOrderDisplayEntity>>> getAllOrders();
  Future<Either<Failure, void>> deleteOrder(String orderId);
  Stream<Either<Failure, List<MessageEntity>>> listenToMessages();
  Future<Either<Failure, void>> sendMessage(String senderId, String text);
  Future<Either<Failure, List<UserMonthlyOrdersEntity>>> getOrdersPerMonth();
  Future<Either<Failure, List<InventoryEntity>>> getInventory();

  Future<Either<Failure, List<UserOrdersSummaryEntity>>>
      getAllUsersOrdersSummary();

  Future<Either<Failure, void>> confirmUserOrders(String userId);
}
