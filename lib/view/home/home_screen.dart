import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/view/home/widgets/booking_card.dart';
import 'package:petcare/view/home/widgets/custom_calendar.dart';
import 'package:petcare/view/home/widgets/stat_card.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../bookings/booking_screen.dart';
import 'models/booking_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  final List<BookingModel> bookedList = [
    BookingModel(
      userName: 'Tamim',
      location: 'New York, NY',
      time: '12:20 PM',
      service: 'Dog walking',
      date: 'Mon, Oct 02, 2025 at 10:00 AM',
      price: '\$20/hr',
      petName: 'Max',
      petBreed: 'Labrador',
      petImage: AppImages.max,
      userProfileImage: AppImages.tamim,
    ),
    BookingModel(
      userName: 'Tamim',
      location: 'Dhaka',
      time: '02:00 PM',
      service: 'House sitting',
      date: 'Tue, Oct 03, 2025 at 10:00 AM ',
      price: '\$35/hr',
      petName: 'Max',
      petBreed: 'Labrador',
      petImage: AppImages.max,
      userProfileImage: AppImages.tamim,
    ),
  ];

  final List<BookingModel> upcomingList = [
    BookingModel(
      userName: 'Seam',
      location: 'Sylhet',
      time: '10:00 AM',
      service: 'Vet Checkup',
      date: 'Fri, Oct 10, 2025 ',
      price: '\$50/visit',
      petName: 'Rocky',
      petBreed: 'Husky',
      petImage: AppImages.max,
      userProfileImage: AppImages.tamim,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F4),
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCards(),
            SizedBox(height: 24.h),
            _buildBookingTabs(),
            SizedBox(height: 20.h),
            CustomCalendarWidget(
              unavailableDays: [
                DateTime.now().add(const Duration(days: 3)),
                DateTime.now().add(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 5)),
              ],
              onDaySelected: (day) {},
            ),
            SizedBox(height: 24.h),
            _buildRecentBookings(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBookings() {
    final displayList = _selectedTabIndex == 0 ? bookedList : upcomingList;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedTabIndex == 0 ? 'Recent Bookings' : 'Upcoming List',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainAppColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          displayList.isEmpty
              ? const Center(child: Text("No Bookings Found"))
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayList.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = displayList[index];
              return BookingCard(
                userName: item.userName,
                location: item.location,
                time: item.time,
                service: item.service,
                date: item.date,
                price: item.price,
                petName: item.petName,
                petBreed: item.petBreed,
                petImage: item.petImage,
                userProfileImage: item.userProfileImage,
              );
            },
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,
      toolbarHeight: 90.h,
      leadingWidth: 80.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
        child: const CircleAvatar(

          radius: 40.0,
          backgroundColor: Color(0xFFFFFFFF),
          child: CircleAvatar(

            radius: 36.0,
            backgroundImage: AssetImage('images/n.png'),

          ),
        )
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Back',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Seam Rahman',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.15),
            ),
            child: SvgPicture.asset(
              'assets/icons/notifica.svg', // Replace with your actual SVG asset path

              width: 24.sp, // Use width/height instead of size
              height: 24.sp,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.4,
        children: [
          StatCard(
            title: 'Total Bookings',
            count: '800',
            borderColor: AppColors.mainC,
            countColor: AppColors.mainC,
            bgColor: const Color(0xFFE7F4F6),
          ),
          StatCard(
            title: 'On going services',
            count: '06',
            borderColor: AppColors.blueColor,
            countColor: AppColors.blueColor,
            bgColor: AppColors.blueColor.withOpacity(0.04),
          ),
          StatCard(
            title: 'Completed services',
            count: '400',
            borderColor: AppColors.greenColor,
            countColor: AppColors.greenColor,
            bgColor: AppColors.greenColor.withOpacity(0.04),
          ),
          StatCard(
            title: 'Upcoming services',
            count: '14',
            borderColor: AppColors.redColor,
            countColor: AppColors.redColor,
            bgColor: AppColors.redColor.withOpacity(0.04),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingTabs() {
    Widget tabItem(Color color, String text, int index) {
      final isSelected = _selectedTabIndex == index;
      return GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                text,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            tabItem(AppColors.redColor, 'Booked', 0),
            // SizedBox(width: 20.w),
            // tabItem(AppColors.greenColor, 'Upcoming', 1),
          ],
        ),
      ),
    );
  }
}