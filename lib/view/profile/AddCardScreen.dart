// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../utils/app_colors.dart';
//
// class AddCardScreen extends StatelessWidget {
//   const AddCardScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.mainAppColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Add Card', // Title from the fifth image
//           style: GoogleFonts.montserrat(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(30.r),
//             bottomRight: Radius.circular(30.r),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Please enter payment information',
//               style: GoogleFonts.montserrat(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 20.h),
//
//             // --- Card Details Form Fields ---
//             // Name on Card
//             _buildTextField(label: 'Name on card'),
//             // Card Number
//             _buildTextField(label: 'Card Number', initialValue: '1234 5678 9101 1121', keyboardType: TextInputType.number),
//
//             // Expiry and CVV Row
//             Row(
//               children: [
//                 Expanded(child: _buildTextField(label: 'Expiration Date', initialValue: 'MM/YY', keyboardType: TextInputType.datetime)),
//                 SizedBox(width: 15.w),
//                 Expanded(child: _buildTextField(label: 'CVV', initialValue: '123', keyboardType: TextInputType.number)),
//               ],
//             ),
//
//             // Country Dropdown (Placeholder)
//             _buildCountryDropdown(label: 'Country', selectedValue: 'Bangladesh'),
//
//             // Street Address Fields
//             _buildTextField(label: 'Street Name And Number'),
//             _buildTextField(label: 'Additional Address Details (optional)'),
//             _buildTextField(label: 'City/Town'),
//
//             // Zip/Postal Code
//             _buildTextField(label: 'Postcode', initialValue: '10000', keyboardType: TextInputType.number),
//
//             SizedBox(height: 20.h),
//
//             // --- Security Information Section ---
//             _buildSecurityInfo(),
//             SizedBox(height: 80.h), // Extra space for button padding
//
//           ],
//         ),
//       ),
//       // --- Floating Save Button ---
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               blurRadius: 10,
//               spreadRadius: 2,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: ElevatedButton(
//           onPressed: () {
//             // Implement form submission logic
//             Get.back(); // Navigate back after saving
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.mainAppColor,
//             padding: EdgeInsets.symmetric(vertical: 14.h),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//           ),
//           child: Text(
//             'Save',
//             style: GoogleFonts.montserrat(
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // --- Reusable Form Field Widgets ---
//
//   Widget _buildTextField({required String label, String? initialValue, TextInputType keyboardType = TextInputType.text}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         TextFormField(
//           initialValue: initialValue,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             isDense: true,
//             contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.r),
//               borderSide: BorderSide(color: AppColors.mainAppColor),
//             ),
//           ),
//           style: GoogleFonts.montserrat(fontSize: 14.sp),
//         ),
//         SizedBox(height: 15.h),
//       ],
//     );
//   }
//
//   Widget _buildCountryDropdown({required String label, required String selectedValue}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w500,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 8.h),
//         Container(
//           height: 48.h, // Fixed height for visual consistency
//           padding: EdgeInsets.symmetric(horizontal: 12.w),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               isExpanded: true,
//               value: selectedValue,
//               icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
//               style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.black),
//               items: <String>['Bangladesh', 'USA', 'UK']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 // Handle country change
//               },
//             ),
//           ),
//         ),
//         SizedBox(height: 15.h),
//       ],
//     );
//   }
//
//   Widget _buildSecurityInfo() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Your information is secure',
//           style: GoogleFonts.montserrat(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 5.h),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(Icons.lock_outline, size: 16.r, color: Colors.grey),
//             SizedBox(width: 8.w),
//             Expanded(
//               child: Text(
//                 'We use secure socket layer encryption and Stripe to process your card payment securely.',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 12.sp,
//                   color: Colors.grey[600],
//                   height: 1.4,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }