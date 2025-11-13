import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCards(),
            SizedBox(height: 24.h),
            _buildBookingTabs(),
            SizedBox(height: 20.h),
            _buildCalendarSection(),
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
            child:CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                'assets/icons/Notification.svg',
                width: 35,
                height: 35,
                color: AppColors.mainAppColor,
              ),
            )
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

  // --- ৪টি স্ট্যাটাস কার্ড ---
  Widget _buildStatCards() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.4, // কার্ডগুলোর সাইজ ঠিক করার জন্য
        children: [
          _buildStatCard(
              title: 'Total Bookings',
              count: '800',
              borderColor: Colors.blue.shade300
          ),
          _buildStatCard(
              title: 'On going services',
              count: '06',
              borderColor: Colors.lightBlue.shade300
          ),
          _buildStatCard(
              title: 'Completed services',
              count: '400',
              borderColor: Colors.green.shade300
          ),
          _buildStatCard(
              title: 'Upcoming services',
              count: '14',
              borderColor: Colors.red.shade300
          ),
        ],
      ),
    );
  }


  Widget _buildStatCard({
    required String title,
    required String count,
    required Color borderColor
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
              fontWeight: FontWeight.w500,
              color: AppColors.subHeadingColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            count,
            style: GoogleFonts.montserrat(
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  // --- "Bookings" এবং "Upcoming" ট্যাব ---
  Widget _buildBookingTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          // "Bookings" Tab
          Column(
            children: [
              Text(
                'Bookings',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary, // সিলেক্টেড কালার
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                width: 24.w,
                height: 3.h,
                color: AppColors.primary,
              )
            ],
          ),
          SizedBox(width: 20.w),

          // "Upcoming" Tab
          Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                'Upcoming',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark.withOpacity(0.7), // ডি-সিলেক্টেড
                ),
              ),
              // --- অবতারগুলো ---
              Positioned(
                left: 10.w,
                top: -10.h,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10.r,
                      backgroundColor: Colors.pink.shade100,
                      child: Text('A', style: TextStyle(fontSize: 10.sp, color: Colors.pink.shade800)),
                    ),
                    Transform.translate(
                      offset: Offset(-8.w, 0),
                      child: CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.orange.shade100,
                        child: Text('A', style: TextStyle(fontSize: 10.sp, color: Colors.orange.shade800)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // --- ক্যালেন্ডার সেকশন ---
  // নোট: এটি ডিজাইনের সাথে মেলানোর জন্য একটি স্ট্যাটিক ক্যালেন্ডার
  // রিয়েল অ্যাপে 'table_calendar' এর মতো প্যাকেজ ব্যবহার করা ভালো
  Widget _buildCalendarSection() {
    // ক্যালেন্ডারের দিনগুলো (নভেম্বর ২০২১, ছবির মতো)
    const List<String> calendarDays = [
      '27', '28', '29', '30', '31', '1', '2',
      '3', '4', '5', '6', '7', '8', '9',
      '10', '11', '12', '13', '14', '15', '16',
      '17', '18', '19', '20', '21', '22', '23',
      '24', '25', '26', '27', '28', '29', '30',
      '31', '1', '2', '3', '4', '5', '6'
    ];
    // হাইলাইটেড দিনগুলো
    final Set<String> redDays = {'12', '14'};
    final Set<String> tealDays = {'13', '20'};
    final Set<String> greyDays = {'27', '28', '29', '30', '31', '1', '2', '3', '4', '5', '6'};

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // --- ক্যালেন্ডার হেডার (Month/Year) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios, size: 18.sp, color: AppColors.textDark),
              Text(
                'November 2025',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 18.sp, color: AppColors.textDark),
            ],
          ),
          SizedBox(height: 16.h),

          // --- সপ্তাহের দিন (Sun, Mon...) ---
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => Center(
              child: Text(
                day,
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ))
                .toList(),
          ),
          SizedBox(height: 8.h),

          // --- ক্যালেন্ডারের দিনগুলো ---
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(calendarDays.length, (index) {
              final day = calendarDays[index];
              final isGrey = index < 7 || index >= 35; // প্রথম ও শেষ লাইনের দিন
              final isRed = redDays.contains(day) && !isGrey;
              final isTeal = tealDays.contains(day) && !isGrey;

              Color bgColor = Colors.transparent;
              Color textColor = Colors.red;

              if (isRed) {
                bgColor = AppColors.primary;
                textColor = AppColors.primary;
              } else if (isTeal) {
                bgColor = AppColors.mainAppColor.withOpacity(0.1);
                textColor = AppColors.mainAppColor;
              }

              return Container(
                margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // --- "Recent Bookings" সেকশন ---
  Widget _buildRecentBookings() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // --- হেডার (Recent Bookings + See all) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Bookings',
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainAppColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),

          // --- বুকিং কার্ড লিস্ট ---
          _buildBookingCard(
            userName: 'Tamim',
            location: 'New York, NY',
            time: '12:20 PM',
            service: 'Dog walking',
            date: 'Mon, Oct 02, 2025 at 10:00AM',
            price: '\$20/hr',
            petName: 'Max',
            petBreed: 'Labrador',
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
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // --- একটি সিঙ্গেল বুকিং কার্ডের ডিজাইন (image_acc2fe.png অনুযায়ী) ---
  Widget _buildBookingCard({
    required String userName,
    required String location,
    required String time,
    required String service,
    required String date,
    required String price,
    required String petName,
    required String petBreed,
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
          // --- উপরের অংশ: ইউজার ইনফো ---
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/profileImg.png'), // ইউজার ছবি
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

          // --- সার্ভিস ইনফো ---
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

          // --- সময় এবং পেমেন্ট ---
          Row(
            children: [
              _buildInfoChip('For 2 hours'),
              SizedBox(width: 10.w),
              _buildInfoChip('\$40'),
            ],
          ),
          SizedBox(height: 16.h),

          // --- পেট ইনফো ---
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                color: AppColors.mainAppColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.r)
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SvgPicture.asset( 'assets/icons/max.svg', width: 60.w, height: 60.h),
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

          // --- বাটন (Cancel/Accept) ---
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainAppColor,
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
                      color: Colors.white,
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

  // --- বুকিং কার্ডের ছোট চিপ ("For 2 hours") ---
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



  // --- "Creations" আইটেম (ডিজাইন অনুযায়ী) ---
  Widget _buildCreationsItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(
                Icons.maps_ugc_rounded,
                size: 26.sp,
                color: AppColors.grey
            ),
            Positioned(
              left: 3.w,
              top: 0.h,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 7.r,
                    backgroundColor: Colors.pink.shade100,
                    child: Text('A', style: TextStyle(fontSize: 7.sp, color: Colors.pink.shade800)),
                  ),
                  Transform.translate(
                    offset: Offset(-5.w, 0),
                    child: CircleAvatar(
                      radius: 7.r,
                      backgroundColor: Colors.orange.shade100,
                      child: Text('A', style: TextStyle(fontSize: 7.sp, color: Colors.orange.shade800)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'creations',
          style: GoogleFonts.montserrat(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}