import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Domain/entity/user_gorge_orditem.dart';

import 'sections/user_res_detailed_tabel.dart';

class UserResDetailed extends StatelessWidget {
  final int total_count;
  final String date;
  final List<UserGorgeOrditem> itemss;
  final String name;

  const UserResDetailed(
      {super.key,
      required this.total_count,
      required this.date,
      required this.itemss,
      required this.name});

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
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                UserResDetailedTabel(
                  total_count: total_count,
                  date: date,
                  itemss: itemss,
                ),
              ],
            ),
          )),
    ));
  }
}
