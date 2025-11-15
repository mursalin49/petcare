import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:petcare/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.showBackButton = true, // ✅ optional by default
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: AppColors.mainAppColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ✅ Conditionally show back button
              showBackButton
                  ? InkWell(
                onTap: onBackTap ?? () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/backIcon.svg",
                  color: AppColors.white,
                ),
              )
                  : const SizedBox(width: 24),

              // Title in center
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat-Regular',
                  fontSize: 18.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Spacer for balance
              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height * 0.15);
}
