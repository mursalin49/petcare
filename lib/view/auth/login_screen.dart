import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helpers/route.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../components/custom_text_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool agree = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                SvgPicture.asset("assets/images/appLogo.svg"),
                SizedBox(height: 10.h),

                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontFamily: 'BaksoSapi',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainAppColor,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "Login to your account",
                  style: TextStyle(
                    fontFamily: 'Montserrat-Bold',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7A7A7A),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.065),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    border: const Border(
                      top: BorderSide(
                      color: AppColors.mainAppColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Enter your E-mail or Number",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF303030),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          textEditingController: emailController,
                          hintText: 'Enter your E-mail or Number',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Color(0xFF5E5E5E),
                          ),
                          fillColor: Color(0xFFFFFFFF),
                          fieldBorderColor: AppColors.borderColor,
                        ),
                        SizedBox(height: 16.h,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF303030),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          textEditingController: passController,
                          hintText: '**********',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.subHeadingColor,
                          ),
                          isPassword: true,
                          fillColor: Color(0xFFFFFFFF),
                          fieldBorderColor: AppColors.borderColor,
                        ),

                        SizedBox(height: 8.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => agree = !agree),
                              child: Container(
                                height: 18.h,
                                width: 18.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.mainAppColor, width: 1.5),
                                  borderRadius: BorderRadius.circular(4),
                                  color: agree ? AppColors.mainAppColor : Colors.transparent,
                                ),
                                child: agree
                                    ? SvgPicture.asset(
                                  "assets/icons/checkIcon.svg",
                                  height: 14.h,
                                  width: 14.w,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Remember me',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF737373),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: (){
                                Get.toNamed(AppRoutes.forgotPasswordScreen);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF5C5C),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                        GestureDetector(
                          onTap: (){
                           Get.offNamed(AppRoutes.bottomNavScreen);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: AppColors.mainAppColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'BaksoSapi',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: Color(0xFFB1B1B1),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                "Or Continue With",
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF303030),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1.5,
                                color: Color(0xFFB1B1B1),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google Button
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF0B0E12).withOpacity(0.20),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: IconButton(
                                onPressed: () async {

                                },
                                icon: SvgPicture.asset(AppIcons.googleIcon, width: 20, height: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ),

                            SizedBox(width: 10.w),

                            // apple Button
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF0B0E12).withOpacity(0.20),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: IconButton(
                                onPressed: () async {

                                },
                                icon: SvgPicture.asset(AppIcons.appleIcon, width: 20, height: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ),

                            SizedBox(width: 10.w),

                            // Facebook Button
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF0B0E12).withOpacity(0.20),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                              child: IconButton(
                                onPressed: () async {

                                },
                                icon: SvgPicture.asset(AppIcons.fbIcon, width: 20, height: 20),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account? ",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF2B2B2B),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  Get.toNamed(AppRoutes.signUpScreen);
                                },
                                child: Text(
                                  "Create Account",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2B2B2B),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: MediaQuery.of(context).size.height * 0.030),

              ],
            ),
        ),
      ),
    );
  }
}