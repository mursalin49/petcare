import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/view/create_service/Boarding.dart';
import 'package:petcare/view/create_service/dog_day_care.dart';

class AppColors {
  static const Color mainAppColor = Color(0xFF035F75);
  static const Color primaryText = Color(0xFF1C1C1E);
  static const Color secondaryText = Color(0xFF8E8E93);
  static const Color textDark = Color(0xFF1C1C1E);
  static const Color grey = Color(0xFF8E8E93);
  static const Color white = Colors.white;
  static const Color border = Color(0xFFE5E5E5);
  static const Color Secondaryborder = Color(0xFFD1D1D6);
  static const Color inputBorder = Color(0xFFD1D1D6);
}

class DogWalkingSetupScreen extends StatelessWidget {
  const DogWalkingSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Redirects to the DogWalkingRateScreen which is the main setup page
    return const DogWalkingRateScreen();
  }
}

class DogWalkingController extends GetxController {
  // --- Rates ---
  var selectedService = 'Dog Walking'.obs;
  var showAdditionalRates = false.obs;
  var updateAdditionalRates = true.obs;

  // --- Availability ---
  var maxWalksPerDay = 4.obs;
  var availableTimes = '6am - 11am'.obs;

  // --- Location/Area (Screen 2) ---
  var useHomeAddress = true.obs;
  var selectedDistanceType = 'Miles'.obs;
  var serviceAreaDistance = 5.obs; // Example initial distance
  var selectedTravelModes = {'Walking': true.obs, 'Cycling': false.obs, 'Driving': true.obs}.obs;

  // --- Pet Preferences (Screen 2) ---
  var petSizes = {'Small dog (0-15 lbs)': true.obs, 'Medium dog (16-40 lbs)': true.obs, 'Large dog (41-100 lbs)': false.obs, 'Giant dog (100+ lbs)': false.obs,}.obs;
  var acceptsPuppies = true.obs;
  var cancellationPolicy = {'Same day': true.obs, 'One day': false.obs, 'Two day': false.obs, 'Three day': false.obs,}.obs;


  void incrementMaxWalks() => maxWalksPerDay.value++;
  void decrementMaxWalks() {
    if (maxWalksPerDay.value > 1) {
      maxWalksPerDay.value--;
    }
  }

  void toggleAdditionalRates() {
    showAdditionalRates.value = !showAdditionalRates.value;
  }

  void toggleCheckbox(Map<String, RxBool> map, String key, bool value) {
    if (map.containsKey(key)) {
      map[key]!.value = value;
    }
  }
}


