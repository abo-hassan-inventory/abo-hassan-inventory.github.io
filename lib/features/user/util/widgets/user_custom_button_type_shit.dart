import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';

class UserCustomButtonTypeShit extends StatelessWidget {
  final String name;
  final Color background;
  final VoidCallback onTap;
  const UserCustomButtonTypeShit(
      {super.key,
      required this.name,
      required this.background,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: C.thirdbackground),
          ),
        ),
      ),
    );
  }
}
