class AdminInventoryEntity {
  final String? id; // لو Supabase بينشئه تلقائيًا (UUID أو text)
  final String name; // اسم العنصر أو المنتج
  final int quantity; // الكمية

  const AdminInventoryEntity({
    this.id,
    required this.name,
    required this.quantity,
  });

  /// لو محتاج تعمل parsing من خريطة (Map) جاية من استعلام Supabase
  factory AdminInventoryEntity.fromMap(Map<String, dynamic> map) {
    return AdminInventoryEntity(
      id: map['id'] as String?,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
    );
  }

  /// لو محتاج تحول الـ Entity لـ Map عشان تبعت لـ Supabase
  Map<String, dynamic> toMap() {
    final map = {
      'name': name,
      'quantity': quantity,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }
}
