import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:petcare/view/create_service/dog_day_care.dart';

import 'DogWalking.dart';



// ⚠️ Note: Define AppColors based on your project structure.

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



// -----------------------------------------------------------------------------

// ডামি স্ক্রিন (Dummy Screens for Navigation)

// -----------------------------------------------------------------------------





// class DogDayCareSetupScreen extends StatelessWidget {
//
//   const DogDayCareSetupScreen({super.key});
//
//   @override
//
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//
//       appBar: AppBar(title: Text('Dog Day Care Setup', style: GoogleFonts.montserrat(color: Colors.white)), backgroundColor: AppColors.mainAppColor),
//
//       body: Center(child: Text('Dog Day Care Page', style: GoogleFonts.montserrat())),
//
//     );
//
//   }
//
// }

// -----------------------------------------------------------------------------





class BoardingController extends GetxController {

  var selectedService = 'Boarding'.obs;

  var showAdditionalRates = false.obs;

  var updateRatesBasedOnBase = true.obs;

  var offerGroomingForFree = false.obs;

  var isFullTimeAvailable = true.obs;

  var selectedPottyBreak = '0-2 hours'.obs;

  var petCount = 1.obs;



  var petSizes = {'Small dog (0-15 lbs)': true.obs, 'Medium dog (16-40 lbs)': true.obs, 'Large dog (41-100 lbs)': false.obs, 'Giant dog (100+ lbs)': false.obs,};

  var homeTypes = {'House': true.obs, 'Apartment': false.obs, 'Farm': false.obs,};

  var yardTypes = {'Fenced yard': true.obs, 'Unfenced yard': false.obs, 'No yard': false.obs,};

  var boardingExpectations = {'Smoking inside home': false.obs, 'Children age 0-5': true.obs, 'Children age 6-12': true.obs, 'Dogs are allowed on bed': true.obs, 'Cats in home': true.obs, 'Caged pets in home': false.obs, 'None of the above': false.obs,};

  var hostingAbilities = {'Pets from different families at the same time': true.obs, 'Puppies under 1 year old': true.obs, 'Dogs that are not crate trained': true.obs, 'Uneudtered male dog': false.obs, 'Unsprayed female dogs': false.obs, 'Female dogs in heat': false.obs, 'None of the above': false.obs,};

  var cancellationPolicy = {'Same day': true.obs, 'One day': false.obs, 'Two day': false.obs, 'Three day': true.obs,};



  void incrementPetCount() => petCount.value++;

  void decrementPetCount() {

    if (petCount.value > 1) {

      petCount.value--;

    }

  }



  void toggleAdditionalRates() {

    showAdditionalRates.value = !showAdditionalRates.value;

  }

}





class BoardingSetupScreen extends StatelessWidget {

  const BoardingSetupScreen({super.key});



  @override

