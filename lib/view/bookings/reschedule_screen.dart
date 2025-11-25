import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/app_colors.dart';
import '../components/custom_date_picker_sheet.dart';
import '../components/custom_time_picker_sheet.dart';
import '../home/widgets/custom_calendar.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen({super.key});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  bool _isCalendarVisible = false;

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;

  @override
  void initState() {
    super.initState();

    _selectedStartDate = DateTime.now();
    _selectedEndDate = DateTime.now().add(const Duration(days: 1));
    _selectedStartTime = const TimeOfDay(hour: 10, minute: 0);
    _selectedEndTime = const TimeOfDay(hour: 12, minute: 0);
    _selectedTime = const TimeOfDay(hour: 11, minute: 0);
  }

  Future<void> _selectDate(BuildContext context, String type) async {
    DateTime initialDate = DateTime.now();
    DateTime? rangeStart;

    if (type == 'Start' && _selectedStartDate != null) {
      initialDate = _selectedStartDate!;
    } else if (type == 'End') {
      if (_selectedStartDate != null) {
        rangeStart = _selectedStartDate;
        if (_selectedEndDate != null && _selectedEndDate!.isAfter(_selectedStartDate!)) {
          initialDate = _selectedEndDate!;
        } else {
          initialDate = _selectedStartDate!.add(const Duration(days: 1));
        }
      } else if (_selectedEndDate != null) {
        initialDate = _selectedEndDate!;
      }
    }

    final DateTime? picked = await showCustomDatePickerSheet(
      context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      rangeStart: rangeStart,
    );

    if (picked != null) {
      setState(() {
        if (type == 'Start') {
          _selectedStartDate = picked;
          if (_selectedEndDate != null && picked.isAfter(_selectedEndDate!)) {
            _selectedEndDate = picked;
          }
        } else if (type == 'End') {
          if (_selectedStartDate != null && picked.isBefore(_selectedStartDate!)) {
            _selectedEndDate = _selectedStartDate;
          } else {
            _selectedEndDate = picked;
          }
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, String type) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (type == 'Start' && _selectedStartTime != null) {
      initialTime = _selectedStartTime!;
    } else if (type == 'End' && _selectedEndTime != null) {
      initialTime = _selectedEndTime!;
    } else if (type == 'PetSitter' && _selectedTime != null) {
      initialTime = _selectedTime!;
    }

    final TimeOfDay? picked = await showCustomTimePickerSheet(
      context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        if (type == 'Start') {
          _selectedStartTime = picked;
        } else if (type == 'End') {
          _selectedEndTime = picked;
        } else if (type == 'PetSitter') {
          _selectedTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Reschedule Booking',
          style: GoogleFonts.montserrat(
            fontSize: 18,
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
      body: Stack(
        children: [
          // --- Main Content ---
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoCard(),
                SizedBox(height: 24.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isCalendarVisible = !_isCalendarVisible;
                    });
                  },
                  child: _buildInputContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pet sitter available time",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.sp,
                            color: Color(0xFF7C7C7C),
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/icons/calenderr.svg",
                          width: 20.sp,
                          height: 20.sp,
                          color: AppColors.subHeadingColor,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                _buildLabelText("Note"),
                SizedBox(height: 8.h),
                _buildInputContainer(
                  child: Text(
                    "Please ensure all windows are securely locked after cleaning. Kindly use eco-friendly cleaning products as we prefer them.",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Color(0xFF7C7C7C),
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                _buildLabelText("Select reschedule date & time"),
                SizedBox(height: 12.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSmallPickerBox(
                              "Start date",
                              _selectedStartDate != null
                                  ? DateFormat('dd/MM/yyyy').format(_selectedStartDate!)
                                  : "Select Date",
                              onTap: () => _selectDate(context, 'Start'),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildSmallPickerBox(
                              "End date",
                              _selectedEndDate != null
                                  ? DateFormat('dd/MM/yyyy').format(_selectedEndDate!)
                                  : "Select Date",
                              onTap: () => _selectDate(context, 'End'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      /// --- Time Row ---
                      Row(
                        children: [
                          Expanded(
                            child: _buildSmallPickerBox(
                              "Start time",
                              _selectedStartTime != null
                                  ? _selectedStartTime!.format(context)
                                  : "Select Time",
                              onTap: () => _selectTime(context, 'Start'),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildSmallPickerBox(
                              "End time",
                              _selectedEndTime != null
                                  ? _selectedEndTime!.format(context)
                                  : "Select Time",
                              onTap: () => _selectTime(context, 'End'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),

                _buildActionButtons(context),

                SizedBox(height: 16.h),

                Center(
                  child: Text(
                    "You can reschedule the time only once.",
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),

          // Calendar overlay for Pet sitter available time
          if (_isCalendarVisible)
            Positioned(
              top: 150.h,
              left: 20.w,
              right: 20.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close/Date Header
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.close, size: 24.sp, color: AppColors.textDark),
                            onPressed: () {
                              setState(() {
                                _isCalendarVisible = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    // Calendar Body
                    CustomCalendarWidget(
                      unavailableDays: [
                        DateTime.now().add(const Duration(days: 3)),
                        DateTime.now().add(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 5)),
                      ],
                      onDaySelected: (day) {
                        setState(() {
                          _isCalendarVisible = false;
                        });
                      },
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildUserInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/profileImg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Tamim Sarkar",
            style: GoogleFonts.montserrat(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Dhanmondi, Dhaka 1209",
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.subHeadingColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelText(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildInputContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: child,
    );
  }

  // Interactive Picker Box
  Widget _buildSmallPickerBox(String label, String value, {VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.subHeadingColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              side: BorderSide(color: AppColors.redColor, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.redColor,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _showSuccessDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainAppColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Send',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, color: Colors.grey, size: 24.sp),
                ),
              ),
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                child: Icon(Icons.check, color: Colors.green, size: 40.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Your reschedule has been\nsuccessfully confirmed.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}