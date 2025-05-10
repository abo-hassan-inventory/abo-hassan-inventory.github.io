class InventoryEntity {
  final String? id; // Nullable لأن Supabase هي اللي بتولده
  final String name;
  final int quantity;

  const InventoryEntity({
    this.id, // ما نمرروش أثناء الإضافة، لكنه موجود عند الجلب
    required this.name,
    required this.quantity,
  });

  /// تحويل من `Map` إلى `InventoryEntity`
  factory InventoryEntity.fromMap(Map<String, dynamic> map) {
    return InventoryEntity(
      id: map['id'] as String?, // Nullable عشان ممكن يكون null في البداية
      name: map['name'] as String,
      quantity: map['quantity'] as int,
    );
  }

  /// تحويل من `InventoryEntity` إلى `Map`
  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'quantity': quantity,
    };

    if (id != null) {
      map['id'] = id!; // لو جاي من Supabase، نخليه موجود
    }

    return map;
  }
}

// this is the main model entity for each row in the tabel
