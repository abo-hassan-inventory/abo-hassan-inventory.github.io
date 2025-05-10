import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_project/features/user/Presentation/pages/home/widgets/user__home_card_widget.dart';
import 'package:inventory_project/features/user/wrapper/user_wrapper_navigation.dart';

class UserHomeBodySection extends StatelessWidget {
  const UserHomeBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userhomecustomcard(
            miantext: "عرض المخزون",
            image_path: "assets/images/2.png",
            onTap: () {
              (context
                  .findAncestorStateOfType<UserWrapperNavigationState>()!
                  .navigateToPage(3));
            },
          ),
          userhomecustomcard(
            miantext: "تاريخ حجوزات وطلبيات",
            image_path: "assets/images/5.png",
            onTap: () {
              (context
                  .findAncestorStateOfType<UserWrapperNavigationState>()!
                  .navigateToPage(0));
            },
          ),
          userhomecustomcard(
            miantext: "إرسال رسالة عامة",
            image_path: "assets/images/3.png",
            onTap: () {
              (context
                  .findAncestorStateOfType<UserWrapperNavigationState>()!
                  .navigateToPage(4));
            },
          ),
        ],
      ),
    );
  }
}
