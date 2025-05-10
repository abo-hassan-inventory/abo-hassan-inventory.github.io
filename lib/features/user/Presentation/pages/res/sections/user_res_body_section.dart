import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/features/user/Presentation/pages/res/widgets/user_resc_ard_widget.dart';

import '../../../state manegment/user_reservations_bloc/res_bloc.dart';

class UserResBodySection extends StatelessWidget {
  const UserResBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResBloc, ResState>(
      builder: (context, state) {
        if (state is resLoading) {
          return CircularProgressIndicator();
        }
        if (state is resLoaded) {
          if (state.ordersList.isEmpty) {
            return Container(
              child: Center(
                child: Text(
                  "لا يوجد حجوزات",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            );
          } else if (state.ordersList.isNotEmpty) {
            return Container(
                padding: EdgeInsets.all(0.h),
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return UserRescArdWidget(
                        name: state.ordersList[index].userName,
                        date: state.ordersList[index].orderDate!,
                        total_items: state.ordersList[index].items.length,
                        items: state.ordersList[index].items,
                      );
                    },
                    itemCount: state.ordersList.length));
          }
        }
        if (state is ResInitial) {
          return Container(
            child: Center(
              child: Text("simpel error just try to refresh the app"),
            ),
          );
        }
        return Container(
          child: Text("unkown error has happend please try again later"),
        );
      },
    );
  }
}
