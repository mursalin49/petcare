import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/view/bookings/chat.dart';

// Note: Assuming 'petcare' is your project root and RescheduleScreen exists
import 'package:petcare/view/bookings/reschedule_screen.dart';
import 'package:petcare/view/bookings/widgets/chat_list.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../home/widgets/custom_calendar.dart';
import 'dialog.dart';
import 'models/model.dart';

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

class CompletionRatingDialog extends StatefulWidget {
  final String userName;
  final VoidCallback onDone;

  const CompletionRatingDialog({
    super.key,
    required this.userName,
    required this.onDone,
  });

  @override
  State<CompletionRatingDialog> createState() => _CompletionRatingDialogState();
}

class _CompletionRatingDialogState extends State<CompletionRatingDialog> {
  int _rating = 5;
  final List<String> ratingLabels = [
    'Bad',
    'Average',
    'Good',
    'Great',
    'Amazing',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
          color: AppColors.bgColor,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/tick-circle.svg',
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 16),
              Text(
                'Your task has been completed',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Average Rating and Feedback\n${widget.userName}',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: AppColors.subHeadingColor,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Avg. Rating',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
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
                          color: starValue <= _rating
                              ? Colors.amber
                              : AppColors.subHeadingColor.withOpacity(0.5),
                        ),
                        Text(
                          ratingLabels[index],
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: starValue <= _rating
                                ? AppColors.textDark
                                : AppColors.subHeadingColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // --- Feedback Note ---
              Text(
                'Feedback Note',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  hintStyle: GoogleFonts.montserrat(
                    color: AppColors.subHeadingColor,
                  ),
                  fillColor: AppColors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    // Sets the rounded corners
                    borderRadius: BorderRadius.circular(10),

                    // --- ADD BORDER COLOR HERE ---
                    borderSide: const BorderSide(
                      color: Color(0xFFEEEEEE),
                      width: 1.0,
                    ),
                    // -----------------------------
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Done',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingsScreen extends StatefulWidget {
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
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: List.generate(statuses.length, (index) {
                    final status = statuses[index]['name'];
                    final color = statuses[index]['color'] as Color;
                    final bool isSelected =
                        controller.selectedStatus.value == status;

                    return GestureDetector(
                      onTap: () => controller.selectStatus(status),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? color : AppColors.white,
                          border: Border.all(color: color, width: 1.2),
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
              ),
            ),
            const SizedBox(height: 16),

            _buildColorLegends(),
            const SizedBox(height: 20),

            CustomCalendarWidget(
              unavailableDays: [
                DateTime.now().add(const Duration(days: 1)),
                DateTime.now().add(const Duration(days: 2)),
                DateTime.now().add(const Duration(days: 3)),
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
                        style: GoogleFonts.montserrat(
                          color: AppColors.grey,
                          fontSize: 16,
                        ),
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
                    return ExpandableBookingCard(booking: booking);
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
          Get.to(
            () => ChatListScreen(
              userImage: 'assets/images/nirob.jpg',
              userName: 'Your Name',
            ),
          );
        },
        backgroundColor: AppColors.mainAppColor,
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: Colors.white,
        ),
      ),
      // --- END Floating Messenger Button ---
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
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
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
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
            decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
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

  const ExpandableBookingCard({super.key, required this.booking});

  @override
  State<ExpandableBookingCard> createState() => _ExpandableBookingCardState();
}

class _ExpandableBookingCardState extends State<ExpandableBookingCard> {
  bool _isExpanded = false;

  // True if it's 'On going' or 'Upcoming' (standard card with buttons)
  bool get _hasActiveButtons =>
      widget.booking.status == 'On going' ||
      widget.booking.status == 'Upcoming';

  // True if it's 'Completed' or 'Cancelled' (simple card, full tap expandable)
  bool get _isFullCardToggleLogic =>
      widget.booking.status == 'Completed' ||
      widget.booking.status == 'Cancelled';

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
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(
    String title, {
    bool useIcon = false,
    String? svgPath,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (useIcon && svgPath != null) ...[
          SvgPicture.asset(
            svgPath,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.mainAppColor,
              BlendMode.srcIn,
            ),
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
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: isBold ? AppColors.textDark : AppColors.subHeadingColor,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(
    String label,
    String value, {
    bool lastItem = false,
    bool isValueGrey = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isValueGrey ? AppColors.grey : AppColors.subHeadingColor,
            ),
          ),
          if (!lastItem) ...[const SizedBox(height: 10)],
        ],
      ),
    );
  }

  Widget _buildInfo(
    String label,
    String value, {
    bool lastItem = false,
    bool isValueGrey = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isValueGrey ? AppColors.grey : AppColors.subHeadingColor,
            ),
          ),
          if (!lastItem) ...[const SizedBox(height: 10)],
        ],
      ),
    );
  }

  // --- EXPANDED SECTIONS IMPLEMENTATION ---

  Widget _buildPetDetailsSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Pet Information:'),
          const SizedBox(height: 12),
          _buildInfo('Pet Name:', widget.booking.petName),
          _buildInfo('Type:', widget.booking.petType),
          _buildInfo('Weight (lbs):', widget.booking.petWeight),
          _buildInfo('Age:', widget.booking.petAge),
          _buildInfo('Breed:', widget.booking.petBreed),
          _buildInfo('Gender:', widget.booking.petGender),
          _buildInfo(
            'Dates of birth:',
            widget.booking.dateOfBirth,
            lastItem: true,
          ),
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
          _buildInfoColumn(
            'Spayed/Neutered?',
            'Spayed/Neutered',
            isValueGrey: true,
          ),
          _buildInfoColumn(
            'House Trained?',
            'Not House Trained',
            isValueGrey: true,
          ),
          _buildInfoColumn(
            'Friendly with children?',
            'Friendly with children',
            isValueGrey: true,
          ),
          _buildInfoColumn(
            'Friendly with dogs?',
            'Friendly with dogs',
            isValueGrey: true,
          ),
          _buildInfoColumn('Adoption Date', widget.booking.adoptionDate),
          _buildInfoColumn(
            'About your pet',
            widget.booking.aboutPet,
            lastItem: true,
          ),
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
          _buildInfoColumn('Pill', widget.booking.fill),
          _buildInfoColumn(
            'Anything else a sitter should know?',
            'Add instructions for walking, feeding or other care',
            lastItem: true,
            isValueGrey: true,
          ),
        ],
      ),
    );
  }

  Widget _buildVetInformationSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Care info', useIcon: true, svgPath: AppIcons.paw),
          const SizedBox(height: 12),
          _buildInfoColumn(
            'Veterinary info',
            'Vet\'s Name: ${widget.booking.vetName}\nClinic: ${widget.booking.clinicName}\nAddress: ${widget.booking.vetAddress}\nNumber: ${widget.booking.vetNumber}',
            isValueGrey: true,
          ),
          _buildInfoColumn(
            'Pet insurance provider',
            widget.booking.petInsuranceProvider,
            lastItem: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Note'),
          const SizedBox(height: 12),
          Text(
            widget.booking.vetNote,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(
            'Pricing',
            useIcon: true,
            svgPath: AppIcons.billing,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            'Bathing / Grooming',
            '\$${widget.booking.bathingPrice.toStringAsFixed(2)}',
          ),
          _buildInfoRow(
            'Extended Care',
            '\$${widget.booking.extendedCarePrice.toStringAsFixed(2)}',
          ),
          _buildInfoRow(
            'Additional Pet Rate',
            '\$${widget.booking.additionalRate.toStringAsFixed(2)}',
          ),
          const Divider(height: 20, color: AppColors.borderColor),
          _buildInfoRow(
            'Total',
            '\$${widget.booking.total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  // --- END EXPANDED SECTIONS IMPLEMENTATION ---
  // --- Widget for Completed/Cancelled Status Bar (Full Width, Expanded) ---
  Widget _buildCompletedCancelledStatusBar(String status) {
    final Color barColor = status == 'Completed'
        ? Color(0xFFBCBCBC)
        : Color(0xFFBCBCBC);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: barColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: barColor,
        ),
      ),
    );
  }

  // --- End Status Widget ---

  @override
  Widget build(BuildContext context) {
    final booking = widget.booking;

    // Helper to build contact info rows with icons
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

    Widget buildContactInfoR(String text) {
      return Row(
        children: [
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

    // Main content of the booking card
    Widget cardContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row: User profile, rating, and date/price
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(booking.userProfileImage),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.userName,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Location info - shown for all statuses
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.subHeadingColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'New York, NY',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subHeadingColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Rating - shown for all statuses
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${booking.rating} (${booking.totalReviews})',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.subHeadingColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Date badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: booking.status == 'Completed'
                        ? AppColors.greenColor.withOpacity(0.1)
                        : booking.status == 'Cancelled'
                        ? AppColors.redColor.withOpacity(0.1)
                        : AppColors.mainAppColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    booking.date,
                    style: GoogleFonts.montserrat(
                      color: booking.status == 'Completed'
                          ? AppColors.greenColor
                          : booking.status == 'Cancelled'
                          ? AppColors.redColor
                          : AppColors.mainAppColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Service name and Price in one row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                booking.service,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(width: 12),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: booking.price,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  TextSpan(
                    text: " Per walk",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Contact label
        Text(
          'Contact',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),

        // Contact Info
        buildContactInfoRow(Icons.phone_outlined, booking.contact),
        const SizedBox(height: 8),
        buildContactInfoRow(Icons.calendar_today_outlined, booking.date),

        // Pick-up/Drop-off times - Only for On going and Upcoming
        if (booking.status == 'On going' || booking.status == 'Upcoming') ...[
          const SizedBox(height: 8),
          buildContactInfoR("Pick-up time: ${booking.pickupTime}"),
          const SizedBox(height: 8),
          buildContactInfoR("Drop-off time: ${booking.dropoffTime}"),
        ],

        const SizedBox(height: 16),

        // Pet Summary Box with dropdown/arrow - Only for On going and Upcoming
        if (booking.status == 'On going' || booking.status == 'Upcoming')
          GestureDetector(
            onTap: _toggleExpansion,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
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
                      Text(
                        booking.petName,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        booking.petBreed,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: AppColors.subHeadingColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    _isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    size: 28,
                    color: AppColors.subHeadingColor,
                  ),
                ],
              ),
            ),
          ),

        // Expanded Details - Only for On going and Upcoming
        if (booking.status == 'On going' || booking.status == 'Upcoming')
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
                      _buildNoteSection(),
                      if (booking.status == 'On going') _buildPricingSection(),
                    ],
                  )
                : const SizedBox.shrink(),
          ),

        // Buttons - Only for On going and Upcoming
        if (_hasActiveButtons)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: _buildCardFooter(context, booking.status),
          ),

        // Status text for Completed/Cancelled - shown at bottom right when NOT expanded
        if (_isFullCardToggleLogic && !_isExpanded) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              booking.status,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: booking.status == 'Completed'
                    ? AppColors.greenColor
                    : AppColors.redColor,
              ),
            ),
          ),
        ],

        // Expanded sections for Completed/Cancelled
        if (_isFullCardToggleLogic)
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
                      _buildNoteSection(),
                      _buildCompletedCancelledStatusBar(booking.status),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
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
          ),
        ],
      ),
      child: GestureDetector(
        onTap: _isFullCardToggleLogic ? _toggleExpansion : null,
        behavior: _isFullCardToggleLogic
            ? HitTestBehavior.opaque
            : HitTestBehavior.deferToChild,
        child: cardContent,
      ),
    );
  }

  /// ----------------------------------------- FOOTER LOGIC ----------------------------
  Widget _buildCardFooter(BuildContext context, String status) {
    final BookingService bookingService = Get.find<BookingService>();
    final BookingStatusController statusController =
        Get.find<BookingStatusController>();
    final BookingData booking = widget.booking;

    void updateAndSelectStatus(
      String newStatus,
      String snackbarTitle,
      String snackbarMessage,
      Color color,
    ) {
      bookingService.updateBookingStatus(booking, newStatus);
      statusController.selectStatus(newStatus);
      Get.snackbar(
        snackbarTitle,
        snackbarMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: color,
        colorText: Colors.white,
      );
    }

    void handleCompletionConfirmation() {
      updateAndSelectStatus(
        'Completed',
        'Success',
        'Booking marked as Completed.',
        AppColors.greenColor,
      );
    }

    void handleCancellationConfirmation() {
      updateAndSelectStatus(
        'Cancelled',
        'Cancelled',
        'Booking has been cancelled.',
        AppColors.redColor,
      );
    }

    void acceptBooking() {
      updateAndSelectStatus(
        'On going',
        'Accepted',
        'Booking has been accepted and is now On going.',
        AppColors.mainAppColor,
      );
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
                onPressed: () => Get.to(() => const RescheduleScreen()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF7726A),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Reschedule',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: showCompletionDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Ask for complete',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
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
                  backgroundColor: const Color(0xFFF7726A),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Decline',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: acceptBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainAppColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Accept',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
