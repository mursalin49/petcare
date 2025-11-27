import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

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

          Icon(
            Icons.check,
            color: AppColors.redColor,
            size: 30,
          ),
          const SizedBox(height: 16),


          Text(
            'Are you sure you want to cancel the booking?',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark
            ),
          ),
          const SizedBox(height: 32),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side:  BorderSide(color: AppColors.redColor, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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