import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/messages/widgets/admin_meassage_widget.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/messages/bloc/message_bloc.dart';

class AdminMessageBodySection extends StatelessWidget {
  final String user_id;
  const AdminMessageBodySection({super.key, required this.user_id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(builder: (context, state) {
      if (state is MessageLoading) {
        return Container(
            height: 580.h,
            child: const Center(child: CircularProgressIndicator()));
      }
      if (state is MessageLoaded) {
        if (state.messages.isEmpty) {
          return Center(
            child: Text("لا يوجد رسائل حتي الان",
                style: Theme.of(context).textTheme.displayLarge),
          );
        } else if (state.messages.isNotEmpty) {
          return Container(
            height: 580.h,
            child: ListView.builder(
                reverse: true,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    sender: state.messages[index].senderName,
                    message: state.messages[index].text,
                    date: state.messages[index].createdAt.toString(),
                    isMe: user_id == state.messages[index].senderId
                        ? true
                        : false,
                  );
                }),
          );
        }
      }
      if (state is MessageInitial) {
        return Container(
          color: C.primaryBackground,
          height: 600.h,
          child: Center(
            child: Text("لا تقلق فقط قم باعادة تشغيل البرناامج",
                style: Theme.of(context).textTheme.displayLarge),
          ),
        );
      }
      return Container(
        color: C.primaryBackground,
        height: 600.h,
        child: Text("لا  قم باعادة تشغيل البرناامج",
            style: Theme.of(context).textTheme.displayLarge),
      );
    });
  }
}
