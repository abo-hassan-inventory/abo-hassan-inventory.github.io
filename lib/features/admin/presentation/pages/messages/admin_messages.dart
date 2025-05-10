import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/messages/sections/mainsection.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/messages/bloc/message_bloc.dart';
import 'package:inventory_project/features/user/util/widgets/snackbar/user_snackbar.dart';

class AdminMessages extends StatefulWidget {
  final String userid;
  const AdminMessages({super.key, required this.userid});

  @override
  State<AdminMessages> createState() => _AdminMessagesState();
}

class _AdminMessagesState extends State<AdminMessages> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageBloc>(context).add(StartListeningToMessages());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: C.primaryBackground,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: C.primaryBackground,
              centerTitle: true,
              title: Text(
                "الرسائل",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            body: BlocListener<MessageBloc, MessageState>(
              listener: (context, state) {
                if (state is MessageError) {
                  user_SnackBar(
                      context: context,
                      message: state.message,
                      backgroundColor: C.red);
                }
                if (state is MessageSent) {
                  print(
                      "==============>>message sent to group ${state.message}");
                }
              },
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        children: [
                          Mainsection(
                            user_id: widget.userid,
                          )
                        ],
                      ),
                    ),
                  )),
            )));
  }
}
