// ignore_for_file: unnecessary_type_check

import 'package:dartz/dartz.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_inventory_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/entiti/message_entity.dart';

// what is donehere is seperation of concerns
abstract class AdminRemoteDataSource {
  Stream<List<InventoryEntity>> listenToInventoryChanges();
  Future<void> addProduct(InventoryEntity product);
  Future<void> updateProduct(InventoryEntity product);
  Future<void> deleteProduct(String productId);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final SupabaseClient supabase;

  AdminRemoteDataSourceImpl({required this.supabase});

  @override
  // this methodes lisents to all the changes done on the tabel by the predefiend trigers that i did in the supabase
  Stream<List<InventoryEntity>> listenToInventoryChanges() {
    return supabase.from('inventory').stream(primaryKey: ['id']).map(
        (data) => data.map((item) => InventoryEntity.fromMap(item)).toList());
  }

  @override
  // this methode is for the adding part each product has a uiud uniq id in the supabase so we dont send the id insted we get it from it
  Future<void> addProduct(InventoryEntity product) async {
    await supabase.from('inventory').insert(product.toMap());
  }

// same here we get the id from the supabase and update the product and we dont send the id insted we get it from it
  @override
  Future<void> updateProduct(InventoryEntity product) async {
    if (product.id == null) {
      throw Exception('Cannot update a product without an ID.');
    }
    await supabase
        .from('inventory')
        .update(product.toMap())
        .eq('id', product.id!);
  }

// here we olready have the id so we simply delete the product
  @override
  Future<void> deleteProduct(String productId) async {
    await supabase.from('inventory').delete().eq('id', productId);
  }

  Future<String?> getUserName(String userId) async {
    try {
      final result = await supabase
          .from('clients')
          .select('name')
          .eq('id', userId)
          .maybeSingle();

      if (result == null) {
        throw Exception("User not found in clients table for id: $userId");
      }
      return result['name'] as String?;
    } catch (e) {
      print("AuthRemoteDataSource.getUserData: Error fetching user data - $e");
      throw Exception("Error fetching user data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final response =
        await supabase.from('orders').select('*'); // نجيب كل الطلبات

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    throw Exception("فشل جلب الطلبات");
  }

  Future<List<Map<String, dynamic>>> getOrderItems(String orderId) async {
    final response =
        await supabase.from('order_items').select('*').eq('order_id', orderId);

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    throw Exception("فشل جلب عناصر الطلب للطلب $orderId");
  }

  Future<void> deleteOrder(String orderId) async {
    print(
        " the data source order id that got till here is this ==================<<<<< $orderId");
    try {
      await supabase.from('orders').delete().eq('id', orderId);
    } catch (e) {
      throw Exception("فشل حذف الطلب: $e");
    }
  }

  Stream<Either<Failure, List<MessageEntity>>> listenToMessages() {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map<Either<Failure, List<MessageEntity>>>((data) {
          try {
            final messages = data.map((row) {
              return MessageEntity(
                id: row['id'] as String,
                senderId: row['sender_id'] as String,
                senderName: row['sender_name'] as String,
                text: row['text'] as String,
                createdAt: DateTime.parse(row['created_at'] as String),
              );
            }).toList();
            return Right(messages);
          } catch (e) {
            return Left(Failure(e.toString()));
          }
        })
        .handleError((error) {
          // لو حصل خطأ في الـ stream نفسه
          return Left(Failure(error.toString()));
        });
  }

  Future<Either<Failure, void>> sendMessage(
      String senderId, String text) async {
    try {
      // جيب اسم المرسل (لو عندك جدول clients)
      final userName = await getUserName(senderId) ?? "Unknown User";

      // أضف صف في جدول messages
      await supabase.from('messages').insert({
        'sender_id': senderId,
        'sender_name': userName,
        'text': text,
        // created_at يتم تلقائياً من Supabase
      });

      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> getOrdersPerMonthRaw() async {
    final response = await supabase.rpc('get_orders_per_month');
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    } else {
      throw Exception("فشل جلب البيانات من get_orders_per_month");
    }
  }

  Future<Either<String, List<InventoryEntity>>> getInventory() async {
    try {
      final response = await supabase.from('inventory').select();
      final data = response as List;
      return Right(data.map((e) => InventoryEntity.fromMap(e)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAllOrdersSummaryRaw() async {
    final response = await supabase.rpc('get_all_users_orders_summary');
    // أو ممكن تعمل select/group if you prefer
    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    } else {
      throw Exception("فشل جلب ملخص الطلبات للمستخدمين");
    }
  }

  /// تحذف كل الطلبات الخاصة بالمستخدم (userId) من جداول orders و order_items
  Future<void> confirmUserOrders(String userId) async {
    // 1) نحذف من order_items باستخدام Subselect أو طريقتين
    //    أ) جلب order_ids أولًا ثم الحذف
    //    ب) أو إن كان Supabase يسمح بـ in('order_id', subquery)
    // الأسهل غالبًا: نجلب الـ orderIds، ثم نحذف بها

    // جلب كل أوامر المستخدم
    final ordersResponse =
        await supabase.from('orders').select('id').eq('client_id', userId);

    if (ordersResponse is List) {
      final orderIds =
          ordersResponse.map((row) => row['id'] as String).toList();

      if (orderIds.isNotEmpty) {
        // نحذف من order_items this can be removed if the orders are deleted from the orders effict the items list
        // await supabase.from('order_items').delete().eq('order_id', orderIds);

        // 2) نحذف من orders
        await supabase.from('orders').delete().eq('client_id', userId);
      } else {
        // مافيش أوامر أصلًا
        return;
      }
    } else {
      throw Exception("فشل جلب أوامر المستخدم");
    }
  }
}
