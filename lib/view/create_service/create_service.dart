import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helpers/route.dart';
import '../../utils/app_colors.dart';

class CreateService extends StatelessWidget {
  const CreateService({super.key});

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
          'Services',
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

          // --- 1. Boarding Service ---
          _buildServiceItem(
            iconPath: 'assets/icons/calendar-add-01 (1).svg',
            title: 'Boarding',
            subtitle: 'In the sitter\'s home',
            onTap: () {
              Get.toNamed(AppRoutes.bording);
            },
          ),
          SizedBox(height: 16.h),

          // --- 2. House Sitting Service ---
          _buildServiceItem(
            iconPath: 'assets/icons/home-hashtag.svg',
            title: 'Doggy Day Care',
            subtitle: 'In your home',
            onTap: () {

              Get.toNamed(AppRoutes.dogDay);
            },
          ),
          SizedBox(height: 16.h),

          _buildServiceItem(
            iconPath: 'assets/icons/lochome.svg',
            title: 'Dog Walking',
            subtitle: 'Visits in your home',
            onTap: () {
              Get.toNamed(AppRoutes.dogwalk);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required String iconPath,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    const Color cardBorderColor = Color(0xFFE3E6F0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              colorFilter: ColorFilter.mode(AppColors.mainAppColor, BlendMode.srcIn),
              placeholderBuilder: (_) => SizedBox(height: 32.sp, width: 32.sp),
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
      ),
    );
  }
}