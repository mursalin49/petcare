import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../bookings/widgets/custom_calendar.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F8F4),
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCards(),
          SizedBox(height: 24.h),
          _buildBookingTabs(),
          SizedBox(height: 20.h),
          CustomCalendarWidget(
            unavailableDays: [
              DateTime(2025, 11, 16),
              DateTime(2025, 11, 14),
              DateTime(2025, 11, 18),
            ],
          ),
          SizedBox(height: 24.h),
          _buildRecentBookings(),
          ],
        ),
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
          radius: 30,
          backgroundImage: AssetImage('assets/images/profileImg.png'),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Back',
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Seam Rahman',
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
              color: Colors.white.withOpacity(0.15),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
              size: 24.sp,
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


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.4,
        children: [
          _buildStatCard(
              title: 'Total Bookings',
              count: '800',
              borderColor: AppColors.mainC,
              countColor:  AppColors.mainC,
          ),
          _buildStatCard(
              title: 'On going services',
              count: '06',
              borderColor: AppColors.blueColor,
              countColor: AppColors.blueColor,
          ),
          _buildStatCard(
              title: 'Complete services',
              count: '400',
              borderColor: AppColors.greenColor,
              countColor: AppColors.greenColor,
          ),
          _buildStatCard(
              title: 'Upcoming services',
              count: '14',
              borderColor: AppColors.redColor,
              countColor: AppColors.redColor,
          ),
        ],
      ),
    );
  }


  Widget _buildStatCard({
    required String title,
    required String count,
    required Color borderColor,
    required Color countColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              count,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,

                color: countColor,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBookingTabs() {


    Widget _buildTabItem(Color color, String text) {
      return Row(
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
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark.withOpacity(0.9),
            ),
          ),
        ],
      );
    }





    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTabItem(AppColors.primary, 'Booked'),
          SizedBox(width: 20.w),
          _buildTabItem(AppColors.greenColor, 'Upcoming'),
        ],
      ),
    );
  }




  Widget _buildRecentBookings() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Bookings',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainAppColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),

          _buildBookingCard(
            userName: 'Tamim',
            location: 'New York, NY',
            time: '12:20 PM',
            service: 'Dog walking',
            date: 'Mon, Oct 02, 2025 at 10:00AM',
            price: '\$20/hr',
            petName: 'Max',
            petBreed: 'Labrador',
            petImage: 'assets/images/max.jpg',
          ),
          SizedBox(height: 16.h),
          _buildBookingCard(
            userName: 'Tamim',
            location: 'New York, NY',
            time: '12:20 PM',
            service: 'House sitting',
            date: 'Mon, Oct 02, 2025 at 10:00AM',
            price: '\$20/hr',
            petName: 'Max',
            petBreed: 'Labrador',
            petImage: 'assets/images/max.jpg',
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }


  Widget _buildBookingCard({
    required String userName,
    required String location,
    required String time,
    required String service,
    required String date,
    required String price,
    required String petName,
    required String petBreed,
    required String petImage,
    // --- [FIXED]
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/profileImg.png'),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: AppColors.foundationColor, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        location,
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subHeadingColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                time,
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    date,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ],
              ),
              Text(
                price,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              _buildInfoChip('For 2 hours'),
              SizedBox(width: 10.w),
              _buildInfoChip('\$40'),
            ],
          ),
          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.grey.withOpacity(0.2))
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),

                  child: Image.asset(
                    petImage,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      petName,
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      petBreed,
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subHeadingColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, size: 16.sp, color: AppColors.subHeadingColor)
              ],
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainAppColor, // টিল ব্যাকগ্রাউন্ড
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white, // সাদা টেক্সট
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget _buildInfoChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.shade300)
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.subHeadingColor
        ),
      ),
    );
  }





}