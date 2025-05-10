import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_orders_bloc/bloc/user_order_bloc.dart';
import 'package:inventory_project/features/user/util/widgets/user_custom_button_type_shit.dart';

import '../../../../../auth/presentation/stateManegment/auth_bloc.dart';
import '../../../../../auth/presentation/stateManegment/auth_state.dart';
import '../../../state manegment/user_inventory_bloc/user_inventory_bloc.dart';

// later you add here the sucess after this button is pressed
class UserOrdersButonsSection extends StatelessWidget {
  const UserOrdersButonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserOrderBloc, UserOrderState>(
      builder: (context, state) {
        if (state is user_order_temp_list_loaded) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, auth) {
              if (auth is AuthSuccess) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserCustomButtonTypeShit(
                        name: "الغاء الطلب",
                        background: C.bluish,
                        onTap: () {
                          context.read<UserInventoryBloc>().add(
                              UpdateInventoryFromOrderList(state.templist));
                          print(
                              "==============>oreder items was updated in the inventory list ");
                          context.read<UserOrderBloc>().add(cancelOrder());
                          print(
                              "=============================oredr was cancelled============================");
                        }),
                    UserCustomButtonTypeShit(
                        name: "تاكيد الطلب",
                        background: C.green,
                        onTap: () {
                          print(
                              "the lsit is ${state.templist} and the user id is ${auth.user.id}");
                          context
                              .read<UserOrderBloc>()
                              .add(confirmOrder(auth.user.id, state.templist));
                        }),
                  ],
                );
              }
              return Center(
                child: Text(
                    "the error in here is becous the user is not loged in and some how there you are her logged in if that ever happend i fucked up"),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
