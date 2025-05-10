// ignore_for_file: unnecessary_type_check

import 'package:dartz/dartz.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class userInventoryRemoteDataSource {
  Future<Either<String, List<UserInventoryEntity>>> getInventory();
  Stream<List<UserInventoryEntity>> listenToInventoryChanges();
  Future<void> confirmOrder(
      String clientId, List<UserInventoryEntity> tempList);
}

class UserInventoryRemote implements userInventoryRemoteDataSource {
  final SupabaseClient supabase;

  UserInventoryRemote(this.supabase);
  @override
  Stream<List<UserInventoryEntity>> listenToInventoryChanges() {
    return supabase.from('inventory').stream(primaryKey: ['id']).map(
      (data) => data.map((item) => UserInventoryEntity.fromMap(item)).toList(),
    );
  }

  @override
  Future<Either<String, List<UserInventoryEntity>>> getInventory() async {
    try {
      final response = await supabase.from('inventory').select();
      final data = response as List;
      return Right(data.map((e) => UserInventoryEntity.fromMap(e)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> confirmOrder(
      String clientId, List<UserInventoryEntity> tempList) async {
    try {
      // 1) تحديث المخزون
      for (final item in tempList) {
        // أ) نجيب الكمية الحالية من الـ inventory
        final data = await supabase
            .from('inventory')
            .select('quantity') // حدد الأعمدة المطلوبة
            .eq('id', item.id!) // item.id! لو واثق إنها مش null
            .maybeSingle(); // بيرجع Map أو null

        if (data == null) {
          throw Exception(
              "لم يتم العثور على المنتج في جدول inventory للعنصر: ${item.name}");
        }

        final oldQty = data['quantity'] as int;
        final newQty = oldQty - item.quantity;
        if (newQty < 0) {
          throw Exception(
              "الكمية المطلوبة أكتر من المتاحة للعنصر: ${item.id!}");
        }

        // ب) نعمل update للكمية الجديدة
        await supabase
            .from('inventory')
            .update({'quantity': newQty}).eq('id', item.id!);
      }
      print("===================>order items was updated in supabase");

      // 2) إنشاء الطلب في جدول orders
      // التاريخ (order_date) بيتحدد تلقائيًا في Supabase
      final insertedOrder = await supabase
          .from('orders')
          .insert({
            'client_id': clientId,
            // مش هنضيف order_date لأن Supabase بيتولاه
          })
          .select()
          .single();

      final orderId = insertedOrder['id'] as String;
      print("===========>> got the oredr id and its $orderId");

      // 3) إضافة العناصر للـ order_items
      final orderItems = tempList
          .map((item) => {
                'order_id': orderId,
                'item_name': item.name,
                'inventory_id': item.id!,
                'quantity': item.quantity,
              })
          .toList();

      await supabase.from('order_items').insert(orderItems);

      print("===================>order items was inserted in supabase");
    } catch (e) {
      throw Exception("حصل خطأ أثناء تأكيد الطلب: $e");
    }
  }

  Future<String?> getUserName(String userId) async {
    final response = await supabase
        .from('clients')
        .select('name')
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return null;
    return response['name'] as String?;
  }

  Future<List<Map<String, dynamic>>> getOrdersByUser(String userId) async {
    final response =
        await supabase.from('orders').select('*').eq('client_id', userId);

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    throw Exception("فشل جلب الطلبات للمستخدم $userId");
  }

  Future<List<Map<String, dynamic>>> getOrderItems(String orderId) async {
    final response =
        await supabase.from('order_items').select('*').eq('order_id', orderId);

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    }
    throw Exception("فشل جلب عناصر الطلب للطلب $orderId");
  }
}
