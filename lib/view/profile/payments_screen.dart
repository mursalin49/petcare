import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class SavedCard {
  final String cardType;
  final String lastFour;
  final String name;
  final String expiry;
  final bool isDefault;

  SavedCard({required this.cardType, required this.lastFour, required this.name, required this.expiry, this.isDefault = false});
}

final List<SavedCard> dummyCards = [
  SavedCard(cardType: 'Visa', lastFour: '6267', name: 'Bryan Edwards', expiry: '7/2033', isDefault: true),
];

// Example data for Payment History tabs
final List<Map<String, dynamic>> dummyHistory = [
  {'date': '03/20/2024 to 03/25/2024', 'details': 'Chabuka\'s stay with Jaye E.', 'amount': 46.00, 'type': 'American Express XXXX 1002'},
  {'date': '03/20/2024 to 03/25/2024', 'details': 'Tip: \$6.00', 'amount': 6.00, 'type': 'Tip'},
  {'date': '03/20/2024 to 03/25/2024', 'details': 'American Express XXXX 1002', 'amount': 330.00, 'type': 'American Express XXXX 1002'},
  {'date': '03/20/2024 to 03/25/2024', 'details': 'American Express XXXX 1002', 'amount': 46.00, 'type': 'American Express XXXX 1002'},
];


class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainAppColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Payments',
            style: GoogleFonts.montserrat(
              fontSize: 18,
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
          padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWalletBalance(),
              SizedBox(height: 30.h),

              Text(
                'Payment History',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h),

              _buildPaymentTabs(),
              SizedBox(height: 15.h),

              SizedBox(
                height: 500.h,
                child: TabBarView(
                  children: [
                    PaymentHistoryContent(tabName: 'Earnings'),
                    PaymentHistoryContent(tabName: 'Pending'),
                    PaymentHistoryContent(tabName: 'Withdrawals'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('WALLET', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey[600])),
            Text('US\$ 0.00', style: GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.w700, color: AppColors.mainAppColor)),
          ],
        ),
        SizedBox(height: 15.h),
        // Withdraw Button
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     border: Border.all(color: AppColors.mainAppColor, width: 1),
        //     borderRadius: BorderRadius.circular(10.r),
        //   ),
        //   child: TextButton(
        //     onPressed: () {},
        //     child: Text('Withdraw', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.mainAppColor)),
        //   ),
        // ),
        // SizedBox(height: 10.h),
        // Add or Modify Payment Method Button (Navigates to SavedCardsScreen)
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.mainAppColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: TextButton(
            onPressed: () {
              Get.to(() => const SavedCardsScreen());
            },
            child: Text(
              'Add or Modify a Payment Method',
              style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentTabs() {
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.mainAppColor,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black87,
        labelStyle: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Earnings'),
          Tab(text: 'Pending'),
          Tab(text: 'Withdrawals'),
        ],
      ),
    );
  }
}

// --- Payment History Tab Content Widget ---
class PaymentHistoryContent extends StatelessWidget {
  final String tabName;
  PaymentHistoryContent({required this.tabName});

