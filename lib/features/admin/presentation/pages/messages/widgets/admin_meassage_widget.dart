import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_project/core/theme/C.dart';

class MessageBubble extends StatelessWidget {
  final String sender;
  final String message;
  final String date;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.sender,
    required this.message,
    required this.date,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          if (!isMe)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                sender,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          Container(
            constraints: const BoxConstraints(maxWidth: 300),
            decoration: BoxDecoration(
              color: isMe ? const Color.fromARGB(255, 95, 98, 122) : C.blue3,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft:
                    isMe ? const Radius.circular(4) : const Radius.circular(20),
                bottomRight:
                    isMe ? const Radius.circular(20) : const Radius.circular(4),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat(
                        'EEE, MMM d, yyyy hh:mm a',
                      ).format(DateTime.parse(date)),
                      style: TextStyle(
                        color: isMe
                            ? Colors.white70
                            : Color.fromARGB(255, 71, 72, 83),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (isMe)
                      const Icon(
                        Icons.done_all,
                        size: 14,
                        color: Colors.white70,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
