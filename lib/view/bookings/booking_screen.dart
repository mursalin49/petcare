import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:petcare/view/bookings/booking_status_controller.dart';
import 'package:petcare/view/bookings/reschedule_screen.dart';
import 'package:petcare/view/bookings/widgets/custom_calendar.dart';
// import 'package:petcare/view/bookings/widgets/custom_calendar.dart'; // --- এই লাইনটির আর প্রয়োজন নেই

import '../../utils/app_colors.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatefulWidget{
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {

  final BookingStatusController controller = Get.put(BookingStatusController());

  final List<String> statuses = [
    'On going',
    'Completed',
    'Cancelled',
    'Upcoming',
    'Rebooked'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: _buildCustomAppBar(),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          /// ----------------------------------------- Status Section ----------------------------
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(
                children: List.generate(statuses.length, (index) {
                  final status = statuses[index];
                  final bool isSelected = controller.selectedStatus.value == status;

                  return GestureDetector(
                    onTap: () => controller.selectStatus(status),
                    child: Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected? AppColors.mainAppColor : Colors.white,
                        border: Border.all(
                          color: AppColors.mainAppColor,
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          color: isSelected ? Colors.white : AppColors.mainAppColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                    ),
                  );
                }),
              ),
            ),
          )
          ),
          SizedBox(height: 16.h),

          _buildColorLegends(),
          SizedBox(height: 20.h),
          CustomCalendarWidget(
            unavailableDays: [
              DateTime(2025, 11, 16),
              DateTime(2025, 11, 14),
              DateTime(2025, 11, 18),
            ],
          ),
          SizedBox(height: 24.h),

          /// ----------------------------------------- Booking Section ----------------------------
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ExpandableBookingCard(
                    name: "Tamim",
                    profileImage: "assets/images/profileImg.png",
                    rating: 3.8,
                    totalReviews: 1200,
                    date: "02/09/2025",
                    serviceType: "Dog walking",
                    contactNumber: "(229) 555-0109",
                    bookingDate: "01/09/2025",
                    pickUpTime: "10:00 AM",
                    dropOffTime: "10:00 AM",
                    price: "99",
                    status: "Completed",
                  ),
                  ExpandableBookingCard(
                    name: "Tamim",
                    profileImage: "assets/images/profileImg.png",
                    rating: 3.8,
                    totalReviews: 1200,
                    date: "02/09/2025",
                    serviceType: "Dog walking",
                    contactNumber: "(229) 555-0109",
                    bookingDate: "01/09/2025",
                    pickUpTime: "10:00 AM",
                    dropOffTime: "10:00 AM",
                    price: "99",
                    status: "Rebooked",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// -------------------------------------------------------------------
  /// --- Helper Widgets (এই পেজের জন্য) ---
  /// -------------------------------------------------------------------

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
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () { /* ফিল্টার অ্যাকশন */ },
          icon: Icon(Icons.filter_list_rounded, color: Colors.white, size: 26.sp),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }

  Widget _buildColorLegends() {
    Widget legendItem(Color color, String text) {
      return Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.subHeadingColor,
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          legendItem(AppColors.mainAppColor, 'On going'),
          legendItem(Colors.green, 'Completed'),
          legendItem(Colors.red, 'Cancelled'),
          legendItem(Colors.lightBlue.shade300, 'Upcoming'),
        ],
      ),
    );
  }


}


/// -------------------------------------------------------------------
/// --- এক্সপ্যান্ডেবল বুকিং কার্ড উইজেট (আগের মতোই) ---
/// -------------------------------------------------------------------

class ExpandableBookingCard extends StatefulWidget {
  final String name;
  final String profileImage;
  final double rating;
  final int totalReviews;
  final String date;
  final String serviceType;
  final String contactNumber;
  final String bookingDate;
  final String pickUpTime;
  final String dropOffTime;
  final String price;
  final String status;

  const ExpandableBookingCard({
    super.key,
    required this.name,
    required this.profileImage,
    required this.rating,
    required this.totalReviews,
    required this.date,
    required this.serviceType,
    required this.contactNumber,
    required this.bookingDate,
    required this.pickUpTime,
    required this.dropOffTime,
    required this.price,
    required this.status,
  });

  @override
  State<ExpandableBookingCard> createState() => _ExpandableBookingCardState();
}

class _ExpandableBookingCardState extends State<ExpandableBookingCard> {

  bool _isExpanded = false;

