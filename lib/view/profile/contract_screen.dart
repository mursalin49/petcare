import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/contact_controller.dart';

class AppColors {
  static const Color mainAppColor = Color(0xFF035F75);
  static const Color white = Colors.white;
}

// Data Model
class ContactOption {
  final String title;
  final String assetPath;

  ContactOption({required this.title, required this.assetPath});
}

// List of Options
final List<ContactOption> options = [
  ContactOption(title: "Ticket", assetPath: "assets/icons/ticket.svg"),
  ContactOption(title: "Virtual Assistant", assetPath: "assets/icons/ai-brain-01.svg"),
  ContactOption(title: "WhatsApp", assetPath: "assets/icons/whatsapp (1).svg"),
];

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    // Put controller
    final controller = Get.put(ContactController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Contact Us',
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
      ),

      // List
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: options.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.selectedContact.value == options[index].title;

            return GestureDetector(
              onTap: () => controller.selectContact(options[index].title),
              child: ContactItemCard(option: options[index], isSelected: isSelected),
            );
          });
        },
      ),
    );
  }
}


// --- Custom Item Card Widget ---
class ContactItemCard extends StatelessWidget {
  final ContactOption option;
  final bool isSelected;

  const ContactItemCard({super.key, required this.option, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainAppColor.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.mainAppColor : const Color(0xFFE3E6F0),
          width: 0.6,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            offset: const Offset(0, 2),
            blurRadius: 2,

          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            SvgPicture.asset(
              option.assetPath,
              width: 28.w,
              height: 28.h,
              colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
            ),
            const SizedBox(width: 20),
            Text(
              option.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.mainAppColor : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
