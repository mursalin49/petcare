import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/view/profile/payments_screen.dart';
import 'package:petcare/view/profile/portfolio_screen.dart';
import 'package:petcare/view/profile/privacy_policy_screen.dart';
import 'package:petcare/view/profile/promo_code.dart';
import 'package:petcare/view/profile/services_screen.dart';
import 'package:petcare/view/profile/terms_condition_screen.dart';


import '../../Controller/profile_controller.dart';
import '../../utils/app_colors.dart';
import 'account_setting.dart';
import 'change_password_screen.dart';
import 'delate_account.dart';
import 'edit_profile_screen.dart';
import 'help_support_screen.dart';

final controller = Get.put(ProfileController());


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // --- Helper Widgets ---

  Widget _buildRoleButton(IconData icon, String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainAppColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.mainAppColor : AppColors.foundationColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? Colors.white : AppColors.mainAppColor,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.mainAppColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // New widget for the card-based sections with shadow and rounded corners
  Widget _buildCardSection({String? title, required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE3E6F0),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 16.h),
          ],
          child,
        ],
      ),
    );
  }

  // Helper for the column layout in Earnings Summary
  Widget _buildEarningColumn(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.subHeadingColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          amount,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  // Helper for all menu items
  Widget _buildMenuItem({
    String? svgIcon,
    IconData? icon,
    required String title,
    required VoidCallback onTap,
    Color? titleColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [

            if (svgIcon != null)
              SvgPicture.asset(
                svgIcon,
                width: 22.w,
                height: 22.h,
                color: titleColor ?? Colors.black87,
              )

            else if (icon != null)
              Icon(
                icon,
                size: 22.sp,
                color: titleColor ?? Colors.black87,
              ),

            SizedBox(width: 12.w),

            // Text
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? Color(0xFF585858),
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }


  // Helper for menu item dividers
  Widget _buildDivider() {
    return Divider(
      color: AppColors.foundationColor,
      height: 1,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile',
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
        child: Column(
          children: [
            // Profile Picture and Info Section - Uses white background
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  // Profile Picture
                  Stack(
                    children: [
                      Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.white,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child:   Image.asset(
                            'assets/images/profileImg.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.foundationColor,
                                child: Icon(
                                  Icons.person,
                                  size: 60.sp,
                                  color: AppColors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 36.w,
                          height: 36.w,


                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  // Name
                  Text(
                    'Seam Rahman',
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset(
                        'assets/icons/location.svg',
                        width: 16.w,
                        height: 16.h,
                        // color: AppColors.foundationColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'New York, NY',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.foundationColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/star.svg',
                        width: 16.w,
                        height: 16.h,
                        // color: AppColors.foundationColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '4.9 (42 reviews)',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.white, // Light pink background
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.mainAppColor, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite, color: Color(0xFFFF6B8A), size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Sitter on Wuffoos',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainAppColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            // Padding between top section and first card
            SizedBox(height: 16.h),

            // **Earnings Summary Section (Card Style)**
            _buildCardSection(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Title
                  Text(
                    'Earnings Summary',
                    style: GoogleFonts.montserrat(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Total Income and Promo Code Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Income',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textDark.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '\$900.50',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const PromoCodeScreen()),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.mainAppColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.only(bottom: 3.h),
                          child: Text(
                            'Apply Promo Code',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mainAppColor,
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Monthly/Pending Earnings Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildEarningColumn('This Month', '\$842.00'),
                      _buildEarningColumn('Last Month', '\$753.50'),
                      _buildEarningColumn('Pending', '\$135.00'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // **Account Information Section (Card Style)**
            _buildCardSection(
              title: 'Account Information',
              child: Column(
                children: [
                  _buildMenuItem(
                    svgIcon: "assets/icons/edit.svg",
                    title: 'Edit Profile',
                    onTap: () => Get.to(() => const EditProfileScreen()),
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/change.svg",
                    title: 'Change password',
                    onTap: () => Get.to(() => const ChangePasswordScreen()),
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/payment-method.svg",
                    title: 'Payments',
                    onTap: () => Get.to(() => const PaymentsScreen()),
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/serviceIcon.svg",
                    title: 'Services',
                    onTap: () => Get.to(() => const YourServicesScreen()),
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/portfolio.svg",
                    title: 'Portfolio',
                    onTap: () => Get.to(() => PortfolioScreen()),
                  ),

                  // Switch Profile Item
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // SvgPicture.asset(
                        //   "assets/icons/switch.svg",
                        //   width: 22.w,
                        //   height: 22.h,
                        //   color: AppColors.mainAppColor,
                        // ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Text(
                            'Switch profile',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Obx(() => Switch(
                          value: controller.switchProfile.value,
                          onChanged: controller.toggleSwitch,
                          activeColor: AppColors.mainAppColor,
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // privacy and policy
            SizedBox(height: 8),
            _buildCardSection(
              title: 'Policy Center',
              child: Column(
                children: [
                  _buildMenuItem(
                    svgIcon: "assets/icons/shield-check.svg",
                    title: 'Privacy Policy',
                    onTap: () => Get.to(() => const PrivacyPolicyScreen()),
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/command-line.svg",
                    title: 'Terms & Condition',
                    onTap: () => Get.to(() => const TermsConditionScreen()),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),

            // **Settings Section (Card Style)**

            _buildCardSection(
              title: 'Settings',
              child: Column(
                children: [
                  _buildMenuItem(
                    svgIcon: "assets/icons/account-setting-03.svg",
                    title: 'Account Settings',
                    onTap: () => Get.to(() => account()),
                  ),
                  _buildMenuItem(
                    svgIcon: "assets/icons/help-circle.svg",
                    title: 'Help & Support',
                    onTap: () => Get.to(() => const HelpSupportScreen()),
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/logout (1).svg",
                    title: 'Log Out',
                    onTap: () {},
                  ),

                  _buildMenuItem(
                    svgIcon: "assets/icons/elements.svg",
                    title: 'Delete Account',
                    titleColor: Colors.red,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DeleteAccountDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}