import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/C.dart';
import '../../../../domain/entiti/analysis/ItemSummaryEntity.dart';
import '../oreder_details/admin_res_detailed.dart';

class AdminAnalysisCart extends StatelessWidget {
  final String name;
  final int orderCount;
  final List<ItemSummaryEntity> items;
  final String userId;

  const AdminAnalysisCart(
      {super.key,
      required this.name,
      required this.orderCount,
      required this.items,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminroroDetailed(
                  total_count: items.length,
                  name: name,
                  itemss: items,
                  userId: userId,
                )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 120.h,
        decoration: BoxDecoration(
          color: C.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: C.secondaryBackground),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "قام بحجز  $orderCount طلب ",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: C.green),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "اضغط هنا لعرض الطلبات ",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: C.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
