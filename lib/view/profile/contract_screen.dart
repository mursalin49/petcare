import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppColors {
  static const Color mainAppColor = Color(0xFF035F75);
  static const Color white = Colors.white;
}

// --- Data Model ---
class ContactOption {
  final String title;
  final String assetPath;

  ContactOption({required this.title, required this.assetPath});
}

// --- List of Options ---
final List<ContactOption> options = [
  ContactOption(title: "Ticket", assetPath: "assets/icons/ticket.svg"),
  ContactOption(title: "Virtual Assistant", assetPath: "assets/icons/ai-brain-01.svg"),
  ContactOption(title: "WhatsApp", assetPath: "assets/icons/whatsapp (1).svg"),
];


class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Contract Us',
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        itemCount: options.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ContactItemCard(option: options[index]);
        },
      ),
    );
  }
}

// --- Custom Item Card Widget ---
class ContactItemCard extends StatelessWidget {
  final ContactOption option;

  const ContactItemCard({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 0.1),
      ),
      child: InkWell(
        onTap: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Tapped on ${option.title}')),
          // );
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                option.assetPath,
                width: 28.w,
                height: 28.h,
                colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                placeholderBuilder: (context) => const CircularProgressIndicator(),
              ),
              const SizedBox(width: 20),
              Text(
                option.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