  /// --- [HELPER 1] ডিটেইলস কার্ডের জন্য টেমপ্লেট ---
  Widget _buildSectionCard({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 16.h),
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade200, width: 1.5)
      ),
      child: child,
    );
  }

  // --- [HELPER 2] ডিটেইলস কার্ডের টাইটেল ---
  Widget _buildSectionTitle(String title, {String? iconAsset}) {
    return Row(
      children: [
        if (iconAsset != null) ...[
          Icon(Icons.pets_rounded, color: AppColors.mainAppColor, size: 22.sp),
          SizedBox(width: 8.w),
        ],
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  // --- [HELPER 3] ইনফো রো (Label: Value) ---
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              label,
              style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.subHeadingColor, fontWeight: FontWeight.w500)
          ),
          Text(
              value,
              style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.textDark, fontWeight: FontWeight.w500)
          ),
        ],
      ),
    );
  }

  // --- [HELPER 4] ইনফো কলাম (Label / Value) ---
  Widget _buildInfoColumn(String label, String value, {bool lastItem = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              label,
              style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.w600, color: AppColors.textDark)
          ),
          SizedBox(height: 4.h),
          Text(
              value,
              style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.subHeadingColor)
          ),
          if (!lastItem) ...[
            SizedBox(height: 10.h),
            Divider(color: Colors.grey.shade200, height: 1),
          ]
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    // --- বাটন এবং স্ট্যাটাস কালারের জন্য লজিক ---

    String leftButtonText = '';
    Color leftButtonColor = AppColors.primary;
    String rightButtonText = '';
    Color rightButtonColor = AppColors.mainAppColor;
    Color statusColor = AppColors.subHeadingColor;
    // --- বাটন ---
    SizedBox(height: 16.h);
    Row(
    children: [
    Expanded(
    child: ElevatedButton(
    onPressed: () {
    // --- [পরিবর্তন] "Reschedule" বাটন ক্লিক করলে নতুন পেজে যাবে ---
    if (leftButtonText == 'Reschedule' || rightButtonText == 'Reschedule') {
    Get.to(() => const RescheduleScreen());
    }
    // TODO: অন্যান্য বাটনের জন্যও লজিক যোগ করুন (Cancel, Delete, etc.)
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: leftButtonColor,
    //...
    ),
    child: Text(leftButtonText, ),
    ),
    ),
    // ... (বাকি বাটন)
    // ... ডান বাটনের onPressed-এও একই লজিক যোগ করতে পারেন
    ],
    );
    switch (widget.status) {
      case "Completed":
        leftButtonText = 'Reschedule';
        rightButtonText = 'Ask for complete';
        statusColor = Colors.green;
        break;
      case "Rebooked":
        leftButtonText = 'Cancel';
        rightButtonText = 'Re-book';
        statusColor = Colors.blueAccent;
        break;
      case "On going":
        leftButtonText = 'Cancel';
        rightButtonText = 'Reschedule';
        statusColor = AppColors.mainAppColor;
        break;
      case "Cancelled":
        leftButtonText = 'Delete';
        rightButtonText = 'Book Again';
        statusColor = Colors.red;
        break;
      case "Upcoming":
        leftButtonText = 'Cancel';
        rightButtonText = 'Reschedule';
        statusColor = Colors.lightBlue.shade300;
        break;
      default:
        leftButtonText = 'Cancel';
        rightButtonText = 'Details';
    }

    // --- কন্টাক্ট ইনফোর জন্য একটি লোকাল হেল্পার ---
    Widget buildContactInfoRow(IconData icon, String text) {
      return Row(
        children: [
          Icon(icon, color: AppColors.subHeadingColor, size: 16.sp),
          SizedBox(width: 10.w),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.subHeadingColor,
            ),
          ),
        ],
      );
    }

    // --- কার্ডের মেইন কন্টেইনার ---
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
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
          // --- ইউজার ইনফো (উপরের অংশ) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(radius: 24, backgroundImage: AssetImage(widget.profileImage)),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text('${widget.rating} (${widget.totalReviews})', style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.subHeadingColor)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.mainAppColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                child: Text(widget.date, style: GoogleFonts.montserrat(color: AppColors.mainAppColor, fontSize: 12.sp, fontWeight: FontWeight.w600)),
              )
            ],
          ),
          SizedBox(height: 16.h),

          // --- সার্ভিস এবং কন্টাক্ট ইনফো ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.serviceType, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  SizedBox(height: 10.h),
                  Text("Contact", style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  SizedBox(height: 8.h),
                  buildContactInfoRow(Icons.phone_outlined, widget.contactNumber),
                  SizedBox(height: 8.h),
                  buildContactInfoRow(Icons.calendar_today_outlined, widget.bookingDate),
                  SizedBox(height: 8.h),
                  buildContactInfoRow(Icons.access_time_rounded, "Pick-up: ${widget.pickUpTime}"),
                  SizedBox(height: 8.h),
                  buildContactInfoRow(Icons.access_time_rounded, "Drop-off: ${widget.dropOffTime}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("\$${widget.price}", style: GoogleFonts.montserrat(fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                  Text("Per walk", style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.subHeadingColor)),
                  SizedBox(height: 10.h),
                  Text(widget.status, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: statusColor)),
                ],
              )
            ],
          ),

          // --- পেট ইনফো হেডার (এক্সপ্যান্ড করার জন্য) ---
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  color: AppColors.mainAppColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.mainAppColor.withOpacity(0.1))
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset('assets/images/max.jpg', width: 48.w, height: 48.w, fit: BoxFit.cover),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Max", style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      Text("Labrador", style: GoogleFonts.montserrat(fontSize: 12.sp, color: AppColors.subHeadingColor)),
                    ],
                  ),
                  const Spacer(),
                  Icon(_isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, size: 28.sp, color: AppColors.subHeadingColor)
                ],
              ),
            ),
          ),

          // --- এক্সপ্যান্ডেবল কন্টেন্ট (অ্যানিমেশন সহ) ---
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Visibility(
                visible: _isExpanded,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Pet Information ---
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Pet Information"),
                          SizedBox(height: 12.h),
                          _buildInfoRow("Pet Name:", "Max boy"),
                          _buildInfoRow("Type:", "Dog"),
                          _buildInfoRow("Weight (lbs):", "8kg"),
                          _buildInfoRow("Age:", "3 Yer 4Month"),
                          _buildInfoRow("Breed:", "Mix"),
                          _buildInfoRow("Gender:", "Male"),
                          _buildInfoRow("Dates of birth:", "5kg"),
                        ],
                      ),
                    ),
                    // --- Additional details ---
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Additional details"),
                          SizedBox(height: 12.h),
                          _buildInfoColumn("Microchipped?", "Microchipped"),
                          _buildInfoColumn("Spayed/Neutered?", "Spayed/Neutered"),
                          _buildInfoColumn("House Trained?", "Not House Trained"),
                          _buildInfoColumn("friendly with children?", "Friendly with children"),
                          _buildInfoColumn("friendly with dogs?", "Friendly with children"),
                          _buildInfoColumn("Adoption Date", "10/12/2025"),
                          _buildInfoColumn("About your pet", "Good for eating my share 😊", lastItem: true),
                        ],
                      ),
                    ),
                    // --- Care info 1 ---
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Care info", iconAsset: "assets/icons/pet_paw.svg"),
                          SizedBox(height: 12.h),
                          _buildInfoColumn("Potty break", "Needs a potty break every hour"),
                          _buildInfoColumn("Energy level", "High energy level"),
                          _buildInfoColumn("Feeding schedule", "Needs to be fed in the morning"),
                          _buildInfoColumn("Can be left alone", "Can be left alone for 1 hour or less"),
                          _buildInfoColumn("Medications", "Pill\nABCD Pill"),
                          _buildInfoColumn("Anything else a sitter should know?", "Add instructions for walking, feeding or other care", lastItem: true),
                        ],
                      ),
                    ),
                    // --- Care info 2 ---
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Care info", iconAsset: "assets/icons/pet_paw.svg"),
                          SizedBox(height: 12.h),
                          _buildInfoColumn("Veterinary info", "Vet's Name: Dr. Emily Carter\nClinic: Happy Paws..."),
                          _buildInfoColumn("Pet insurance provider", "Labrador", lastItem: true),
                        ],
                      ),
                    ),
                    // --- Note ---
                    _buildSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Note"),
                          SizedBox(height: 12.h),
                          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.", style: GoogleFonts.montserrat(fontSize: 14.sp, color: AppColors.subHeadingColor)),
                        ],
                      ),
                    ),
                    // --- Pricing Section ---
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, bottom: 8.h, left: 4.w),
                      child: _buildSectionTitle("Pricing"),
                    ),
                    _buildSectionCard(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w), // প্রাইসিং কার্ডের জন্য আলাদা প্যাডিং
                        child: Column(
                          children: [
                            _buildInfoRow("Bathing / Grooming", "\$60.00"),
                            _buildInfoRow("Extended Care", "\$40.00"),
                            _buildInfoRow("Additional Pet Rate", "\$10.00"),
                            Divider(height: 20.h, color: Colors.grey.shade300),
                            _buildInfoRow("Total", "\$170.00"),
                          ],
                        )
                    ),
                  ],
                )
            ),
          ),
          // --- এক্সপ্যান্ডেবল কন্টেন্ট শেষ ---


          // --- বাটন ---
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: leftButtonColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(leftButtonText, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: rightButtonColor,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(rightButtonText, style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}