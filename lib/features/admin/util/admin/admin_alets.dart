import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/inventory_bloc/inventory_bloc.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/res/admin_res_bloc.dart';

// -------------<<<--------dialog alert to show when the user is trying to delete a product on long pressing the product in the list tabel ---------------->>>-------------

// this is gonna be only for the admin page inventory page trying to delete an item
void admin_delete_alert(BuildContext context, String item_id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: C.primaryBackground,
          title: Text('تأكيد الحذف'),
          content: Text(
            'هل انت متاكد انك تريد حذف هذا الصنف نهائيا ؟',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<InventoryBloc>()
                        .add(DeleteProductEvent(productId: item_id));
                    Navigator.of(context).pop();
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

// this is fro the order delete alert ================>>>

void admin_order_delte(BuildContext context, String order_id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: C.primaryBackground,
          title: Text('تأكيد الحذف'),
          content: Text(
            'هل انت متاكد انك تريد حذف هذا الطلب نهائيا ؟',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<AdminResBloc>().add(deleteOrder(order_id));

                    Navigator.of(context).pop();
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