  Widget build(BuildContext context) {

    final controller = Get.put(BoardingController());



    return Scaffold(

      backgroundColor: Colors.white,

      appBar: _buildCustomAppBar(context),

      body: SingleChildScrollView(

        padding: EdgeInsets.symmetric(horizontal: 16.w),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            SizedBox(height: 10.h),



// Service Name Dropdown

            _buildServiceSelection(controller),



// Info Banner

            _buildInfoBanner(),

            SizedBox(height: 20.h),



// --- Set your base rate ---

            _buildSectionTitle('Set your base rate', isMainTitle: true),

            _buildRateInput(

              title: 'Set your base rate',

// subtitle: 'What you will earn per service: \$24.00',

              initialValue: '28.00',

              keepPercentage: 'What you will earn per service: \$24.00',

              isStandalone: true,

            ),



// Checkbox (Update my additional rates)

            Obx(() => _buildSquareCheckbox(

                text: 'Update my additional rates based on my base rate',

                value: controller.updateRatesBasedOnBase.value,

                onChanged: (val) => controller.updateRatesBasedOnBase.value = val!

            )),

            Text('Turn off to adjust your rate manually', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),



// -----------------------------------------------------------------

// --- Additional Rates Section (Toggleable) ---

// -----------------------------------------------------------------

            SizedBox(height: 20.h),

            Obx(() {

              if (controller.showAdditionalRates.value) { // Show state

                return Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    _buildRateInput(title: 'Holiday Rate', initialValue: '28.00'),

                    _buildRateInput(title: 'Puppy Rate', initialValue: '28.00'),

                    _buildRateInput(title: 'Extended Stay Rate', initialValue: '28.00'),

                    _buildRateInput(title: 'Bathing / Grooming', initialValue: '28.00'),



                    Obx(() => _buildSquareCheckbox(

                        text: 'Offer for free',

                        value: controller.offerGroomingForFree.value,

                        onChanged: (val) => controller.offerGroomingForFree.value = val!

                    )),

                    SizedBox(height: 10.h),



                    _buildRateInput(

                      title: 'Daily Sitter Pick-Up/Drop-Off',

                      initialValue: '28.00',

                      keepPercentage: 'You keep: 80%',

                      isStandalone: false,

                      addBottomSpacing: true,

                    ),

                  ],

                );

              }

              return const SizedBox.shrink(); // Hide state

            }),



            SizedBox(height: 10.h),



// --- Show/Hide Button ---

            Obx(() => _buildShowHideButton(

                controller.showAdditionalRates.value ? 'Hide additional rates' : 'Show additional rates',

                controller.toggleAdditionalRates,

                controller.showAdditionalRates.value

            )),

            SizedBox(height: 30.h),



// -----------------------------------------------------------------

// --- AVAILABILITY SECTION ---

// -----------------------------------------------------------------

            _buildSectionTitle('Availability'),

            Text('Are you home full-time during the week?', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),

            SizedBox(height: 10.h),



            Obx(() => Row(

              children: [

                _buildRadioOption(text: 'Yes', value: true, groupValue: controller.isFullTimeAvailable.value, onChanged: (val) => controller.isFullTimeAvailable.value = val!,),

                SizedBox(width: 20.w),

                _buildRadioOption(text: 'No', value: false, groupValue: controller.isFullTimeAvailable.value, onChanged: (val) => controller.isFullTimeAvailable.value = val!,),

              ],

            )),

            SizedBox(height: 15.h),





            Text('You can edit any date individually by going to your calendar.', style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.secondaryText)),

            SizedBox(height: 10.h),

            _buildDaySelectors(),

            SizedBox(height: 30.h),



// --- Potty Breaks ---

            _buildSectionTitle('How frequently can you provide potty breaks?'),



// 2x2 গ্রিড লেআউট

            Wrap(

              spacing: 20.w, // কলামগুলির মধ্যে দূরত্ব

              runSpacing: 10.h, // রো-গুলির মধ্যে দূরত্ব

              children: [

                _buildPottyBreakOption('0-2 hours', controller),

                _buildPottyBreakOption('2-4 hours', controller),

                _buildPottyBreakOption('4-8 hours', controller),

                _buildPottyBreakOption('8+ hours', controller),

              ],

            ),

            SizedBox(height: 30.h),



// -----------------------------------------------------------------

// --- PET PREFERENCES SECTION ---

// -----------------------------------------------------------------

            _buildSectionTitle('Pet preferences'),

            Text('How many pets per day can you host in your home?', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),

            SizedBox(height: 10.h),



            _buildPetCountSelector(controller),

            SizedBox(height: 30.h),



            _buildSectionTitle('What type of pets can you host in your home?'),

            SizedBox(height: 10.h),

            ...controller.petSizes.keys.map((key) => Obx(() => _buildSquareCheckbox(text: key, value: controller.petSizes[key]!.value, onChanged: (val) => controller.petSizes[key]!.value = val!))).toList(),

