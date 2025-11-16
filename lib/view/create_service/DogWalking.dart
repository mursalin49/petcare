import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

class DogWalkingController extends GetxController {
  // --- Rates ---
  var selectedService = 'Dog Walking'.obs;
  var showAdditionalRates = false.obs;
  var updateAdditionalRates = true.obs;

  // --- Availability ---
  var maxWalksPerDay = 4.obs;
  var availableTimes = '6am - 11am'.obs;

  // --- Location/Area ---
  var useHomeAddress = true.obs;
  var selectedDistanceType = 'Miles'.obs;
  var serviceAreaDistance = 5.obs;
  var selectedTravelModes = {'Walking': true.obs, 'Cycling': false.obs, 'Driving': false.obs}.obs;

  // --- Pet Preferences ---
  var petSizes = {'Small dog (0-15 lbs)': true.obs, 'Medium dog (16-40 lbs)': true.obs, 'Large dog (41-100 lbs)': true.obs, 'Giant dog (100+ lbs)': true.obs,}.obs;
  var acceptsPuppies = true.obs;
  var cancellationPolicy = {'Same day': true.obs, 'One day': true.obs, 'Two day': true.obs, 'Three day': true.obs,}.obs;

  void toggleAdditionalRates() {
    showAdditionalRates.value = !showAdditionalRates.value;
  }

  void toggleCheckbox(Map<String, RxBool> map, String key, bool value) {
    if (map.containsKey(key)) {
      map[key]!.value = value;
    }
  }
}


/// Wrapper screen to initialize the controller
class DogWalkingSetupScreen extends StatelessWidget {
  const DogWalkingSetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialize controller here so it can be found
    final controller = Get.put(DogWalkingController());
    return const DogWalkingServiceSetupScreen();
  }
}

class DogWalkingServiceSetupScreen extends StatelessWidget {
  const DogWalkingServiceSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DogWalkingController>();
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

            _buildSectionTitle('Set your base rate'),
            _buildRateInputField(
              title: 'Per walk',
              placeholderValue: '28.00',
              keepText: 'What you will earn per service: \$24.00',
              rateType: 'Per walk',
              showKeepText: true,
            ),
            SizedBox(height: 20.h),

