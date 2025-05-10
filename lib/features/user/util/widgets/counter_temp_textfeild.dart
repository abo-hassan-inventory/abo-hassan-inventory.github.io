import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';

// the centerd text feild one at the user inventory view
class CounterTextField extends StatefulWidget {
  final BuildContext the_buttomsheet_context;
  final int initialValue;
  final ValueChanged<int>? onChanged;
  final TextEditingController controller;
  final GlobalKey<FormState> form_key;

  const CounterTextField({
    Key? key,
    required this.initialValue,
    this.onChanged,
    required this.controller,
    required this.form_key,
    required this.the_buttomsheet_context,
  }) : super(key: key);

  @override
  _CounterTextFieldState createState() => _CounterTextFieldState();
}

class _CounterTextFieldState extends State<CounterTextField> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue;
    widget.controller.text = counter.toString();
  }

  void _updateCounter(int newCounter) {
    setState(() {
      counter = newCounter;
      widget.controller.text = counter.toString();
    });
    if (widget.onChanged != null) {
      widget.onChanged!(counter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // TextField that shows the current counter value and by counter i mean that i shows the real time quantaty of the product

      Center(
          child: Form(
              key: widget.form_key,
              // made it larg to fit the validations
              child: SizedBox(
                width: 280.w,
                height: 60.h,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // here is the validations for this text feilds
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "من فضلك قم بادخال الكمية";
                    }
                    if (value.contains('-')) {
                      return "من فضلك ادخل قيمه موجبه ";
                    }
                    if (value == '0') {
                      return "من فضلك أدخل رقم صحيح أكبر من صفر";
                    }
                    if (int.tryParse(value) == null) {
                      return " من فضلك قم بادخال رقم";
                    }
                    if (int.parse(value) > widget.initialValue) {
                      return "الكميه المتاحه لا تكفي";
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "من فضلك أدخل أرقام فقط";
                    }

                    return null;
                  },
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    final newVal = int.tryParse(value);
                    if (newVal != null) {
                      setState(() {
                        counter = newVal;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(counter);
                      }
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                    border: OutlineInputBorder(),
                  ),
                ),
              ))),
      SizedBox(height: 10.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Decrease button on the left
          GestureDetector(
              onTap: () {
                if (counter > 0) {
                  _updateCounter(counter - 1);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: C.bluish, borderRadius: BorderRadius.circular(5)),
                width: 40.w,
                height: 40.h,
                child: Icon(Icons.remove, color: C.primaryBackground),
              )),

          // the button  on the right
          GestureDetector(
              onTap: () {
                if (counter >= 0) {
                  _updateCounter(counter + 1);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: C.bluish, borderRadius: BorderRadius.circular(5)),
                width: 40.w,
                height: 40.h,
                child: Icon(Icons.add, color: C.primaryBackground),
              ))
        ],
      ),
    ]);
    // Increase button
  }
}
