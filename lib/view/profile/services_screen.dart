import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/app_colors.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Service',
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          SizedBox(height: 20.h),

          _buildServiceItem(
            iconPath:'assets/icons/fbIcon',
            title: 'Boarding',
            subtitle: 'In the sitter\'s home',
          ),
          SizedBox(height: 16.h),
          _buildServiceItem(
            iconPath: 'assets/icons/house_sitting.svg',
            title: 'House Sitting',
            subtitle: 'In your home',
          ),
          SizedBox(height: 16.h),
          _buildServiceItem(
            iconPath: 'assets/icons/drop_in_visits.svg', // Change this to your actual SVG path
            title: 'Drop-In Visits',
            subtitle: 'Visits in your home',
          ),
        ],
      ),
    );
  }


  Widget _buildServiceItem({
    required String iconPath,
    required String title,
    required String subtitle,
  }) {
    const Color cardBorderColor = Color(0xFFE3E6F0);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorderColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            height: 32.sp,
            width: 32.sp,
            // SVG-e color dewar jonno ColorFilter.mode use korte hoy
            colorFilter: ColorFilter.mode(AppColors.mainAppColor, BlendMode.srcIn),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.subHeadingColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: cardBorderColor),
        ],
      ),
    );
  }
}