            SizedBox(height: 30.h),





// --- About your home ---
            _buildSectionTitle('About your home'),
            Text('What type of home do you live in?', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
            SizedBox(height: 10.h),
            ...controller.homeTypes.keys.map((key) => Obx(() => _buildSquareCheckbox(text: key, value: controller.homeTypes[key]!.value, onChanged: (val) => controller.homeTypes[key]!.value = val!))).toList(),
            SizedBox(height: 20.h),

            Text('What type of yard do you have?', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),
            SizedBox(height: 10.h),
            ...controller.yardTypes.keys.map((key) => Obx(() => _buildSquareCheckbox(text: key, value: controller.yardTypes[key]!.value, onChanged: (val) => controller.yardTypes[key]!.value = val!))).toList(),
            SizedBox(height: 30.h),

            // --- Boarding Expectations ---
            _buildSectionTitle('What can pet owners expect when boarding at your home?'),
            SizedBox(height: 10.h),
            ...controller.boardingExpectations.keys.map((key) => Obx(() => _buildSquareCheckbox(text: key, value: controller.boardingExpectations[key]!.value, onChanged: (val) => controller.boardingExpectations[key]!.value = val!))).toList(),
            SizedBox(height: 30.h),

            // --- Hosting Abilities ---
            _buildSectionTitle('Are you able to host any of the following?'),
            SizedBox(height: 10.h),
            ...controller.hostingAbilities.keys.map((key) => Obx(() => _buildSquareCheckbox(text: key, value: controller.hostingAbilities[key]!.value, onChanged: (val) => controller.hostingAbilities[key]!.value = val!))).toList(),
            SizedBox(height: 30.h),

            // --- Cancellation Policy ---
            _buildSectionTitle('What is your cancellation policy for Doggy Day Care?'),
            SizedBox(height: 10.h),
            ...controller.cancellationPolicy.keys.map((key) => Obx(() => _buildSquareCheckbox(text: key, value: controller.cancellationPolicy[key]!.value, onChanged: (val) => controller.cancellationPolicy[key]!.value = val!))).toList(),
            SizedBox(height: 30.h),

// --- Bottom CTA Button ---

            Container(

              width: double.infinity,

              height: 50.h,

              decoration: BoxDecoration(color: AppColors.mainAppColor, borderRadius: BorderRadius.circular(10.r),),

              child: TextButton(

                onPressed: () {

                  Get.snackbar('Service Created', 'The boarding service settings have been saved.', snackPosition: SnackPosition.BOTTOM);

                },

                child: Text('Create Service', style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),),

              ),

            ),

