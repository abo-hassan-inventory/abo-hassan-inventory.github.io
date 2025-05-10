import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:inventory_project/features/admin/presentation/pages/Analysis/analysis_page.dart';
import 'package:inventory_project/features/admin/presentation/pages/home/admin_home.dart';
import 'package:inventory_project/core/theme/C.dart';
import 'package:inventory_project/features/admin/presentation/pages/inventory/admin_inventory.dart';
import 'package:inventory_project/features/admin/presentation/pages/messages/admin_messages.dart';
import 'package:inventory_project/features/admin/presentation/pages/res/admin_res.dart';

//--------------------used googel nav bar in this page for the navigation -------------------------------
class WrapperNavigation extends StatefulWidget {
  final String userid;

  const WrapperNavigation({super.key, required this.userid});
  @override
  WrapperNavigationState createState() => WrapperNavigationState();
}

class WrapperNavigationState extends State<WrapperNavigation> {
  int _selectedIndex = 2;
  late PageController _pageController;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    _pages = [
      AnalysisPage(),
      AdminRes(),
      AdminHome(),
      AdminInventory(),
      AdminMessages(
        userid: widget.userid,
      ),
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
                  icon: Icons.bar_chart_rounded,
                ),
                GButton(
                  icon: Icons.notifications,
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