  @override
  Widget build(BuildContext context) {
    if (tabName == 'Earnings' && dummyHistory.isEmpty) {
      return Center(
        child: Text(
          'You haven\'t made any withdrawals yet.',
          style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: dummyHistory.length,
      itemBuilder: (context, index) {
        final item = dummyHistory[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4.w,
                height: 40.h,
                color: AppColors.mainAppColor.withOpacity(0.5),
                margin: EdgeInsets.only(right: 10.w),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['date'], style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey[600])),
                    SizedBox(height: 4.h),
                    Text(item['details'], style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Text(
                '\$${item['amount'].toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: tabName == 'Pending' ? Colors.orange : AppColors.mainAppColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

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
          'Add Card',
          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r), bottomRight: Radius.circular(30.r)),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        itemCount: dummyCards.length,
        itemBuilder: (context, index) {
          return CardItem(card: dummyCards[index]);
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        child: ElevatedButton(
          onPressed: () {

            Get.to(() => const AddCardDetailsScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainAppColor,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          ),
          child: Text('Add Default Payment Method', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
        ),
      ),
    );
  }
}

// --- Individual Card Item Widget ---
class CardItem extends StatelessWidget {
  final SavedCard card;

  const CardItem({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFE3E6F0),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.h, right: 10.w),
            child: Icon(
              card.isDefault ? Icons.radio_button_checked : Icons.radio_button_off,
              color: card.isDefault ? AppColors.mainAppColor : Colors.grey,
              size: 20.r,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${card.cardType} - ${card.lastFour}', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                SizedBox(height: 4.h),
                Text(card.name, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.black54)),
                Text(card.expiry, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.black54)),
                SizedBox(height: 10.h),
                if (card.isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(5.r)),
                    child: Text('DEFAULT', style: GoogleFonts.montserrat(fontSize: 10.sp, fontWeight: FontWeight.w600, color: Colors.black87)),
                  )
              ],
            ),
          ),
          IconButton(
            // SvgPicture.asset("assets/images/appLogo.svg"),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            iconSize: 20.r,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// --- AddCardDetailsScreen ---
class AddCardDetailsScreen extends StatelessWidget {
  const AddCardDetailsScreen({super.key});

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
          'Card Details',
          style: GoogleFonts.montserrat(fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please enter payment information',
                style: GoogleFonts.montserrat(fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF585858))),
            SizedBox(height: 20.h),

            // --- Card Details Form Fields ---
            _buildTextField(label: 'Name on Card', hintText: 'Name on card'),
            _buildTextField(label: 'Card Number',
                hintText: '1234 5678 9101 1121',
                keyboardType: TextInputType.number),

            Row(
              children: [
                Expanded(child: _buildTextField(label: 'Expiration Date',
                    hintText: 'MM/YY',
                    keyboardType: TextInputType.datetime)),
                SizedBox(width: 15.w),
                Expanded(child: _buildTextField(label: 'CVC',
                    hintText: '123',
                    keyboardType: TextInputType.number)),
              ],
            ),

            _buildCountryDropdown(
                label: 'Country', selectedValue: 'Bangladesh'),

            _buildTextField(label: 'Street Name And Number',
                hintText: 'Street Name And Number'),
            _buildTextField(label: 'Additional Address Details (optional)',
                hintText: 'Additional Address Details (optional)'),
            _buildTextField(label: 'City/Town', hintText: 'City'),

            _buildTextField(label: 'Postcode',
                hintText: '10000',
                keyboardType: TextInputType.number),

            SizedBox(height: 20.h),

            _buildSecurityInfo(),
            SizedBox(height: 80.h),
          ],
        ),
      ),
      // --- Floating Save Button ---
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, -2))
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainAppColor,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
          ),
          child: Text('Save', style: GoogleFonts.inter(fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, String? hintText, TextInputType keyboardType = TextInputType
          .text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333))),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: GoogleFonts.montserrat(
                fontSize: 16, color: Color(0xFF7F7F7F)),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: AppColors.mainAppColor)),
          ),
          style: GoogleFonts.montserrat(fontSize: 14.sp),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildCountryDropdown(
      {required String label, required String selectedValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333))),
        SizedBox(height: 8.h),
        Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              icon: const Icon(
                  Icons.keyboard_arrow_down, color: Colors.black54),
              style: GoogleFonts.montserrat(
                  fontSize: 16, color: Color(0xFF7F7F7F)),
              items: <String>['Bangladesh', 'USA', 'UK'].map<
                  DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value));
              }).toList(),
              onChanged: (String? newValue) {
                /* Handle country change */
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE7F4F6),
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your information is secure',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Icon(Icons.person, color: Color(0xFF035F75)),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'We use bank-level encryption and Stripe to protect your payment information',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Color(0xFF000000),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}