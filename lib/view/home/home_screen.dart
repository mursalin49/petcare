import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_colors.dart';

class AppAssets {

  static const String seamProfileImg = 'assets/images/profileImg.png';
  static const String tamimProfileImg = 'assets/images/tamim.png';
  static const String petImage = 'assets/images/maxx.png';
}

class InfoChip extends StatelessWidget {
  final String text;

  const InfoChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.borderColor)
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

// StatCard Widget
class StatCard extends StatelessWidget {
  final String title;
  final String count;
  final Color borderColor;
  final Color countColor;

  const StatCard({
    super.key,
    required this.title,
    required this.count,
    required this.borderColor,
    required this.countColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
              color: Color(0xFF585858),
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: Text(
              count,
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: countColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// BookingCard Widget (User profile image is now required)
class BookingCard extends StatelessWidget {
  final String userName;
  final String location;
  final String time;
  final String service;
  final String date;
  final String price;
  final String petName;
  final String petBreed;
  final String petImage;
  final String userProfileImage;

  const BookingCard({
    super.key,
    required this.userName,
    required this.location,
    required this.time,
    required this.service,
    required this.date,
    required this.price,
    required this.petName,
    required this.petBreed,
    required this.petImage,
    required this.userProfileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Header
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(userProfileImage),
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

          // Service and Price Info
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

          // Info Chips
          Row(
            children: [
              const InfoChip(text: 'For 2 hours'),
              SizedBox(width: 10.w),
              const InfoChip(text: '\$40'),
            ],
          ),
          SizedBox(height: 16.h),

          // Pet Info Container
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.borderColor)
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: AppColors.borderColor, width: 1.w),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Image.asset(
                      petImage,
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                    ),
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

          // Action Buttons
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
                      color: AppColors.white,
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
                      color: AppColors.white,
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
}

// Custom Calendar Widget
class CustomCalendarWidget extends StatefulWidget {
  final List<DateTime> unavailableDays;
  final Function(DateTime)? onDaySelected;

  const CustomCalendarWidget({
    super.key,
    required this.unavailableDays,
    this.onDaySelected,
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isUnavailable(DateTime day) {
    return widget.unavailableDays.any(
          (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(2030),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarFormat: CalendarFormat.month,
        onPageChanged: (focusedDay) {
          final now = DateTime.now();
          if (focusedDay.isBefore(DateTime(now.year, now.month))) {
            setState(() => _focusedDay = DateTime(now.year, now.month));
          } else {
            setState(() => _focusedDay = focusedDay);
          }
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: const Icon(Icons.chevron_left, size: 20, color: AppColors.textDark),
          rightChevronIcon: const Icon(Icons.chevron_right, size: 20, color: AppColors.textDark),
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
          weekendStyle: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(2),
          todayDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: true,
          defaultTextStyle: TextStyle(color: AppColors.primaryText),
          weekendTextStyle: TextStyle(color: AppColors.primaryText),
        ),
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          if (!_isUnavailable(selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDaySelected?.call(selectedDay);
          }
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            // Red-mark unavailable days
            if (_isUnavailable(day)) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Regular',
                      fontSize: 13,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }

            // Normal day cell
            return Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 13,
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 3. --- MAIN HOME SCREEN WIDGET ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
                DateTime.now().add(const Duration(days: 5)),
                DateTime.now().add(const Duration(days: 6)),
                DateTime.now().add(const Duration(days: 7)),
              ],
              onDaySelected: (day) {
                // Handle day selection logic
              },
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
          backgroundImage: AssetImage(AppAssets.seamProfileImg),
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
              color: AppColors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Seam Rahman',
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
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
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.white,
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
          ),
          StatCard(
            title: 'On going services',
            count: '06',
            borderColor: AppColors.blueColor,
            countColor: AppColors.blueColor,
          ),
          StatCard(
            title: 'Completed services',
            count: '400',
            borderColor: AppColors.greenColor,
            countColor: AppColors.greenColor,
          ),
          StatCard(
            title: 'Upcoming services',
            count: '14',
            borderColor: AppColors.redColor,
            countColor: AppColors.redColor,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingTabs() {
    Widget _buildTabItem(Color color, String text, int index) {
      final isSelected = _selectedTabIndex == index;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
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
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? AppColors.textDark : AppColors.subHeadingColor,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTabItem(AppColors.mainAppColor, 'Booked', 0),
              SizedBox(width: 20.w),
              _buildTabItem(AppColors.redColor, 'Upcoming', 1),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBookings() {
    return Container(
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
                  fontSize: 18.sp,
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
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainAppColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),

          // Booking Card 1 using Tamim's image
          const BookingCard(
            userName: 'Tamim',
            location: 'New York, NY',
            time: '12:20 PM',
            service: 'Dog walking',
            date: 'Mon, Oct 02, 2025 at 10:00AM',
            price: '\$20/hr',
            petName: 'Max',
            petBreed: 'Labrador',
            petImage: AppAssets.petImage,
            userProfileImage: AppAssets.tamimProfileImg, // *** USING TAMIM'S IMAGE ***
          ),
          SizedBox(height: 16.h),
          // Booking Card 2 using Tamim's image
          const BookingCard(
            userName: 'Tamim',
            location: 'New York, NY',
            time: '12:20 PM',
            service: 'House sitting',
            date: 'Mon, Oct 02, 2025 at 10:00AM',
            price: '\$20/hr',
            petName: 'Max',
            petBreed: 'Labrador',
            petImage: AppAssets.petImage,
            userProfileImage: AppAssets.tamimProfileImg, // *** USING TAMIM'S IMAGE ***
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}