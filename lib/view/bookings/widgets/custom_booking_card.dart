import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:petcare/view/bookings/ongoing_details_screen.dart';

class CustomBookingCard extends StatelessWidget {
  final String name;
  final String profileImage;
  final double rating;
  final int totalReviews;
  final String date;
  final String serviceType;
  final String contactNumber;
  final String bookingDate;
  final String pickUpTime;
  final String dropOffTime;
  final String price;
  final String status;
  final VoidCallback? onTap;

  const CustomBookingCard({
    super.key,
    required this.name,
    required this.profileImage,
    required this.rating,
    required this.totalReviews,
    required this.date,
    required this.serviceType,
    required this.contactNumber,
    required this.bookingDate,
    required this.pickUpTime,
    required this.dropOffTime,
    required this.price,
    required this.status,
    this.onTap,
  });


  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case "on going":
        return AppColors.mainAppColor;
      case "completed":
        return Colors.green;
      case "cancelled":
      case "canceled":
        return Colors.redAccent;
      case "pending":
        return Color(0xFFCF8906);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => const OngoingDetailsScreen());
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Color(0xFFE3E6F0),
            width: 0.6,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              offset: const Offset(0, 2),
              blurRadius: 2,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: AssetImage(profileImage),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20.sp),
                            SizedBox(width: 3.w),
                            Text(
                              "$rating ($totalReviews)",
                              style: TextStyle(
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9F5FC),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        date,
                        style: GoogleFonts.inter(
                          color: AppColors.mainAppColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "\$$price  Per day",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),

            Text(
              serviceType,
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 12.h),

            // Contact
            Text(
              "Contact",
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontWeight: FontWeight.w500,
                color: Color(0xFF3C3C3C),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey[600], size: 20.sp),
                SizedBox(width: 6.w),
                Text(
                  contactNumber,
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF585858),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.grey[600], size: 20.sp),
                SizedBox(width: 6.w),
                Text(
                  bookingDate,
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF585858),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // Pick-up / Drop-off
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick-up time: $pickUpTime",
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF101010),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Drop-off time: $dropOffTime",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101010),
                      ),
                    ),
                    Text(
                      status,
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: getStatusColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