            SizedBox(height: 40.h),

          ],

        ),

      ),

    );

  }



  AppBar _buildCustomAppBar(BuildContext context) {

// const String editIconPath = 'assets/icons/edit.svg'; // Placeholder for SVG asset



    return AppBar(

      backgroundColor: AppColors.mainAppColor,

      elevation: 0,

      leading: IconButton(

        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),

        onPressed: () => Get.back(),

      ),

      title: Text(

        'Boarding',

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

// Handle edit action

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



// -----------------------------------------------------------------

// --- UTILITY WIDGETS ---

// -----------------------------------------------------------------



  Widget _buildServiceSelection(BoardingController controller) {

// Dropdown options and their corresponding screens

    final List<Map<String, dynamic>> services = [

      {'name': 'Boarding', 'icon': Icons.home_outlined, 'screen': const BoardingSetupScreen()},

      {'name': 'Dog Walking', 'icon': Icons.directions_walk_outlined, 'screen': DogWalkingSetupScreen()},

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

            decoration: BoxDecoration(

              border: Border.all(color: AppColors.Secondaryborder),

              borderRadius: BorderRadius.circular(10.r),

            ),

            child: DropdownButtonHideUnderline(

              child: Obx(() => DropdownButton<String>(

                value: controller.selectedService.value,

                isExpanded: true,

                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.grey, size: 24.r),

                style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.textDark),



                onChanged: (String? newValue) {

                  if (newValue != null && newValue != controller.selectedService.value) {

                    controller.selectedService.value = newValue;



                    final selected = services.firstWhere((s) => s['name'] == newValue);

                    if (selected['screen'] is Widget) {

                      if (newValue == 'Boarding') {

                        Get.off(() => const BoardingSetupScreen());

                      } else {

                        Get.to(() => selected['screen'] as Widget);

                      }

                    }

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

              style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.textDark, height: 1.4),

            ),

          ),

        ],

      ),

    );

  }



  Widget _buildSectionTitle(String title, {bool isMainTitle = false}) {

    return Padding(

      padding: EdgeInsets.only(bottom: 10.h),

      child: Text(

        title,

        style: GoogleFonts.montserrat(

            fontSize: 16.sp,

            fontWeight: FontWeight.w600,

            color: isMainTitle ? AppColors.textDark : AppColors.textDark

        ),

      ),

    );

  }



  Widget _buildShowHideButton(String text, VoidCallback onPressed, bool isHideButton) {

    return Container(

      width: double.infinity,

      height: 50.h,

      decoration: BoxDecoration(

        color: isHideButton ? AppColors.mainAppColor : Colors.white,

        borderRadius: BorderRadius.circular(10.r),

        border: isHideButton ? null : Border.all(color: AppColors.border, width: 2),

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



  Widget _buildRateInput({

    required String title,

    required String initialValue,

    String keepPercentage = 'What you will earn per service: \$24.00',

    String? subtitle,

    bool isStandalone = false,

    bool addBottomSpacing = false,

  }) {

    final showTitle = isStandalone || title != 'Set your base rate';



    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        if (showTitle && title != 'Set your base rate')

          Text(title, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textDark)),



        if (title == 'Set your base rate' && subtitle != null)

          Text(subtitle, style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.grey)),



        SizedBox(height: 5.h),



        Container(

          height: 45.h,

          decoration: BoxDecoration(

            border: Border.all(color: AppColors.Secondaryborder),

            borderRadius: BorderRadius.circular(8.r),

          ),

          child: Row(

            children: [

              Padding(

                padding: EdgeInsets.symmetric(horizontal: 10.w),

                child: Text('Per day', style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.grey)),

              ),

              const VerticalDivider(width: 1, color: AppColors.inputBorder),

              Expanded(

                child: Padding(

                  padding: EdgeInsets.symmetric(horizontal: 10.w),

                  child: Align(

                    alignment: Alignment.centerRight,

                    child: Text(

                      '\$$initialValue',

                      style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.textDark),

                    ),

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



        if (!isStandalone && title != 'Daily Sitter Pick-Up/Drop-Off')

          SizedBox(height: 15.h),

      ],

    );

  }



  Widget _buildRadioOption({required String text, required bool value, required bool groupValue, required ValueChanged<bool?> onChanged}) {

// This is used for "Are you home full-time"

    return Row(

      children: [

        Radio<bool>(

          value: value,

          groupValue: groupValue,

          onChanged: onChanged,

          activeColor: AppColors.mainAppColor,

          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

        ),

        Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),

      ],

    );

  }



  Widget _buildDaySelectors() {

    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];



    final activeDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];





    return Container(

      decoration: BoxDecoration(



        border: Border.all(color: AppColors.border, width: 1.r),

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

                      ? BorderSide(color: AppColors.inputBorder, width: 1.r)

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



// Potty Break Option

  Widget _buildPottyBreakOption(String text, BoardingController controller) {

    return SizedBox(

      width: (MediaQuery.of(Get.context!).size.width - 32.w - 20.w) / 2,

      child: InkWell(

        onTap: () => controller.selectedPottyBreak.value = text,

        child: Row(

          mainAxisSize: MainAxisSize.min,

          children: [

            Obx(() => Radio<String>(

              value: text,

              groupValue: controller.selectedPottyBreak.value,

              onChanged: (val) => controller.selectedPottyBreak.value = val!,

              activeColor: AppColors.mainAppColor,

              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

            )),

            Expanded(

              child: Text(text, style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText)),

            ),

          ],

        ),

      ),

    );

  }



// Pet Count Selector

  Widget _buildPetCountSelector(BoardingController controller) {

    return Row(

      children: [

        _buildCounterButton(icon: Icons.remove, onPressed: controller.decrementPetCount),

        SizedBox(width: 15.w),

// Pet Count

        Obx(() => Container(

          width: 35.r,

          height: 35.r,

          alignment: Alignment.center,

          decoration: BoxDecoration(

            border: Border.all(color: AppColors.inputBorder),

            borderRadius: BorderRadius.circular(8.r),

          ),

          child: Text(

            controller.petCount.value.toString(),

            style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.primaryText),

          ),

        )),

        SizedBox(width: 15.w),

        _buildCounterButton(icon: Icons.add, onPressed: controller.incrementPetCount),

      ],

    );

  }



  Widget _buildCounterButton({required IconData icon, required VoidCallback onPressed}) {

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



  Widget _buildSquareCheckbox({required String text, required bool value, required ValueChanged<bool?> onChanged}) {

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

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.r)),

              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

            ),

          ),

          SizedBox(width: 4.w),

          Expanded(

            child: Text(

              text,

              style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.primaryText),

            ),

          ),

        ],

      ),

    );

  }

}