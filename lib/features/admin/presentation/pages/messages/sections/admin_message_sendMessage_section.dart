import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/inventory/widgets/admin_inventory_textfeild_widget.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/messages/bloc/message_bloc.dart';

class AdminMessageSendmessageSection extends StatefulWidget {
  final String user_id;
  const AdminMessageSendmessageSection({super.key, required this.user_id});

  @override
  State<AdminMessageSendmessageSection> createState() =>
      _AdminMessageSendmessageSectionState();
}

class _AdminMessageSendmessageSectionState
    extends State<AdminMessageSendmessageSection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: C.primaryBackground,
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Transform.rotate(
            angle: 3.14, // Rotate 180 degrees (pi radians)
            child: IconButton(
              icon: Icon(
                Icons.send_rounded,
                size: 30,
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context
                      .read<MessageBloc>()
                      .add(sendMessage(widget.user_id, _controller.text));
                  _controller.clear();
                  FocusScope.of(context).unfocus();
                }

                _controller.clear();
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Expanded(
            child: AdminInventoryTextfeildWidget(
              controller: _controller,
              label: 'اكتب رسالة...',
            ),
          ),
        ],
      ),
    );
  }
}
