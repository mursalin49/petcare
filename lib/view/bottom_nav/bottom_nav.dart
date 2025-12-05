import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petcare/view/bookings/booking_screen.dart';
import 'package:petcare/view/profile/profile_screen.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../bookings/widgets/chat_list.dart';
import '../create_service/create_service.dart';
import '../home/home_screen.dart';





class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;

  void navigationItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    CreateService(),
     BookingsScreen(),
    ChatListScreen(),
    ProfileScreen(),


  ];

  // Create nav items in a getter
  List<BottomNavigationBarItem> get _navItems => [
    _navItem(AppIcons.home, AppIcons.homes, "Home", 0),
    _navItem(AppIcons.create, AppIcons.creates, "Create Service",  1),
    _navItem(AppIcons.bookingsICon, AppIcons.bookingsIConS, "Bookings",  2),
    _navItem(AppIcons.message, AppIcons.messages, "Messages",  3),
    _navItem(AppIcons.profileIcon, AppIcons.profileIconS, "Profile",  4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],

      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          color: Color(0xFFE7F4F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.08),
              offset: const Offset(4, 0),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          border: const Border(
            top: BorderSide(
              color: Color(0xFFE3E6F0),
              width: 1,
            ),
          ),
        ),
        height: 95.h,
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.mainAppColor,
          selectedLabelStyle: TextStyle(
            fontFamily: 'SegeoUi_bold',
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            color: AppColors.mainAppColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'SegeoUi_bold',
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.foundationColor,
          ),
          showSelectedLabels: true,
          unselectedItemColor: AppColors.foundationColor,
          backgroundColor: Colors.transparent,
          onTap: navigationItemTap,
          items: _navItems,
        ),
      ),
    );
  }
  BottomNavigationBarItem _navItem(
      String unselected,
      String selected,// Only one path needed
      String label,
      int index,
      ) {

    final bool isSelected = selectedIndex == index;
    final Color iconColor = isSelected
        ? AppColors.mainAppColor
        : AppColors.foundationColor;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            selectedIndex == index ? selected : unselected,
          ),
          SizedBox(height: 10.h),
        ],
      ),
      label: label,
    );
  }
}