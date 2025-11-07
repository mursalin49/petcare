import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/helpers/route.dart';
import 'package:petcare/view/splash/sitter_onboarding_screen.dart';
import '../../utils/app_colors.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              // --- Header with Logo and Sign In ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/images/appLogo.svg"),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Login Screen
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainAppColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.044),

              // --- Image ---
              Center(
                child: Image.asset(
                  "assets/images/signinImg.png",
                ),
              ),
              SizedBox(height: 18),

              // --- Title Text ---
              Text(
                "You Trusted and loving pet \ncare app' (TBC",
                style: TextStyle(
                  fontFamily: 'BaksoSapi',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFE6C5D),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.094),

              // --- Action Buttons (Refactored) ---
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  /// Action buttons
  Widget _buildActionButtons() {
    return Column(
      children: [
        // 'Find pet care' button - Assuming this should lead to the main app flow or login/signup.
        _customButton(
          "Find pet care",
          // The original code navigated to AppRoutes.sitter.
          // For finding care, maybe it should navigate to a main screen or stay as sitter onboarding for now.
          // I've kept the original navigation for consistency but you might want to change it.
          // Get.toNamed(AppRoutes.sitter),
              () => Get.toNamed(AppRoutes.loginScreen), // Use appropriate route
          isFilled: true,
        ),
        SizedBox(height: 16.h),

        // 'Become a sitter' button
        _customButton(
          "Become a sitter",
              () => Get.toNamed(AppRoutes.sitter), // Navigate to Sitter Onboarding/Flow
          isFilled: false,
        ),
      ],
    );
  }

  /// Reusable custom button
  Widget _customButton(String text, VoidCallback onTap, {bool isFilled = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: isFilled ? 14.h : 12.h),
        decoration: BoxDecoration(
          color: isFilled ? AppColors.mainAppColor : AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border:
          isFilled ? null : Border.all(color: AppColors.mainAppColor, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Montserrat-Bold',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isFilled ? AppColors.white : AppColors.mainAppColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  }
