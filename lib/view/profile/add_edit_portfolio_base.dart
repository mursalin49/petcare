// Placeholder class for the dotted border effect
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  const DottedBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // This is a simplified placeholder for the visual DottedBorder effect
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          style: BorderStyle.none,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}

// Base screen for Add/Edit
class PortfolioBaseScreen extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onAction;

  const PortfolioBaseScreen({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onAction,
  });

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
          title,
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
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // --- Image Upload Area ---
            DottedBorderContainer(
              child: Icon(
                Icons.camera_alt_outlined,
                size: 40.r,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30.h),

            // --- Action Button (Publish/Save Changes) ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainAppColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextButton(
                onPressed: onAction,
                child: Text(
                  buttonText,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}