import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onMicTap;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    required this.textEditingController,
    this.onMicTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // The image has a very subtle shadow and a white background
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Faint shadow for depth
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: textEditingController,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          // Using a transparent border since the Container handles the shape and shadow
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,

          fillColor: Colors.transparent,
          filled: true,

          hintText: "Search any Product..",
          // Use your AppTextStyles here, adjusting color to match the light gray
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade400, // Or context.textHint
            fontWeight: FontWeight.w400,
          ),

          // Search Icon (Left)
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 12.w),
            child: Icon(
              Icons.search,
              color: Colors.grey.shade400, // Match the hint text color
              size: 24.sp,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 24.h,
          ),

          // Microphone Icon (Right)
          suffixIcon: GestureDetector(
            onTap: onMicTap,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Icon(
                Icons.mic_none_outlined,
                color: Colors.grey.shade400, // Match the hint text color
                size: 24.sp,
              ),
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 24.h,
          ),

          // Vertical padding to center the text nicely
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}
