import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/profile_controller.dart';
import '../../utils/app_colors.dart';

final controller = Get.put(ProfileController());

class account extends StatelessWidget {
  const account({super.key});

  // Helper for collapsible section items
  Widget _buildCollapsibleItem({
    required String title,
    required RxBool isExpanded,
    required Widget expandedContent,
  }) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            InkWell(
              onTap: () => isExpanded.value = !isExpanded.value,
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    Icon(
                      isExpanded.value
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_right_rounded,
                      size: 22.sp,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
            ),

            // Expanded content
            if (isExpanded.value)
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
                ),
                child: expandedContent,
              ),
          ],
        ),
      );
    });
  }

  // Language option item
  Widget _buildLanguageOption({
    required String language,
    required RxString selectedLanguage,
  }) {
    return Obx(() {
      bool isSelected = selectedLanguage.value == language;
      return InkWell(
        onTap: () => selectedLanguage.value = language,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isSelected ? AppColors.mainAppColor : Colors.grey.shade200,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Center(
            child: Text(
              language,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.mainAppColor : Color(0xFF1F2937),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Notification toggle item
  Widget _buildNotificationToggle({
    required String title,
    required RxBool value,
    Function(bool)? onChanged,
  }) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1F2937),
              ),
            ),
            Transform.scale(
              scale: 0.85,
              child: Switch(
                value: value.value,
                onChanged: (newValue) {
                  value.value = newValue;
                  if (onChanged != null) {
                    onChanged(newValue);
                  }
                },
                activeColor: Colors.white,
                activeTrackColor: AppColors.mainAppColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create reactive variables
    final languageExpanded = false.obs;
    final notificationExpanded = false.obs;
    final selectedLanguage = 'English'.obs;
    final notificationAll = true.obs;
    final notificationBooking = true.obs;
    final notificationReminder = true.obs;

    // Listen to individual notification changes to update "All"
    void updateAllSwitch() {
      if (notificationBooking.value && notificationReminder.value) {
        notificationAll.value = true;
      } else {
        notificationAll.value = false;
      }
    }

    // Listen to "All" switch to control others
    void handleAllSwitch(bool value) {
      notificationAll.value = value;
      notificationBooking.value = value;
      notificationReminder.value = value;
    }

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
          'Account settings',
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
            SizedBox(height: 20.h),

            // Language Section
            _buildCollapsibleItem(
              title: 'Language',
              isExpanded: languageExpanded,
              expandedContent: Column(
                children: [
                  SizedBox(height: 8.h),
                  _buildLanguageOption(
                    language: 'English',
                    selectedLanguage: selectedLanguage,
                  ),
                  _buildLanguageOption(
                    language: 'Spanish',
                    selectedLanguage: selectedLanguage,
                  ),
                ],
              ),
            ),

            // Notifications Section
            _buildCollapsibleItem(
              title: 'Notifications',
              isExpanded: notificationExpanded,
              expandedContent: Column(
                children: [
                  _buildNotificationToggle(
                    title: 'All',
                    value: notificationAll,
                    onChanged: handleAllSwitch,
                  ),
                  _buildNotificationToggle(
                    title: 'Booking',
                    value: notificationBooking,
                    onChanged: (value) => updateAllSwitch(),
                  ),
                  _buildNotificationToggle(
                    title: 'Reminder',
                    value: notificationReminder,
                    onChanged: (value) => updateAllSwitch(),
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