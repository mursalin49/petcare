import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import 'contract_screen.dart' hide AppColors;
import 'faq_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          'Help & Support',
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
          _buildMenuItem(
            title: 'Faq',
            onTap: () {
              Get.to(() => const FaqScreen());
            },
          ),
          SizedBox(height: 16.h),
          _buildMenuItem(
            title: 'Contact Us',
            onTap: () => Get.to(() => const ContactUsScreen()),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    // required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.foundationColor),
        ),
        child: Row(
          children: [
            // Icon(icon, size: 24.sp, color: AppColors.mainAppColor),
            // SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.subHeadingColor),
          ],
        ),
      ),
    );
  }
}

