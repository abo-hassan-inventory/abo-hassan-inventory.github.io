import 'user_gorge_orditem.dart';

class UserGorgeOrder {
  final String orderId; // orders.id
  final String? clientId; // orders.client_id
  final DateTime? orderDate; // orders.order_date (لو عندك)
  final String userName; // اسم المستخدم (من جدول clients)
  final List<UserGorgeOrditem> items;

  const UserGorgeOrder({
    required this.orderId,
    this.clientId,
    this.orderDate,
    required this.userName,
    required this.items,
  });
}
