import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CustomSquareButton extends StatelessWidget {
  const CustomSquareButton({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // button action
      onPressed: onPressed,

      // button styling and exact dimensions
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(92.w, 25.h),
        fixedSize: Size(92.w, 25.h),
        backgroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),

      // button layout
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // button text
          Text(
            title,
            style: AppTextStyles.medium12.copyWith(color: AppColors.onPrimary),
          ),

          // spacing
          SizedBox(width: 4.w),

          // arrow icon
          Icon(Icons.arrow_forward, color: AppColors.onPrimary, size: 16.sp),
        ],
      ),
    );
  }
}
