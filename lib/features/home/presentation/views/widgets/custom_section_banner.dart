import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_outlined_button.dart';

/// A customizable banner widget used for section headers like
/// "Deal of the Day" or "Trending Products".
class CustomSectionBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData subtitleIcon;
  final Color backgroundColor;
  final VoidCallback onViewAllPressed;

  const CustomSectionBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subtitleIcon,
    required this.backgroundColor,
    required this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    //* ================ Main container holding the banner ================
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0.r),
      ),

      // All the content inside the Banner
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* ========= Left side: Title and Subtitle Column =========
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- Title Text (e.g., "Deal of the Day") ---
                Text(title, style: AppTextStyles.medium16),

                // --- Spacing between title and subtitle ---
                SizedBox(height: 8.0.h),

                // --- Subtitle Row (Icon + Text) ---
                Row(
                  children: [
                    // icon
                    Icon(
                      subtitleIcon,
                      color: AppColors.onPrimary,
                      size: 16.0.sp,
                    ),
                    // space
                    SizedBox(width: 6.0.w),
                    // text
                    Flexible(
                      child: Text(
                        subtitle,
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.onPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          //* ========= Right side: 'View all' Outlined Button =========
          SizedBox(width: 12.0.w),
          Padding(
            padding: .symmetric(horizontal: 4.w, vertical: 8.h),
            child: CustomOutlinedButton(
              onViewAllPressed: onViewAllPressed,
              title: 'View all',
            ),
          ),
        ],
      ),
    );
  }
}
