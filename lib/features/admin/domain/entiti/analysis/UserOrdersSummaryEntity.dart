import 'ItemSummaryEntity.dart';

class UserOrdersSummaryEntity {
  final String userId;
  final String userName;
  final int orderCount;
  final List<ItemSummaryEntity> items;

  const UserOrdersSummaryEntity({
    required this.userId,
    required this.userName,
    required this.orderCount,
    required this.items,
  });
}
