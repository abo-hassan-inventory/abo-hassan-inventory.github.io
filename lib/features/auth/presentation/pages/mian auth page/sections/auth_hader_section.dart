import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthHaderSection extends StatelessWidget {
  const AuthHaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 395.h,
      child: Stack(
        children: [
          Center(
              child: Container(
            height: 400.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/assets/images/9.png",
                  ),
                  fit: BoxFit.cover),
            ),
          )),
        ],
      ),
    );
  }
}
