import 'package:flutter/material.dart';
import 'package:inventory_project/features/admin/presentation/pages/home/widgets/admin_home_custom_card.dart';
import 'package:inventory_project/features/admin/wrapper/admin/wrapper_navigation.dart';

// -------,,,,,,, fix transition navigation to message page --------------
//----------fix is done it was becous the page counter start from zero not one ------------------------
class AdminHomeBodySection extends StatelessWidget {
  const AdminHomeBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      AdminHomeCustomCard(
          miantext: "عرض المخزون",
          image_path: "assets/images/2.png",
          onTap: () {
            (context.findAncestorStateOfType<WrapperNavigationState>())
                ?.navigateToPage(3);
          }),
      AdminHomeCustomCard(
          miantext: "حجوزات وطلبيات",
          image_path: "assets/images/5.png",
          onTap: () {
            (context.findAncestorStateOfType<WrapperNavigationState>())
                ?.navigateToPage(1);
          }),
      AdminHomeCustomCard(
          miantext: "إرسال رسالة عامة",
          image_path: "assets/images/3.png",
          onTap: () {
            (context.findAncestorStateOfType<WrapperNavigationState>())
                ?.navigateToPage(4);
          }),
      AdminHomeCustomCard(
          miantext: "لوحة طلبات المندوبين",
          image_path: "assets/images/1.png",
          onTap: () {
            (context.findAncestorStateOfType<WrapperNavigationState>())
                ?.navigateToPage(0);
          }),
    ]);
  }
}
