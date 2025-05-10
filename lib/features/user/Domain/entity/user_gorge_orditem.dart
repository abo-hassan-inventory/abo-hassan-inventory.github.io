class UserGorgeOrditem {
  final String? id;
  final String orderId;
  final int quantity;
  final String itemName;

  const UserGorgeOrditem({
    this.id,
    required this.orderId,
    required this.quantity,
    required this.itemName,
  });
}
