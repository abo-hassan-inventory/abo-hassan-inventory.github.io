import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/user/Presentation/pages/home/user_home.dart';
import 'package:inventory_project/features/user/Presentation/pages/inventory/user_inventory.dart';
import 'package:inventory_project/features/user/Presentation/pages/orders/user_orders.dart';
import 'package:inventory_project/features/user/Presentation/pages/res/user_res.dart';

import '../../admin/presentation/pages/messages/admin_messages.dart';

//--------------------used googel nav bar in this page for the navigation -------------------------------
class UserWrapperNavigation extends StatefulWidget {
  final String user_id;

  UserWrapperNavigation({super.key, required this.user_id});
  @override
  UserWrapperNavigationState createState() => UserWrapperNavigationState();
}

class UserWrapperNavigationState extends State<UserWrapperNavigation> {
  int _selectedIndex = 2;
  late PageController _pageController;
  late List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    // هنا بنعرّف الصفحات، ونستخدم widget.user_id في UserRes
    _pages = [
      UserRes(userId: widget.user_id),
      UserOrders(),
      UserHome(),
      UserInventory(),
      AdminMessages(userid: widget.user_id),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: C.bluish,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.transparent,
              gap: 8,
              activeColor: C.green, // Active icon color
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.transparent, // No background color
              color: C.grey, // Inactive icon color
              tabs: [
                GButton(
                  icon: Icons.archive_outlined,
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                ),
                GButton(
                  icon: Icons.home_filled,
                ),
                GButton(
                  icon: Icons.inventory_2_rounded,
                ),
                GButton(
                  icon: Icons.mail_outline_rounded,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
