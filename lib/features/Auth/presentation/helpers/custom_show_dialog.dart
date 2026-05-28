import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

Future<void> customShowDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String buttonTitle,
  required IconData icon,
  required VoidCallback onPressed,
}) async {
  await showDialog(
    context: context,

    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.wifi_off_rounded,
                color: AppColors.onPrimary,
                size: 35.sp,
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              title,
              style: AppTextStyles.semiBold20.copyWith(
                color: AppColors.textPrimary,
              ),
            ),

            SizedBox(height: 12.h),

            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular14.copyWith(),
            ),

            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(buttonTitle),
              ),
            ),
          ],
        ),
      );
    },
  );
}