            Obx(() => _buildSquareCheckbox(
                text: 'Update my additional rates based on my base rate',
                value: controller.updateAdditionalRates.value,
                onChanged: (val) => controller.updateAdditionalRates.value = val!
            )),
            Text('Turn off to adjust your rate manually', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
            SizedBox(height: 20.h),

            Obx(() {
              if (controller.showAdditionalRates.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRateInputField(title: '60 minute rate', placeholderValue: '28.00', keepText: 'You keep: \$24.00', rateType: 'Per day', showKeepText: true),
                    _buildRateInputField(title: 'Holiday Rate', placeholderValue: '28.00', keepText: 'You keep: \$24.00', rateType: 'Per day', showKeepText: true),
                    _buildRateInputField(title: 'Additional Rate', placeholderValue: '28.00', keepText: 'You keep: \$24.00', rateType: 'Per day', showKeepText: true),
                    _buildRateInputField(title: 'Puppy Rate', placeholderValue: '28.00', keepText: 'You keep: \$24.00', rateType: 'Per day', showKeepText: true),

                    _buildSquareCheckbox(
                        text: 'Offer for free',
                        value: false,
                        onChanged: (val) => {}
                    ),
                    SizedBox(height: 15.h),

                    _buildRateInputField(
                      title: 'Daily Sitter Pick-Up/Drop-Off',
                      placeholderValue: '28.00',
                      keepText: 'You keep: 80%',
                      rateType: 'Per day',
                      showKeepText: true,
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

            _buildSectionTitle('Availability'),
            Text('How many walks can you do per day?', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
            SizedBox(height: 10.h),

            _buildWalksCountInput(controller),

            SizedBox(height: 15.h),
            Text('You can edit any date individually by going to your calendar.', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
            SizedBox(height: 10.h),
            _buildDaySelectors(),
            SizedBox(height: 20.h),

            _buildSectionTitle('What times are you available for Dog walking on weekdays?'),
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRadioOption<String>(text: '6am - 11am', value: '6am - 11am', groupValue: controller.availableTimes.value, onChanged: (val) => controller.availableTimes.value = val!),
                _buildRadioOption<String>(text: '11am - 3am', value: '11am - 3am', groupValue: controller.availableTimes.value, onChanged: (val) => controller.availableTimes.value = val!),
                _buildRadioOption<String>(text: '3am - 10am', value: '3am - 10am', groupValue: controller.availableTimes.value, onChanged: (val) => controller.availableTimes.value = val!),
                _buildRadioOption<String>(text: 'None', value: 'None', groupValue: controller.availableTimes.value, onChanged: (val) => controller.availableTimes.value = val!),
              ],
            )),
            SizedBox(height: 20.h),

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

            _buildSectionTitle('Service Area'),
            Text('The service area you define here will be for house sitting.', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
            SizedBox(height: 15.h),

            _buildMapPlaceholder(),
            SizedBox(height: 15.h),

            Obx(() => Row(
              children: [
                _buildRadioOption<String>(text: 'Miles', value: 'Miles', groupValue: controller.selectedDistanceType.value, onChanged: (val) => controller.selectedDistanceType.value = val!),
                SizedBox(width: 20.w),
                _buildRadioOption<String>(text: 'Minutes', value: 'Minutes', groupValue: controller.selectedDistanceType.value, onChanged: (val) => controller.selectedDistanceType.value = val!),
              ],
            )),
            SizedBox(height: 15.h),

            // Service Area Input
            _buildServiceAreaInputField(controller),
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

            _buildSectionTitle('What type of pets can you host in your home?'),
            ...controller.petSizes.keys.map((key) => Obx(() => _buildSquareCheckbox(
                text: key,
                value: controller.petSizes[key]!.value,
                onChanged: (val) => controller.toggleCheckbox(controller.petSizes, key, val!)
            ))).toList(),
            SizedBox(height: 20.h),

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

            _buildSectionTitle('What is your cancellation policy for Doggy Day Care?'),
            ...controller.cancellationPolicy.keys.map((key) => Obx(() => _buildSquareCheckbox(
                text: key,
                value: controller.cancellationPolicy[key]!.value,
                onChanged: (val) => controller.toggleCheckbox(controller.cancellationPolicy, key, val!)
            ))).toList(),

            SizedBox(height: 100.h),
          ],
        ),
      ),
      bottomNavigationBar: _buildStickyFooter(context, 'Create Service'),
    );
  }
}


// --- AppBar ---
AppBar _buildCustomAppBar(BuildContext context, String title) {
  return AppBar(

    backgroundColor: AppColors.mainAppColor,

    elevation: 0,

    leading: IconButton(

      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),

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

    actions: [

      IconButton(

        onPressed: () {


        },

        icon: const Icon(Icons.edit_outlined, color: Colors.white),

      ),

      SizedBox(width: 8.w),

    ],



    shape: RoundedRectangleBorder(

      borderRadius: BorderRadius.only(

        bottomLeft: Radius.circular(30.r),

        bottomRight: Radius.circular(30.r),

      ),

    ),

  );
}

// --- Footer CTA ---
Widget _buildStickyFooter(BuildContext context, String text) {
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
          if (text == 'Continue') {

          } else {
            // Placeholder action for Create Service
            Get.snackbar('Service Created', 'The Dog Walking service settings have been saved.', snackPosition: SnackPosition.BOTTOM);
          }
        },
        child: Text(text, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
      ),
    ),
  );
}

Widget _buildServiceSelection(DogWalkingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.Secondaryborder),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Obx(() => DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: controller.selectedService.value,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.grey),
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.selectedService.value = newValue;
          }
        },
        items: <String>['Dog Walking'] // Only one option shown
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Icon(Icons.home, color: AppColors.grey),
                SizedBox(width: 8.w),
                Text(
                  value,
                  style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    )),
  );
}


Widget _buildInfoBanner() {
  return Container(
    margin: EdgeInsets.only(top: 15.h, bottom: 10.h),
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
Widget _buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.h, top: 5.h),
    child: Text(
      title,
      style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textDark),
    ),
  );
}

