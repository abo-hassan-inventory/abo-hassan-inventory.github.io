import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_item_entity.dart';
import 'package:inventory_project/features/admin/presentation/pages/res/oreder_details/sections/admin_res_detailed_tabel.dart';

class AdminResDetailed extends StatelessWidget {
  final int total_count;
  final String date;
  final List<AdminInventoryEntity> itemss;
  final String name;

  const AdminResDetailed(
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
                AdminResDetailedTabel(
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
