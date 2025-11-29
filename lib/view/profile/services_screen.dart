import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../create_service/Boarding.dart';
import '../create_service/create_service.dart';
import '../create_service/dog_day_care.dart';
import '../create_service/DogWalking.dart'; // Import DogWalkingSetupScreen

class YourServicesScreen extends StatelessWidget {
  const YourServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.add, color: Colors.white),
        //     onPressed: () => Get.to(() => const CreateService()),
        //   ),
        // ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        children: [
          // --- Service 1: Boarding (EDIT MODE) ---
          _buildServiceCard(
            iconPath: 'assets/icons/calendar-add-01 (1).svg',
            title: 'Boarding',
            subtitle: 'In the sitter\'s home',
            price: '\$99',
            priceUnit: 'Per day',
            onTap: () {
              // Navigate to BoardingSetupScreen in EDITING MODE
              Get.to(() => const BoardingSetupScreen(isEditing: true));
            },
          ),
          SizedBox(height: 16.h),

          // --- Service 2: Doggy Day Care (EDIT MODE) ---
          _buildServiceCard(
            iconPath: 'assets/icons/home-hashtag.svg',
            title: 'Doggy Day Care',
            subtitle: 'In the sitter\'s home',
            price: '\$99',
            priceUnit: 'Per visit',
            onTap: () {
              // Navigate to DoggyDayCareSetupScreen in EDITING MODE
              Get.to(() => DoggyDayCareSetupScreen(isEditing: true));
            },
          ),
          SizedBox(height: 16.h),

          // --- Service 3: Dog Walking (EDIT MODE) ---
          _buildServiceCard(
            iconPath: 'assets/icons/doggy.svg',
            title: 'Dog Walking',
            subtitle: 'In your neighbourhood',
            price: '\$99',
            priceUnit: 'Per walk',
            onTap: () {
              // Navigate to DogWalkingSetupScreen in EDITING MODE
              Get.to(() => const DogWalkingSetupScreen(isEditing: true));
            },
          ),
        ],
      ),
    );
  }


  Widget _buildServiceCard({
    required String iconPath,
    required String title,
    required String subtitle,
    required String price,
    required String priceUnit,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [

            SvgPicture.asset(
              iconPath,
              height: 24.sp,
              width: 24.sp,
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
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),


            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  priceUnit,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}