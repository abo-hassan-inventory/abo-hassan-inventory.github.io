import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/messages/sections/admin_message_body_section.dart';
import 'package:inventory_project/features/admin/presentation/pages/messages/sections/admin_message_sendMessage_section.dart';

class Mainsection extends StatelessWidget {
  final String user_id;
  const Mainsection({super.key, required this.user_id});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: C.primaryBackground,
      child: Column(
        children: [
          AdminMessageBodySection(user_id: user_id),
          SizedBox(
            height: 10.h,
          ),
          AdminMessageSendmessageSection(
            user_id: user_id,
          )
        ],
      ),
    );
  }
}
