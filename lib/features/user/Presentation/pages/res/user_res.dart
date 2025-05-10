import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/pages/res/sections/user_res_body_section.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_reservations_bloc/res_bloc.dart';

import '../../../util/widgets/snackbar/user_snackbar.dart';

class UserRes extends StatefulWidget {
  final String userId;
  const UserRes({super.key, required this.userId});

  @override
  State<UserRes> createState() => _UserResState();
}

class _UserResState extends State<UserRes> {
  @override
  void initState() {
    context.read<ResBloc>().add(GetReservations(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: C.primaryBackground,
      appBar: AppBar(
        backgroundColor: C.primaryBackground,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "الحجوزات",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
              child: BlocListener<ResBloc, ResState>(
            listener: (context, state) {
              if (state is resError) {
                user_SnackBar(
                    context: context,
                    message: state.message,
                    backgroundColor: C.red);
              }

              if (state is resSuccess) {
                user_SnackBar(
                    context: context,
                    message: state.message,
                    backgroundColor: C.green);
              }
            },
            child: UserResBodySection(),
          ))),
    ));
  }
}
