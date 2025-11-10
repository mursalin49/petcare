import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart'; // <<< 1. Import flutter_svg

import '../../helpers/route.dart';
import '../../utils/app_colors.dart';

class SitterOnboardingScreen extends StatelessWidget {
  const SitterOnboardingScreen({super.key});
  static const String dog1Asset = 'assets/images/dog1.png';
  static const String dog2Asset = 'assets/images/dog2 (2).png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Become a Sitter',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Section: Get paid to play with pets ---
            Text('Get paid to play with pets', style: GoogleFonts.montserrat(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 10.h),
            const Text(
              'Wuffoos makes it easy and promotes you to the nation\'s largest network of pet owners, delivering dog-walking, connecting you love.',
              style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black54),
            ),
            SizedBox(height: 20.h),
            _buildPrimaryButton(text: 'Get started', onPressed: () {
              Get.toNamed(AppRoutes.loginScreen);
            }),

            SizedBox(height: 30.h),

            // --- Section: Flexibility puts you in control ---
            Text('Flexibility puts you in control', style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
            SizedBox(height: 10.h),

            _buildCheckListItem('Set your own schedule and prices'),
            _buildCheckListItem('Offer any combination of pet care home'),
            _buildCheckListItem('Set the, age and other pet preferences that work for you.'),

            SizedBox(height: 20.h),

            // Image and text box sections... (omitted for brevity)
            // ...

            // --- Image 1 (dog1.png) ---
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  dog1Asset,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200.h,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: Text('Image not found: dog1.png', style: GoogleFonts.montserrat(color: Colors.red)),
                    );
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -30.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Text(
                  "It's easy. I go to the calendar and mark myself as available when I want to be.",
                  style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text('The tools to succeed', style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
            SizedBox(height: 10.h),
            _buildCheckListItem('The Wuffoos Guarantee which includes up to \$25,000 in vet cost reimbursement'),
            _buildCheckListItem('Manage your pet sitting schedule and more with the Wuffoos app'),
            _buildCheckListItem('24/7 support, including vet assistance'),
            SizedBox(height: 30.h),
            Text('How it works', style: GoogleFonts.montserrat(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 20.h),
            _buildHowItWorksItem(title: 'Create your profile', description: 'Tell us a little about yourself and what pet home you want to offer.'),
            _buildHowItWorksItem(title: 'Accept requests', description: 'Tell us the types of pets you want to care for and the dates that work for you. You make your own schedule.'),
            _buildHowItWorksItem(title: 'Get paid', description: 'Payments are sent directly to your bank once you have completed a service.'),
            SizedBox(height: 10.h),
            _buildPrimaryButton(text: 'Get started', onPressed: () {
              Get.toNamed(AppRoutes.loginScreen);
            }),
            SizedBox(height: 20.h),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  dog2Asset,
                  height: 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200.h,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: Text('Image of Sitting Dog here', style: GoogleFonts.montserrat(color: Colors.grey)),
                    );
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -30.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))],
                ),
                child: Text(
                  "Thanks to the Wuffoos App, I know about my clients schedule immediately and I'm quick to respond!",
                  style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.black87, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            // ...

            // --- Section: Services ---
            Text('Services', style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 15.h),

            _buildServiceCard(

                svgIconPath: 'assets/icons/bording.svg',
                title: 'Boarding',
                subtitle: 'Care for a dog or cat overnight in your home. Sitters who offer boarding can make up to 3x more than sitters don\'t.',
                highlight: 'HIGHEST EARNING'
            ),

            // Example 2: Using the standard IconData (if svgIconPath is null)
            _buildServiceCard(
              svgIconPath: 'assets/icons/doggy.svg',
              title: 'Doggy Day Care',
              subtitle: 'Watch dogs during the day. Drop off and pick up in their own homes.',
            ),

            // Example 3: Using the NEW svgIconPath
            _buildServiceCard(
              svgIconPath: 'assets/icons/doggyfoot.svg', // <<< Using another SVG icon
              title: 'Dog Walking',
              subtitle: 'Take dogs out for a walk in your schedule.',
            ),

            SizedBox(height: 30.h),

            // --- Safety section... (omitted for brevity) ---
            Text('Safety first. Always.', style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87)),
            SizedBox(height: 10.h),
            const Text('We work tirelessly to ensure tails keep wagging and purrs keep coming.', style: TextStyle(fontSize: 14, height: 1.5, color: Colors.black54)),
            SizedBox(height: 15.h),
            _buildSafetyCheckListItem('Every service you offer on Wuffoos is backed by The Wuffoos Guarantee'),
            _buildSafetyCheckListItem('Safe, secured, and convenient online payments'),
            _buildSafetyCheckListItem('A top tier support team available 24/7'),
            _buildSafetyCheckListItem('Ongoing pet parent and sitter education'),
            SizedBox(height: 30.h),
            Text('Connect with pet owners ones your profile is approve', style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
            SizedBox(height: 10.h),
            _buildPrimaryButton(text: 'Start creating your profile', onPressed: () {}),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  // --- Utility Widgets ---

  Widget _buildPrimaryButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mainAppColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }

  // ... (Other utility widgets like _buildCheckListItem, _buildSafetyCheckListItem, _buildHowItWorksItem are unchanged)
  Widget _buildCheckListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check, color: AppColors.mainAppColor, size: 20.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, height: 1.5, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyCheckListItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: AppColors.mainAppColor, size: 20.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, height: 1.5, color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksItem({required String title, required String description}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.mainAppColor)),
          SizedBox(height: 5.h),
          Text(description, style: GoogleFonts.montserrat(fontSize: 14.sp, height: 1.4, color: Colors.black54)),
        ],
      ),
    );
  }

  // <<< 2. Modified _buildServiceCard to accept IconData or String? svgIconPath
  Widget _buildServiceCard({
    IconData? icon, // Made optional (IconData?)
    String? svgIconPath, // New optional parameter for SVG path
    required String title,
    required String subtitle,
    String? highlight,
  }) {
    // Determine which icon to display
    Widget iconWidget;
    if (svgIconPath != null) {
      // If SVG path is provided, use SvgPicture.asset
      iconWidget = SvgPicture.asset(
        svgIconPath,
        height: 28.r,
        width: 28.r,
        // Use colorFilter to apply the primary color to the SVG
        colorFilter: ColorFilter.mode(AppColors.mainAppColor, BlendMode.srcIn),
      );
    } else if (icon != null) {
      // If IconData is provided, use standard Icon
      iconWidget = Icon(icon, size: 28.r, color: AppColors.mainAppColor);
    } else {
      // Fallback: If neither is provided, use a placeholder
      iconWidget = SizedBox(width: 28.r);
    }

    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5)],
          border: Border.all(color: Colors.grey.shade200, width: 1.r)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWidget, // <<< Display the chosen icon widget
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                    if (highlight != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.yello,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          highlight,
                          style: GoogleFonts.montserrat(fontSize: 10.sp, fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(subtitle, style: GoogleFonts.montserrat(fontSize: 13.sp, height: 1.4, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}