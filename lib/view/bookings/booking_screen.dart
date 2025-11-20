import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// Note: Assuming 'petcare' is your project root and RescheduleScreen exists
import 'package:petcare/view/bookings/reschedule_screen.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_colors.dart';
import '../home/widgets/custom_calendar.dart';



// Define AppAssets
class AppAssets {
  static const String tamimProfileImg = 'assets/images/tamim.png'; // Placeholder for user profile
  static const String petImage = 'assets/images/cat.png'; // Placeholder for pet image
}

// Define AppIcons (Placeholder, must exist in your assets)
class AppIcons {
  static const String order = 'assets/icons/order.svg';
  static const String location = 'assets/icons/location.svg';
  static const String clock = 'assets/icons/clock.svg';
  static const String paw = 'assets/icons/paw.svg';
  static const String vet = 'assets/icons/vet.svg';
  static const String billing = 'assets/icons/billing.svg';
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

// --- DUMMY DATA ---
final List<BookingData> initialBookings = [
  BookingData(
    userName: 'Tamim',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppAssets.petImage,
    date: '02/09/2025',
    price: '\$99',
    isRebooked: true,
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
    service: 'Pet Sitting',
    contact: '(229) 555-0109',
    pickupTime: '09:00 AM',
    dropoffTime: '05:00 PM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppAssets.petImage,
    date: '07/09/2025',
    price: '\$150',
    isRebooked: false,
    status: 'Completed',
    rating: 4.5,
    totalReviews: 500,
    petType: 'Dog',
    petWeight: '25Kg',
    petAge: '5 Yer',
    petGender: 'Female',
    dateOfBirth: '10/01/2020',
    adoptionDate: '10/12/2020',
    aboutPet: 'Very friendly and loves cuddles.',
    pottyBreak: 'Needs a potty break every 3 hours',
    energyLevel: 'Medium energy level',
    feedingSchedule: 'Needs to be fed twice a day',
    canBeLeftAlone: 'Can be left alone for 4 hours',
    medications: 'None',
    vetName: 'Dr. John Smith',
    clinicName: 'City Vet',
    vetAddress: '10 Main St, Boston, MA',
    vetNumber: '(406) 555-0121',
    petInsuranceProvider: 'Rover',
    vetNote: 'Needs lots of playtime.',
    bathingPrice: 0.00,
    extendedCarePrice: 0.00,
    additionalRate: 0.00,
    total: 150.00,
  ),
  BookingData(
    userName: 'Tamim',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Dog walking',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
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
    userName: 'Kawsar',
    userProfileImage: AppAssets.tamimProfileImg,
    location: 'New York, NY',
    service: 'Cat Care',
    contact: '(229) 555-0109',
    pickupTime: '10:00 AM',
    dropoffTime: '10:00 AM',
    petName: 'Max', // UNIFORM DATA
    petBreed: 'Labrador', // UNIFORM DATA
    petImage: AppAssets.petImage,
    date: '02/09/2025',
    price: '\$50',
    isRebooked: false,
    status: 'Upcoming',
    rating: 4.2,
    totalReviews: 800,
    petType: 'Cat',
    petWeight: '5Kg',
    petAge: '1 Yer 6Month',
    petGender: 'Female',
    dateOfBirth: '01/01/2024',
    adoptionDate: '01/01/2024',
    aboutPet: 'Shy but sweet.',
    pottyBreak: 'Uses litter box',
    energyLevel: 'Low energy level',
    feedingSchedule: 'Free feeding kibble',
    canBeLeftAlone: 'Can be left alone for 8 hours',
    medications: 'None',
    vetName: 'Dr. Mark Lee',
    clinicName: 'Feline Friends Clinic',
    vetAddress: '30 Catnip Ave, Boston, MA',
    vetNumber: '(406) 555-0122',
    petInsuranceProvider: 'CatGuard',
    vetNote: 'Loves tuna.',
    bathingPrice: 0.00,
    extendedCarePrice: 0.00,
    additionalRate: 0.00,
    total: 50.00,
  ),
];

// --------------------------------------------------------------------------
// --- GETX CONTROLLERS AND SERVICE ---
// --------------------------------------------------------------------------

class BookingStatusController extends GetxController {
  var selectedStatus = 'On going'.obs;

