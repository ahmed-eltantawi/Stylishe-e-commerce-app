import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class SponsoredBanner extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onPressed;
  final String title;
  const SponsoredBanner({
    super.key,
    required this.imageUrl,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),

      // Takes the full width of the parent/screen
      width: double.infinity,
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Upper Bar
          Container(
            height: 40.h,
            alignment: Alignment.centerLeft,
            child: Text('Sponsored', style: AppTextStyles.medium20),
          ),

          // Main Banner Image
          ClipRRect(
            // Adding a slight border radius to match the image aesthetics
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              width: double.infinity,
              child: showImage(image: imageUrl, fit: BoxFit.cover),
            ),
          ),

          // Bottom Bar
          SizedBox(
            height: 30.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTextStyles.bold16),
                IconButton(
                  icon: Icon(
                    color: AppColors.textPrimary,
                    Icons.chevron_right, // Matches the thin arrow look
                    size: 20.sp,
                  ),
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
