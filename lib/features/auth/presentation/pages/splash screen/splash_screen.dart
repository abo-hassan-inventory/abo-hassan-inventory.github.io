import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/features/admin/wrapper/admin/wrapper_navigation.dart';
import 'package:inventory_project/features/auth/presentation/pages/mian%20auth%20page/main_auth_page.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_bloc.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_event.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_state.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/wrapper/user_wrapper_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(checkAuthstate());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          print(
              "==========================user is logged in and his name is  ${state.user.name} ============================");
          if (state.user.role == "admin") {
            print(
                "========client is found  and his name is :${state.user.name} >> his role :${state.user.role}  >>>navigate to admin panel ============================");
            await Future.delayed(Duration(seconds: 3), () {});

            Navigator.pushReplacement(
                (context),
                MaterialPageRoute(
                    builder: (context) => WrapperNavigation(
                          userid: state.user.id,
                        )));
          } else {
            if (state.user.role == "user") {
              print(
                  "========client is found  and his name is :${state.user.name} >> his role :${state.user.role}  >>>navigate to user panel ============================");

              await Future.delayed(Duration(seconds: 3), () {});
              context.read<UserInventoryBloc>().add(GetInventory());
              Navigator.pushReplacement(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => UserWrapperNavigation(
                            user_id: state.user.id,
                          )));
              context.read<UserInventoryBloc>().add(GetInventory());
            }
          }
        }
        if (state is AuthLoading) {}
        if (state is unauthenticated) {
          print(
              "===============the suer is not logged in ============================");
          await Future.delayed(Duration(seconds: 3), () {});
          // if ther is no current session go to login
          Navigator.pushReplacement((context),
              MaterialPageRoute(builder: (context) => MainAuthPage()));
        }
        if (state is AuthFailure) {
          print(
              "========================== somthing went wrong on cheking for the user and he is not logged in ============================");
          print(
              "that somthing is  ${state.message} ============================");
          await Future.delayed(Duration(seconds: 3), () {});

          Navigator.pushReplacement((context),
              MaterialPageRoute(builder: (context) => MainAuthPage()));
        }
      },
      builder: (context, state) {
        return Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/assets/images/8.png"))),
            child: Center(
              child: Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/assets/images/7.png"))),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: Offset(1.0, 1.0),
                    end: Offset(1.2, 1.2),
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  ),
            ));
      },
    );
  }
}
