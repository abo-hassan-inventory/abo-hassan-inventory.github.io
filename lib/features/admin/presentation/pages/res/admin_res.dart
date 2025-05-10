import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/res/sections/admin_res_body_section.dart';
import 'package:inventory_project/features/user/util/widgets/snackbar/user_snackbar.dart';

import '../../state manegment/res/admin_res_bloc.dart';

//  res stands for reservations
class AdminRes extends StatelessWidget {
  const AdminRes({super.key});

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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              context.read<AdminResBloc>().add(GetAllOrders());
            },
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: BlocListener<AdminResBloc, AdminResState>(
              listener: (context, state) {
                if (state is adminResError) {
                  user_SnackBar(
                      context: context,
                      message: state.message,
                      backgroundColor: C.red);
                }
                if (state is adminResSuccess) {
                  user_SnackBar(
                      context: context,
                      message: state.message,
                      backgroundColor: C.green);
                }
              },
              child: AdminResBodySection(),
            ),
          )),
    ));
  }
}