Widget _buildDaySelectors() {

  final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];



  final activeDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];





  return Container(

    decoration: BoxDecoration(



      border: Border.all(color: Color(0xFF9ABFC8), width: 2.r),

      borderRadius: BorderRadius.circular(10.r),

    ),

    child: Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: days.asMap().entries.map((entry) {

        final index = entry.key;

        final day = entry.value;

        final isActive = activeDays.contains(day);



        final bool showRightDivider = index < days.length - 1;



        return Expanded(

          child: Container(

            height: 35.r,

            alignment: Alignment.center,



            decoration: BoxDecoration(

              color: isActive ? AppColors.white : AppColors.Secondaryborder ,

              border: Border(

                right: showRightDivider

                    ? BorderSide(color: Color(0xFF9ABFC8), width: 2.r)

                    : BorderSide.none,

              ),

            ),

            child: Text(

              day,

              style: GoogleFonts.montserrat(

                fontSize: 12.sp,

                fontWeight: FontWeight.w500,

                color: Colors.black,

              ),

            ),

          ),

        );

      }).toList(),

    ),

  );

}
Widget _buildRateInputField({
  required String title,
  required String placeholderValue,
  required String keepText,
  required String rateType,
  required bool showKeepText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != 'Per walk')
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Text(title, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        ),

      Container(
        decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(8.r)),
        child: Row(
          children: [

            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              width: 100.w,
              alignment: Alignment.centerLeft,
              child: Text(rateType, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.grey)),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('\$$placeholderValue', style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.textDark)),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 5.h),


      if (showKeepText)
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(keepText, style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
        ),
    ],
  );
}

Widget _buildShowHideButton(String text, VoidCallback onPressed, bool isHideButton) {
  return Container(
    width: double.infinity,
    height: 50.h,
    margin: EdgeInsets.only(top: 15.h),
    decoration: BoxDecoration(
      color: isHideButton ? AppColors.mainAppColor : AppColors.white,
      borderRadius: BorderRadius.circular(10.r),
      border: isHideButton ? null : Border.all(color: AppColors.mainAppColor, width: 2.r),
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
              color: isHideButton ? Colors.white : AppColors.mainAppColor,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            isHideButton ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: isHideButton ? Colors.white : AppColors.mainAppColor,
            size: 20.r,
          ),
        ],
      ),
    ),
  );
}


Widget _buildWalksCountInput(DogWalkingController controller) {

  return Container(
    height: 45.h,
    decoration: BoxDecoration(border: Border.all(color: AppColors.Secondaryborder), borderRadius: BorderRadius.circular(8.r)),
    child: Row(
      children: [

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          width: 100.w,
          alignment: Alignment.centerLeft,
          child: Text('Per day', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.grey)),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Obx(() => Align(
              alignment: Alignment.centerRight,
              child: Text(
                controller.maxWalksPerDay.value.toString(),
                style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AppColors.textDark),
              ),
            )),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSquareCheckbox({required String text, required bool value, required ValueChanged<bool?> onChanged}) {
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
        Expanded(child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText))),
      ],
    ),
  );
}


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


Widget _buildInputWithLabel({required String label, required String initialValue}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        initialValue: initialValue, // Shows 1000, BD
        style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.Secondaryborder, width: 1.r)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.Secondaryborder, width: 1.r)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.mainAppColor, width: 2.r)),
        ),
      ),
    ],
  );
}

// --- **MODIFIED** Map Placeholder (Matches Screenshot 3) ---
Widget _buildMapPlaceholder() {
  return Container(
    height: 300.h,
    width: 350.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: Color(0xFFE3E6F0)),
      color: Color(0xFFFFFFFF),
    ),
    child: Stack(
      children: [
        Positioned( 
          top: 10.w,
          left: 10.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Location', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14.sp, color: AppColors.textDark)),
              Text('New York, NY', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),
            ],
          ),

          ),
SizedBox(height: 30),

        Center(child: Image(image: AssetImage('assets/images/map.png'), height: 300.h, width: 320.w)),


      ],
    ),
  );
}

// --- Radio Option (Matches Radio style in Screenshots 2 & 3) ---
Widget _buildRadioOption<T>({required String text, required T value, required T groupValue, required ValueChanged<T?> onChanged}) {
  return InkWell(
    onTap: () => onChanged(value),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(value: value, groupValue: groupValue, onChanged: onChanged, activeColor: AppColors.mainAppColor, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
        Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
      ],
    ),
  );
}

Widget _buildServiceAreaInputField(DogWalkingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Service area', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.primaryText)),
      SizedBox(height: 5.h),
      Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: '0',
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.Secondaryborder, width: 1.r)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.Secondaryborder, width: 1.r)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: AppColors.mainAppColor, width: 2.r)),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Obx(() => Text(controller.selectedDistanceType.value, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText))),
        ],
      ),
    ],
  );
}