import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_colors.dart';



class AppAssets {
  static const String seamProfileImg = 'assets/images/profileImg.png';
  static const String tamimProfileImg = 'assets/images/tamim.png';
  static const String petImage = 'assets/images/maxx.png';
}


class BookingStatusController extends GetxController {
  var selectedStatus = 'On going'.obs;

  void selectStatus(String status) {
    selectedStatus.value = status;
  }
}


class BookingData {
  final String userName;
  final String userProfileImage;
  final String location;
  final String service;
  final String contact;
  final String pickupTime;
  final String dropoffTime;
  final String petName;
  final String petBreed;
  final String petImage;
  final String date;
  final String price;
  final bool isRebooked;
  final String status;
  final double rating;
  final int totalReviews;

  final String petType;
  final String petWeight;
  final String petAge;
  final String petGender;
  final String dateOfBirth;
  final String adoptionDate;
  final String aboutPet;
  final String pottyBreak;
  final String energyLevel;
  final String feedingSchedule;
  final String canBeLeftAlone;
  final String medications;
  final String vetName;
  final String clinicName;
  final String vetAddress;
  final String vetNumber;
  final String petInsuranceProvider;
  final String vetNote;
  final double bathingPrice;
  final double extendedCarePrice;
  final double additionalRate;
  final double total;

  BookingData({
    required this.userName,
    required this.userProfileImage,
    required this.location,
    required this.service,
    required this.contact,
    required this.pickupTime,
    required this.dropoffTime,
    required this.petName,
    required this.petBreed,
    required this.petImage,
    required this.date,
    required this.price,
    this.isRebooked = false,
    required this.status,
    required this.rating,
    required this.totalReviews,
    required this.petType,
    required this.petWeight,
    required this.petAge,
    required this.petGender,
    required this.dateOfBirth,
    required this.adoptionDate,
    required this.aboutPet,
    required this.pottyBreak,
    required this.energyLevel,
    required this.feedingSchedule,
    required this.canBeLeftAlone,
    required this.medications,
    required this.vetName,
    required this.clinicName,
    required this.vetAddress,
    required this.vetNumber,
    required this.petInsuranceProvider,
    required this.vetNote,
    required this.bathingPrice,
    required this.extendedCarePrice,
    required this.additionalRate,
    required this.total,
  });

  BookingData copyWith({
    bool? isRebooked,
    String? status,
  }) {
    return BookingData(
      userName: this.userName,
      userProfileImage: this.userProfileImage,
      location: this.location,
      service: this.service,
      contact: this.contact,
      pickupTime: this.pickupTime,
      dropoffTime: this.dropoffTime,
      petName: this.petName,
      petBreed: this.petBreed,
      petImage: this.petImage,
      date: this.date,
      price: this.price,
      isRebooked: isRebooked ?? this.isRebooked,
      status: status ?? this.status,
      rating: this.rating,
      totalReviews: this.totalReviews,
      petType: this.petType,
      petWeight: this.petWeight,
      petAge: this.petAge,
      petGender: this.petGender,
      dateOfBirth: this.dateOfBirth,
      adoptionDate: this.adoptionDate,
      aboutPet: this.aboutPet,
      pottyBreak: this.pottyBreak,
      energyLevel: this.energyLevel,
      feedingSchedule: this.feedingSchedule,
      canBeLeftAlone: this.canBeLeftAlone,
      medications: this.medications,
      vetName: this.vetName,
      clinicName: this.clinicName,
      vetAddress: this.vetAddress,
      vetNumber: this.vetNumber,
      petInsuranceProvider: this.petInsuranceProvider,
      vetNote: this.vetNote,
      bathingPrice: this.bathingPrice,
      extendedCarePrice: this.extendedCarePrice,
      additionalRate: this.additionalRate,
      total: this.total,
    );
  }
}


