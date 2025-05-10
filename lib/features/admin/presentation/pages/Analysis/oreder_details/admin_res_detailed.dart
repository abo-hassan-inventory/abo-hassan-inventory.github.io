import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_item_entity.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/analysis_bloc/roro/bloc/orderssummary_bloc.dart';

import '../../../../domain/entiti/analysis/ItemSummaryEntity.dart';
import 'sections/admin_res_detailed_tabel.dart';

class AdminroroDetailed extends StatelessWidget {
  final int total_count;

  final List<ItemSummaryEntity> itemss;
  final String name;
  final String userId;

  const AdminroroDetailed(
      {super.key,
      required this.total_count,
      required this.itemss,
      required this.name,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    if (itemss.isEmpty) {
      return Center(
        child: Text("لا يوجد حجوزات"),
      );
    } else if (itemss.isNotEmpty) {
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
                  AdminroroDetailedTabel(
                    total_count: total_count,
                    itemss: itemss,
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<OrdersSummaryBloc>()
                          .add(ConfirmUserOrdersEvent(userId));
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      height: 75.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: C.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("تاكيد الطلبات",
                            style: Theme.of(context).textTheme.displayLarge),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ));
    }
    return Center(
      child: Text("حدث خطا ما لا تقلق قم باعادة تشغيل البرنامج"),
    );
  }
}
