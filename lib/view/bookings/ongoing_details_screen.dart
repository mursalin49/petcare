import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare/view/bookings/custom_app_bar.dart';
import 'package:petcare/view/bookings/widgets/custom_calendar.dart';

import '../../utils/app_colors.dart';
import '../bookings/widget/custom_calendar.dart';

class OngoingDetailsScreen extends StatelessWidget{
  const OngoingDetailsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "On going details",
        showBackButton: true,
      ),
      body: Expanded(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Pet sitter Availability",
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111111),
                  ),
                ),
                SizedBox(height: 18.h),
                Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Color(0xFFFE6C5D),
                          borderRadius: BorderRadius.circular(5.r)
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Booked",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101010),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Color(0xFF008364),
                          borderRadius: BorderRadius.circular(5.r)
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Available",
                      style: TextStyle(
                        fontFamily: 'Montserrat-Regular',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF101010),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomCalendarWidget(
                  unavailableDays: [
                    DateTime(2025, 11, 12),
                    DateTime(2025, 11, 13),
                    DateTime(2025, 11, 14),
                  ],
                  onDaySelected: (selectedDay) {
                    debugPrint('Selected: $selectedDay');
                  },
                ),
                SizedBox(height: 24.h),

                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Color(0xFFE3E6F0),
                      width: 0.6,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.r,
                                backgroundImage: AssetImage("assets/images/profileImg.png"),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Seam Rahman",
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 20.sp),
                                      SizedBox(width: 3.w),
                                      Text(
                                        "3.8 (1200)",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-Regular',
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9F5FC),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              "09/10/2025",
                              style: GoogleFonts.inter(
                                color: AppColors.mainAppColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),

                      Text(
                        "Dog Walking",
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Contact
                      Text(
                        "Contact",
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3C3C3C),
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey[600], size: 20.sp),
                          SizedBox(width: 6.w),
                          Text(
                            "01793396294",
                            style: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF585858),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, color: Colors.grey[600], size: 20.sp),
                          SizedBox(width: 6.w),
                          Text(
                            "10/10/25",
                            style: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF585858),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Pick-up / Drop-off
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pick-up time: 10:00 AM",
                            style: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF101010),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            "Drop-off time: 10:00 AM",
                            style: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF101010),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Pricing",
                        style: TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF101010),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Column(
                        children: [
                          _buildServicePriceRow("Bathing / Grooming", "\$60.00"),
                          SizedBox(height: 8.h),
                          _buildServicePriceRow("Extended Care", "\$40.00"),
                          SizedBox(height: 8.h),
                          _buildServicePriceRow("Additional Pet Rate", "\$10.00"),
                          SizedBox(height: 8.h),
                          _buildServicePriceRow("Pick Up And Drop Off", "\$50.00"),
                          SizedBox(height: 8.h),
                          Divider(
                            thickness: 1,
                            color: Color(0xFF585858),
                          ),
                          SizedBox(height: 8.h),
                          _buildServicePriceRow("Total", "\$160.00"),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      ExpansionTile(
                        tilePadding: EdgeInsets.all(10),
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Color(0xFFE5E5E5),
                            width: 1,
                          ),
                        ),
                        collapsedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Color(0xFFE5E5E5),
                            width: 1,
                          ),
                        ),
                        childrenPadding: EdgeInsets.all(16),
                        title: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage("assets/images/bigPet.png"),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Max",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Labrador",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 13.sp,
                                    color: Color(0xFF7A7A7A),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          /// Pet Information in separate container
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE3E6F0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _buildInfoSection("Pet Information", [
                              _buildInfoRow("Pet Name:", "Max.Doy"),
                              _buildInfoRow("Type:", "Dog"),
                              _buildInfoRow("Weight (lbs):", "10 Kg"),
                              _buildInfoRow("Age:", "3 Yer 4Month"),
                              _buildInfoRow("Breed:", "Mix"),
                              _buildInfoRow("Gender:", "Male"),
                              _buildInfoRow("Dates of birth:", "10/12/2022"),
                            ]),
                          ),

                          SizedBox(height: 12),

                          /// Additional Details in separate container
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE3E6F0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _buildInfoSection("Additional details", [
                              _buildInfoRow("Microchipped?", "Microchipped"),
                              _buildInfoRow("Spayed/Neutered?", "Spayed/Neutered"),
                              _buildInfoRow("House Trained?", "Not House Trained"),
                              _buildInfoRow("friendly with children?", "Friendly with children"),
                              _buildInfoRow("Friendly with dogs?", "Friendly with children"),
                              _buildInfoRow("Adoption Date", "10/12/2025"),
                            ]),
                          ),
                          SizedBox(height: 12.h),

                          ///  Care Info in separate container
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE3E6F0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _buildInfoSection("Care info", [
                              _buildInfoColum("Potty break", "Needs a potty break every hour"),
                              _buildInfoColum("Energy level", "High energy level"),
                              _buildInfoColum("Feeding schedule", "Needs to be fed in the morning"),
                              _buildInfoColum("Can be left alone", "Can be left alone for 1 hour or less"),
                              _buildInfoColum("Medications", "High energy level"),
                              _buildInfoColum("Pill", "ABCD pill"),
                              _buildInfoColum("Anything else a sitter should know?", "Add instructions for walking, feeding or other care"),

                            ]),
                          ),
                          SizedBox(height: 12.h),

                          /// Veterinary info
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE3E6F0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _buildInfoSection("Veterinary info", [
                              _buildInfoRow("Vet's Name:", "Dr. Emily Carter"),
                              _buildInfoRow("Clinic:", "Happy Paws Animal Clinic"),
                              _buildInfoRow("Address:", "45 Green Park Rd, Boston"),
                              _buildInfoRow("Number:", "017923242342"),
                              _buildInfoColum("Pet insurance provider", "Labrador")
                            ]),
                          ),
                          SizedBox(height: 12.h),

                          /// Note info
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFE3E6F0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _buildInfoSection("Note", [
                              _buildInfoColum("", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),

                      /// Button section Row
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFE6C5D),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    "Reschedule",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat-Regular',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 18.h),
                          Expanded(
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.mainAppColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/inboxIcon.svg", color: AppColors.white,),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "Chat",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat-Regular',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable pricing row
  Widget _buildServicePriceRow(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF101010),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF585858),
          ),
        ),
      ],
    );
  }

/// Reusable info section
  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 13.sp,
                color: Color(0xFF7A7A7A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColum(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 13.sp,
              color: Color(0xFF7A7A7A),
            ),
          ),
        ],
      ),
    );
  }


}