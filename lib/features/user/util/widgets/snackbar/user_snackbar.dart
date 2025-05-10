import 'package:flutter/material.dart';

void user_SnackBar({
  required BuildContext context,
  required String message,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top +
            20, // مسافة من أعلى الشاشة، ممكن تعدلها حسب احتياجك
        left: 10,
        right: 10,
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 2),
    ),
  );
}