final List<BookingData> allBookings = [

  BookingData(
    userName: 'Tamim',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max boy',
    petBreed: 'Mix',
    petImage: AppAssets.petImage,
    date: '02/09/2025',
    price: '\$99',
    isRebooked: false,
    status: 'On going',
    rating: 3.8,
    totalReviews: 1200,
    petType: 'Dog',
    petWeight: '8Kg',
    petAge: '3 Yer 4Month',
    petGender: 'Male',
    dateOfBirth: '10/01/2022',
    adoptionDate: '10/12/2025',
    aboutPet: 'Good for eating my share 😊',
    pottyBreak: 'Needs a potty break every hour',
    energyLevel: 'High energy level',
    feedingSchedule: 'Needs to be fed in the morning',
    canBeLeftAlone: 'Can be left alone for 1 hour or less',
    medications: 'ABCD Pill',
    vetName: 'Dr. Emily Carter',
    clinicName: 'Happy Paws Animal Clinic',
    vetAddress: '20 Green Park Rd, Boston, MA',
    vetNumber: '(406) 555-0120',
    petInsuranceProvider: 'Labrador',
    vetNote: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    bathingPrice: 60.00,
    extendedCarePrice: 40.00,
    additionalRate: 10.00,
    total: 170.00,
  ),

  BookingData(
    userName: 'Tamim',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max boy',
    petBreed: 'Mix',
    petImage: AppAssets.petImage,
    date: '07/09/2025',
    price: '\$99',
    isRebooked: false,
    status: 'Completed',
    rating: 3.8,
    totalReviews: 1200,
    petType: 'Dog',
    petWeight: '8Kg',
    petAge: '3 Yer 4Month',
    petGender: 'Male',
    dateOfBirth: '10/01/2022',
    adoptionDate: '10/12/2025',
    aboutPet: 'Good for eating my share 😊',
    pottyBreak: 'Needs a potty break every hour',
    energyLevel: 'High energy level',
    feedingSchedule: 'Needs to be fed in the morning',
    canBeLeftAlone: 'Can be left alone for 1 hour or less',
    medications: 'ABCD Pill',
    vetName: 'Dr. Emily Carter',
    clinicName: 'Happy Paws Animal Clinic',
    vetAddress: '20 Green Park Rd, Boston, MA',
    vetNumber: '(406) 555-0120',
    petInsuranceProvider: 'Labrador',
    vetNote: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    bathingPrice: 60.00,
    extendedCarePrice: 40.00,
    additionalRate: 10.00,
    total: 170.00,
  ),

  BookingData(
    userName: 'Tamim',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max boy',
    petBreed: 'Mix',
    petImage: AppAssets.petImage,
    date: '05/09/2025',
    price: '\$99',
    isRebooked: false,
    status: 'Cancelled',
    rating: 3.8,
    totalReviews: 1200,
    petType: 'Dog',
    petWeight: '8Kg',
    petAge: '3 Yer 4Month',
    petGender: 'Male',
    dateOfBirth: '10/01/2022',
    adoptionDate: '10/12/2025',
    aboutPet: 'Good for eating my share 😊',
    pottyBreak: 'Needs a potty break every hour',
    energyLevel: 'High energy level',
    feedingSchedule: 'Needs to be fed in the morning',
    canBeLeftAlone: 'Can be left alone for 1 hour or less',
    medications: 'ABCD Pill',
    vetName: 'Dr. Emily Carter',
    clinicName: 'Happy Paws Animal Clinic',
    vetAddress: '20 Green Park Rd, Boston, MA',
    vetNumber: '(406) 555-0120',
    petInsuranceProvider: 'Labrador',
    vetNote: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    bathingPrice: 60.00,
    extendedCarePrice: 40.00,
    additionalRate: 10.00,
    total: 170.00,
  ),

  BookingData(
    userName: 'Tamim',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max boy',
    petBreed: 'Mix',
    petImage: AppAssets.petImage,
    date: '02/09/2025',
    price: '\$99',
    isRebooked: false,
    status: 'Upcoming',
    rating: 3.8,
    totalReviews: 1200,
    petType: 'Dog',
    petWeight: '8Kg',
    petAge: '3 Yer 4Month',
    petGender: 'Male',
    dateOfBirth: '10/01/2022',
    adoptionDate: '10/12/2025',
    aboutPet: 'Good for eating my share 😊',
    pottyBreak: 'Needs a potty break every hour',
    energyLevel: 'High energy level',
    feedingSchedule: 'Needs to be fed in the morning',
    canBeLeftAlone: 'Can be left alone for 1 hour or less',
    medications: 'ABCD Pill',
    vetName: 'Dr. Emily Carter',
    clinicName: 'Happy Paws Animal Clinic',
    vetAddress: '20 Green Park Rd, Boston, MA',
    vetNumber: '(406) 555-0120',
    petInsuranceProvider: 'Labrador',
    vetNote: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    bathingPrice: 60.00,
    extendedCarePrice: 40.00,
    additionalRate: 10.00,
    total: 170.00,
  ),
];


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
  DateTime _focusedDay = DateTime(2025, 11, 15);
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextFormatter: (date, locale) {

            if (date.month == 11 && date.year == 2025) {
              return 'November 2025';
            }
            return '${MaterialLocalizations.of(context).formatMonthYear(date)}';
          },
          leftChevronIcon: const Icon(Icons.chevron_left, size: 24, color: AppColors.textDark),
          rightChevronIcon: const Icon(Icons.chevron_right, size: 24, color: AppColors.textDark),
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
          weekendStyle: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
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
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(2),
          todayDecoration: BoxDecoration(
            color: AppColors.greenColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: AppColors.mainAppColor,
            shape: BoxShape.circle,
          ),
          defaultTextStyle: GoogleFonts.montserrat(color: AppColors.primaryText, fontSize: 14),
          weekendTextStyle: GoogleFonts.montserrat(color: AppColors.primaryText, fontSize: 14),
          outsideTextStyle: GoogleFonts.montserrat(color: AppColors.grey.withOpacity(0.5), fontSize: 14),
        ),
        calendarBuilders: CalendarBuilders(


          defaultBuilder: (context, day, focusedDay) {

            if (day.month == 11 && day.year == 2025) {
              if (day.day == 12) { // Red
                return _buildSolidDayBlock(day.day, AppColors.redColor);
              } else if (day.day == 13) { // Green
                return _buildSolidDayBlock(day.day, AppColors.greenColor);
              } else if (day.day == 14) { // Dark Teal
                return _buildSolidDayBlock(day.day, AppColors.mainAppColor);
              }
            }

            if (_isUnavailable(day)) {
              return _buildSolidDayBlock(day.day, AppColors.redColor.withOpacity(0.7));
            }

            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSolidDayBlock(int day, Color color) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text('$day', style: GoogleFonts.montserrat(fontSize: 14, color: AppColors.white))),
    );
  }
}

