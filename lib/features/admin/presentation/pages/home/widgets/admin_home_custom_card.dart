import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/core/theme/C.dart';

class AdminHomeCustomCard extends StatelessWidget {
  final String miantext;
  final String image_path;
  final Function() onTap;
  const AdminHomeCustomCard(
      {super.key,
      required this.miantext,
      required this.image_path,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 110.h,
        decoration: BoxDecoration(
          color: C.secondaryBackground,
          border: Border.all(color: C.green, width: 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(100),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(image_path))),
            ),
            Text(
              miantext,
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
