import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import 'DogWalkingController.dart';



// ... DogWalkingController (as updated above) ...

// --- SCREENS ---

class DogWalkingSetupScreen extends StatelessWidget {
  final bool isEditing;
  const DogWalkingSetupScreen({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    Get.put(DogWalkingController());
    return DogWalkingServiceSetupScreen(isEditing: isEditing);
  }
}

class DogWalkingServiceSetupScreen extends StatelessWidget {
  final bool isEditing;
  const DogWalkingServiceSetupScreen({super.key, this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DogWalkingController>();
    final buttonText = isEditing ? 'Save Service' : 'Create Service';

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildCustomAppBar(context, isEditing),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBanner(),
            SizedBox(height: 20.h),

            _buildSectionTitle('Set your base rate'),
            // BASE RATE (Using new controller)
            _buildRateInputField(

              controller: controller.baseRateController,
              keepText: 'What you will earn per service: \$24.00',
              rateType: 'Per walk',
              showKeepText: true,
              isStandalone: true,
            ),
            SizedBox(height: 20.h),

            Obx(() => _buildSquareCheckbox(
              text: 'Update my additional rates based on my base rate',
              value: controller.updateAdditionalRates.value,
              onChanged: (val) => controller.updateAdditionalRates.value = val!,
            )),
            Text(
              'Turn off to adjust your rate manually',
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: AppColors.secondaryText,
              ),
            ),
            SizedBox(height: 20.h),

            // --- Additional Rates (Using new controllers) ---
            Obx(() {
              if (controller.showAdditionalRates.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('60 minute rate', topPadding: 0),
                    _buildRateInputField(

                      controller: controller.rate60MinController,
                      keepText: 'You keep: \$24.00',
                      rateType: 'Per day',
                      showKeepText: true,
                    ),
                    _buildSectionTitle('Holiday Rate', topPadding: 0),
                    _buildRateInputField(

                      controller: controller.holidayRateController,
                      keepText: 'You keep: \$24.00',
                      rateType: 'Per day',
                      showKeepText: true,
                    ),
                    _buildSectionTitle('Additional Rate', topPadding: 0),
                    _buildRateInputField(

                      controller: controller.additionalRateController,
                      keepText: 'You keep: \$24.00',
                      rateType: 'Per day',
                      showKeepText: true,
                    ),
                    _buildSectionTitle('Puppy Rate', topPadding: 0),
                    _buildRateInputField(

                      controller: controller.puppyRateController,
                      keepText: 'You keep: \$24.00',
                      rateType: 'Per day',
                      showKeepText: false, // Checkbox below provides spacing
                    ),
                    SizedBox(height: 15.h),
                    Obx(() =>
                        _buildSquareCheckbox(
                          text: 'Offer for free',
                          value: controller.offerPuppyForFree.value,
                          onChanged: (val) =>
                          controller.offerPuppyForFree.value = val!,
                        )),
                    SizedBox(height: 15.h),
                    _buildSectionTitle('Daily Sitter Pick-Up/Drop-Off', topPadding: 0),
                    _buildRateInputField(

                      controller: controller.pickupDropOffController,
                      keepText: 'You keep: 80%',
                      rateType: 'Per day',
                      showKeepText: true,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
            // --- Show/Hide Button and Divider Logic (Fixed) ---
            Obx(() => Column(
              children: [
                _buildShowHideButton(
                  controller.showAdditionalRates.value
                      ? 'Hide additional rates'
                      : 'Show additional rates',
                  controller.toggleAdditionalRates,
                  controller.showAdditionalRates.value,
                ),
                SizedBox(height: 30.h),
              ],
            )),

            // --- Availability ---
            _buildSectionTitle('Availability', topPadding: 0),
            Text(
              'How many walks can you do per day?',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.primaryText,
              ),
            ),
            SizedBox(height: 10.h),
            _buildWalksCountInput(controller), // Using updated input field
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
            SizedBox(height: 20.h),

            _buildSectionTitle('What times are you available for Dog walking on weekdays?'),
            Wrap(
              spacing: 20.w,
              runSpacing: 10.h,
              children: [
                _buildPottyBreakOption('6am - 11am', controller),
                _buildPottyBreakOption('11am - 3am', controller),
                _buildPottyBreakOption('3am - 10am', controller),
                _buildPottyBreakOption('None', controller),
              ],
            ),

            SizedBox(height: 20.h),

            Obx(() => _buildSwitchToggle(
              text: 'Use my home address',
              value: controller.useHomeAddress.value,
              onChanged: (val) => controller.useHomeAddress.value = val!,
            )),
            SizedBox(height: 10.h),
            _buildInputWithLabel(
                label: 'Location',
                controller: controller.locationController
            ),
            SizedBox(height: 20.h),

            // --- Service Area ---
            _buildSectionTitle('Service Area'),
            Text(
              'The service area you define here will be for house sitting.',
              style: GoogleFonts.montserrat(
                fontSize: 12.sp,
                color: AppColors.secondaryText,
              ),
            ),
            SizedBox(height: 15.h),
            _buildMapPlaceholder(),
            SizedBox(height: 15.h),

            Obx(() => Row(
              children: [
                _buildRadioOption<String>(
                  text: 'Miles',
                  value: 'Miles',
                  groupValue: controller.selectedDistanceType.value,
                  onChanged: (val) => controller.selectedDistanceType.value = val!,
                ),
                SizedBox(width: 20.w),
                _buildRadioOption<String>(
                  text: 'Minutes',
                  value: 'Minutes',
                  groupValue: controller.selectedDistanceType.value,
                  onChanged: (val) => controller.selectedDistanceType.value = val!,
                ),
              ],
            )),
            SizedBox(height: 15.h),
            _buildServiceAreaInputField(controller),
            SizedBox(height: 20.h),

            _buildSectionTitle('Travel mode'),
            ...controller.selectedTravelModes.keys.map((key) => Obx(() => _buildSquareCheckbox(
              text: key,
              value: controller.selectedTravelModes[key]!.value,
              onChanged: (val) => controller.toggleCheckbox(
                controller.selectedTravelModes,
                key,
                val!,
              ),
            ))).toList(),

            SizedBox(height: 20.h),

            // --- Pet Preferences ---
            _buildSectionTitle('What type of pets can you host in your home?'),
            ...controller.petSizes.keys.map((key) => Obx(() => _buildSquareCheckbox(
              text: key,
              value: controller.petSizes[key]!.value,
              onChanged: (val) => controller.toggleCheckbox(
                controller.petSizes,
                key,
                val!,
              ),
            ))).toList(),
            SizedBox(height: 20.h),

            _buildSectionTitle('Do you accept puppies under 1 year old?'),
            Obx(() => Row(
              children: [
                _buildRadioOption<bool>(
                  text: 'Yes',
                  value: true,
                  groupValue: controller.acceptsPuppies.value,
                  onChanged: (val) => controller.acceptsPuppies.value = val!,
                ),
                SizedBox(width: 20.w),
                _buildRadioOption<bool>(
                  text: 'No',
                  value: false,
                  groupValue: controller.acceptsPuppies.value,
                  onChanged: (val) => controller.acceptsPuppies.value = val!,
                ),
              ],
            )),
            SizedBox(height: 20.h),

            _buildSectionTitle('What is your cancellation policy for Doggy Day Care?'),
            ...controller.cancellationPolicy.keys.map((key) => Obx(() => _buildSquareCheckbox(
              text: key,
              value: controller.cancellationPolicy[key]!.value,
              onChanged: (val) => controller.toggleCheckbox(
                controller.cancellationPolicy,
                key,
                val!,
              ),
            ))).toList(),

            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildStickyFooter(context, buttonText, isEditing),
    );
  }
}

// --- WIDGETS ---

AppBar _buildCustomAppBar(BuildContext context, bool isEditing) {
  // ... (No change)
  return AppBar(
    backgroundColor: AppColors.mainAppColor,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size: 24),
      onPressed: () => Get.back(),
    ),
    title: Text(
      'Dog Walking',
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

Widget _buildStickyFooter(BuildContext context, String text, bool isEditing) {
  // ... (No change)
  final snackbarTitle = isEditing ? 'Service Saved' : 'Service Created';
  final snackbarMessage = 'The Dog Walking service settings have been ${isEditing ? 'saved' : 'created'}.';

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
          Get.snackbar(
            snackbarTitle,
            snackbarMessage,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: Text(
          text,
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

Widget _buildInfoBanner() {
  // ... (No change)
  return Container(
    margin: EdgeInsets.only(top: 15.h, bottom: 10.h),
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

Widget _buildSectionTitle(String title, {double topPadding = 5}) { // Added topPadding for modularity
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

// FIX 4: _buildDaySelectors is now correct (already fixed in your input)

Widget _buildDaySelectors(DogWalkingController controller) {
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

// FIX 5: _buildRateInputField updated to use TextEditingController
Widget _buildRateInputField({

  required TextEditingController controller, // Changed from placeholderValue
  required String keepText,
  required String rateType,
  required bool showKeepText,
  bool isStandalone = false, // Added for correct top spacing
}) {
  // Don't show title if it's the base rate (Per walk)
  final showTitleAboveInput = !isStandalone  != 'Per walk';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (showTitleAboveInput)
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),

        ),
      SizedBox(height: isStandalone ? 5.h : 0.h),
      Container(
        height: 45.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.Secondaryborder),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.centerLeft,
              child: Text(
                rateType,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  color: AppColors.grey,
                ),
              ),
            ),
            const VerticalDivider(width: 1, color: AppColors.Secondaryborder),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w, left: 10.w),
                child: TextFormField(
                  controller: controller,
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
      if (showKeepText)
        Padding(
          padding: EdgeInsets.only(top: 4.h, bottom: 10.h),
          child: Text(
            keepText,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: AppColors.secondaryText,
            ),
          ),
        ),
      // Add extra spacing between additional rate groups
      if (!isStandalone && showKeepText)
        SizedBox(height: 10.h),
    ],
  );
}

// FIX 6: _buildShowHideButton color logic fixed
Widget _buildShowHideButton(
    String text,
    VoidCallback onPressed,
    bool isHideButton,
    ) {
  return Container(
    width: double.infinity,
    height: 50.h,
    margin: EdgeInsets.only(top: 15.h),
    decoration: BoxDecoration(
      color: AppColors.mainAppColor, // Always solid background
      borderRadius: BorderRadius.circular(10.r),
      // Removed border logic as the color is always mainAppColor
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
              color: Colors.white, // Always white text
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            isHideButton ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white, // Always white icon
            size: 20.r,
          ),
        ],
      ),
    ),
  );
}

// FIX 7: _buildWalksCountInput updated to use TextFormField and controller
Widget _buildWalksCountInput(DogWalkingController controller) {
  return Container(
    height: 45.h,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.Secondaryborder),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          alignment: Alignment.centerLeft,
          child: Text(
            'Per day',
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              color: AppColors.grey,
            ),
          ),
        ),
        const VerticalDivider(width: 1, color: AppColors.Secondaryborder),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            child: TextFormField(
              controller: controller.maxWalksController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
              decoration: const InputDecoration(
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
  );
}