  void selectStatus(String status) {
    selectedStatus.value = status;
  }
}

class BookingService extends GetxController {
  final RxList<BookingData> bookings = initialBookings.obs;

  void updateBookingStatus(BookingData booking, String newStatus) {
    int index = bookings.indexWhere((b) => b == booking);
    if (index != -1) {
      BookingData updatedBooking = booking.copyWith(status: newStatus);
      bookings[index] = updatedBooking;
    }
  }
}

// --------------------------------------------------------------------------
// --- DIALOG WIDGETS ---
// --------------------------------------------------------------------------

class CancellationConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const CancellationConfirmationDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.redColor, size: 40),
          const SizedBox(height: 16),
          Text(
            'Are you sure you want to cancel the booking?',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side:  BorderSide(color: AppColors.redColor, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('No', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.redColor)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Yes', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CompletionRatingDialog extends StatefulWidget {
  final String userName;
  final VoidCallback onDone;

  const CompletionRatingDialog({super.key, required this.userName, required this.onDone});

  @override
  State<CompletionRatingDialog> createState() => _CompletionRatingDialogState();
}

class _CompletionRatingDialogState extends State<CompletionRatingDialog> {
  int _rating = 5;
  final List<String> ratingLabels = ['Bad', 'Average', 'Good', 'Great', 'Amazing'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline, color: AppColors.greenColor, size: 50),
              const SizedBox(height: 16),
              Text(
                'Your task has been completed',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark),
              ),
              const SizedBox(height: 4),
              Text(
                'Average Rating and Feedback\n${widget.userName}',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 14, color: AppColors.subHeadingColor),
              ),
              const SizedBox(height: 24),
              Text('Avg. Rating', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),

              // --- Rating Stars ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starValue = index + 1;
                  return GestureDetector(
                    onTap: () => setState(() => _rating = starValue),
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          size: 30,
                          color: starValue <= _rating ? Colors.amber : AppColors.subHeadingColor.withOpacity(0.5),
                        ),
                        Text(
                          ratingLabels[index],
                          style: GoogleFonts.montserrat(fontSize: 10, color: starValue <= _rating ? AppColors.textDark : AppColors.subHeadingColor),
                        )
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // --- Feedback Note ---
              Text('Feedback Note', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark)),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  hintStyle: GoogleFonts.montserrat(color: AppColors.subHeadingColor),
                  fillColor: AppColors.inputBorderColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Done Button ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    widget.onDone();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainAppColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Done', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// --- BOOKINGSSCREEN IMPLEMENTATION ---
// --------------------------------------------------------------------------

class BookingsScreen extends StatefulWidget{
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {

  final BookingStatusController controller = Get.put(BookingStatusController());
  final BookingService bookingService = Get.put(BookingService());

  final List<Map<String, dynamic>> statuses = [
    {'name': 'On going', 'color': AppColors.mainAppColor},
    {'name': 'Completed', 'color': AppColors.greenColor},
    {'name': 'Cancelled', 'color': AppColors.redColor},
    {'name': 'Upcoming', 'color': AppColors.upcomingColor},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F4),
      appBar: _buildCustomAppBar(),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Status Filter Row
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
                DateTime.now().add(const Duration(days: 3)),
                DateTime.now().add(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 5)),
              ],
              onDaySelected: (day) {},
            ),
            SizedBox(height: 24.h),

            const SizedBox(height: 24),

            /// ----------------------------------------- Booking Section ----------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),

              child: Obx(() {
                String selectedStatus = controller.selectedStatus.value;

                List<BookingData> filteredList = bookingService.bookings
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
      // --- Floating Messenger Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the floating messenger button
          Get.snackbar(
              'Chat',
              'Opening general chat window...',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.mainAppColor,
              colorText: Colors.white
          );
        },
        backgroundColor: AppColors.mainAppColor,
        child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white),
      ),
      // --- END Floating Messenger Button ---
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size: 24),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Order Details',
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
              AppIcons.order,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              height: 24.w,
              width: 24.w,
            ),
          ),
        ),
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

