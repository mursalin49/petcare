import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/view/bookings/booking_screen.dart';
import 'package:petcare/view/home/widgets/custom_calendar.dart';
import 'package:petcare/view/home/widgets/stat_card.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../bookings/models/model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BookingStatusController controller;
  late BookingService bookingService;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BookingStatusController());
    bookingService = Get.put(BookingService());
  }

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
            SizedBox(height: 20.h),

            // Stat Cards
            _buildStatCards(),
            SizedBox(height: 24.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [

                  Container(
                    width: 21.w,
                    height: 21.h,
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(width: 8.w),

                  Text(
                    'Booked',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),
            ),

            SizedBox(height: 16.h),
            // Calendar
            CustomCalendarWidget(
              unavailableDays: [
                DateTime.now().add(const Duration(days: 1)),
                DateTime.now().add(const Duration(days: 2)),
                DateTime.now().add(const Duration(days: 4)),
              ],
              onDaySelected: (day) {},
            ),
            SizedBox(height: 24.h),

            // Recent Bookings
            _buildRecentBookings(),
            SizedBox(height: 30.h),
          ],
        ),
      ),

    );
  }

  Widget _buildRecentBookings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Bookings',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () => Get.to(() => const BookingsScreen()),
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

          // Display all bookings - No filter on HomeScreen
          Obx(() {
            List<BookingData> displayList = bookingService.bookings.toList();

            if (displayList.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    "No bookings found.",
                    style: GoogleFonts.montserrat(
                      color: AppColors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final booking = displayList[index];
                return ExpandableBookingCard(booking: booking);
              },
            );
          }),
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
            // This is correct for loading a local image asset
            backgroundImage: AssetImage('assets/images/n.png'),
          ),
        ),
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
              'assets/icons/notifica.svg',
              width: 24.sp,
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1.4,
        children: [
          StatCard(
            title: 'Total Bookings',
            count: '800',
            borderColor: AppColors.mainAppColor,
            countColor: AppColors.mainAppColor,
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
}