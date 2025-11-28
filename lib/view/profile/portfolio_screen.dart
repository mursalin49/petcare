import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart'; // Ensure this is imported
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Ensure these paths are correct for your project
import 'package:petcare/view/profile/add_portfolio_screen.dart';
import '../../utils/app_colors.dart';
import 'portfolio_controller.dart';
import 'edit_portfolio_screen.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioController = Get.put(PortfolioController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Portfolio',
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // --- Add Portfolio Button (Dotted Border) ---
            GestureDetector(
              onTap: () => Get.to(() => AddPortfolioScreen()),
              child: Container(
                width: double.infinity,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    color: AppColors.mainAppColor,
                    strokeWidth: 2.w, // Thickness of the dashes
                    dashWidth: 8.w,   // Length of each dash
                    dashSpace: 4.w,   // Space between dashes
                    borderRadius: 10.r,
                  ),
                  child: Center(
                    child: Text(
                      'Add Portfolio',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainAppColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // --- Portfolio List (Uses Obx) ---
            Obx(() {
              if (portfolioController.portfolioImages.isEmpty) {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text('No portfolio images added yet.',
                            style:
                            GoogleFonts.montserrat(color: Colors.grey))));
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

  void _showDeleteDialog(BuildContext context, PortfolioController controller) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Image',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
        content: Text('Are you sure you want to delete this image from your portfolio?',
            style: GoogleFonts.montserrat()),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.montserrat(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              controller.deleteImage(imagePath);
              Get.back();
            },
            child: Text('Delete',
                style: GoogleFonts.montserrat(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.file(
              File(imagePath),
              height: 200.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Delete Button (SVG with White Circle Background)
          Positioned(
            top: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () => _showDeleteDialog(context, controller),
              child: Container(
                padding: EdgeInsets.all(5.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/trash.svg',
                  height: 20.r,
                  width: 20.r,
                  colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Painter for Dashed Border (Unchanged) ---
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(borderRadius),
      ));

    final dashPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double length = draw ? dashWidth : dashSpace;
        if (distance + length > metric.length) {
          if (draw) {
            dest.addPath(
                metric.extractPath(distance, metric.length), Offset.zero);
          }
          break;
        }
        if (draw) {
          dest.addPath(
              metric.extractPath(distance, distance + length), Offset.zero);
        }
        distance += length;
        draw = !draw;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}