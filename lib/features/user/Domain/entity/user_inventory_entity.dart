class UserInventoryEntity {
  final String? id; // بتجيلك من Supabase تلقائي
  final String name;
  final int quantity;

  const UserInventoryEntity({
    this.id,
    required this.name,
    required this.quantity,
  });

  factory UserInventoryEntity.fromMap(Map<String, dynamic> map) {
    return UserInventoryEntity(
      id: map['id'] as String?,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'quantity': quantity,
    };
    if (id != null) map['id'] = id!;
    return map;
  }
}
