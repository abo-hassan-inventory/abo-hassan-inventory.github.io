import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/domain/entiti/admin_inventory_entity.dart';
import 'package:inventory_project/features/admin/presentation/pages/inventory/widgets/admin_inventory_textfeild_widget.dart';
import 'package:inventory_project/features/admin/presentation/state%20manegment/inventory_bloc/inventory_bloc.dart';

//-----------<<<--------------this section is for adding new item into the list in the inventory page buttom sheet ---------------->>>-----------------[]
void addnewitem_sheet(
  BuildContext context,
) {
  TextEditingController item_name = TextEditingController();
  TextEditingController item_quantity = TextEditingController();
  GlobalKey<FormState> name = GlobalKey<FormState>();
  GlobalKey<FormState> quantaity = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: C.thirdbackground,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Text(
                  "اضافة منتج جديد",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 20),
                AdminInventoryTextfeildWidget(
                  lol: name,
                  controller: item_name,
                  label: "ادخل اسم الصنف",
                ),
                SizedBox(height: 20),
                AdminInventoryTextfeildWidget(
                  lol: quantaity,
                  controller: item_quantity,
                  label: "ادخل الكمية",
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if (name.currentState!.validate() &&
                        quantaity.currentState!.validate()) {
                      //------------ here im passing the new data to the event to add the new item using the text controller
                      context.read<InventoryBloc>().add(AddProductEvent(
                              product: InventoryEntity(
                            name: item_name.text,
                            quantity: int.parse(item_quantity.text),
                          )));
                      // still called the event to refresh the list------------------

                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: C.bluish,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "اضافة",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: C.thirdbackground),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// ----------------------------this section is for editing the proudct info in the admin side inventory page buttom sheeet ------------------------>>>>>
void EditItem_sheet(BuildContext context, String name, int quantity, String id,
    TextEditingController lol) {
  TextEditingController item_name_update = TextEditingController();
  TextEditingController item_quantity_update = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: C.thirdbackground,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wrap content
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(
                      width: 50.w,
                    ),
                    Text(
                      "اسم الصنف :",
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(quantity.toString(),
                        style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(
                      width: 50.w,
                    ),
                    Text(
                      "الكميه المتاحه :",
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AdminInventoryTextfeildWidget(
                  hint: name,
                  controller: item_name_update,
                  label: "ادخل اسم الصنف",
                ),
                const SizedBox(height: 20),
                AdminInventoryTextfeildWidget(
                  hint: quantity.toString(),
                  controller: item_quantity_update,
                  label: "ادخل الكمية",
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // this part is for the default value
                    final String updatedName = item_name_update.text.isNotEmpty
                        ? item_name_update.text
                        : name;
                    final int updatedQuantity =
                        item_quantity_update.text.isNotEmpty
                            ? int.parse(item_quantity_update.text)
                            : quantity;
                    // ---------------here is me calling the two events update and refresh events
                    context.read<InventoryBloc>().add(UpdateProductEvent(
                        product: InventoryEntity(
                            id: id,
                            name: updatedName,
                            quantity: updatedQuantity)));
                    // cancelling the foucs on the search feild
                    lol.clear();

                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: C.bluish,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "حفظ",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: C.thirdbackground),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}
