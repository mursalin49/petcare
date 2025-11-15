import 'dart:ui' as BorderType;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petcare/view/bookings/custom_app_bar.dart';
import '../../../utils/app_colors.dart';
import 'package:get/get.dart';

import '../components/custom_date_picker_sheet.dart';
import '../components/custom_time_picker_sheet.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {

  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Set default values
  @override
  void initState() {
    super.initState();
    startDate = null;
    startTime = null;
    endDate = null;
    endTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Boarding", showBackButton: true),
      body: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.031),

                Text(
                  "When do you need a sitter?",
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 18.sp,
                    color: Color(0xFF111111),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE5E5E5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      /// Row 1: Start Date - End Date
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateField(
                              label: 'Start date',
                              date: startDate,
                              placeholder: "Select start date",
                              onTap: () async {
                                final DateTime? picked =
                                    await showCustomDatePickerSheet(
                                      context,
                                      initialDate: startDate ?? DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                    );
                                if (picked != null && picked != startDate) {
                                  setState(() {
                                    startDate = picked;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildDateField(
                              label: 'End date',
                              date: startDate,
                              placeholder: "Select end date",
                              onTap: () async {
                                final DateTime? picked =
                                    await showCustomDatePickerSheet(
                                      context,
                                      initialDate: startDate ?? DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2030),
                                    );
                                if (picked != null && picked != startDate) {
                                  setState(() {
                                    startDate = picked;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      /// Row 2: Start Time - End Time
                      Row(
                        children: [
                          Expanded(
                            child: _buildTimeField(
                              label: "Start time",
                              time: startTime,
                              placeholder: "Select start time",
                              onTap: () async {
                                final TimeOfDay? picked =
                                    await showCustomTimePickerSheet(
                                      context,
                                      initialTime: startTime ?? TimeOfDay.now(),
                                    );
                                if (picked != null && picked != startTime) {
                                  setState(() {
                                    startTime = picked;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildTimeField(
                              label: "End time",
                              placeholder: "Select end time",
                              time: endTime,
                              onTap: () async {
                                final TimeOfDay? picked =
                                    await showCustomTimePickerSheet(
                                      context,
                                      initialTime: endTime ?? TimeOfDay.now(),
                                    );
                                if (picked != null && picked != endTime) {
                                  setState(() {
                                    endTime = picked;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 24.h),
                //
                // GestureDetector(
                //   onTap: () {},
                //   child: DottedBorder(
                //     color: AppColors.mainAppColor,
                //     strokeWidth: 1.5,
                //     dashPattern: const [7, 3],
                //     borderType: BorderType.RRect,
                //     radius: const Radius.circular(8),
                //     child: Container(
                //       width: double.infinity,
                //       padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(Icons.add, color: AppColors.mainAppColor, size: 20),
                //           SizedBox(width: 8.w),
                //           const Text(
                //             "Select your pets",
                //             style: TextStyle(
                //               fontFamily: 'Montserrat-Regular',
                //               fontSize: 16,
                //               color: AppColors.mainAppColor,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.030),
                // GestureDetector(
                //   onTap: (){
                //     Get.to(() => const BoardingSittersScreen());
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: 14.h),
                //     decoration: BoxDecoration(
                //       color: AppColors.mainAppColor,
                //       borderRadius: BorderRadius.circular(8.r),
                //     ),
                //     child: Text(
                //       "Next",
                //       style: TextStyle(
                //         fontFamily: 'Montserrat-Regular',
                //         fontSize: 18.sp,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.white,
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.050),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    String? placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14.sp,
            color: const Color(0xFF101010),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Color(0xFFE5E5E5), width: 1),
            ),
            child: Text(
              date != null
                  ? DateFormat('dd/MM/yyyy').format(date)
                  : (placeholder ?? ''),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: date != null ? Color(0xFF1F1D1D) : Color(0xFF757575),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
    String? placeholder,
  }) {
    String formatTimeOfDay(TimeOfDay tod) {
      final hour = tod.hourOfPeriod == 0 ? 12 : tod.hourOfPeriod;
      final minute = tod.minute.toString().padLeft(2, '0');
      final period = tod.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour:$minute $period';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14.sp,
            color: const Color(0xFF101010),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Color(0xFFE5E5E5), width: 1),
            ),
            child: Text(
              time != null ? formatTimeOfDay(time) : (placeholder ?? ''),
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: time != null ? Color(0xFF1F1D1D) : Color(0xFF757575),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
