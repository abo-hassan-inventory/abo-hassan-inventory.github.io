// data/repositories/admin_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/admin/data/data_source/admin_remote_data_source.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_inventory_entity.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_display_entity.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_item_entity.dart';
import 'package:inventory_project/features/admin/domain/entiti/analysis/UserOrdersSummaryEntity.dart';
import 'package:inventory_project/features/admin/domain/entiti/message_entity.dart';
import 'package:inventory_project/features/admin/domain/entiti/user_monthly_orders_entity.dart';
import 'package:inventory_project/features/admin/domain/repo/admin_repo.dart';

import '../../domain/entiti/analysis/ItemSummaryEntity.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSourceImpl remoteDataSource;

  AdminRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<InventoryEntity>>> listenToInventoryChanges() {
    return remoteDataSource.listenToInventoryChanges().map((data) {
      try {
        return Right(data);
      } catch (e) {
        return Left(Failure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> addProduct(InventoryEntity product) async {
    try {
      await remoteDataSource.addProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(InventoryEntity product) async {
    try {
      await remoteDataSource.updateProduct(product);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      await remoteDataSource.deleteProduct(productId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminOrderDisplayEntity>>> getAllOrders() async {
    try {
      // أ) نجيب كل الطلبات
      final ordersData = await remoteDataSource.getAllOrders();

      final List<AdminOrderDisplayEntity> result = [];

      for (final orderMap in ordersData) {
        final orderId = orderMap['id'] as String;
        final clientId = orderMap['client_id'] as String?;
        final orderDateStr = orderMap['order_date'] as String?;
        final orderDate =
            orderDateStr != null ? DateTime.parse(orderDateStr) : null;

        // ب) جيب اسم المستخدم
        String userName = "Unknown User";
        if (clientId != null) {
          print("the id is =========================<<<<< $clientId");
          final name = await remoteDataSource.getUserName(clientId);
          print(" the user name is =====================<<<<< $name");
          userName = name ?? "Unknown User";
        }

        // ج) جيب عناصر الطلب
        final itemsData = await remoteDataSource.getOrderItems(orderId);

        final items = itemsData.map((itemMap) {
          final itemId = itemMap['id'] as String?;
          final quantity = itemMap['quantity'] as int;
          final itemName = itemMap['item_name'] as String; // العمود اللي ضفته

          return AdminInventoryEntity(
            id: itemId,
            name: itemName,
            quantity: quantity,
          );
        }).toList();

        // د) بناء الـ Entity النهائي
        final orderEntity = AdminOrderDisplayEntity(
          orderId: orderId,
          clientId: clientId,
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

  @override
  Future<Either<Failure, void>> deleteOrder(String orderId) async {
    try {
      await remoteDataSource.deleteOrder(orderId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> listenToMessages() {
    return remoteDataSource.listenToMessages();
  }

  @override
  Future<Either<Failure, void>> sendMessage(String senderId, String text) {
    return remoteDataSource.sendMessage(senderId, text);
  }

  @override
  Future<Either<Failure, List<UserMonthlyOrdersEntity>>>
      getOrdersPerMonth() async {
    try {
      // 1) استدعاء الـ RPC function
      final rawData = await remoteDataSource.getOrdersPerMonthRaw();

      final List<UserMonthlyOrdersEntity> result = [];

      // 2) لف على كل صف من النتيجة
      for (final row in rawData) {
        final clientId = row['client_id'] as String;
        final monthStr = row['month_start'] as String?;
        final orderCount = row['order_count'] as int;

        // 3) جيب اسم المستخدم من جدول clients
        final userName =
            await remoteDataSource.getUserName(clientId) ?? "Unknown User";

        // 4) حول الشهر من نص لـ DateTime
        DateTime monthDate = DateTime.now();
        if (monthStr != null) {
          monthDate = DateTime.parse(monthStr);
        }

        // 5) بناء الـ Entity
        result.add(UserMonthlyOrdersEntity(
          clientId: clientId,
          userName: userName,
          monthStart: monthDate,
          orderCount: orderCount,
        ));
      }

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InventoryEntity>>> getInventory() async {
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
  Future<Either<Failure, List<UserOrdersSummaryEntity>>>
      getAllUsersOrdersSummary() async {
    try {
      // استدعاء الدالة اللي بترجع الصفوف
      final rawData = await remoteDataSource.getAllOrdersSummaryRaw();

      // grouped هي خريطة client_id -> قائمة من الصفوف
      final Map<String, List<Map<String, dynamic>>> grouped = {};

      for (final row in rawData) {
        final clientId = row['client_id'] as String;
        grouped.putIfAbsent(clientId, () => []).add(row);
      }

      final List<UserOrdersSummaryEntity> result = [];

      // لف على كل userId
      grouped.forEach((clientId, rows) {
        // نفترض كل الصفوف نفس user_name, order_count
        final userName = rows.first['user_name'] as String;
        final orderCount = rows.first['order_count'] as int;

        // بناء قائمة items
        final items = rows.map((r) {
          final itemName = r['item_name'] as String;
          final totalQuantity = r['total_quantity'] as int;
          return ItemSummaryEntity(
            itemName: itemName,
            totalQuantity: totalQuantity,
          );
        }).toList();

        result.add(UserOrdersSummaryEntity(
          userId: clientId,
          userName: userName,
          orderCount: orderCount,
          items: items,
        ));
      });

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmUserOrders(String userId) async {
    try {
      await remoteDataSource.confirmUserOrders(userId);
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
