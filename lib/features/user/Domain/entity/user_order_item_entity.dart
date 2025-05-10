class UserOrderItemEntity {
  final String? id;
  final String orderId;
  final String inventoryId;
  final int quantity;

  const UserOrderItemEntity({
    this.id,
    required this.orderId,
    required this.inventoryId,
    required this.quantity,
  });

  factory UserOrderItemEntity.fromMap(Map<String, dynamic> map) {
    return UserOrderItemEntity(
      id: map['id'] as String?,
      orderId: map['order_id'] as String,
      inventoryId: map['inventory_id'] as String,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'order_id': orderId,
      'inventory_id': inventoryId,
      'quantity': quantity,
    };
    if (id != null) map['id'] = id!;
    return map;
  }
}
