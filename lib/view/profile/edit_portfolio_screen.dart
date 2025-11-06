import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import 'portfolio_controller.dart';

final PortfolioController portfolioController = Get.find();

class EditPortfolioScreen extends StatelessWidget {
  final String oldImagePath;

  const EditPortfolioScreen({super.key, required this.oldImagePath});

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
        title: Text('Edit Portfolio', style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Image', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),

            // --- Current Image Display Area with Replace Button Overlay ---
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.file(
                    File(oldImagePath),
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.change_circle_outlined, size: 40.r, color: Colors.white),
                        onPressed: () async {
                          // Call the replace function
                          await portfolioController.replaceImage(oldImagePath);
                          Get.back(); // Navigate back after replacement
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // --- Save Changes Button ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.mainAppColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text('Save Changes', style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}