class DogWalkingDetailScreen extends StatelessWidget {
  const DogWalkingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the existing controller initialized in DogWalkingRateScreen
    final controller = Get.find<DogWalkingController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildCustomAppBar(context, 'Dog Walking'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // --- Day Selector (Small) ---
                _buildSmallDaySelectors(),
                SizedBox(height: 10.h),
                Text('You can edit any date individually by going to your calendar.', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),

                SizedBox(height: 20.h),
                Divider(color: AppColors.border, height: 1.h),
                SizedBox(height: 20.h),

                // --- Time Slots ---
                _buildSectionTitle('What times are you available for Dog walking on weekdays?'),
                Wrap(
                  spacing: 10.w, runSpacing: 10.h,
                  children: [
                    _buildTimeSlotChip('6am - 11am', controller),
                    _buildTimeSlotChip('11am - 3pm', controller),
                    _buildTimeSlotChip('3pm - 10pm', controller),
                    _buildTimeSlotChip('None', controller),
                  ],
                ),
                SizedBox(height: 20.h),

                // --- Location Toggle & Input ---
                Obx(() => _buildSwitchToggle(
                    text: 'Use my home address',
                    value: controller.useHomeAddress.value,
                    onChanged: (val) => controller.useHomeAddress.value = val!
                )),
                SizedBox(height: 10.h),
                _buildInputWithLabel(label: 'Location', initialValue: '1000, BD'),

                SizedBox(height: 20.h),
                Divider(color: AppColors.border, height: 1.h),
                SizedBox(height: 20.h),

                // --- Service Area ---
                _buildSectionTitle('Service Area'),
                Text('The service area you define here will be for house sitting.', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
                SizedBox(height: 15.h),

                _buildMapPlaceholder(),
                SizedBox(height: 15.h),

                // Distance Type Radio
                Obx(() => Row(
                  children: [
                    _buildRadioOption<String>(text: 'Miles', value: 'Miles', groupValue: controller.selectedDistanceType.value, onChanged: (val) => controller.selectedDistanceType.value = val!),
                    SizedBox(width: 20.w),
                    _buildRadioOption<String>(text: 'Minutes', value: 'Minutes', groupValue: controller.selectedDistanceType.value, onChanged: (val) => controller.selectedDistanceType.value = val!),
                  ],
                )),
                SizedBox(height: 15.h),

                // Service Area Input
                _buildServiceAreaInput(controller),
                SizedBox(height: 20.h),

                // Travel Mode Checkboxes
                _buildSectionTitle('Travel mode'),
                ...controller.selectedTravelModes.keys.map((key) => Obx(() => _buildSquareCheckbox(
                    text: key,
                    value: controller.selectedTravelModes[key]!.value,
                    onChanged: (val) => controller.toggleCheckbox(controller.selectedTravelModes, key, val!)
                ))).toList(),

                SizedBox(height: 20.h),
                Divider(color: AppColors.border, height: 1.h),
                SizedBox(height: 20.h),

                // --- Pet Hosting ---
                _buildSectionTitle('What type of pets can you host in your home?'),
                ...controller.petSizes.keys.map((key) => Obx(() => _buildSquareCheckbox(
                    text: key,
                    value: controller.petSizes[key]!.value,
                    onChanged: (val) => controller.toggleCheckbox(controller.petSizes, key, val!)
                ))).toList(),
                SizedBox(height: 20.h),

                // --- Puppies ---
                _buildSectionTitle('Do you accept puppies under 1 year old?'),
                Obx(() => Row(
                  children: [
                    _buildRadioOption<bool>(text: 'Yes', value: true, groupValue: controller.acceptsPuppies.value, onChanged: (val) => controller.acceptsPuppies.value = val!),
                    SizedBox(width: 20.w),
                    _buildRadioOption<bool>(text: 'No', value: false, groupValue: controller.acceptsPuppies.value, onChanged: (val) => controller.acceptsPuppies.value = val!),
                  ],
                )),

                SizedBox(height: 20.h),
                Divider(color: AppColors.border, height: 1.h),
                SizedBox(height: 20.h),

                // --- Cancellation Policy ---
                _buildSectionTitle('What is your cancellation policy for Doggy Day Care?'),
                ...controller.cancellationPolicy.keys.map((key) => Obx(() => _buildSquareCheckbox(
                    text: key,
                    value: controller.cancellationPolicy[key]!.value,
                    onChanged: (val) => controller.toggleCheckbox(controller.cancellationPolicy, key, val!)
                ))).toList(),

                SizedBox(height: 100.h), // Extra space for sticky footer
              ],
            ),
          ),

          // --- Bottom CTA Button ---
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildStickyFooter(context, 'Create Service'),
          ),
        ],
      ),
    );
  }

// Utility Widgets (Definitions moved to the bottom section for consolidation)
// ...
}

class DogWalkingRateScreen extends StatelessWidget {
  const DogWalkingRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller here so it can be found by DogWalkingDetailScreen
    final controller = Get.put(DogWalkingController());

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildCustomAppBar(context, 'Dog Walking'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),

            _buildServiceSelection(controller),
            _buildInfoBanner(),
            SizedBox(height: 20.h),

            // --- Set your base rate ---
            _buildSectionTitle('Set your base rate', isMainTitle: true),
            _buildBaseRateInput(
              title: 'Per walk ',
              initialValue: '28.00',
              keepPercentage: 'What you will earn per service: \$24.00',
            ),

            SizedBox(height: 20.h),
            // Checkbox (Update my additional rates)
            Obx(() => _buildSwitchToggle(
                text: 'Update my additional rates based on my base rate',
                value: controller.updateAdditionalRates.value,
                onChanged: (val) => controller.updateAdditionalRates.value = val!
            )),
            Text('Turn off to adjust your rate manually', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),

            SizedBox(height: 20.h),

