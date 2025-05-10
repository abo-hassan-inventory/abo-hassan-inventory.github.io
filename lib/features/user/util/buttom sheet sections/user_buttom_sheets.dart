import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Domain/entity/user_inventory_entity.dart';
import 'package:inventory_project/features/user/Presentation/state%20manegment/user_inventory_bloc/user_inventory_bloc.dart';
import 'package:inventory_project/features/user/util/widgets/user_buttom_sheet_card.dart';
import 'package:inventory_project/features/user/util/widgets/counter_temp_textfeild.dart';
import 'package:inventory_project/features/user/util/widgets/user_custom_button_type_shit.dart';

import '../../Presentation/state manegment/user_orders_bloc/bloc/user_order_bloc.dart';

// ----------------------------this section is for tacking a order from the inventory for the users  buttom sheeet ------------------------>>>>>

void add_new_order(BuildContext context, String name, int quantity, String id,
    TextEditingController controller, GlobalKey<FormState> key) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Builder(builder: (BuildContext newcontext) {
        return BlocBuilder<UserInventoryBloc, UserInventoryState>(
          builder: (context, state) {
            if (state is user_inventoryloading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is user_inventoryError) {
              return Center(child: Text(state.message));
            }
            if (state is user_inventoryLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: C.thirdbackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 15.h),
                        Center(
                            child: Text("اختر الكمية المطلوبة",
                                style:
                                    Theme.of(context).textTheme.displayLarge)),
                        SizedBox(height: 30.h),
                        //this section is fro the card that shows the name and quantaty
                        UserButtomSheetCard(name: name, quantity: quantity),
                        SizedBox(height: 20.h),
                        // ------------ this widget is for the text form feild for the reactive countering ------------------
                        Container(
                          width: 280.w,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: CounterTextField(
                            the_buttomsheet_context: newcontext,
                            form_key: key,
                            controller: controller,
                            initialValue: quantity,
                            onChanged: (newVal) {},
                          ),
                        ),
                        SizedBox(height: 40.h),
                        // 0---------------------------- this section is fro the buttons in the buttom sheet
                        Container(
                          width: 350.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // this section is for the adding and cancel buttons in the buttom sheet

                              UserCustomButtonTypeShit(
                                  name: "الغاء",
                                  background: C.bluish,
                                  onTap: () {
                                    Navigator.pop(context);
                                  }),
                              // here is all the functions of replacing the achual list from the supa with temp
                              // data about the quantaty left after you make an order to it
                              UserCustomButtonTypeShit(
                                  name: "اضافه الي الطلب ",
                                  background: C.green,
                                  onTap: () {
                                    if (key.currentState!.validate()) {
                                      print(
                                          "you pressed the button to add the item to the temp list ");
                                      context.read<UserOrderBloc>().add(
                                          add_item(UserInventoryEntity(
                                              id: id,
                                              name: name,
                                              quantity:
                                                  int.parse(controller.text))));
                                      context.read<UserInventoryBloc>().add(
                                          UpdateInventory_temp(
                                              int.parse(controller.text), id));

                                      Navigator.pop(context);
                                    }
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                  child: Container(
                child: Text("unknown error has happend talk to the developer"),
              ));
            }
          },
        );
      });
    },
  );
}
