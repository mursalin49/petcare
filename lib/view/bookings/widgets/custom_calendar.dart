import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/app_colors.dart';


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
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime(2030),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        calendarFormat: CalendarFormat.month,
        onPageChanged: (focusedDay) {
          final now = DateTime.now();
          if (focusedDay.isBefore(DateTime(now.year, now.month))) {
            setState(() => _focusedDay = DateTime(now.year, now.month));
          } else {
            setState(() => _focusedDay = focusedDay);
          }
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon: const Icon(Icons.chevron_left, size: 24),
          rightChevronIcon: const Icon(Icons.chevron_right, size: 24),
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF11293A),
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF11293A),
          ),
          weekendStyle: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF11293A),
          ),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.circle,
          ),
          outsideDaysVisible: true,
          defaultTextStyle: const TextStyle(color: Colors.black87),
          weekendTextStyle: const TextStyle(color: Colors.black87),
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
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            // Red-mark unavailable days
            if (_isUnavailable(day)) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Color(0xFFFE6C5D),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Regular',
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }

            // Normal day cell
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
