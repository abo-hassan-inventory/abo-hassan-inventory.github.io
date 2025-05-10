import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/auth/presentation/pages/mian%20auth%20page/widgets/auth_admin_sign.dart';
import 'package:inventory_project/features/auth/presentation/pages/mian%20auth%20page/widgets/auth_user_sign.dart';

class AuthBarSection extends StatelessWidget {
  const AuthBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 425.h,
        decoration: BoxDecoration(
            color: C.primaryBackground,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelStyle: Theme.of(context).textTheme.displayMedium,
                  indicatorColor: Colors.blueAccent,
                  tabs: [
                    Tab(
                      text: 'تسجيل الدخول كأدمن',
                    ),
                    Tab(text: 'تسجيل الدخول كمندوب'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AuthAdminSign(),
                      AuthUserSign(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
