class MessageEntity {
  final String id;
  final String senderId;
  final String senderName; // العمود الجديد
  final String text;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.createdAt,
  });
}
