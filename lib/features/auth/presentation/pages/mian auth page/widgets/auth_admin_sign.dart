import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_bloc.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_event.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_state.dart';

class AuthAdminSign extends StatefulWidget {
  AuthAdminSign({super.key});

  @override
  State<AuthAdminSign> createState() => _AuthAdminSignState();
}

class _AuthAdminSignState extends State<AuthAdminSign> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'اسم المستخدم',
              labelStyle: Theme.of(context).textTheme.bodySmall,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.h),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodySmall,
              labelText: 'كلمة المرور',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const CircularProgressIndicator();
              }
              return GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(
                        LoginEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      );
                },
                child: Container(
                  width: 300.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: C.bluish),
                  child: Center(
                    child: Text(
                      "تسجيل الدخول",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: C.secondaryBackground),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
