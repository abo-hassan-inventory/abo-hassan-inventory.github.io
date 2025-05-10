import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/wrapper/admin/wrapper_navigation.dart';
import 'package:inventory_project/features/auth/presentation/pages/mian auth page/sections/auth_bar_section.dart';
import 'package:inventory_project/features/auth/presentation/pages/mian auth page/sections/auth_hader_section.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_bloc.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_state.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/wrapper/user_wrapper_navigation.dart';

class MainAuthPage extends StatelessWidget {
  const MainAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: C.authbackground,
        resizeToAvoidBottomInset:
            true, // Let the Scaffold adjust when the keyboard appears.
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              if (state.user.role == "admin") {
                Navigator.pushReplacement(
                    (context),
                    MaterialPageRoute(
                        builder: (context) => WrapperNavigation(
                              userid: state.user.id,
                            )));
              } else {
                if (state.user.role == "user") {
                  context.read<UserInventoryBloc>().add(GetInventory());
                  Navigator.pushReplacement(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => UserWrapperNavigation(
                                user_id: state.user.id,
                              )));
                }
              }
            } else if (state is AuthFailure) {
              Navigator.pop(context); // أقفل اللودينج
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints
                        .maxHeight, // Ensures content fills the screen.
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AuthHaderSection(),
                      AuthBarSection(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