class BookingsScreen extends StatefulWidget{
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {

  final BookingStatusController controller = Get.put(BookingStatusController());

  final List<Map<String, dynamic>> statuses = [
    {'name': 'On going', 'color': AppColors.mainAppColor},
    {'name': 'Completed', 'color': AppColors.greenColor},
    {'name': 'Cancelled', 'color': AppColors.redColor},
    {'name': 'Upcoming', 'color': AppColors.upcomingColor},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: _buildCustomAppBar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: List.generate(statuses.length, (index) {
                  final status = statuses[index]['name'];
                  final color = statuses[index]['color'] as Color;
                  final bool isSelected = controller.selectedStatus.value == status;

                  return GestureDetector(
                    onTap: () => controller.selectStatus(status),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? color : AppColors.white,
                        border: Border.all(
                          color: color,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.montserrat(
                          color: isSelected ? Colors.white : color,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )),
            const SizedBox(height: 16),

            _buildColorLegends(),
            const SizedBox(height: 20),

            CustomCalendarWidget(
              unavailableDays: [
                DateTime(2025, 11, 18),
              ],
            ),
            const SizedBox(height: 24),

            /// ----------------------------------------- Booking Section ----------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Obx(() {

                String selectedStatus = controller.selectedStatus.value;


                List<BookingData> filteredList = allBookings
                    .where((booking) => booking.status == selectedStatus)
                    .toList();

                if (filteredList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        "No '$selectedStatus' bookings found.",
                        style: GoogleFonts.montserrat(color: AppColors.grey, fontSize: 16),
                      ),
                    ),
                  );
                }


                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final booking = filteredList[index];
                    return ExpandableBookingCard(
                      booking: booking,
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }



  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Order Details',
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () { },
          icon: Icon(Icons.filter_list_rounded, color: Colors.white, size: 26), // SOLVED: .sp রিমুভ করা হয়েছে
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _buildColorLegends() {
    Widget legendItem(Color color, String text) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,

              shape: BoxShape.rectangle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.subHeadingColor,
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),

      child: SingleChildScrollView(

        scrollDirection: Axis.horizontal,
        child: Row(

          children: [
            legendItem(AppColors.mainAppColor, 'On going'),

            const SizedBox(width: 16),
            legendItem(AppColors.greenColor, 'Completed'),

            const SizedBox(width: 16),
            legendItem(AppColors.redColor, 'Cancelled'),

            const SizedBox(width: 16),
            legendItem(AppColors.upcomingColor, 'Upcoming'),
          ],
        ),
      ),
    );
  }
}




class ExpandableBookingCard extends StatefulWidget {
  final BookingData booking;

  const ExpandableBookingCard({
    super.key,
    required this.booking,
  });

  @override
  State<ExpandableBookingCard> createState() => _ExpandableBookingCardState();
}