            // --- Additional Rates Section (Toggleable) ---
            Obx(() {
              if (controller.showAdditionalRates.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRateInput(title: '60 minute rate', initialValue: '45.00', keepPercentage: 'You keep: \$38.00'),
                    _buildRateInput(title: 'Holiday Rate', initialValue: '35.00', keepPercentage: 'You keep: \$28.00'),
                    _buildRateInput(title: 'Additional Dog Rate', initialValue: '10.00', keepPercentage: 'You keep: \$8.00'),
                    _buildRateInput(title: 'Puppy Rate', initialValue: '32.00', keepPercentage: 'You keep: \$26.00'),

                    Obx(() => _buildSquareCheckbox(
                        text: 'Offer for free',
                        value: false,
                        onChanged: (val) => {}
                    )),
                    SizedBox(height: 10.h),

                    _buildRateInput(
                      title: 'Daily Sitter Pick-Up/Drop-Off',
                      initialValue: '15.00',
                      keepPercentage: 'You keep: \$12.00',
                      addBottomSpacing: true,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),

            // --- Show/Hide Button ---
            Obx(() => _buildShowHideButton(
                controller.showAdditionalRates.value ? 'Hide additional rates' : 'Show additional rates',
                controller.toggleAdditionalRates,
                controller.showAdditionalRates.value
            )),

            SizedBox(height: 30.h),
            Divider(color: AppColors.border, height: 1.h),
            SizedBox(height: 30.h),

            // --- AVAILABILITY SECTION ---
            _buildSectionTitle('Availability'),

            Text('How many walks can you do per day?', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
            SizedBox(height: 10.h),
            _buildWalksCountSelector(controller),
            SizedBox(height: 15.h),

            Text('You can edit any date individually by going to your calendar.', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
            SizedBox(height: 10.h),

            _buildDaySelectors(),

            SizedBox(height: 30.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildStickyFooter(context, 'Continue'),
    );
  }
}


// =============================================================================
// V. SHARED UTILITY WIDGETS (Helper functions used by both screens)
// =============================================================================

// --- AppBar ---
AppBar _buildCustomAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: AppColors.mainAppColor,
    elevation: 0,
    leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Get.back()),
    title: Text(title, style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.white)),
    centerTitle: true,
    actions: [
      IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white), onPressed: () {}),
      SizedBox(width: 8.w),
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r))),
  );
}

// --- Footer CTA ---
Widget _buildStickyFooter(BuildContext context, String text) {
  final isContinue = text == 'Continue';
  return Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, -3))],
    ),
    child: Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(color: AppColors.mainAppColor, borderRadius: BorderRadius.circular(10.r)),
      child: TextButton(
        onPressed: () {
          if (isContinue) {
            Get.to(() => const DogWalkingDetailScreen());
          } else {
            Get.snackbar('Service Created', 'The Dog Walking service settings have been saved.', snackPosition: SnackPosition.BOTTOM);
          }
        },
        child: Text(text, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    ),
  );
}

// --- Service Dropdown (Used in Rate Screen) ---
Widget _buildServiceSelection(DogWalkingController controller) {
  final List<Map<String, dynamic>> services = [
    {'name': 'Boarding', 'icon': Icons.home_outlined, 'screen': BoardingSetupScreen()},
    {'name': 'Dog Walking', 'icon': Icons.directions_walk_outlined, 'screen': const DogWalkingSetupScreen()},
    {'name': 'Dog Day Care', 'icon': Icons.pets_outlined, 'screen': const DogDayCareSetupScreen()},
  ];

  return Padding(
    padding: EdgeInsets.only(bottom: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Service name', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
          decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(10.r)),
          child: DropdownButtonHideUnderline(
            child: Obx(() => DropdownButton<String>(
              value: controller.selectedService.value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey, size: 24.r),
              style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.textDark),

              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedService.value = newValue;
                  final selected = services.firstWhere((s) => s['name'] == newValue);
                  Get.off(() => selected['screen'] as Widget); // Use Get.off to replace current route
                }
              },
              items: services.map<DropdownMenuItem<String>>((service) {
                return DropdownMenuItem<String>(
                  value: service['name'],
                  child: Row(
                    children: [
                      Icon(service['icon'] as IconData, color: AppColors.mainAppColor, size: 24.r),
                      SizedBox(width: 10.w),
                      Text(service['name'] as String),
                    ],
                  ),
                );
              }).toList(),
            )),
          ),
        ),
      ],
    ),
  );
}

