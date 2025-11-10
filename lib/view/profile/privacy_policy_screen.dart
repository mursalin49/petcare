import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Privacy & Policy',
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

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Text("Privacy & policy" ,   style: GoogleFonts.montserrat(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.black87,
        ),),
SizedBox(height: 15.h),
            Text(
              "We collect personal information that you voluntarily provide to us when you register on "
                  "the [app/service], express an interest in obtaining information about us or our products "
                  "and home,\n\n"
                  "The personal information that we collect depends on the context of your interactions "
                  "with us and the [app/service], the choices you make, and the products and features you use.",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 15.h),

            Text(
              "1. Information we collect",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "The personal information that we collect depends on the context of your interactions "
                  "with us and the [app/service], the choices you make, and the products and features you use.",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 15.h),

            Text(
              "2. Information use collect",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "We process your personal information for these purposes in reliance on our legitimate "
                  "business interests, in order to enter into or perform a contract with you,",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
