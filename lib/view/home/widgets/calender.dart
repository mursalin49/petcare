// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// // আপনার প্রোজেক্টের কালার ফাইল ইম্পোর্ট করুন (Assuming these imports provide the colors)
// import '../../../utils/app_colors.dart';
//
//
// class CustomCalendarWidget extends StatefulWidget {
//   // নতুন: Map ব্যবহার করা হচ্ছে যেখানে Key হলো দিন এবং Value হলো বুকিং এর Status (String)
//   // এটি ৪টি ভিন্ন কালার দেখানোর জন্য Status-কে ম্যাপ করতে সাহায্য করবে।
//   final Map<DateTime, String> bookingDays;
//   final Function(DateTime)? onDaySelected;
//
//   const CustomCalendarWidget({
//     super.key,
//     required this.bookingDays, // `unavailableDays` এর পরিবর্তে `bookingDays`
//     this.onDaySelected,
//   });
//
//   @override
//   State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
// }
//
// class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//
//   // Status অনুযায়ী কালার নির্ধারণ করার ফাংশন
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'On going':
//         return AppColors.mainAppColor; // Blue
//       case 'Completed':
//         return AppColors.greenColor; // Green
//       case 'Cancelled':
//         return AppColors.redColor; // Red
//       case 'Upcoming':
//         return AppColors.upcomingColor; // Orange
//       default:
//         return AppColors.grey; // Default
//     }
//   }
//
//   // দিনটি ম্যাপে আছে কি না এবং তার Status বের করার ফাংশন
//   String? _getDayStatus(DateTime day) {
//     // শুধুমাত্র তারিখ অংশটি (Year, Month, Day) ম্যাপের Key এর সাথে মেলাতে হবে
//     final dateOnly = DateTime(day.year, day.month, day.day);
//
//     // ম্যাপটি চেক করা
//     for (final date in widget.bookingDays.keys) {
//       // isSameDay ব্যবহার করা নিরাপদ
//       if (isSameDay(date, dateOnly)) {
//         return widget.bookingDays[date];
//       }
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(8.0),
//       margin: EdgeInsets.symmetric(horizontal: 20.w),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.borderColor, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.10),
//             offset: const Offset(0, 2),
//             blurRadius: 2,
//           ),
//         ],
//       ),
//       child: TableCalendar(
//         firstDay: DateTime.now(),
//         lastDay: DateTime(2030),
//         focusedDay: _focusedDay,
//         startingDayOfWeek: StartingDayOfWeek.sunday,
//         calendarFormat: CalendarFormat.month,
//         // rowHeight একটু কমিয়ে দিলে ক্যালেন্ডার কম্প্যাক্ট দেখাবে
//         rowHeight: 45.h,
//
//         onPageChanged: (focusedDay) {
//           final now = DateTime.now();
//           // Ensure we don't focus on a month before the current one (unless year/month is same)
//           if (focusedDay.isBefore(DateTime(now.year, now.month, 1))) {
//             setState(() => _focusedDay = DateTime(now.year, now.month, 1));
//           } else {
//             setState(() => _focusedDay = focusedDay);
//           }
//         },
//
//         // --- Header Style ---
//         headerStyle: HeaderStyle(
//           formatButtonVisible: false,
//           titleCentered: true,
//           leftChevronIcon: const Icon(Icons.chevron_left, size: 20, color: AppColors.textDark),
//           rightChevronIcon: const Icon(Icons.chevron_right, size: 20, color: AppColors.textDark),
//           titleTextStyle: const TextStyle(
//             fontFamily: 'Montserrat-Regular',
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textDark,
//           ),
//         ),
//
//         // --- Calendar Body Style (Rectangular) ---
//         calendarStyle: CalendarStyle(
//           cellMargin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
//
//           // আজকের দিনের স্টাইল
//           todayDecoration: BoxDecoration(
//             // যদি আজকের দিনটি বুকিং ম্যাপে না থাকে, তবে mainAppColor ব্যবহার করা হবে
//             color: _getDayStatus(DateTime.now()) == null ? AppColors.mainAppColor : Colors.transparent,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           todayTextStyle: TextStyle(
//             // যদি বুকিং থাকে, তবে টেক্সট কালার textDark, না হলে white
//             color: _getDayStatus(DateTime.now()) == null ? AppColors.white : AppColors.textDark,
//             fontWeight: FontWeight.w500,
//           ),
//
//           // সিলেক্ট করা দিনের স্টাইল
//           selectedDecoration: BoxDecoration(
//             color: AppColors.mainAppColor,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           selectedTextStyle: const TextStyle(
//             color: AppColors.white,
//             fontWeight: FontWeight.w500,
//           ),
//
//           outsideDaysVisible: true,
//         ),
//
//         selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//
//         onDaySelected: (selectedDay, focusedDay) {
//           setState(() {
//             _selectedDay = selectedDay;
//             _focusedDay = focusedDay;
//           });
//           widget.onDaySelected?.call(selectedDay);
//         },
//
//         // --- Custom Builder for Booked Days (4 Colors) ---
//         calendarBuilders: CalendarBuilders(
//           defaultBuilder: (context, day, focusedDay) {
//             final status = _getDayStatus(day);
//
//             if (status != null) {
//               final color = _getStatusColor(status);
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Center(
//                   child: Text(
//                     '${day.day}',
//                     style: const TextStyle(
//                       fontFamily: 'Montserrat-Regular',
//                       fontSize: 13,
//                       color: AppColors.white, // Text color is white for all status colors
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               );
//             }
//             return null; // Return null for non-booked days to use default styling
//           },
//         ),
//       ),
//     );
//   }
// }