class _ExpandableBookingCardState extends State<ExpandableBookingCard> {

  bool _isExpanded = false;

  Widget _buildSectionCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor, width: 1)
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String title, {bool useIcon = false}) {
    return Row(
      children: [
        if (useIcon) ...[
          Icon(Icons.pets_rounded, color: AppColors.mainAppColor, size: 22),
          const SizedBox(width: 8),
        ],
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }


  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "$label:",
              style: GoogleFonts.montserrat(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500)
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
                value,
                textAlign: TextAlign.right,
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: isBold ? AppColors.textDark : AppColors.subHeadingColor,
                    fontWeight: isBold ? FontWeight.w700 : FontWeight.w500
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, {bool lastItem = false, bool isValueGrey = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              label,
              style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)
          ),
          const SizedBox(height: 4),
          Text(
              value,
              style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500, color: isValueGrey ? AppColors.grey : AppColors.subHeadingColor)
          ),
          if (!lastItem) ...[
            const SizedBox(height: 10),
            const Divider(color: AppColors.borderColor, height: 1),
          ]
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final booking = widget.booking;


    Widget buildContactInfoRow(IconData icon, String text) {
      return Row(
        children: [
          Icon(icon, color: AppColors.subHeadingColor, size: 16),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.subHeadingColor,
            ),
          ),
        ],
      );
    }


    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 24, backgroundImage: AssetImage(booking.userProfileImage)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.userName, style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${booking.rating} (${booking.totalReviews})', style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.subHeadingColor)),
                    ],
                  ),
                ],
              ),
              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.mainAppColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Text(booking.date, style: GoogleFonts.montserrat(color: AppColors.mainAppColor, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 4),
                  Text(booking.price, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  Text("Per walk", style: GoogleFonts.montserrat(fontSize: 12, color: AppColors.subHeadingColor)),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),


          Text(booking.service, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          const SizedBox(height: 12),

          buildContactInfoRow(Icons.phone_outlined, booking.contact),
          const SizedBox(height: 8),
          buildContactInfoRow(Icons.calendar_today_outlined, booking.date),

          if (booking.status == 'On going') ...[
            const SizedBox(height: 8),
            buildContactInfoRow(Icons.access_time_rounded, "Pick-up: ${booking.pickupTime}"),
            const SizedBox(height: 8),
            buildContactInfoRow(Icons.access_time_rounded, "Drop-off: ${booking.dropoffTime}"),
          ],



          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor)
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(booking.petImage),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(booking.petName, style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      Text(booking.petBreed, style: GoogleFonts.montserrat(fontSize: 12, color: AppColors.subHeadingColor)),
                    ],
                  ),
                  const Spacer(),
                  Icon(_isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, size: 28, color: AppColors.subHeadingColor)
                ],
              ),
            ),
          ),


          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Visibility(
                visible: _isExpanded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Pet Information"),
                          const SizedBox(height: 12),
                          _buildInfoRow("Pet Name", booking.petName),
                          _buildInfoRow("Type", booking.petType),
                          _buildInfoRow("Weight (lbs)", booking.petWeight),
                          _buildInfoRow("Age", booking.petAge),
                          _buildInfoRow("Breed", booking.petBreed),
                          _buildInfoRow("Gender", booking.petGender),
                          _buildInfoRow("Date of Birth", booking.dateOfBirth),
                        ],
                      ),
                    ),
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Additional details"),
                          const SizedBox(height: 12),
                          _buildInfoColumn("Microchipped?", "Microchipped"),
                          _buildInfoColumn("Spayed/Neutered?", "Spayed/Neutered"),
                          _buildInfoColumn("House Trained?", "Not House Trained"),
                          _buildInfoColumn("friendly with children?", "Friendly with children"),
                          _buildInfoColumn("friendly with dogs?", "Friendly with dogs"),
                          _buildInfoColumn("Adoption Date", booking.adoptionDate, lastItem: true),
                        ],
                      ),
                    ),

                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Care info", useIcon: true),
                          const SizedBox(height: 12),
                          _buildInfoColumn("Potty break", booking.pottyBreak),
                          _buildInfoColumn("Energy level", booking.energyLevel),
                          _buildInfoColumn("Feeding schedule", booking.feedingSchedule),
                          _buildInfoColumn("Can be left alone", booking.canBeLeftAlone),
                          _buildInfoColumn("Medications", booking.medications),
                          _buildInfoColumn("Anything else a sitter should know?", "Add instructions for walking, feeding or other care", isValueGrey: true, lastItem: true),
                        ],
                      ),
                    ),

                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Veterinary info", useIcon: true),
                          const SizedBox(height: 12),
                          _buildInfoColumn("Vet's Name", booking.vetName),
                          _buildInfoColumn("Clinic", booking.clinicName),
                          _buildInfoRow("Address", booking.vetAddress),
                          _buildInfoColumn("Number", booking.vetNumber),
                          _buildInfoColumn("Pet insurance provider", booking.petInsuranceProvider, lastItem: true),
                        ],
                      ),
                    ),

                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Note"),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.inputBorderColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(booking.vetNote, style: GoogleFonts.montserrat(fontSize: 14, color: AppColors.secondaryText)),
                          ),
                        ],
                      ),
                    ),
                    // --- Pricing Section ---
                    _buildSectionCard(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: _buildSectionTitle("Pricing"),
                            ),
                            _buildInfoRow("Bathing / Grooming", "\$${booking.bathingPrice.toStringAsFixed(2)}"),
                            _buildInfoRow("Extended Care", "\$${booking.extendedCarePrice.toStringAsFixed(2)}"),
                            _buildInfoRow("Additional Pet Rate", "\$${booking.additionalRate.toStringAsFixed(2)}"),
                            const Divider(height: 20, color: AppColors.borderColor),
                            _buildInfoRow("Total", "\$${booking.total.toStringAsFixed(2)}", isBold: true),
                          ],
                        )
                    ),
                  ],
                )
            ),
          ),

          const SizedBox(height: 16),
          _buildCardFooter(context, booking.status)
        ],
      ),
    );
  }

  Widget _buildCardFooter(BuildContext context, String status) {
    switch (status) {
      case 'On going':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showRescheduleSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Reschedule', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () { /* TODO: Ask for complete logic */ },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Ask for complete', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        );
      case 'Upcoming':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () { /* TODO: Decline Logic */ },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Decline', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () { /* TODO: Accept Logic */ },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Accept', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        );
      case 'Completed':
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              'Completed',
              style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.greenColor)
          ),
        );
      case 'Cancelled':
        return Align(
          alignment: Alignment.centerRight,
          child: Text(
              'Cancelled',
              style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.redColor)
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // --- RESCHEDULE LOGIC (MODAL) ---
  void _showRescheduleSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, scrollController) {
            return RescheduleBottomSheet(scrollController: scrollController);
          },
        );
      },
    );
  }
}
class RescheduleBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const RescheduleBottomSheet({super.key, required this.scrollController});

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: AppColors.redColor),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Icon(Icons.check_circle_outline, color: AppColors.greenColor, size: 80),
              const SizedBox(height: 20),
              Text(
                'Your reschedule has been successfully confirmed.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(allBookings[0].userProfileImage),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tamim Sarkar', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                      Text('Dhanmondi, Dhaka 1209', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.subHeadingColor)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),


              Text('Pet sitter available time', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 8),
              _buildTextInputWithIcon(Icons.calendar_today_outlined),
              const SizedBox(height: 20),

              Text('Note', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Please ensure all windows are securely locked after cleaning. Kindly use eco-friendly cleaning products as we prefer them.',
                  style: GoogleFonts.montserrat(fontSize: 14, color: AppColors.secondaryText),
                ),
              ),
              const SizedBox(height: 20),


              Text('Select reschedule date & time', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 12),

              // --- Date and Time Pickers ---
              Row(
                children: [
                  Expanded(child: _buildTimeDatePicker('Start date', '01/09/2025')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTimeDatePicker('End date', '01/09/2025')),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildTimeDatePicker('Start time', '11:00pm')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTimeDatePicker('End time', '11:00pm')),
                ],
              ),
              const SizedBox(height: 20),

              // --- Calendar Component ---
              CustomCalendarWidget(
                unavailableDays: [
                  DateTime(2025, 11, 12),
                  DateTime(2025, 11, 14),
                ],
              ),
              const SizedBox(height: 20),

              // --- Buttons ---
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.redColor),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Cancel', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.redColor)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showConfirmationDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainAppColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Send', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Center(
                child: Text('You can reschedule the time only once.', style: GoogleFonts.montserrat(fontSize: 12, color: AppColors.redColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInputWithIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(icon, color: AppColors.subHeadingColor, size: 20),
        ),
      ),
    );
  }

  Widget _buildTimeDatePicker(String title, String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.inputBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(placeholder, style: GoogleFonts.montserrat(fontSize: 14, color: AppColors.secondaryText)),
        ),
      ],
    );
  }
}