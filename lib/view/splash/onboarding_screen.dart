import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/helpers/route.dart';
import '../../utils/app_colors.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget{
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset("assets/images/appLogo.svg"),
                  GestureDetector(
                    onTap: (){
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
              Center(
                child: Image.asset(
                  "assets/images/signinImg.png",
                ),
              ),
              SizedBox(height: 18),
              Text(
                "You Trusted and loving pet \ncare app' (TBC",
                style: TextStyle(
                  fontFamily: 'BaksoSapi',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color:Color(0xFFFE6C5D),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.094),

              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.mainAppColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "Find pet care",
                    style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.mainAppColor, width: 2)
                  ),
                  child: Text(
                    "Become a sitter",
                    style: TextStyle(
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainAppColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}