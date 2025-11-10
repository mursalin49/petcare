import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

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
          'Terms & Condition',
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Title
            Text(
              "Terms & Condition",
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "Welcome to Services App !\n\n"
                  "Accessing or using our home, you agree to be bound "
                  "by these Terms of Service. If you do not agree with any "
                  "part of the terms, you must not use our home.",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "2. User Responsibilities As a user, you agree to:",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 10.h),

            _bullet("Use the service only for lawful purposes."),
            _bullet("Provide accurate and complete information when required."),
            _bullet("Maintain the confidentiality of your account password."),

            SizedBox(height: 20.h),

            Text(
              "3. Intellectual Property",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              "All content, trademarks, and data on this service, including but not limited to text, "
                  "graphics, logos, and images, are the property of [Your Company Name].",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "4. Disclaimers",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "The service is provided on an \"as is\" and \"as available\" "
                  "basis. [Your Company Name] makes no warranties, expressed "
                  "or implied, regarding the operation.",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "5. Disclaimers",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "The service is provided on an \"as is\" and \"as available\" "
                  "basis. [Your Company Name] makes no warranties, expressed "
                  "or implied, regarding the operation.",
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              "6. Disclaimers",
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "The service is provided on an \"as is\" and \"as available\" "
                  "basis. [Your Company Name] makes no warranties, expressed "
                  "or implied, regarding the operation.",
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

  Widget _bullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
