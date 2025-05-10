import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_orders_bloc/bloc/user_order_bloc.dart';

// -------------<<<--------dialog alert to show when the user is trying to delete a product on long pressing the product in the list tabel in the user orders list  ---------------->>>-------------

void user_delete_alert(BuildContext context,
    {required String item_id, required int item_quantaty}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: C.primaryBackground,
          title: Text('تأكيد الحذف'),
          content: Text(
            "هل انت متاكد انك تريد ازالة هذا الصنف نهائيا  من قائمة الطلبات؟",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<UserOrderBloc>().add(remove_item(item_id));
                    Navigator.of(context).pop();
                    context
                        .read<UserInventoryBloc>()
                        .add(updateInventoryfromorder(item_quantaty, item_id));
                  },
                  child: Container(
                    width: 80.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: C.blue),
                    child: Center(
                      child: Text(
                        "نعم",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: C.secondaryBackground,
                                ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 80.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: C.blue3),
                    child: Center(
                      child: Text(
                        "لا",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: C.secondaryBackground,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void user_sucess_order_checkout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: C.primaryBackground,
          content: Text(
            'تم تسجيل ١٥ طلبًا بإجمالي ٥٠ قطعة بنجا',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      );
    },
  );
}