// --------------------------------------------------------------------------
// --- CORRECTED EXPANDABLE BOOKING CARD WIDGET ---
// --------------------------------------------------------------------------
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

  // True if it's 'On going' or 'Upcoming' (standard card with pricing/buttons/dropdown)
  bool get _hasActiveButtons => widget.booking.status == 'On going' || widget.booking.status == 'Upcoming';

  // True if it's 'Completed' or 'Cancelled' (image-like card, full tap expandable, no pricing, no buttons)
  bool get _isFullCardToggleLogic => widget.booking.status == 'Completed' || widget.booking.status == 'Cancelled';


  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

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

  Widget _buildSectionTitle(String title, {bool useIcon = false,  String? svgPath, }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (useIcon && svgPath != null) ...[
          SvgPicture.asset(
            svgPath,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(AppColors.mainAppColor, BlendMode.srcIn),
          ),
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
          ]
        ],
      ),
    );
  }

  // --- Widget for Status Display (Collapsed Tag for C/C) ---
  Widget _buildStatusDisplay(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Text(
          status,
          style: GoogleFonts.montserrat(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600)),
    );
  }
  // --- End Status Widget ---

  // --- Widget for Completed/Cancelled Status Bar (Full Width, Expanded) ---
  Widget _buildCompletedCancelledStatusBar(String status) {
    final Color barColor = status == 'Completed' ? AppColors.greenColor : AppColors.redColor;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: barColor.withOpacity(0.15), // Lighter background
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: barColor, // Use the status color for the text
        ),
      ),
    );
  }
  // --- End Status Widget ---

  // --- EXPANDED SECTIONS IMPLEMENTATION ---

  Widget _buildPetDetailsSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Pet Information'),
          const SizedBox(height: 12),
          _buildInfoColumn('Pet Name', widget.booking.petName),
          _buildInfoColumn('Type', widget.booking.petType),
          _buildInfoColumn('Weight (lbs)', widget.booking.petWeight),
          _buildInfoColumn('Age', widget.booking.petAge),
          _buildInfoColumn('Breed', widget.booking.petBreed),
          _buildInfoColumn('Gender', widget.booking.petGender),
          _buildInfoColumn('Dates of birth', widget.booking.dateOfBirth, lastItem: true),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetailsSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Additional details'),
          const SizedBox(height: 12),
          _buildInfoColumn('Microchipped?', 'Microchipped', isValueGrey: true),
          _buildInfoColumn('Spayed/Neutered?', 'Spayed/Neutered', isValueGrey: true),
          _buildInfoColumn('House Trained?', 'Not House Trained', isValueGrey: true),
          _buildInfoColumn('Friendly with children?', 'Friendly with children', isValueGrey: true),
          _buildInfoColumn('Friendly with dogs?', 'Friendly with dogs', isValueGrey: true),
          _buildInfoColumn('Adoption Date', widget.booking.adoptionDate),
          _buildInfoColumn('About your pet', widget.booking.aboutPet, lastItem: true),
        ],
      ),
    );
  }

  Widget _buildPetCareInfoSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Care info', useIcon: true, svgPath: AppIcons.paw),
          const SizedBox(height: 12),
          _buildInfoColumn('Potty break', widget.booking.pottyBreak),
          _buildInfoColumn('Energy level', widget.booking.energyLevel),
          _buildInfoColumn('Feeding schedule', widget.booking.feedingSchedule),
          _buildInfoColumn('Can be left alone', widget.booking.canBeLeftAlone),
          _buildInfoColumn('Medications', widget.booking.medications),
          _buildInfoColumn('Anything else a sitter should know?', 'Add instructions for walking, feeding or other care', lastItem: true, isValueGrey: true),
        ],
      ),
    );
  }

  Widget _buildVetInformationSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Veterinary Info', useIcon: true, svgPath: AppIcons.vet),
          const SizedBox(height: 12),
          _buildInfoColumn('Veterinary info', 'Vet\'s Name: ${widget.booking.vetName}\nClinic: ${widget.booking.clinicName}\nAddress: ${widget.booking.vetAddress}\nNumber: ${widget.booking.vetNumber}', isValueGrey: true),
          _buildInfoColumn('Pet insurance provider', widget.booking.petInsuranceProvider),
          _buildInfoColumn('Note', widget.booking.vetNote, lastItem: true, isValueGrey: true),
        ],
      ),
    );
  }


  Widget _buildPricingSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Pricing', useIcon: true, svgPath: AppIcons.billing),
          const SizedBox(height: 12),
          _buildInfoRow('Bathing / Grooming', '\$${widget.booking.bathingPrice.toStringAsFixed(2)}'),
          _buildInfoRow('Extended Care', '\$${widget.booking.extendedCarePrice.toStringAsFixed(2)}'),
          _buildInfoRow('Additional Pet Rate', '\$${widget.booking.additionalRate.toStringAsFixed(2)}'),
          const Divider(height: 20, color: AppColors.borderColor),
          _buildInfoRow('Total', '\$${widget.booking.total.toStringAsFixed(2)}', isBold: true),
        ],
      ),
    );
  }

  // --- END EXPANDED SECTIONS IMPLEMENTATION ---

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

    // Determine the main card structure
    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row
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
                // Show rating for all statuses for uniformity
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('${booking.rating} (${booking.totalReviews})', style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.subHeadingColor)),
                  ],
                ),
              ],
            ),
            const Spacer(),

            // --- Rebooked Tag (Only for On going) ---
            if (booking.status == 'On going' && booking.isRebooked) ...[
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: AppColors.mainAppColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                    'Rebooked',
                    style: GoogleFonts.montserrat(
                        color: AppColors.mainAppColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ],
            // --- END Rebooked Tag ---

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    // Use appropriate colors for the date container background
                      color: booking.status == 'Completed' ? AppColors.greenColor.withOpacity(0.1) :
                      booking.status == 'Cancelled' ? AppColors.redColor.withOpacity(0.1) :
                      AppColors.mainAppColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                      booking.date,
                      style: GoogleFonts.montserrat(
                        // Use the color based on status
                          color: booking.status == 'Completed' ? AppColors.greenColor :
                          booking.status == 'Cancelled' ? AppColors.redColor :
                          AppColors.mainAppColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 4),
                // --- Price Display (Hidden for Completed/Cancelled/Upcoming) ---
                if (!_isFullCardToggleLogic && booking.status != 'Upcoming') ...[
                  Text(booking.price, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  Text("Per walk", style: GoogleFonts.montserrat(fontSize: 12, color: AppColors.subHeadingColor)),
                ]
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Text(booking.service, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textDark)),
        const SizedBox(height: 12),

        // Contact & Schedule Info
        buildContactInfoRow(Icons.phone_outlined, booking.contact),
        const SizedBox(height: 8),
        buildContactInfoRow(Icons.calendar_today_outlined, booking.date),


        if (!_isFullCardToggleLogic) ...[ // Only show pick-up/drop-off for active/upcoming
          const SizedBox(height: 8),
          buildContactInfoRow(Icons.access_time_rounded, "Pick-up time: ${booking.pickupTime}"),
          const SizedBox(height: 8),
          buildContactInfoRow(Icons.access_time_rounded, "Drop-off time: ${booking.dropoffTime}"),
        ],

        // --- Status Text for Completed/Cancelled Cards in the main card area (Only when collapsed) ---
        if (_isFullCardToggleLogic && !_isExpanded) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: _buildStatusDisplay(
              booking.status,
              booking.status == 'Completed' ? AppColors.greenColor : AppColors.redColor,
            ),
          ),
        ],
        // --- End Status Text ---

        const SizedBox(height: 16),

        // --- PET SUMMARY/DROPDOWN TOGGLE (Hidden if C/C and Collapsed) ---
        // Condition: Show if it's Active/Upcoming (regardless of expansion) OR if it's C/C AND expanded.
        if (!_isFullCardToggleLogic || _isExpanded)
          GestureDetector(
            // Tap Logic: Active/Upcoming cards use the Pet Summary box as the toggle target.
            // C/C cards rely on the main card GestureDetector (onTap: _toggleExpansion in the outer container).
            onTap: _hasActiveButtons ? _toggleExpansion : null,
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

                  // --- Icon Logic based on Status ---
                  if (_hasActiveButtons) // On going/Upcoming: Expand/Collapse Icon
                    Icon(_isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, size: 28, color: AppColors.subHeadingColor)
                  else // Completed/Cancelled: Arrow Icon
                    const Icon(Icons.keyboard_arrow_right_rounded, size: 28, color: AppColors.subHeadingColor)
                  // --- End Icon Logic ---
                ],
              ),
            ),
          ),
        // --- END PET SUMMARY ---


        // Expanded Details (Dropdown)
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isExpanded
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPetDetailsSection(),
              _buildAdditionalDetailsSection(),
              _buildPetCareInfoSection(),
              _buildVetInformationSection(),

              // --- PRICING SECTION: Only shown for On going/Upcoming (when _isFullCardToggleLogic is false) ---
              if (!_isFullCardToggleLogic)
                _buildPricingSection(),
            ],
          )
              : const SizedBox.shrink(),
        ),


        // --------------------------------------------------------------------------
        // --- FOOTER SECTION: BUTTONS OR STATUS BAR (CONDITIONAL) ---
        // --------------------------------------------------------------------------

        // Footer Buttons for 'On going' or 'Upcoming' (Only show when collapsed)
        if (_hasActiveButtons && !_isExpanded)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildCardFooter(context, booking.status),
          ),

        // Full Width Status Bar for 'Completed' or 'Cancelled' (Only visible when expanded)
        if (_isFullCardToggleLogic && _isExpanded)
          _buildCompletedCancelledStatusBar(booking.status),

        // --------------------------------------------------------------------------
        // --- END FOOTER SECTION ---
        // --------------------------------------------------------------------------
      ],
    );


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
      // Use GestureDetector on the main container for the full card toggle logic (Completed/Cancelled only)
      child: GestureDetector(
        // Card will only react to a full tap if it's Completed/Cancelled
          onTap: _isFullCardToggleLogic ? _toggleExpansion : null,
          // Use HitTestBehavior.opaque to capture taps across the entire widget area for C/C cards
          behavior: _isFullCardToggleLogic ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
          child: cardContent
      ),
    );
  }

  /// ----------------------------------------- FOOTER LOGIC ----------------------------
  Widget _buildCardFooter(BuildContext context, String status) {
    final BookingService bookingService = Get.find<BookingService>();
    final BookingStatusController statusController = Get.find<BookingStatusController>();
    final BookingData booking = widget.booking;

    void updateAndSelectStatus(String newStatus, String snackbarTitle, String snackbarMessage, Color color) {
      bookingService.updateBookingStatus(booking, newStatus);
      statusController.selectStatus(newStatus);
      Get.snackbar(snackbarTitle, snackbarMessage, snackPosition: SnackPosition.BOTTOM, backgroundColor: color, colorText: Colors.white);
    }

    void handleCompletionConfirmation() {
      // Logic for Completion
      updateAndSelectStatus('Completed', 'Success', 'Booking marked as Completed.', AppColors.greenColor);
    }

    void handleCancellationConfirmation() {
      // Logic for Cancellation
      updateAndSelectStatus('Cancelled', 'Cancelled', 'Booking has been cancelled.', AppColors.redColor);
    }

    void acceptBooking() {
      // Logic for Acceptance
      updateAndSelectStatus('On going', 'Accepted', 'Booking has been accepted and is now On going.', AppColors.mainAppColor);
    }

    void showCompletionDialog() {
      Get.dialog(
        CompletionRatingDialog(
          userName: booking.userName,
          onDone: handleCompletionConfirmation,
        ),
      );
    }

    void showCancelDialog() {
      Get.dialog(
        CancellationConfirmationDialog(
          onConfirm: handleCancellationConfirmation,
        ),
      );
    }

    switch (status) {
      case 'On going':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.to(() =>  const RescheduleScreen()), // Reschedule is the decline/red button
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7726A), // Red color for reschedule/decline
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Reschedule', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: showCompletionDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor, // Main color for acceptance/completion
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Ask for Complete', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        );

      case 'Upcoming':
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: showCancelDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7726A), // Decline button color
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
                onPressed: acceptBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor, // Accept button is MainAppColor
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Accept', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink(); // Completed/Cancelled cards do not show active buttons
    }
  }

}