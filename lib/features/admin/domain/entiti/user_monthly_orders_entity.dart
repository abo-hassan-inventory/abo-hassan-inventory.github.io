class UserMonthlyOrdersEntity {
  final String clientId;
  final String userName;
  final DateTime monthStart;
  final int orderCount;

  const UserMonthlyOrdersEntity({
    required this.clientId,
    required this.userName,
    required this.monthStart,
    required this.orderCount,
  });
}
