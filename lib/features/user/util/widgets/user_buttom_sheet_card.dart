import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';

class UserButtomSheetCard extends StatelessWidget {
  final String name;
  final int quantity;
  const UserButtomSheetCard(
      {super.key, required this.name, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 65.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: C.blue2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "الكميه المتاحه",
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              "اسم الصنف",
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ]),
          SizedBox(height: 5.h),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              quantity.toString(),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: C.primaryBackground),
            ),
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: C.primaryBackground),
            ),
          ]),
        ],
      ),
    );
  }
}
