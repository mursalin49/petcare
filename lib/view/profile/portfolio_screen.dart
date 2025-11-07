import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import 'portfolio_controller.dart';
import 'edit_portfolio_screen.dart';


final PortfolioController portfolioController = Get.put(PortfolioController());

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

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
          'Portfolio',
          style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // --- Add Portfolio Button ---
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainAppColor, width: 1.r),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextButton(
                onPressed: () => portfolioController.pickAndSaveImage(),
                child: Text('Add Portfolio', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.mainAppColor)),
              ),
            ),
            SizedBox(height: 20.h),

            // --- Portfolio List (Uses Obx) ---
            Obx(() {
              if (portfolioController.portfolioImages.isEmpty) {
                return Center(child: Padding(padding: EdgeInsets.only(top: 50.h), child: Text('No portfolio images added yet.', style: GoogleFonts.montserrat(color: Colors.grey))));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: portfolioController.portfolioImages.length,
                itemBuilder: (context, index) {
                  final imagePath = portfolioController.portfolioImages[index];
                  return PortfolioItemCard(imagePath: imagePath);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

// --- Individual Portfolio Card Widget ---
class PortfolioItemCard extends StatelessWidget {
  final String imagePath;
  const PortfolioItemCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final PortfolioController controller = Get.find();

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Stack(
        children: [
          // Image: Loads from local file path
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.file(
              File(imagePath),
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Edit/Delete Button
          Positioned(
            top: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                // Show options: Edit or Delete
                Get.bottomSheet(
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit, color: AppColors.mainAppColor),
                            title: Text('Edit Image', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                            onTap: () {
                              Get.back();
                              Get.to(() => EditPortfolioScreen(oldImagePath: imagePath));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete, color: Colors.red),
                            title: Text('Delete Image', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, color: Colors.red)),
                            onTap: () {
                              controller.deleteImage(imagePath);
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    )
                );
              },
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.mainAppColor, width: 1.r),
                ),
                child: Icon(
                  Icons.more_vert, // Use a more general icon to signify options
                  size: 18.r,
                  color: AppColors.mainAppColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}