import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/app_colors.dart';


// Custom Dropdown widget
class CustomDropdownHome extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onItemSelected;

  CustomDropdownHome({
    required this.items,
    this.selectedItem,
    required this.onItemSelected,
  });

  @override
  _CustomDropdownHomeState createState() => _CustomDropdownHomeState();
}

class _CustomDropdownHomeState extends State<CustomDropdownHome> {
  String? _selectedMonthYear;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDropdown(context),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: AppColors.mainAppColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              (_selectedMonthYear != null && widget.selectedItem == "Month")
                  ? _selectedMonthYear!
                  : (widget.selectedItem ?? "Select"),
              style: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF5E5E5E),
              ),
            ),
            SizedBox(width: 5.w),
            SvgPicture.asset(
              "assets/icons/bottomArrow.svg",
              width: 24.w,
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }

  // Method to show the dropdown menu
  void _showDropdown(BuildContext context) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double verticalPosition = offset.dy + renderBox.size.height + 10.0;
    final String? newSelection = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, verticalPosition, 0, 0),
      items: widget.items.map((String item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7C7C7C),
            ),
          ),
        );
      }).toList(),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.white, width: 1),
      ),

    );

    // Call the callback function to update the selected item
    if (newSelection != null) {
      widget.onItemSelected(newSelection);
    }
  }
}
