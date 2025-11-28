import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import 'DoggyDayCareController.dart';



class DoggyDayCareSetupScreen extends StatelessWidget {
  final bool isEditing;
  const DoggyDayCareSetupScreen({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoggyDayCareController());
    final buttonText = isEditing ? 'Save Service' : 'Create Service';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(context, isEditing),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            // Info Banner
            _buildInfoBanner(),
            SizedBox(height: 20.h),

            // Set your base rate
            _buildSectionTitle('Set your base rate'), // Removed isMainTitle for simplicity
            _buildRateInput(
              title: 'Set your base rate',
              controller: controller.baseRateController, // Use controller
              keepPercentage: 'What you will earn per service: \$24.00',
              isStandalone: true,
            ),

            // Checkbox (Update my additional rates)
            Obx(() =>
                _buildSquareCheckbox(
                  text: 'Update my additional rates based on my base rate',
                  value: controller.updateRatesBasedOnBase.value,
                  onChanged: (val) =>
                  controller.updateRatesBasedOnBase.value = val!,
                )),
            Text(
              'Turn off to adjust your rate manually',
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: AppColors.secondaryText,
              ),
            ),

            SizedBox(height: 20.h),

            // --- Additional Rates Section (Fixed logic) ---
            Obx(() {
              if (controller.showAdditionalRates.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Holiday Rate
                    _buildSectionTitle('Holiday Rate', topPadding: 0),
                    _buildRateInput(
                      title: 'Holiday Rate',
                      controller: controller.holidayRateController,
                    ),

                    // Puppy Rate
                    _buildSectionTitle('Puppy Rate', topPadding: 0),
                    _buildRateInput(
                      title: 'Puppy Rate',
                      controller: controller.puppyRateController,
                    ),

                    // Bathing / Grooming
                    _buildSectionTitle('Bathing / Grooming', topPadding: 0),
                    _buildRateInput(
                      title: 'Bathing / Grooming',
                      controller: controller.groomingRateController,
                      addBottomSpacing: false, // Checkbox below provides spacing
                    ),
                    Obx(() =>
                        _buildSquareCheckbox(
                          text: 'Offer for free',
                          value: controller.offerGroomingForFree.value,
                          onChanged: (val) =>
                          controller.offerGroomingForFree.value = val!,
                        )),
                    SizedBox(height: 10.h),

                    // Daily Sitter Pick-Up/Drop-Off
                    _buildSectionTitle('Daily Sitter Pick-Up/Drop-Off', topPadding: 0),
                    _buildRateInput(
                      title: 'Daily Sitter Pick-Up/Drop-Off',
                      controller: controller.pickupDropOffRateController,
                      keepPercentage: 'You keep: 80%',
                      addBottomSpacing: true,
                    ),

                    // Hide Button (Visible when rates are SHOWN)
                    _buildShowHideButton(
                      'Hide additional rates',
                      controller.toggleAdditionalRates,
                      controller.showAdditionalRates.value,
                    ),

                    SizedBox(height: 30.h),
                  ],
                );
              }

