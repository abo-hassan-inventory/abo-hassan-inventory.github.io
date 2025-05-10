import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_bloc.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_event.dart';
import 'package:inventory_project/features/auth/presentation/stateManegment/auth_state.dart';

class UserHomeHeaderSection extends StatelessWidget {
  const UserHomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    String Date = DateFormat('dd/MM/yyyy').format(DateTime.now());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Stack(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    child: IconButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        icon: Icon(
                          Icons.logout,
                          color: C.red,
                        )),
                  )),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25.h),
                    Text("اهلا  ${state.user.name}, ",
                        style: Theme.of(context).textTheme.displayLarge),
                    Text(
                      Date,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 10, color: C.grey),
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
