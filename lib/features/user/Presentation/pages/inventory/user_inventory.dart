import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/pages/inventory/sections/user_inventory_tabel_section.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/util/widgets/snackbar/user_snackbar.dart';

class UserInventory extends StatelessWidget {
  const UserInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: C.primaryBackground,
          appBar: AppBar(
            backgroundColor: C.primaryBackground,
            centerTitle: true,
            title: Text(
              "المخزون",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // the search methods
                  // UserInventorySearchSection(),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocListener<UserInventoryBloc, UserInventoryState>(
                    listener: (context, state) {
                      if (state is user_updated_successfully) {
                        user_SnackBar(
                            context: context,
                            message: state.message,
                            backgroundColor: C.green);
                        if (state is user_inventoryError) {
                          user_SnackBar(
                              context: context,
                              message: state.message,
                              backgroundColor: C.red);
                        }
                      }
                    },
                    child: UserInventoryTabelSection(),
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
