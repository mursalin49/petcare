import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming this is defined in your project
import '../../utils/app_colors.dart';

// -------------------------------------------------------------------
// --- Data Model for FAQ Items ---
// -------------------------------------------------------------------
class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

// --- List of FAQ Data ---
final List<FaqItem> faqList = [
  FaqItem(
    question: "How do i book a service App?",
    answer: "Select your service, pick a date & time, and confirm. You'll get a notification with details.",
  ),
  FaqItem(
    question: "Can I reschedule or cancel my booking?",
    answer: "Yes, you can manage your bookings through the 'My Bookings' section in the app. Cancellation and rescheduling policies may vary by service provider.",
  ),
  FaqItem(
    question: "What payment methods are accepted?",
    answer: "We accept all major credit cards, debit cards, and popular mobile payment solutions. Specific options will be displayed during checkout.",
  ),
  FaqItem(
    question: "How do I contact the service provider?",
    answer: "Once your booking is confirmed, the provider's contact details (phone and chat) will be available in the booking details screen.",
  ),
  FaqItem(
    question: "Is my personal information safe?",
    answer: "Yes. We use industry-standard encryption and security protocols to ensure all your personal and payment data is protected.",
  ),
];

// -------------------------------------------------------------------
// --- The Main FAQ Screen Widget ---
// -------------------------------------------------------------------
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Faq', // Title from the image
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // The rounded bottom shape
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
        ),
        // Optional: Adding the profile image placeholder to the AppBar (top right)

      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h), // Spacing between items
            child: FaqExpansionTile(item: faqList[index]),
          );
        },
      ),
    );
  }
}

// -------------------------------------------------------------------
// --- Custom Widget for FAQ Item (ExpansionTile) ---
// -------------------------------------------------------------------
class FaqExpansionTile extends StatelessWidget {
  final FaqItem item;

  const FaqExpansionTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Ensure background is white as in the image
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          // Subtly lift the card off the background (optional, but nice)
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Theme(
          // Removes the divider line below the title
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            // Key property to handle initial expansion state (optional)
            key: PageStorageKey(item.question),
            tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
            // The question part (leading text)
            title: Text(
              item.question,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            // The icon on the trailing side
            trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
            // The answer part (content when expanded)
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.answer,
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      color: Colors.grey[700],
                      height: 1.5,
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