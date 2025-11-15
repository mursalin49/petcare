import 'package:flutter/material.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart'; // আপনার AppColors ইম্পোর্ট করুন

class RescheduleScreen extends StatelessWidget {
  const RescheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ইউজার ইনফো কার্ড ---
            _buildUserInfoCard(),
            SizedBox(height: 24.h),

            // --- Pet sitter available time ইনপুট ---
            _buildTextInputField(
              label: "Pet sitter available time",
              icon: Icons.calendar_today_rounded,
              onIconTap: () {
                // TODO: এখানে ক্যালেন্ডার পপ-আপ দেখানোর লজিক লিখুন
                // যেমন: showDialog(...) বা Get.dialog(...)
              },
            ),
            SizedBox(height: 16.h),

            // --- Note ইনপুট ---
            _buildTextInputField(
              label: "Note",
              hint: "Please ensure all windows are securely locked after cleaning. Kindly use eco-friendly cleaning products as we prefer them.",
              maxLines: 4,
            ),
            SizedBox(height: 24.h),

            // --- তারিখ ও সময় সিলেকশন ---
            _buildDateTimeSelection(),
            SizedBox(height: 40.h),

            // --- বাটন (Cancel / Send) ---
            _buildActionButtons(context),
            SizedBox(height: 16.h),

            // --- ফুটার নোট ---
            Center(
              child: Text(
                "You can reschedule the time only once.",
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary, // লাল
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- [HELPER] ইউজার ইনফো কার্ড ---
  Widget _buildUserInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: AssetImage('assets/images/profileImg.png'), // ইউজার ছবি
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tamim Sarkar",
                style: GoogleFonts.montserrat(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Dhanmondi,Dhaka 1209",
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- [HELPER] টেক্সট ইনপুট ফিল্ড ---
  Widget _buildTextInputField({
    required String label,
    String? hint,
    IconData? icon,
    int maxLines = 1,
    VoidCallback? onIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 12.h),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.montserrat(
              color: AppColors.subHeadingColor,
              fontSize: 14.sp,
            ),
            suffixIcon: icon != null
                ? InkWell(
              onTap: onIconTap,
              child: Icon(icon, color: AppColors.subHeadingColor, size: 20.sp),
            )
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.mainAppColor, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // --- [HELPER] তারিখ ও সময় সিলেকশন ---
  Widget _buildDateTimeSelection() {
    // একটি সিঙ্গেল আইটেম (যেমন: Start date, Start time)
    Widget _buildDateTimeColumn(String label, String value) {
      return InkWell(
        onTap: () {
          // TODO: এখানে Date/Time Picker খোলার লজিক লিখুন
          // যেমন: showDatePicker(...) বা showTimePicker(...)
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.subHeadingColor,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select reschedule date & time",
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 16.h),
        // Start date & End date
        Row(
          children: [
            Expanded(child: _buildDateTimeColumn("Start date", "01/09/2025")),
            SizedBox(width: 16.w),
            Expanded(child: _buildDateTimeColumn("End date", "01/09/2025")),
          ],
        ),
        SizedBox(height: 16.h),
        // Start time & End time
        Row(
          children: [
            Expanded(child: _buildDateTimeColumn("Start time", "11:00pm")),
            SizedBox(width: 16.w),
            Expanded(child: _buildDateTimeColumn("End time", "11:00pm")),
          ],
        ),
      ],
    );
  }

  // --- [HELPER] বাটন (Cancel / Send) ---
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Cancel বাটন
        Expanded(
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: BorderSide(color: AppColors.primary, width: 1.5),
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
        // Send বাটন
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // --- "Send" ক্লিক করলে সাকসেস পপ-আপ দেখাবে ---
              _showSuccessDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainAppColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Send',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- [HELPER] সাকসেস পপ-আপ (image_cd444d.png অনুযায়ী) ---
  void _showSuccessDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(24.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close বাটন
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Get.back(),
                child: Icon(Icons.close, color: Colors.grey.shade500, size: 24.sp),
              ),
            ),
            SizedBox(height: 10.h),
            // সবুজ চেকমার্ক
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: Icon(Icons.check_rounded, color: Colors.green, size: 40.sp),
            ),
            SizedBox(height: 24.h),
            // টেক্সট
            Text(
              "Your reschedule has been successfully confirmed.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}