// --- Info Banner ---
Widget _buildInfoBanner() {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8.r), border: Border.all(color: Colors.grey.shade300)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: AppColors.grey, size: 18.r),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            'We have suggested some default settings based on what works well for new sitters and walkers. You can edit now, or at any time in the future.',
            style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.textDark, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// --- Section Title ---
Widget _buildSectionTitle(String title, {bool isMainTitle = false}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Text(
      title,
      style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textDark),
    ),
  );
}

// --- Day Selectors (Used in Rate Screen) ---
Widget _buildDaySelectors() {
  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final activeDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']; // Example active days

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: days.map((day) {
      final isActive = activeDays.contains(day);
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Container(
            height: 40.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive ? AppColors.mainAppColor : Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: isActive ? AppColors.mainAppColor : AppColors.inputBorder, width: 1.r),
            ),
            child: Text(day, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.w500, color: isActive ? Colors.white : AppColors.primaryText)),
          ),
        ),
      );
    }).toList(),
  );
}

// --- Small Day Selectors (Used in Detail Screen) ---
Widget _buildSmallDaySelectors() {
  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final activeDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: days.map((day) {
      final isActive = activeDays.contains(day);
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Container(
            height: 35.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive ? AppColors.mainAppColor : Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: isActive ? AppColors.mainAppColor : AppColors.inputBorder, width: 1.r),
            ),
            child: Text(day, style: GoogleFonts.montserrat(fontSize: 11.sp, fontWeight: FontWeight.w500, color: isActive ? Colors.white : AppColors.primaryText)),
          ),
        ),
      );
    }).toList(),
  );
}


// --- Base Rate Input (Special Structure) ---
Widget _buildBaseRateInput({required String title, required String initialValue, required String keepPercentage}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 5.h),
      Container(
        decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Text(title, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText))),
                const VerticalDivider(width: 1, color: AppColors.inputBorder),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('\$$initialValue', style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    ),
                  ),
                ),
                Container(
                  width: 40.w, height: 40.h, alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border(left: BorderSide(color: AppColors.inputBorder, width: 1.r)),
                  ),
                  child: Text('\$', style: GoogleFonts.montserrat(fontSize: 16.sp, color: AppColors.grey)),
                ),
              ],
            ),
            Divider(color: AppColors.inputBorder, height: 1.h),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Align(child: Text(keepPercentage, style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.textDark)), alignment: Alignment.centerLeft),
            ),
          ],
        ),
      ),
    ],
  );
}

// --- Additional Rate Input (Simple) ---
Widget _buildRateInput({required String title, required String initialValue, required String keepPercentage, bool addBottomSpacing = false,}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textDark)),
      SizedBox(height: 5.h),
      Container(
        height: 45.h,
        decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Text('Per day', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.grey))),
            const VerticalDivider(width: 1, color: AppColors.inputBorder),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('\$$initialValue', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.textDark)),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 4.h, bottom: addBottomSpacing ? 10.h : 5.h),
        child: Text(keepPercentage, style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.textDark)),
      ),
      SizedBox(height: 15.h),
    ],
  );
}

// --- Show/Hide Button ---
Widget _buildShowHideButton(String text, VoidCallback onPressed, bool isHideButton) {
  return Container(
    width: double.infinity,
    height: 50.h,
    decoration: BoxDecoration(
      color: isHideButton ? AppColors.mainAppColor : AppColors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: isHideButton ? null : Border.all(color: AppColors.mainAppColor, width: 2.r),
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: isHideButton ? Colors.white : AppColors.mainAppColor,
        ),
      ),
    ),
  );
}

// --- Walks Count Selector ---
Widget _buildWalksCountSelector(DogWalkingController controller) {
  return Container(
    height: 45.h,
    decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(8.r)),
    child: Row(
      children: [
        _buildCounterButton(icon: Icons.remove, onPressed: controller.decrementMaxWalks),
        const VerticalDivider(width: 1, color: AppColors.inputBorder),
        Expanded(
          child: Obx(() => Container(
            alignment: Alignment.center,
            child: Text(controller.maxWalksPerDay.value.toString(), style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primaryText)),
          )),
        ),
        const VerticalDivider(width: 1, color: AppColors.inputBorder),
        _buildCounterButton(icon: Icons.add, onPressed: controller.incrementMaxWalks),

        Container(
          width: 70.w, height: double.infinity, alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(topRight: Radius.circular(7.r), bottomRight: Radius.circular(7.r)),
            border: Border(left: BorderSide(color: AppColors.inputBorder, width: 1.r)),
          ),
          child: Text('Per day', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.grey)),
        ),
      ],
    ),
  );
}

