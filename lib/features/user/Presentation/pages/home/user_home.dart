import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/auth/presentation/pages/mian%20auth%20page/main_auth_page.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_bloc.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_state.dart';
import 'package:inventory_project/features/user/Presentation/pages/home/sections/user_home_body_section.dart';
import 'package:inventory_project/features/user/Presentation/pages/home/sections/user_home_header_section.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // log  to the auth page if the user is loged out with sucess
        if (state is AuthLoggedOut) {
          Navigator.pushReplacement((context),
              MaterialPageRoute(builder: (context) => MainAuthPage()));
          // show the error in a snack bar if there is any
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: C.primaryBackground,
              body: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UserHomeHeaderSection(),
                        UserHomeBodySection(),
                      ]),
                ),
              ))),
    );
  }
}
