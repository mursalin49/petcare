import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import 'portfolio_controller.dart';

class EditPortfolioScreen extends StatefulWidget {
  final String oldImagePath;

  const EditPortfolioScreen({super.key, required this.oldImagePath});

  @override
  State<EditPortfolioScreen> createState() => _EditPortfolioScreenState();
}

class _EditPortfolioScreenState extends State<EditPortfolioScreen> {
  File? selectedImage;
  final portfolioController = Get.find<PortfolioController>();

  @override
  void initState() {
    super.initState();
    selectedImage = File(widget.oldImagePath);
  }

  Future<void> pickNewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> saveChanges() async {
    if (selectedImage == null) {
      Get.snackbar('Error', 'No image selected');
      return;
    }

    // If image was changed
    if (selectedImage!.path != widget.oldImagePath) {
      await portfolioController.replaceImageWithFile(
          widget.oldImagePath, selectedImage!);
    }

    Get.back(); // Go back to portfolio screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Edit Portfolio',
            style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // --- Image Display Area with Camera Icon Overlay ---
            Container(
              width: double.infinity,
              height: 250.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Stack(
                children: [
                  selectedImage == null
                      ? CustomPaint(
                    painter: DashedBorderPainter(
                      color: AppColors.mainAppColor,
                      strokeWidth: 2.w,
                      dashWidth: 8.w,
                      dashSpace: 4.w,
                      borderRadius: 10.r,
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: pickNewImage,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20.r),
                              decoration: BoxDecoration(
                                color: AppColors.mainAppColor
                                    .withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 40.r,
                                color: AppColors.mainAppColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Tap to select image',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.file(
                      selectedImage!,
                      width: double.infinity,
                      height: 250.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Camera Icon Overlay - Only show when image is selected
                  if (selectedImage != null)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: pickNewImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(15.r),
                              decoration: BoxDecoration(
                                color: AppColors.mainAppColor.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                size: 35.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),

            // --- Save Changes Button ---
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.mainAppColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: TextButton(
                onPressed: saveChanges,
                child: Text('Save Changes',
                    style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

// --- Custom Painter for Dashed Border ---
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