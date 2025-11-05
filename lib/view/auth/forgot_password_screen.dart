import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helpers/route.dart';
import '../../utils/app_colors.dart';
import '../components/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/backIcon.svg", width: 24.w, height: 24.h),
                    ),
                    Text(
                      "Forgot Password",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F1D1D),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F1D1D),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Don’t worry! Enter your registered email\nor phone number.",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF595959),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.059),

                Text(
                  "Enter your E-mail or Number",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF303030),
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  textEditingController: emailController,
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.subHeadingColor,
                  ),
                  fillColor: Color(0xFFFFFFFF),
                  fieldBorderColor: AppColors.borderColor,
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.030),

                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.oTPScreen);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.mainAppColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      "Send Reset Code",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE6E6E6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.044),

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remembered your password? ",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF2B2B2B),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.loginScreen);
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2B2B2B),
                          ),
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 5.h),

                Center(
                  child: InkWell(
                    onTap: (){
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: Text(
                      "Need Help?",
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2B2B2B),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.030),

              ],
            ),
          ),
        ),
      ),
    );
  }
}