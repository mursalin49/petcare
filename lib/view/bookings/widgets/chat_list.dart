import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../utils/app_colors.dart';
import '../chat.dart';


class ChatListItem {
  final String id;
  final String userName;
  final String userImage;
  final String lastMessage;
  final String time;
  final bool isOnline;
  final int unreadCount;

  ChatListItem({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.lastMessage,
    required this.time,
    required this.isOnline,
    this.unreadCount = 0,
  });
}

class ChatListController extends GetxController {
  final RxList<ChatListItem> chatList = <ChatListItem>[
    ChatListItem(
      id: '1',
      userName: 'Stephen Yustiono',
      userImage: 'assets/images/mursalin.jpg',
      lastMessage: 'Nice. I don\'t know why I ...',
      time: '9:36 AM',
      isOnline: true,
      unreadCount: 0,
    ),
    ChatListItem(
      id: '2',
      userName: 'Stephen Yustiono',
      userImage: 'assets/images/mursalin.jpg',
      lastMessage: 'Nice. I don\'t know why I ...',
      time: '9:36 AM',
      isOnline: false,
      unreadCount: 2,
    ),
    ChatListItem(
      id: '3',
      userName: 'Stephen Yustiono',
      userImage: 'assets/images/mursalin.jpg',
      lastMessage: 'Nice. I don\'t know why I ...',
      time: '9:36 AM',
      isOnline: false,
      unreadCount: 0,
    ),
    ChatListItem(
      id: '4',
      userName: 'Stephen Yustiono',
      userImage: 'assets/images/mursalin.jpg',
      lastMessage: 'Nice. I don\'t know why I ...',
      time: '9:36 AM',
      isOnline: false,
      unreadCount: 1,
    ),
    ChatListItem(
      id: '5',
      userName: 'Stephen Yustiono',
      userImage: 'assets/images/mursalin.jpg',
      lastMessage: 'Nice. I don\'t know why I ...',
      time: '9:36 AM',
      isOnline: false,
      unreadCount: 0,
    ),
  ].obs;

  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  List<ChatListItem> getFilteredChats() {
    if (searchQuery.isEmpty) {
      return chatList;
    }
    return chatList
        .where((chat) =>
        chat.userName.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}

class ChatListScreen extends StatefulWidget {
  final String? userImage;
  final String? userName;

  const ChatListScreen({
    super.key,
    this.userImage,
    this.userName,
  });

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late ChatListController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatListController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () {
                final filteredChats = controller.getFilteredChats();
                if (filteredChats.isEmpty) {
                  return Center(
                    child: Text(
                      'No chats found',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: filteredChats.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Colors.grey.shade200,
                    indent: 70.w,
                  ),
                  itemBuilder: (context, index) {
                    return _buildChatListTile(filteredChats[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      backgroundColor: AppColors.mainAppColor,
      elevation: 0,

      toolbarHeight: 120.h,
      leadingWidth: 80.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
        child: const CircleAvatar(
          radius: 40.0,
          backgroundColor: Color(0xFFFFFFFF),
          child: CircleAvatar(
            radius: 40,
            // This is correct for loading a local image asset
            backgroundImage: AssetImage('assets/images/n.png'),
          ),
        ),
      ),


      title: Text(
        'Chat',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      // *** MODIFICATION END ***

      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.15),
            ),
            child: SvgPicture.asset(
              'assets/icons/notifica.svg',
              width: 24.sp,
              height: 24.sp,
            ),
          ),
        ),
      ],


      // --- FlexibleSpace (Search Bar) ---
      flexibleSpace: FlexibleSpaceBar(
        // Aligning the content (Search Bar) to the bottom of the flexible space
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.updateSearch,
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  color: const Color(0xFF333333),
                ),
                decoration: InputDecoration(
                  hintText: 'Search menu, restaurant or etc',
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    color: Colors.grey.shade400,
                  ),
                  // Search Icon
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 10.w),
                    child: SvgPicture.asset(
                      'assets/icons/search-normal.svg',
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ),

                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 14.w),
                    child: SvgPicture.asset(
                      'assets/icons/filter-vertical.svg',
                      width: 24.sp,
                      height: 24.sp,
                    ),
                  ),

                  contentPadding: EdgeInsets.symmetric(vertical: 13.h),

                  // Decoration for the white, rounded search bar
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatListTile(ChatListItem chat) {
    return InkWell(
      onTap: () {
        Get.to(() => ChatScreen(
          contactName: chat.userName,
          contactImage: chat.userImage,

        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Online indicator dot
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: chat.isOnline
                      ? const Color(0xFF4CAF50)
                      : Colors.transparent,
                ),
              ),
            ),
            // Avatar
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    chat.userImage,
                    width: 50.w,
                    height: 50.h,
                    fit: BoxFit.cover,
                  ),
                ),

              ],
            ),
            SizedBox(width: 12.w),
            // Chat info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.userName,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    chat.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Time
            Text(
              chat.time,
              style: GoogleFonts.montserrat(
                fontSize: 11.sp,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.searchController.dispose();
    super.dispose();
  }
}