// --- Counter Button (Helper for Walks Selector) ---
Widget _buildCounterButton({required IconData icon, required VoidCallback onPressed}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(8.r),
    child: Container(
      width: 40.r, height: 40.r, alignment: Alignment.center,
      child: Icon(icon, color: AppColors.mainAppColor, size: 20.r),
    ),
  );
}

// --- Time Slot Chip (Used in Detail Screen) ---
Widget _buildTimeSlotChip(String text, DogWalkingController controller) {
  return Obx(() => ChoiceChip(
    label: Text(text),
    selected: controller.availableTimes.value == text,
    onSelected: (selected) { if (selected) { controller.availableTimes.value = text; }},
    selectedColor: AppColors.mainAppColor,
    labelStyle: GoogleFonts.montserrat(color: controller.availableTimes.value == text ? Colors.white : AppColors.primaryText, fontSize: 14.sp, fontWeight: FontWeight.w500),
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r), side: BorderSide(color: controller.availableTimes.value == text ? AppColors.mainAppColor : AppColors.Secondaryborder, width: 1.r)),
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
  ));
}

// --- Switch Toggle (Used in both screens) ---
Widget _buildSwitchToggle({required String text, required bool value, required ValueChanged<bool?> onChanged}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.primaryText))),
      Transform.scale(
        scale: 0.8,
        child: Switch(value: value, onChanged: onChanged, activeColor: AppColors.mainAppColor, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ),
    ],
  );
}

// --- Input with Label (Used in Detail Screen) ---
Widget _buildInputWithLabel({required String label, required String initialValue}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.primaryText)),
      SizedBox(height: 5.h),
      TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.Secondaryborder, width: 1.r)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.Secondaryborder, width: 1.r)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.mainAppColor, width: 2.r)),
        ),
      ),
    ],
  );
}

// --- Map Placeholder (Used in Detail Screen) ---
Widget _buildMapPlaceholder() {
  return Container(
    height: 150.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.Secondaryborder), color: Colors.grey.shade200),
    child: Stack(
      children: [
        Center(child: Icon(Icons.location_on, color: AppColors.grey, size: 50.r)),
        Padding(
          padding: EdgeInsets.all(10.w),
          child: Text('NEW YORK, NY', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.textDark)),
        ),
      ],
    ),
  );
}

// --- Radio Option (Used in Detail Screen) ---
Widget _buildRadioOption<T>({required String text, required T value, required T groupValue, required ValueChanged<T?> onChanged}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Radio<T>(value: value, groupValue: groupValue, onChanged: onChanged, activeColor: AppColors.mainAppColor, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
    ],
  );
}

// --- Service Area Input (Used in Detail Screen) ---
Widget _buildServiceAreaInput(DogWalkingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Service area', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.primaryText)),
      SizedBox(height: 5.h),
      Container(
        height: 45.h,
        decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(controller.serviceAreaDistance.value.toString(), style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.textDark)),
                ),
              ),
            ),
            Obx(() => Container(
              width: 70.w, height: double.infinity, alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(topRight: Radius.circular(7.r), bottomRight: Radius.circular(7.r)),
                border: Border(left: BorderSide(color: AppColors.inputBorder, width: 1.r)),
              ),
              child: Text(controller.selectedDistanceType.value, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.grey)),
            )),
          ],
        ),
      ),
    ],
  );
}

// --- Square Checkbox (Used in both screens) ---
Widget _buildSquareCheckbox({required String text, required bool value, required ValueChanged<bool?> onChanged}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.1,
          child: Checkbox(value: value, onChanged: onChanged, activeColor: AppColors.mainAppColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.r)), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        ),
        SizedBox(width: 4.w),
        Expanded(child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText))),
      ],
    ),
  );
}
