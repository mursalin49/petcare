import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/utils/app_colors.dart';

import '../../helpers/route.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({super.key});

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  final TextEditingController _promoController = TextEditingController();
  final FocusNode _promoFocusNode = FocusNode();


  final Set<String> _usedPromoCodes = {};

  @override
  void initState() {
    super.initState();

    _promoFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _promoController.dispose();
    _promoFocusNode.dispose();
    super.dispose();
  }


  void _applyPromoCode() {
    final String code = _promoController.text.trim();
    if (code.isEmpty) {
      return;
    }


    if (_usedPromoCodes.contains(code)) {

      _showResultModal(
        isSuccess: false,
        message: "This promo code has already been used.",
      );
    } else {

      _usedPromoCodes.add(code);
      _showResultModal(
        isSuccess: true,
        message: "Your Promo has been apply successfully",
      );
    }

    _promoController.clear();
    _promoFocusNode.unfocus();
  }


  void _showResultModal({required bool isSuccess, required String message}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Get.back(),
                ),
              ),
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: isSuccess ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess ? Icons.check_rounded : Icons.close_rounded,
                  color: Colors.white,
                  size: 35.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 25.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainAppColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    "Done",
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Promo/Gift Codes',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            SizedBox(height: 30.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/appLogo.svg"),

              ],
            ),

            SizedBox(height: 40.h),

            TextField(
              controller: _promoController,
              focusNode: _promoFocusNode,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: Colors.grey.shade600,
                ),
                hintText: "Add Promo or gift code",
                hintStyle: GoogleFonts.montserrat(
                    color: Colors.grey.shade500,
                    fontSize: 16.sp
                ),
                // "APPLY" বাটন
                suffixIcon: TextButton(
                  onPressed: _applyPromoCode,
                  child: Text(
                    "APPLY",
                    style: GoogleFonts.montserrat(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp
                    ),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainAppColor, width: 2),
                ),
              ),
            ),

            SizedBox(height: 25.h),

            // --- ডিসক্লেইমার টেক্সট ---
            Text(
              "If you obtained your promotional code through an employer-sponsored back-up care programme, by applying the code you agree that booking and related information may be shared with your employer.",
              style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                  height: 1.5
              ),
            ),
          ],
        ),
      ),
    );
  }
}