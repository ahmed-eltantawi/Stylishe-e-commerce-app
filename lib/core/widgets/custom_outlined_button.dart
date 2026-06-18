import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onViewAllPressed,
    required this.title,
  });
  final String title;
  final VoidCallback onViewAllPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onViewAllPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.onPrimary,

        // White border
        side: BorderSide(color: Colors.white, width: 1.2.w),

        // Slightly rounded button edges
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),

        // Small padding
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
      ),

      // Content of the button
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.semiBold12),
          SizedBox(width: 4.0.w),
          Icon(Icons.arrow_forward, size: 16.0.sp),
        ],
      ),
    );
  }
}