              // Show Button (Visible when rates are HIDDEN)
              return Column(
                children: [
                  SizedBox(height: 10.h),
                  _buildShowHideButton(
                    'Show additional rates',
                    controller.toggleAdditionalRates,
                    controller.showAdditionalRates.value,
                  ),

                  SizedBox(height: 30.h),
                ],
              );
            }),
            // --- End Additional Rates Section ---


            // Availability (Starts here, topPadding: 0 ensures continuity after divider)
            _buildSectionTitle('Availability', topPadding: 0),
            Text(
              'Are you home full-time during the week?',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.primaryText,
              ),
            ),
            SizedBox(height: 10.h),

            Obx(() =>
                Row(
                  children: [
                    _buildRadioOption(
                      text: 'Yes',
                      value: true,
                      groupValue: controller.isFullTimeAvailable.value,
                      onChanged: (val) =>
                      controller.isFullTimeAvailable.value = val!,
                    ),
                    SizedBox(width: 20.w),
                    _buildRadioOption(
                      text: 'No',
                      value: false,
                      groupValue: controller.isFullTimeAvailable.value,
                      onChanged: (val) =>
                      controller.isFullTimeAvailable.value = val!,
                    ),
                  ],
                )),
            SizedBox(height: 15.h),

            Text(
              'You can edit any date individually by going to your calendar.',
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: AppColors.secondaryText,
              ),
            ),
            SizedBox(height: 10.h),
            _buildDaySelectors(controller),
            SizedBox(height: 30.h),

            // Potty Breaks
            _buildSectionTitle('How frequently can you provide potty breaks?'),
            Wrap(
              spacing: 20.w,
              runSpacing: 10.h,
              children: [
                _buildPottyBreakOption('0-2 hours', controller),
                _buildPottyBreakOption('2-4 hours', controller),
                _buildPottyBreakOption('4-8 hours', controller),
                _buildPottyBreakOption('8+ hours', controller),
              ],
            ),
            SizedBox(height: 30.h),

            // Pet Preferences Section
            _buildSectionTitle('Pet preferences'),
            Text(
              'How many pets per day can you host in your home?',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.primaryText,
              ),
            ),
            SizedBox(height: 10.h),
            _buildPetCountSelector(controller),
            SizedBox(height: 30.h),

            _buildSectionTitle('What type of pets can you host in your home?'),
            SizedBox(height: 10.h),
            ...controller.petSizes.keys.map((key) =>
                Obx(() =>
                    _buildSquareCheckbox(
                      text: key,
                      value: controller.petSizes[key]!.value,
                      onChanged: (val) =>
                      controller.petSizes[key]!.value = val!,
                    ))).toList(),
            SizedBox(height: 30.h),

            // About your home
            _buildSectionTitle('About your home'),
            Text(
              'What type of home do you live in?',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.primaryText,
              ),
            ),
            SizedBox(height: 10.h),
            ...controller.homeTypes.keys.map((key) =>
                Obx(() =>
                    _buildSquareCheckbox(
                      text: key,
                      value: controller.homeTypes[key]!.value,
                      onChanged: (val) =>
                      controller.homeTypes[key]!.value = val!,
                    ))).toList(),
            SizedBox(height: 20.h),

            Text(
              'What type of yard do you have?',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.primaryText,
              ),
            ),
            SizedBox(height: 10.h),
            ...controller.yardTypes.keys.map((key) =>
                Obx(() =>
                    _buildSquareCheckbox(
                      text: key,
                      value: controller.yardTypes[key]!.value,
                      onChanged: (val) =>
                      controller.yardTypes[key]!.value = val!,
                    ))).toList(),
            SizedBox(height: 30.h),

            // Boarding Expectations
            _buildSectionTitle(
                'What can pet owners expect when boarding at your home?'),
            SizedBox(height: 10.h),
            ...controller.boardingExpectations.keys.map((key) =>
                Obx(() =>
                    _buildSquareCheckbox(
                      text: key,
                      value: controller.boardingExpectations[key]!.value,
                      onChanged: (val) =>
                      controller.boardingExpectations[key]!.value = val!,
                    ))).toList(),
            SizedBox(height: 30.h),

            // Hosting Abilities
            _buildSectionTitle('Are you able to host any of the following?'),
            SizedBox(height: 10.h),
            ...controller.hostingAbilities.keys.map((key) =>
                Obx(() =>
                    _buildSquareCheckbox(
                      text: key,
                      value: controller.hostingAbilities[key]!.value,
                      onChanged: (val) =>
                      controller.hostingAbilities[key]!.value = val!,
                    ))).toList(),
            SizedBox(height: 30.h),

            // Cancellation Policy
            _buildSectionTitle(
                'What is your cancellation policy for Doggy Day Care?'),
            SizedBox(height: 10.h),
            ...controller.cancellationPolicy.keys.map((key) =>
                Obx(() =>
                    _buildSquareCheckbox(
                      text: key,
                      value: controller.cancellationPolicy[key]!.value,
                      onChanged: (val) =>
                      controller.cancellationPolicy[key]!.value = val!,
                    ))).toList(),
            SizedBox(height: 20.h),
            // Padding to ensure content above the sticky footer is visible
            SizedBox(height: 80.h),
          ],
        ),
      ),

      // Sticky Footer
      bottomNavigationBar: _buildStickyFooter(context, buttonText, isEditing),
    );
  }

  // --- Helper Widgets (Updated or Reused from Boarding) ---

  AppBar _buildCustomAppBar(BuildContext context, bool isEditing) {
    return AppBar(
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size: 24),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Doggy Day Care',
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
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.edit,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              height: 24.w,
              width: 24.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppColors.grey, size: 18.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'We have suggested some default settings based on what works well for new sitters and walkers. You can edit now, or at any time in the future.',
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: AppColors.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {double topPadding = 20}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: topPadding.h),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  Widget _buildShowHideButton(String text,
      VoidCallback onPressed,
      bool isHideButton,) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.mainAppColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              isHideButton ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }

  // 2. _buildRateInput - Changed to use TextEditingController
  Widget _buildRateInput({
    required String title,
    required TextEditingController controller, // Changed from initialValue: String to TextEditingController
    String keepPercentage = 'You keep: \$24.00',
    String rateUnit = 'Per day', // Added rateUnit for clarity
    bool isStandalone = false, // Base Rate-এর জন্য ব্যবহৃত
    bool addBottomSpacing = true, // Default to true for spacing between rates
  }) {
    // Only used for the base rate's secondary text, otherwise titles come from _buildSectionTitle
    final showKeepText = title != 'Daily Sitter Pick-Up/Drop-Off';
    final keepText = showKeepText ? 'You keep: \$24.00' : keepPercentage;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title logic removed here to avoid double headers.

        SizedBox(height: isStandalone ? 5.h : 0.h),

        Container(
          height: 45.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.Secondaryborder),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              // Left side text (e.g., 'Per day')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  rateUnit,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    color: AppColors.grey,
                  ),
                ),
              ),
              // Vertical Divider
              const VerticalDivider(width: 1, color: AppColors.Secondaryborder),

              // Right side Input Field (TextFormField for manual input)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextFormField(
                    controller: controller, // Use the provided controller
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textDark,
                    ),
                    decoration: InputDecoration(
                      prefixText: '\$',
                      prefixStyle: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark,
                      ),
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Keep text
        Padding(
          padding: EdgeInsets.only(
            top: 4.h,
            bottom: addBottomSpacing ? 10.h : 5.h,
          ),
          child: Text(
            keepText,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: AppColors.secondaryText,
            ),
          ),
        ),

        if (!isStandalone && addBottomSpacing)
          SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildRadioOption({
    required String text,
    required bool value,
    required bool groupValue,
    required ValueChanged<bool?> onChanged,
  }) {
    // Reused helper widget
    return Row(
      children: [
        Radio<bool>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.mainAppColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildDaySelectors(DoggyDayCareController controller) {
    // Reused helper widget
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF9ABFC8), width: 1.r),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: days.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          final bool showRightDivider = index < days.length - 1;

          return Expanded(
            child: Obx(() {
              final isActive = controller.selectedDays.contains(day);
              return InkWell(
                onTap: () => controller.toggleDay(day),
                child: Container(
                  height: 35.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.mainAppColor : AppColors.white,
                    border: Border(
                      right: showRightDivider
                          ? BorderSide(color: const Color(0xFF9ABFC8), width: 1.r)
                          : BorderSide.none,
                    ),
                  ),
                  child: Text(
                    day,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPottyBreakOption(String text, DoggyDayCareController controller) {
    // Reused helper widget
    return SizedBox(
      width: (MediaQuery
          .of(Get.context!)
          .size
          .width - 32.w - 20.w) / 2,
      child: InkWell(
        onTap: () => controller.selectedPottyBreak.value = text,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() =>
                Radio<String>(
                  value: text,
                  groupValue: controller.selectedPottyBreak.value,
                  onChanged: (val) =>
                  controller.selectedPottyBreak.value = val!,
                  activeColor: AppColors.mainAppColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: AppColors.primaryText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetCountSelector(DoggyDayCareController controller) {
    // Reused helper widget
    return Row(
      children: [
        _buildCounterButton(
          icon: Icons.remove,
          onPressed: controller.decrementPetCount,
        ),
        SizedBox(width: 15.w),
        Obx(() =>
            Container(
              width: 35.r,
              height: 35.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.inputBorder),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                controller.petCount.value.toString(),
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryText,
                ),
              ),
            )),
        SizedBox(width: 15.w),
        _buildCounterButton(
          icon: Icons.add,
          onPressed: controller.incrementPetCount,
        ),
      ],
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    // Reused helper widget
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: 35.r,
        height: 35.r,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: AppColors.mainAppColor, size: 20.r),
      ),
    );
  }

  Widget _buildSquareCheckbox({
    required String text,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    // Reused helper widget
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.mainAppColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.r),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter(BuildContext context, String text, bool isEditing) {
    // Reused helper widget
    final snackbarTitle = isEditing ? 'Service Saved' : 'Service Created';
    final snackbarMessage = 'The Dog Day Care service settings have been ${isEditing ? 'saved' : 'created'}.';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.mainAppColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextButton(
          onPressed: () {
            // Action based on mode
            Get.snackbar(
              snackbarTitle,
              snackbarMessage,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: Text(
            text, // Dynamic Text (Save Service or Create Service)
            style: GoogleFonts.montserrat(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}