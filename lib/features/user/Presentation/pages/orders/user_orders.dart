import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/pages/orders/sections/user_orders_butons_section.dart';
import 'package:inventory_project/features/user/Presentation/pages/orders/sections/user_orders_tabel_section.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_orders_bloc/bloc/user_order_bloc.dart';
import 'package:inventory_project/features/user/util/widgets/snackbar/user_snackbar.dart';

// fix appbar navigation later --------------------------------------------------------------
/////////////////
class UserOrders extends StatelessWidget {
  const UserOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserOrderBloc, UserOrderState>(
          listener: (context, state) {
            if (state is dexter) {
              context.read<UserInventoryBloc>().add(GetInventory());
            }
          },
        ),
      ],
      child: BlocListener<UserOrderBloc, UserOrderState>(
          listener: (context, state) {
            if (state is user_order_temp_list_error) {
              print("=========================the error is ${state.message}");
              user_SnackBar(
                  context: context,
                  message: state.message,
                  backgroundColor: C.red);
            }
            if (state is orederitemdeltedsucessfuly) {
              user_SnackBar(
                  context: context,
                  message: state.message,
                  backgroundColor: C.green);
            }
          },
          child: SafeArea(
              child: Scaffold(
            backgroundColor: C.primaryBackground,
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: C.primaryBackground,
              centerTitle: true,
              title: Text(
                "قائمة الطلبات",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            body: BlocBuilder<UserOrderBloc, UserOrderState>(
              builder: (context, state) {
                if (state is UserOrderInitial) {
                  return Center(
                    child: Text(
                        "لا يوجد طلبات حتي الان قم باضافة بعض الطلبات لتظهر هنا"),
                  );
                }
                if (state is user_order_temp_list_loaded) {
                  if (state.templist.isEmpty) {
                    return Center(
                      child: Text(
                          "لا يوجد طلبات حتي الان قم باضافة بعض الطلبات لتظهر هنا"),
                    );
                  } else if (state.templist.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            UserOrdersTabelSection(),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: UserOrdersButonsSection()),
                          ],
                        ),
                      )),
                    );
                  }
                }
                if (state is user_order_temp_list_loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Center(
                  child: Text("dont worry try adding some orders"),
                );
              },
            ),
          ))),
    );
  }
}