Widget _buildSquareCheckbox({
  // ... (No change)
  required String text,
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return InkWell(
    onTap: () => onChanged(!value),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.mainAppColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
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

Widget _buildSwitchToggle({
  // ... (No change)
  required String text,
  required bool value,
  required ValueChanged<bool?> onChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText,
          ),
        ),
      ),
      Transform.scale(
        scale: 0.8,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.mainAppColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    ],
  );
}

// FIX 8: _buildInputWithLabel updated to use TextEditingController
Widget _buildInputWithLabel({
  required String label,
  required TextEditingController controller, // Changed from initialValue
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        controller: controller,
        style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          color: AppColors.primaryText,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.Secondaryborder,
              width: 1.r,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.Secondaryborder,
              width: 1.r,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: AppColors.mainAppColor,
              width: 2.r,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildMapPlaceholder() {
  // ... (No change - still using AssetImage, assuming path exists)
  return Container(
    height: 300.h,
    width: 350.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: const Color(0xFFE3E6F0)),
      color: const Color(0xFFFFFFFF),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 10.w,
          left: 10.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Location',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'New York, NY',
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Image(
            image: const AssetImage('assets/images/map.png'),
            height: 300.h,
            width: 320.w,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRadioOption<T>({
  // ... (No change)
  required String text,
  required T value,
  required T groupValue,
  required ValueChanged<T?> onChanged,
}) {
  return InkWell(
    onTap: () => onChanged(value),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
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
    ),
  );
}

// FIX 9: _buildServiceAreaInputField updated to use TextFormField and controller
Widget _buildServiceAreaInputField(DogWalkingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Service area',
        style: GoogleFonts.montserrat(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryText,
        ),
      ),
      SizedBox(height: 5.h),
      Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller.serviceAreaController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: AppColors.primaryText,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.Secondaryborder,
                    width: 1.r,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.Secondaryborder,
                    width: 1.r,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppColors.mainAppColor,
                    width: 2.r,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Obx(() => Text(
            controller.selectedDistanceType.value,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              color: AppColors.primaryText,
            ),
          )),
        ],
      ),
    ],
  );
}
Widget _buildPottyBreakOption(String text, DogWalkingController controller) {
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