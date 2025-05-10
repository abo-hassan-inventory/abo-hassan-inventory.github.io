import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';

// this is the messages page later to be alterd eather to use one or more customs as you whant
class UserMessage extends StatelessWidget {
  const UserMessage({super.key});

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
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [],
                    ),
                  ),
                ))));
  }
}
