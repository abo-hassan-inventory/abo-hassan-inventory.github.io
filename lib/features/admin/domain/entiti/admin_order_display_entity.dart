import 'admin_order_item_entity.dart';

class AdminOrderDisplayEntity {
  final String orderId; // رقم الطلب (orders.id)
  final String? clientId; // معرف العميل (لو حابب تخزنه)
  final DateTime?
      orderDate; // تاريخ الطلب (ممكن يكون null لو Supabase بيضيفه تلقائي)
  final String userName; // اسم المستخدم (جاي من clients)
  final List<AdminInventoryEntity> items; // قائمة العناصر في الطلب

  const AdminOrderDisplayEntity({
    required this.orderId,
    this.clientId,
    this.orderDate,
    required this.userName,
    required this.items,
  });
}
