class UserOrderEntity {
  final String? id;
  final String clientId;
  final DateTime? orderDate; // تاريخ الطلب ممكن يبقى null لو لسه متخزنش في DB

  const UserOrderEntity({
    this.id,
    required this.clientId,
    this.orderDate,
  });

  /// تحويل من Map راجع من Supabase إلى UserOrderEntity
  factory UserOrderEntity.fromMap(Map<String, dynamic> map) {
    return UserOrderEntity(
      id: map['id'] as String?,
      clientId: map['client_id'] as String,
      // لو Supabase بيرجع order_date كـ null أو مش موجود، خليها null
      orderDate:
          map['order_date'] != null ? DateTime.parse(map['order_date']) : null,
    );
  }

  /// تحويل من UserOrderEntity إلى Map (لما نعمل insert في Supabase)
  Map<String, dynamic> toMap() {
    final map = {
      'client_id': clientId,
      // مش هنضيف order_date لأن Supabase هيتكفل بيه تلقائيًا
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }
}
