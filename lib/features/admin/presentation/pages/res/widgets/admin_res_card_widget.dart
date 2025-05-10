import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_order_item_entity.dart';
import 'package:inventory_project/features/admin/presentation/pages/res/oreder_details/admin_res_detailed.dart';

import '../../../../util/admin/admin_alets.dart';

class AdminResCardWidget extends StatelessWidget {
  final String order_id;
  final String name;
  final DateTime date;
  final int total_items;
  final List<AdminInventoryEntity> items;

  const AdminResCardWidget({
    super.key,
    required this.name,
    required this.date,
    required this.total_items,
    required this.items,
    required this.order_id,
  });

  @override
  Widget build(BuildContext context) {
    //------------replace later with the acual dates

    final String formattedDate = DateFormat('MM/dd/yyyy hh:mm a').format(date);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminResDetailed(
                  name: name,
                  total_count: total_items,
                  date: formattedDate,
                  itemss: items,
                )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
        height: 120.h,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], color: C.blue, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //--------------------------------fix splach ribbel type shit -----------------------------
                IconButton(
                    // here is the deletion of the orders
                    onPressed: () {
                      admin_order_delte(context, order_id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: C.red,
                    )),
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: C.secondaryBackground),
                ),
              ],
            ),
            Center(
              child: Text(
                " قام بحجز ${total_items} صنف",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: C.green),
              ),
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                formattedDate,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: C.bluish, fontSize: 15.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
