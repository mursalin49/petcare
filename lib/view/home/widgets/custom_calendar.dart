import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';


import '../../../utils/app_colors.dart';


class CustomCalendarWidget extends StatefulWidget {
  final List<DateTime> unavailableDays;
  final Function(DateTime)? onDaySelected;

  const CustomCalendarWidget({
    super.key,
    required this.unavailableDays,
    this.onDaySelected,
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;


  bool _isUnavailable(DateTime day) {
    return widget.unavailableDays.any(
          (d) => d.year == day.year && d.month == day.month && d.day == day.day,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(2030),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarFormat: CalendarFormat.month,

        rowHeight: 45.h,

        onPageChanged: (focusedDay) {
          final now = DateTime.now();
          if (focusedDay.isBefore(DateTime(now.year, now.month))) {
            setState(() => _focusedDay = DateTime(now.year, now.month));
          } else {
            setState(() => _focusedDay = focusedDay);
          }
        },

        // --- Header Style ---
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: const Icon(Icons.chevron_left, size: 20, color: AppColors.textDark),
          rightChevronIcon: const Icon(Icons.chevron_right, size: 20, color: AppColors.textDark),
          titleTextStyle: const TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),


        calendarStyle: CalendarStyle(
          cellMargin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),


          todayDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
          ),


          selectedDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
          ),
          outsideDaysVisible: true,
        ),

        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

        onDaySelected: (selectedDay, focusedDay) {

          if (!_isUnavailable(selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            widget.onDaySelected?.call(selectedDay);
          }
        },

        // --- Custom Builder for Unavailable Days (Red Box) ---
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            if (_isUnavailable(day)) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Regular',
                      fontSize: 13,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}