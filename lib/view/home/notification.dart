import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

// You would typically define NotificationScreen as a StatefulWidget or StatelessWidget
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Sample data to populate the list
  final List<Map<String, dynamic>> notifications = const [
    {
      'name': 'Tamim',
      'message': 'Hey, I loved your recent works about The Serves ..',
      'time': '1 day ago',
    },
    {
      'name': 'Sarah Chen',
      'message': 'Hey, I loved your recent works about The Serves ..',
      'time': '2 days ago',
    },
    {
      'name': 'Tamim',
      'message': 'Hey, I loved your recent works about The Serves ..',
      'time': '1 day ago',
    },
    {
      'name': 'Sarah Chen',
      'message': 'Hey, I loved your recent works about The Serves ..',
      'time': '4 days ago',
    },
  ];

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
          'Notification',
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
      backgroundColor: AppColors.bgColor,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _NotificationCard(
            name: notification['name'] as String,
            message: notification['message'] as String,
            time: notification['time'] as String,
          );
        },
      ),
    );
  }
}

// Reusable widget for an individual notification card
class _NotificationCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const _NotificationCard({
    required this.name,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: AppColors.white,
        // Matching the subtle shadow and rounded corners of the card
        elevation: 1.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 12.0),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/notti.svg',
                    width: 24.sp,
                    height: 24.sp,
                  ),
                ),
              ),

              // 2. Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notification Type & Sender
                    Text(
                      'New message from $name',
                      style: const TextStyle(
                        color: AppColors.mainAppColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Message Snippet
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Time Ago
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Three Dots Menu
              const IconButton(
                onPressed: null, // Keep disabled for visual match
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

