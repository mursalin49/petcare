import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

// Assuming AppColors.mainAppColor is defined elsewhere.
// For this example, I'll define a placeholder color that resembles the image's teal.

class ChatMessage {
  final String id;
  final String senderName;
  final String? senderImage;
  final String message;
  final String time;
  final bool isUserMessage;

  ChatMessage({
    required this.id,
    required this.senderName,
    this.senderImage,
    required this.message,
    required this.time,
    required this.isUserMessage,
  });
}

class ChatScreenController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      id: '1',
      senderName: 'Tamim Sarkar',
      senderImage: 'assets/images/profileImg.png',
      message: 'Hey! How was the new design project coming along?',
      time: '10:30 AM',
      isUserMessage: false,
    ),
    ChatMessage(
      id: '2',
      senderName: 'You',
      message: 'Hey! How was the new design project coming along?',
      time: '10:30 AM',
      isUserMessage: true,
    ),
    ChatMessage(
      id: '3',
      senderName: 'Tamim Sarkar',
      senderImage: 'assets/images/profileImg.png',
      message: 'Hey! How was the new design project coming along?',
      time: '10:30 AM',
      isUserMessage: false,
    ),
    ChatMessage(
      id: '4',
      senderName: 'You',
      message: 'Hey! How was the new design project coming along?',
      time: '10:30 AM',
      isUserMessage: true,
    ),
    ChatMessage(
      id: '5',
      senderName: 'Tamim Sarkar',
      senderImage: 'assets/images/profileImg.png',
      message: 'Hey! How was the new design project coming along?',
      time: '10:30 AM',
      isUserMessage: false,
    ),
  ].obs;

  final messageController = TextEditingController();

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(
      ChatMessage(
        id: DateTime.now().toString(),
        senderName: 'You',
        message: text,
        // Using a simpler format for time, matching the image's 'HH:MM AM/PM' style
        time: TimeOfDay.now().format(Get.context!),
        isUserMessage: true,
      ),
    );

    messageController.clear();
    update();
  }
}

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String contactImage;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.contactImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatScreenController controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatScreenController());
    _scrollController = ScrollController();
  }

  void _scrollToTopAnimated() {
    if (_scrollController.hasClients) {
      // Use the maxScrollExtent for reverse: true list to scroll to the end of the data (bottom of the screen)
      // Since ListView.builder is reversed, scrolling to 0 actually scrolls to the bottom of the chat.
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil must be initialized somewhere in the app's root (e.g., main.dart)
    // to use .w, .h, .r, .sp correctly.
    return Scaffold(
      backgroundColor: Colors.white, // Keeping scaffold white for the main chat background
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                reverse: true,
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[
                  controller.messages.length - 1 - index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
          _buildMessageInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,
      // Rounded corners are on the bottom, matching the look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          // Use Stack to correctly overlay the online status dot
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  widget.contactImage,
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                ),
              ),
              // Online Status Indicator
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 13.w,
                  height: 13.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF20C853), // Green for online
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.contactName,
                style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "Online",
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          )
        ],
      ),
      actions: [
        // Using PopupMenuButton to replicate the 'Delete conversation / Block' menu
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (String result) {
            // Handle menu selection
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete conversation'),
            ),
            const PopupMenuItem<String>(
              value: 'block',
              child: Text('Block'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAvatar(String? imagePath) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: imagePath != null && imagePath.isNotEmpty
                ? Image.asset(imagePath, fit: BoxFit.cover)
                : const Icon(Icons.person, color: Colors.grey),
          ),
        ),
        // Online Status Indicator
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 13.w,
            height: 13.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF20C853),
              border: Border.all(color: Colors.white, width: 2.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    // Calculate padding based on whether it's the user's message
    final double horizontalPadding = 16.w;
    final EdgeInsets rowPadding = message.isUserMessage
        ? EdgeInsets.only(left: 50.w, right: 0, top: 8.h, bottom: 8.h) // Pushes the bubble closer to the right edge
        : EdgeInsets.only(right: 50.w, left: 0, top: 8.h, bottom: 8.h); // Ensures space for the non-user bubble to wrap

    return Padding(
      // Apply conditional padding here to control alignment
      padding: rowPadding,
      child: Row(
        mainAxisAlignment: message.isUserMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUserMessage) ...[
            _buildAvatar(message.senderImage),
            SizedBox(width: 8.w),
          ],
          // Use Expanded/Flexible only if you need text wrapping,
          // but let's wrap the column in Flexible to allow text wrapping for long messages
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUserMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: message.isUserMessage
                        ? const Color(0xFF7DBCB4)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: message.isUserMessage
                        ? null
                        : Border.all(color: const Color(0xFFDDD9D9), width: 1.w),
                  ),
                  child: Text(
                    message.message,
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      color: message.isUserMessage
                          ? Colors.white
                          : const Color(0xFF222222),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message.time,
                  style: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        // The image shows no distinct top border, but a slight shadow might be implied
        // border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left '+' Button (Modified to match the image's light/white circle with dark icon)
            InkWell(
              onTap: () { /* Handle attachment logic */ },
              child: Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mainAppColor,
                  border: Border.all(color: Colors.grey.shade300, width: 1.w),
                ),
                child: Icon(Icons.add, color: AppColors.white, size: 28.sp),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                controller: controller.messageController,
                style: GoogleFonts.montserrat(fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade500),
                  contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  // Flatter appearance matching the image
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r), // Highly rounded
                    borderSide: BorderSide.none, // No distinct line border
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF0F0F0), // Light gray background
                ),
                onSubmitted: (v) {
                  controller.sendMessage(v);
                  _scrollToTopAnimated();
                },
              ),
            ),
            SizedBox(width: 10.w),
            // Right 'Send' Button (Main app color)
            GestureDetector(
              onTap: () {
                controller.sendMessage(controller.messageController.text);
                _scrollToTopAnimated();
              },
              child: CircleAvatar(
                radius: 24.r,
                backgroundColor: AppColors.mainAppColor,
                child: Icon(Icons.send, color: Colors.white, size: 22.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.messageController.dispose();
    _scrollController.dispose();
    // Use Get.delete to clean up the controller if it's not needed elsewhere
    // Get.delete<ChatScreenController>();
    super.dispose();
  }
}